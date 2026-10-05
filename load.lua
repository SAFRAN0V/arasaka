-- ============================================================
-- ARASAKA // DEVICE V5 LOADER
-- UID + instalacao persistente + sessao curta + ticket de uso unico.
-- Windows: pode exigir ARASAKA Auth.exe aberto.
-- Android/iOS: usa token de instalacao persistente salvo pelo executor.
-- ============================================================

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UID = tostring(Player.UserId)

local API = "https://chatprivado-cwu3.onrender.com"
local VERSION = "6.0.0"
local CLIENT_INSTANCE_ID = HttpService:GenerateGUID(false)
local COMPANION_URL = "http://127.0.0.1:27183"
local DEVICE_DIR = "ARASAKA"
local LEGACY_DEVICE_FILE = DEVICE_DIR .. "/device.json"
local DEVICE_FILE = DEVICE_DIR .. "/device_" .. UID .. ".json"

local function getEnv()
    if type(getgenv) == "function" then
        local ok, env = pcall(getgenv)
        if ok and type(env) == "table" then return env end
    end
    return _G
end
local ENV = getEnv()

local function findRequest()
    return request or http_request or (syn and syn.request) or (Fluxus and Fluxus.request) or (http and http.request)
end

local function requestRaw(method, url, bodyTable)
    local req = findRequest()
    local body = bodyTable and HttpService:JSONEncode(bodyTable) or nil
    if req then
        local ok, response = pcall(function()
            return req({Url=url,Method=method,Headers={["Content-Type"]="application/json",["Cache-Control"]="no-cache"},Body=body})
        end)
        if not ok or type(response) ~= "table" then return nil,nil,"Falha de rede" end
        return tonumber(response.StatusCode or response.Status or response.status_code) or 0, tostring(response.Body or response.body or ""), nil
    end
    if method == "POST" then
        local ok, raw = pcall(function() return game:HttpPost(url, body or "{}", Enum.HttpContentType.ApplicationJson) end)
        if not ok then return nil,nil,"Falha de rede" end
        return 200,tostring(raw),nil
    end
    return nil,nil,"Ambiente sem request HTTP compativel"
end

local function requestJson(method, path, bodyTable)
    local status, raw, err = requestRaw(method, API .. path, bodyTable)
    if not raw then return nil, err or "Falha de rede", status end
    local ok, decoded = pcall(function() return HttpService:JSONDecode(raw) end)
    if not ok or type(decoded) ~= "table" then return nil,"Resposta invalida do servidor",status end
    return decoded,nil,status
end

local function detectPlatform()
    local ok, p = pcall(function() return tostring(UserInputService:GetPlatform()) end)
    p = ok and string.lower(p or "") or ""
    if string.find(p,"windows",1,true) then return "windows" end
    if string.find(p,"android",1,true) then return "android" end
    if string.find(p,"ios",1,true) then return "ios" end
    return "other"
end

local PLATFORM = detectPlatform()

local function storageAvailable()
    return type(readfile)=="function" and type(writefile)=="function"
end

local function saveDevice(state)
    if not storageAvailable() then return false,"Este executor nao oferece readfile/writefile para salvar a instalacao." end
    if type(makefolder)=="function" then pcall(function() makefolder(DEVICE_DIR) end) end
    local ok, raw = pcall(function() return HttpService:JSONEncode(state) end)
    if not ok then return false,"Falha ao serializar dispositivo." end
    local wok, werr = pcall(function() writefile(DEVICE_FILE, raw) end)
    if not wok then return false,"Falha ao salvar dispositivo: "..tostring(werr) end
    return true
end

local function readDeviceFile(path)
    local exists = false
    if type(isfile) == "function" then
        pcall(function() exists = isfile(path) end)
    else
        local ok = pcall(function() readfile(path) end)
        exists = ok
    end
    if not exists then return nil end

    local ok, raw = pcall(function() return readfile(path) end)
    if not ok or type(raw) ~= "string" then return nil end

    local dok, decoded = pcall(function() return HttpService:JSONDecode(raw) end)
    if not dok or type(decoded) ~= "table" then return nil end
    if tostring(decoded.uid or "") ~= UID or type(decoded.deviceId) ~= "string" then return nil end

    decoded.platform = PLATFORM
    return decoded
end

local function loadDevice()
    local state = {uid=UID,platform=PLATFORM,deviceId=HttpService:GenerateGUID(false),installToken=nil}
    if not storageAvailable() then return state,false end

    -- V6 MULTI-ACCOUNT: cada UID possui seu proprio device/installToken.
    local perUser = readDeviceFile(DEVICE_FILE)
    if perUser then
        return perUser,true
    end

    -- Migracao transparente do loader antigo: se device.json pertencer a
    -- esta conta, copia para device_<UID>.json sem perder o cadastro.
    local legacy = readDeviceFile(LEGACY_DEVICE_FILE)
    if legacy then
        state = legacy
        pcall(function() saveDevice(state) end)
    end

    return state,true
end

local Device, HAS_STORAGE = loadDevice()

local function localCompanion(path, bodyTable)
    local status, raw, err = requestRaw("POST", COMPANION_URL .. path, bodyTable)
    if not raw or (status~=0 and status~=200) then return nil,err or "ARASAKA Auth offline" end
    local ok, decoded=pcall(function() return HttpService:JSONDecode(raw) end)
    if not ok or type(decoded)~="table" then return nil,"Resposta invalida do ARASAKA Auth" end
    return decoded,nil
end

local function registerCompanion()
    if PLATFORM~="windows" then return true end
    local d,err=localCompanion("/register",{api=API,uid=UID,deviceId=Device.deviceId,installToken=Device.installToken})
    if not d or d.success~=true then return false,(d and d.message) or err or "Abra ARASAKA Auth.exe" end
    return true
end

local function getCompanionProof(useSessionToken)
    local body={uid=UID,version=VERSION,deviceId=Device.deviceId}
    if useSessionToken then body.sessionToken=useSessionToken else body.installToken=Device.installToken end
    local challenge,err=requestJson("POST","/api/device/challenge",body)
    if not challenge then return nil,err end
    if challenge.required~=true then return {required=false} end
    local signed,signErr=localCompanion("/sign",{challengeId=challenge.challengeId,nonce=challenge.nonce,uid=UID,deviceId=Device.deviceId})
    if not signed or signed.success~=true or type(signed.signature)~="string" then return nil,(signed and signed.message) or signErr or "ARASAKA Auth nao respondeu" end
    return {required=true,challengeId=challenge.challengeId,signature=signed.signature}
end

local function bootstrap()
    return requestJson("POST","/api/bootstrap",{
        uid=UID,
        version=VERSION,
        fingerprint=CLIENT_INSTANCE_ID
    })
end

local function redeemKey(keyText)
    return requestJson("POST","/api/redeem-key",{key=keyText,uid=UID,version=VERSION})
end

local function enrollPair(code)
    return requestJson("POST","/api/device/enroll-pair",{pairCode=code,uid=UID,version=VERSION,platform=PLATFORM,deviceId=Device.deviceId})
end

local function acceptEnrollment(response)
    if type(response)~="table" or type(response.installToken)~="string" or response.installToken=="" then return false,"Servidor nao entregou token da instalacao." end
    Device.uid=UID;Device.platform=PLATFORM;Device.deviceId=response.deviceId or Device.deviceId;Device.installToken=response.installToken
    local ok,err=saveDevice(Device)
    if not ok then return false,err end
    if response.companionRequired==true then
        local cok,cerr=registerCompanion()
        if not cok then return false,cerr end
    end
    return true
end

local function requestScriptTicket(sessionToken)
    return requestJson("POST","/api/script-ticket",{uid=UID,version=VERSION,sessionToken=sessionToken})
end

local function downloadScript(ticket,sessionToken)
    local status,source,err=requestRaw("POST",API.."/api/script",{ticket=ticket,uid=UID,version=VERSION,sessionToken=sessionToken})
    if not source then return nil,err or "Falha ao baixar Hub" end
    if status~=0 and status~=200 then return nil,"Servidor recusou o download (HTTP "..tostring(status)..")" end
    if #source<100 then return nil,"Payload invalido: "..tostring(source) end
    return source,nil
end


local function requestModuleTicket(moduleName,sessionToken)
    return requestJson("POST","/api/module-ticket",{
        uid=UID,
        version=VERSION,
        module=moduleName,
        sessionToken=sessionToken
    })
end

local function downloadModule(moduleName,ticket,sessionToken)
    local status,source,err=requestRaw("POST",API.."/api/module",{
        ticket=ticket,
        uid=UID,
        version=VERSION,
        module=moduleName,
        sessionToken=sessionToken
    })
    if not source then return nil,err or "Falha ao baixar modulo" end
    if status~=0 and status~=200 then
        return nil,"Servidor recusou o modulo (HTTP "..tostring(status).."): "..tostring(source)
    end
    if #source<20 then return nil,"Modulo invalido: "..tostring(source) end
    return source,nil
end

local LoadedModules={}
local ModuleExports={}

local function secureLoadModule(moduleName)
    moduleName=string.lower(tostring(moduleName or "")):gsub("[^%w_-]","")
    if moduleName=="" then return nil,"Nome de modulo invalido" end

    if LoadedModules[moduleName] then
        return ModuleExports[moduleName],nil
    end

    local context=ENV.ARASAKA_BOOTSTRAP_CONTEXT
    if type(context)~="table" or type(context.sessionToken)~="string" then
        return nil,"Sessao ARASAKA indisponivel"
    end

    local ticketResponse,ticketErr=requestModuleTicket(moduleName,context.sessionToken)
    if not ticketResponse or ticketResponse.success~=true or type(ticketResponse.ticket)~="string" then
        return nil,(ticketResponse and ticketResponse.message) or ticketErr or "Falha ao emitir ticket do modulo"
    end

    local source,downloadErr=downloadModule(moduleName,ticketResponse.ticket,context.sessionToken)
    if not source then return nil,downloadErr end

    if type(loadstring)~="function" then
        return nil,"Este ambiente nao possui loadstring"
    end

    local chunk,compileErr=loadstring(source,"ARASAKA_MODULE_"..string.upper(moduleName))
    source=nil
    if not chunk then
        return nil,"Falha ao compilar modulo "..moduleName..": "..tostring(compileErr)
    end

    local ok,exported=pcall(chunk)
    chunk=nil
    if not ok then
        return nil,"Erro ao iniciar modulo "..moduleName..": "..tostring(exported)
    end

    local shared=ENV.ARASAKA_SHARED
    if type(exported)=="function" then
        local initOk,initResult=pcall(exported,shared,context)
        if not initOk then
            return nil,"Erro no Init do modulo "..moduleName..": "..tostring(initResult)
        end
        exported=initResult
    elseif type(exported)=="table" and type(exported.Init)=="function" then
        local initOk,initErr=pcall(function()
            exported:Init(shared,context)
        end)
        if not initOk then
            return nil,"Erro no Init do modulo "..moduleName..": "..tostring(initErr)
        end
    end

    LoadedModules[moduleName]=true
    ModuleExports[moduleName]=exported
    return exported,nil
end

ENV.ARASAKA_MODULE_LOADER={
    Load=secureLoadModule,
    IsLoaded=function(moduleName)
        moduleName=string.lower(tostring(moduleName or ""))
        return LoadedModules[moduleName]==true
    end,
    Get=function(moduleName)
        moduleName=string.lower(tostring(moduleName or ""))
        return ModuleExports[moduleName]
    end
}

local function createContext(response)
    local token=response and response.sessionToken
    if type(token)~="string" or token=="" then return nil,"Servidor nao entregou sessionToken" end
    local context={
        api=API,uid=UID,version=VERSION,sessionToken=token,sessionExpiresAt=tonumber(response.sessionExpiresAt),
        licenseExpiresAt=tonumber(response.expiresAt),isLifetime=response.isLifetime==true,
        heartbeatSeconds=tonumber(response.heartbeatSeconds) or 60,offlineGraceSeconds=tonumber(response.offlineGraceSeconds) or 600,
        controlEpoch=tonumber(response.controlEpoch),clientInstanceId=CLIENT_INSTANCE_ID,lastServerOkAt=os.time(),
        deviceId=Device.deviceId,platform=PLATFORM,companionRequired=false,companionUrl=nil
    }
    ENV.ARASAKA_BOOTSTRAP_CONTEXT=context
    return context
end

local function runPayload(authResponse,setStatus)
    local context,contextErr=createContext(authResponse);if not context then return false,contextErr end
    if setStatus then setStatus("Solicitando ticket seguro...",Color3.fromRGB(255,210,80)) end
    local tr,te=requestScriptTicket(context.sessionToken)
    if not tr or tr.success~=true or type(tr.ticket)~="string" then return false,(tr and tr.message) or te or "Falha ao emitir ticket" end
    if setStatus then setStatus("Baixando build autorizada...",Color3.fromRGB(255,210,80)) end
    local source,se=downloadScript(tr.ticket,context.sessionToken);if not source then return false,se end
    if type(loadstring)~="function" then return false,"Este ambiente nao possui loadstring." end
    local chunk,ce=loadstring(source,"ARASAKA_PAYLOAD");source=nil
    if not chunk then return false,"Falha ao compilar payload: "..tostring(ce) end
    if setStatus then setStatus("ARASAKA autorizado. Iniciando...",Color3.fromRGB(80,255,120)) end
    task.wait(0.25)
    local ok,re=pcall(chunk);chunk=nil
    if not ok then ENV.ARASAKA_BOOTSTRAP_CONTEXT=nil;return false,"Erro ao iniciar Hub: "..tostring(re) end
    return true
end

-- UI
local old=PlayerGui:FindFirstChild("ArasakaSecureLoader");if old then old:Destroy() end
local Gui=Instance.new("ScreenGui");Gui.Name="ArasakaSecureLoader";Gui.ResetOnSpawn=false;Gui.IgnoreGuiInset=true;Gui.DisplayOrder=1000000;Gui.Parent=PlayerGui
local Overlay=Instance.new("Frame");Overlay.Size=UDim2.fromScale(1,1);Overlay.BackgroundColor3=Color3.fromRGB(2,2,3);Overlay.BackgroundTransparency=0.06;Overlay.BorderSizePixel=0;Overlay.Parent=Gui
local Card=Instance.new("Frame");Card.AnchorPoint=Vector2.new(0.5,0.5);Card.Position=UDim2.fromScale(0.5,0.5);Card.Size=UDim2.new(0,420,0,280);Card.BackgroundColor3=Color3.fromRGB(10,10,13);Card.BorderSizePixel=0;Card.Parent=Overlay;Instance.new("UICorner",Card).CornerRadius=UDim.new(0,7)
local Stroke=Instance.new("UIStroke",Card);Stroke.Color=Color3.fromRGB(190,25,25);Stroke.Thickness=1.5
local Accent=Instance.new("Frame");Accent.Size=UDim2.new(0,4,1,0);Accent.BackgroundColor3=Color3.fromRGB(210,35,35);Accent.BorderSizePixel=0;Accent.Parent=Card
local Title=Instance.new("TextLabel");Title.BackgroundTransparency=1;Title.Position=UDim2.new(0,20,0,18);Title.Size=UDim2.new(1,-40,0,28);Title.Font=Enum.Font.GothamBold;Title.Text="ARASAKA // SECURE ACCESS";Title.TextSize=16;Title.TextColor3=Color3.fromRGB(245,245,245);Title.TextXAlignment=Enum.TextXAlignment.Left;Title.Parent=Card
local Sub=Instance.new("TextLabel");Sub.BackgroundTransparency=1;Sub.Position=UDim2.new(0,20,0,47);Sub.Size=UDim2.new(1,-40,0,20);Sub.Font=Enum.Font.Code;Sub.Text="UID "..UID.." // "..string.upper(PLATFORM);Sub.TextSize=10;Sub.TextColor3=Color3.fromRGB(115,115,120);Sub.TextXAlignment=Enum.TextXAlignment.Left;Sub.Parent=Card
local Status=Instance.new("TextLabel");Status.BackgroundTransparency=1;Status.Position=UDim2.new(0,20,0,76);Status.Size=UDim2.new(1,-40,0,48);Status.Font=Enum.Font.Gotham;Status.Text="Validando licenca...";Status.TextSize=13;Status.TextWrapped=true;Status.TextColor3=Color3.fromRGB(190,190,195);Status.TextXAlignment=Enum.TextXAlignment.Left;Status.Parent=Card
local Input=Instance.new("TextBox");Input.Position=UDim2.new(0,20,0,134);Input.Size=UDim2.new(1,-40,0,42);Input.BackgroundColor3=Color3.fromRGB(20,20,25);Input.BorderSizePixel=0;Input.ClearTextOnFocus=false;Input.PlaceholderText="UID liberado pelo Admin ou digite sua key";Input.Text="";Input.TextColor3=Color3.fromRGB(245,245,245);Input.PlaceholderColor3=Color3.fromRGB(95,95,100);Input.Font=Enum.Font.Gotham;Input.TextSize=13;Input.Parent=Card;Instance.new("UICorner",Input).CornerRadius=UDim.new(0,5)
local Button=Instance.new("TextButton");Button.Position=UDim2.new(0,20,0,188);Button.Size=UDim2.new(1,-40,0,40);Button.BackgroundColor3=Color3.fromRGB(150,20,25);Button.BorderSizePixel=0;Button.Text="VALIDAR / ATIVAR";Button.TextColor3=Color3.fromRGB(255,255,255);Button.Font=Enum.Font.GothamBold;Button.TextSize=12;Button.Parent=Card;Instance.new("UICorner",Button).CornerRadius=UDim.new(0,5)
local Hint=Instance.new("TextLabel");Hint.BackgroundTransparency=1;Hint.Position=UDim2.new(0,20,0,238);Hint.Size=UDim2.new(1,-40,0,24);Hint.Font=Enum.Font.Code;Hint.Text="Acesso por UID liberado no Admin OU por key // multi-conta liberado";Hint.TextSize=9;Hint.TextColor3=Color3.fromRGB(95,95,100);Hint.TextXAlignment=Enum.TextXAlignment.Left;Hint.Parent=Card
local function setStatus(t,c) Status.Text=tostring(t or "");if c then Status.TextColor3=c end end
local busy=false
local function setBusy(v) busy=v==true;Button.Active=not busy;Button.AutoButtonColor=not busy;Button.Text=busy and "PROCESSANDO..." or "VALIDAR / ATIVAR" end
local function finishSuccess() TweenService:Create(Card,TweenInfo.new(0.18),{BackgroundTransparency=1}):Play();task.wait(0.2);if Gui then Gui:Destroy() end end

local function authAndRun(inputText)
    if busy then return end
    setBusy(true)

    setStatus("Validando UID...",Color3.fromRGB(255,210,80))
    local response,err=bootstrap()

    if response and response.authorized==true then
        -- O Secure Access não pode ficar por cima da loading screen do ARASAKA.
        -- Esconde antes de executar o payload e só volta se houver erro.
        if Gui then Gui.Enabled=false end
        local okRun,runErr=runPayload(response,setStatus)
        if not okRun then
            if Gui then Gui.Enabled=true end
            setStatus(runErr or "Falha ao iniciar Hub.",Color3.fromRGB(255,95,95))
            setBusy(false)
            return
        end
        if Gui then Gui:Destroy() end
        return
    end

    if inputText and inputText~="" then
        setStatus("Ativando key para este UID...",Color3.fromRGB(255,210,80))
        local redeem,redeemErr=redeemKey(inputText)
        if not redeem then
            setStatus(redeemErr or "Falha ao ativar key.",Color3.fromRGB(255,95,95))
            setBusy(false)
            return
        end
        if redeem.success~=true then
            setStatus(redeem.message or "Key recusada.",Color3.fromRGB(255,95,95))
            setBusy(false)
            return
        end

        setStatus("Licenca ativada. Criando sessao...",Color3.fromRGB(255,210,80))
        response,err=bootstrap()
        if response and response.authorized==true then
            -- Mesmo comportamento após resgatar key: a loading screen fica limpa.
            if Gui then Gui.Enabled=false end
            local okRun,runErr=runPayload(response,setStatus)
            if not okRun then
                if Gui then Gui.Enabled=true end
                setStatus(runErr or "Falha ao iniciar Hub.",Color3.fromRGB(255,95,95))
                setBusy(false)
                return
            end
            if Gui then Gui:Destroy() end
            return
        end
    end

    if not response then
        setStatus(err or "Servidor temporariamente indisponivel.",Color3.fromRGB(255,95,95))
    else
        setStatus(response.message or "UID sem acesso. Libere o UID no Admin ou digite uma key.",Color3.fromRGB(255,170,70))
    end
    setBusy(false)
end

Button.MouseButton1Click:Connect(function() authAndRun(Input.Text) end)
task.spawn(function() task.wait(0.2); authAndRun(nil) end)
