-- ============================================================
-- ARASAKA // DEVICE V5 LOADER
-- UID + instalacao persistente + sessao curta + ticket de uso unico.
-- Windows: pode exigir ARASAKA Auth.exe aberto.
-- Android/iOS: usa token de instalacao persistente salvo pelo executor.
-- ============================================================

local _0x1375 = game:GetService("Players")
local _0x0FFE = game:GetService("HttpService")
local _0x8F76 = game:GetService("TweenService")
local _0xBBFD = game:GetService("UserInputService")

local _0x4A41 = _0x1375.LocalPlayer
local _0xB041 = _0x4A41:WaitForChild("PlayerGui")
local _0x7E28 = tostring(_0x4A41.UserId)

local _0xD1F5 = "https://chatprivado-cwu3.onrender.com"
local _0x0AF8 = "6.0.0"
local _0x1526 = _0x0FFE:GenerateGUID(false)
local _0xEDF9 = "http://127.0.0.1:27183"
local _0x42DD = "ARASAKA"
local _0xFB45 = _0x42DD .. "/device.json"
local _0xFB00 = _0x42DD .. "/device_" .. _0x7E28 .. ".json"

local function _0x820F()
    if type(getgenv) == "function" then
        local _0x9605, _0x04F3 = pcall(getgenv)
        if _0x9605 and type(_0x04F3) == "table" then return _0x04F3 end
    end
    return _G
end
local _0x0DE1 = _0x820F()

local function _0xCDBC()
    return request or http_request or (syn and syn.request) or (Fluxus and Fluxus.request) or (http and http.request)
end

local function _0xEB0D(method, url, bodyTable)
    local _0x6619 = _0xCDBC()
    local _0x01A5 = bodyTable and _0x0FFE:JSONEncode(bodyTable) or nil
    if _0x6619 then
        local _0x9605, _0xECEF = pcall(function()
            return _0x6619({Url=url,Method=method,Headers={["Content-Type"]="application/json",["Cache-Control"]="no-cache"},Body=_0x01A5})
        end)
        if not _0x9605 or type(_0xECEF) ~= "table" then return nil,nil,"Falha de rede" end
        return tonumber(_0xECEF.StatusCode or _0xECEF.Status or _0xECEF.status_code) or 0, tostring(_0xECEF.Body or _0xECEF.body or ""), nil
    end
    if method == "POST" then
        local _0x9605, _0x381E = pcall(function() return game:HttpPost(url, _0x01A5 or "{}", Enum.HttpContentType.ApplicationJson) end)
        if not _0x9605 then return nil,nil,"Falha de rede" end
        return 200,tostring(_0x381E),nil
    end
    return nil,nil,"Ambiente sem request HTTP compativel"
end

local function _0x5F40(method, path, bodyTable)
    local _0xDB33, _0x381E, _0x55CF = _0xEB0D(method, _0xD1F5 .. path, bodyTable)
    if not _0x381E then return nil, _0x55CF or "Falha de rede", _0xDB33 end
    local _0x9605, _0xD1A6 = pcall(function() return _0x0FFE:JSONDecode(_0x381E) end)
    if not _0x9605 or type(_0xD1A6) ~= "table" then return nil,"Resposta invalida do servidor",_0xDB33 end
    return _0xD1A6,nil,_0xDB33
end

local function _0xF3E8()
    local _0x9605, _0x7CD8 = pcall(function() return tostring(_0xBBFD:GetPlatform()) end)
    _0x7CD8 = _0x9605 and string.lower(_0x7CD8 or "") or ""
    if string.find(_0x7CD8,"windows",1,true) then return "windows" end
    if string.find(_0x7CD8,"android",1,true) then return "android" end
    if string.find(_0x7CD8,"ios",1,true) then return "ios" end
    return "other"
end

local _0xA00D = _0xF3E8()

local function _0xA5FD()
    return type(readfile)=="function" and type(writefile)=="function"
end

local function _0xBC3A(_0xF05E)
    if not _0xA5FD() then return false,"Este executor nao oferece readfile/writefile para salvar a instalacao." end
    if type(makefolder)=="function" then pcall(function() makefolder(_0x42DD) end) end
    local _0x9605, _0x381E = pcall(function() return _0x0FFE:JSONEncode(_0xF05E) end)
    if not _0x9605 then return false,"Falha ao serializar dispositivo." end
    local _0xE2B4, _0xD1D5 = pcall(function() writefile(_0xFB00, _0x381E) end)
    if not _0xE2B4 then return false,"Falha ao salvar dispositivo: "..tostring(_0xD1D5) end
    return true
end

local function _0xD9DB(path)
    local _0xCFF5 = false
    if type(isfile) == "function" then
        pcall(function() _0xCFF5 = isfile(path) end)
    else
        local _0x9605 = pcall(function() readfile(path) end)
        _0xCFF5 = _0x9605
    end
    if not _0xCFF5 then return nil end

    local _0x9605, _0x381E = pcall(function() return readfile(path) end)
    if not _0x9605 or type(_0x381E) ~= "string" then return nil end

    local _0x50D6, _0xD1A6 = pcall(function() return _0x0FFE:JSONDecode(_0x381E) end)
    if not _0x50D6 or type(_0xD1A6) ~= "table" then return nil end
    if tostring(_0xD1A6.uid or "") ~= _0x7E28 or type(_0xD1A6.deviceId) ~= "string" then return nil end

    _0xD1A6.platform = _0xA00D
    return _0xD1A6
end

local function _0x11A1()
    local _0xF05E = {uid=_0x7E28,platform=_0xA00D,deviceId=_0x0FFE:GenerateGUID(false),installToken=nil}
    if not _0xA5FD() then return _0xF05E,false end

    -- V6 MULTI-ACCOUNT: cada UID possui seu proprio device/installToken.
    local _0x6658 = _0xD9DB(_0xFB00)
    if _0x6658 then
        return _0x6658,true
    end

    -- Migracao transparente do loader antigo: se device.json pertencer a
    -- esta conta, copia para device_<UID>.json sem perder o cadastro.
    local _0x0574 = _0xD9DB(_0xFB45)
    if _0x0574 then
        _0xF05E = _0x0574
        pcall(function() _0xBC3A(_0xF05E) end)
    end

    return _0xF05E,true
end

local _0x0AE5, _0x9885 = _0x11A1()

local function _0xC47A(path, bodyTable)
    local _0xDB33, _0x381E, _0x55CF = _0xEB0D("POST", _0xEDF9 .. path, bodyTable)
    if not _0x381E or (_0xDB33~=0 and _0xDB33~=200) then return nil,_0x55CF or "ARASAKA Auth offline" end
    local _0x9605, _0xD1A6=pcall(function() return _0x0FFE:JSONDecode(_0x381E) end)
    if not _0x9605 or type(_0xD1A6)~="table" then return nil,"Resposta invalida do ARASAKA Auth" end
    return _0xD1A6,nil
end

local function _0x8C81()
    if _0xA00D~="windows" then return true end
    local _0xAE28,_0x55CF=_0xC47A("/register",{api=_0xD1F5,uid=_0x7E28,deviceId=_0x0AE5.deviceId,installToken=_0x0AE5.installToken})
    if not _0xAE28 or _0xAE28.success~=true then return false,(_0xAE28 and _0xAE28.message) or _0x55CF or "Abra ARASAKA Auth.exe" end
    return true
end

local function _0x1937(useSessionToken)
    local _0x01A5={uid=_0x7E28,version=_0x0AF8,deviceId=_0x0AE5.deviceId}
    if useSessionToken then _0x01A5.sessionToken=useSessionToken else _0x01A5.installToken=_0x0AE5.installToken end
    local _0x74BF,_0x55CF=_0x5F40("POST","/api/device/challenge",_0x01A5)
    if not _0x74BF then return nil,_0x55CF end
    if _0x74BF.required~=true then return {required=false} end
    local _0xFD3F,_0xECB0=_0xC47A("/sign",{challengeId=_0x74BF.challengeId,nonce=_0x74BF.nonce,uid=_0x7E28,deviceId=_0x0AE5.deviceId})
    if not _0xFD3F or _0xFD3F.success~=true or type(_0xFD3F.signature)~="string" then return nil,(_0xFD3F and _0xFD3F.message) or _0xECB0 or "ARASAKA Auth nao respondeu" end
    return {required=true,challengeId=_0x74BF.challengeId,signature=_0xFD3F.signature}
end

local function _0x82C5()
    return _0x5F40("POST","/api/bootstrap",{
        uid=_0x7E28,
        version=_0x0AF8,
        fingerprint=_0x1526
    })
end

local function _0x2A22(keyText)
    return _0x5F40("POST","/api/redeem-key",{key=keyText,uid=_0x7E28,version=_0x0AF8})
end

local function _0x354A(code)
    return _0x5F40("POST","/api/device/enroll-pair",{pairCode=code,uid=_0x7E28,version=_0x0AF8,platform=_0xA00D,deviceId=_0x0AE5.deviceId})
end

local function _0x3309(_0xECEF)
    if type(_0xECEF)~="table" or type(_0xECEF.installToken)~="string" or _0xECEF.installToken=="" then return false,"Servidor nao entregou token da instalacao." end
    _0x0AE5.uid=_0x7E28;_0x0AE5.platform=_0xA00D;_0x0AE5.deviceId=_0xECEF.deviceId or _0x0AE5.deviceId;_0x0AE5.installToken=_0xECEF.installToken
    local _0x9605,_0x55CF=_0xBC3A(_0x0AE5)
    if not _0x9605 then return false,_0x55CF end
    if _0xECEF.companionRequired==true then
        local _0xA080,_0x25A4=_0x8C81()
        if not _0xA080 then return false,_0x25A4 end
    end
    return true
end

local function _0x29A4(sessionToken)
    return _0x5F40("POST","/api/script-ticket",{uid=_0x7E28,version=_0x0AF8,sessionToken=sessionToken})
end

local function _0x4821(ticket,sessionToken)
    local _0xDB33,_0xA218,_0x55CF=_0xEB0D("POST",_0xD1F5.."/api/script",{ticket=ticket,uid=_0x7E28,version=_0x0AF8,sessionToken=sessionToken})
    if not _0xA218 then return nil,_0x55CF or "Falha ao baixar Hub" end
    if _0xDB33~=0 and _0xDB33~=200 then return nil,"Servidor recusou o download (HTTP "..tostring(_0xDB33)..")" end
    if #_0xA218<100 then return nil,"Payload invalido: "..tostring(_0xA218) end
    return _0xA218,nil
end


local function _0xBCCB(moduleName,sessionToken)
    return _0x5F40("POST","/api/module-ticket",{
        uid=_0x7E28,
        version=_0x0AF8,
        module=moduleName,
        sessionToken=sessionToken
    })
end

local function _0xD8C0(moduleName,ticket,sessionToken)
    local _0xDB33,_0xA218,_0x55CF=_0xEB0D("POST",_0xD1F5.."/api/module",{
        ticket=ticket,
        uid=_0x7E28,
        version=_0x0AF8,
        module=moduleName,
        sessionToken=sessionToken
    })
    if not _0xA218 then return nil,_0x55CF or "Falha ao baixar modulo" end
    if _0xDB33~=0 and _0xDB33~=200 then
        return nil,"Servidor recusou o modulo (HTTP "..tostring(_0xDB33).."): "..tostring(_0xA218)
    end
    if #_0xA218<20 then return nil,"Modulo invalido: "..tostring(_0xA218) end
    return _0xA218,nil
end

local _0x2F47={}
local _0xA5CB={}

local function _0x3DD5(moduleName)
    moduleName=string.lower(tostring(moduleName or "")):gsub("[^%w_-]","")
    if moduleName=="" then return nil,"Nome de modulo invalido" end

    if _0x2F47[moduleName] then
        return _0xA5CB[moduleName],nil
    end

    local _0x97DB=_0x0DE1.ARASAKA_BOOTSTRAP_CONTEXT
    if type(_0x97DB)~="table" or type(_0x97DB.sessionToken)~="string" then
        return nil,"Sessao ARASAKA indisponivel"
    end

    local _0xB33C,_0xB051=_0xBCCB(moduleName,_0x97DB.sessionToken)
    if not _0xB33C or _0xB33C.success~=true or type(_0xB33C.ticket)~="string" then
        return nil,(_0xB33C and _0xB33C.message) or _0xB051 or "Falha ao emitir ticket do modulo"
    end

    local _0xA218,_0x7DD0=_0xD8C0(moduleName,_0xB33C.ticket,_0x97DB.sessionToken)
    if not _0xA218 then return nil,_0x7DD0 end

    if type(loadstring)~="function" then
        return nil,"Este ambiente nao possui loadstring"
    end

    local _0x81E6,_0xAD1D=loadstring(_0xA218,"ARASAKA_MODULE_"..string.upper(moduleName))
    _0xA218=nil
    if not _0x81E6 then
        return nil,"Falha ao compilar modulo "..moduleName..": "..tostring(_0xAD1D)
    end

    local _0x9605,_0x3CA9=pcall(_0x81E6)
    _0x81E6=nil
    if not _0x9605 then
        return nil,"Erro ao iniciar modulo "..moduleName..": "..tostring(_0x3CA9)
    end

    local _0x13C2=_0x0DE1.ARASAKA_SHARED
    if type(_0x3CA9)=="function" then
        local _0x877C,_0x8733=pcall(_0x3CA9,_0x13C2,_0x97DB)
        if not _0x877C then
            return nil,"Erro no Init do modulo "..moduleName..": "..tostring(_0x8733)
        end
        _0x3CA9=_0x8733
    elseif type(_0x3CA9)=="table" and type(_0x3CA9.Init)=="function" then
        local _0x877C,_0xE3CB=pcall(function()
            _0x3CA9:Init(_0x13C2,_0x97DB)
        end)
        if not _0x877C then
            return nil,"Erro no Init do modulo "..moduleName..": "..tostring(_0xE3CB)
        end
    end

    _0x2F47[moduleName]=true
    _0xA5CB[moduleName]=_0x3CA9
    return _0x3CA9,nil
end

_0x0DE1.ARASAKA_MODULE_LOADER={
    Load=_0x3DD5,
    IsLoaded=function(moduleName)
        moduleName=string.lower(tostring(moduleName or ""))
        return _0x2F47[moduleName]==true
    end,
    Get=function(moduleName)
        moduleName=string.lower(tostring(moduleName or ""))
        return _0xA5CB[moduleName]
    end
}

local function _0xD978(_0xECEF)
    local _0x0240=_0xECEF and _0xECEF.sessionToken
    if type(_0x0240)~="string" or _0x0240=="" then return nil,"Servidor nao entregou sessionToken" end
    local _0x97DB={
        api=_0xD1F5,uid=_0x7E28,version=_0x0AF8,sessionToken=_0x0240,sessionExpiresAt=tonumber(_0xECEF.sessionExpiresAt),
        licenseExpiresAt=tonumber(_0xECEF.expiresAt),isLifetime=_0xECEF.isLifetime==true,
        heartbeatSeconds=tonumber(_0xECEF.heartbeatSeconds) or 60,offlineGraceSeconds=tonumber(_0xECEF.offlineGraceSeconds) or 600,
        controlEpoch=tonumber(_0xECEF.controlEpoch),clientInstanceId=_0x1526,lastServerOkAt=os.time(),
        deviceId=_0x0AE5.deviceId,platform=_0xA00D,companionRequired=false,companionUrl=nil
    }
    _0x0DE1.ARASAKA_BOOTSTRAP_CONTEXT=_0x97DB
    return _0x97DB
end

local function _0x084D(authResponse,_0x7325)
    local _0x97DB,_0x2596=_0xD978(authResponse);if not _0x97DB then return false,_0x2596 end
    if _0x7325 then _0x7325("Solicitando ticket seguro...",Color3.fromRGB(255,210,80)) end
    local _0xC397,_0xD001=_0x29A4(_0x97DB.sessionToken)
    if not _0xC397 or _0xC397.success~=true or type(_0xC397.ticket)~="string" then return false,(_0xC397 and _0xC397.message) or _0xD001 or "Falha ao emitir ticket" end
    if _0x7325 then _0x7325("Baixando build autorizada...",Color3.fromRGB(255,210,80)) end
    local _0xA218,_0xD936=_0x4821(_0xC397.ticket,_0x97DB.sessionToken);if not _0xA218 then return false,_0xD936 end
    if type(loadstring)~="function" then return false,"Este ambiente nao possui loadstring." end
    local _0x81E6,_0xC564=loadstring(_0xA218,"ARASAKA_PAYLOAD");_0xA218=nil
    if not _0x81E6 then return false,"Falha ao compilar payload: "..tostring(_0xC564) end
    if _0x7325 then _0x7325("ARASAKA autorizado. Iniciando...",Color3.fromRGB(80,255,120)) end
    task.wait(0.25)
    local _0x9605,_0x2B84=pcall(_0x81E6);_0x81E6=nil
    if not _0x9605 then _0x0DE1.ARASAKA_BOOTSTRAP_CONTEXT=nil;return false,"Erro ao iniciar Hub: "..tostring(_0x2B84) end
    return true
end

-- UI
local _0xF696=_0xB041:FindFirstChild("ArasakaSecureLoader");if _0xF696 then _0xF696:Destroy() end
local _0x5D82=Instance.new("ScreenGui");_0x5D82.Name="ArasakaSecureLoader";_0x5D82.ResetOnSpawn=false;_0x5D82.IgnoreGuiInset=true;_0x5D82.DisplayOrder=1000000;_0x5D82.Parent=_0xB041
local _0x2E51=Instance.new("Frame");_0x2E51.Size=UDim2.fromScale(1,1);_0x2E51.BackgroundColor3=Color3.fromRGB(2,2,3);_0x2E51.BackgroundTransparency=0.06;_0x2E51.BorderSizePixel=0;_0x2E51.Parent=_0x5D82
local _0x14D4=Instance.new("Frame");_0x14D4.AnchorPoint=Vector2.new(.5,.5);_0x14D4.Position=UDim2.fromScale(.5,.5);_0x14D4.Size=UDim2.new(0,420,0,280);_0x14D4.BackgroundColor3=Color3.fromRGB(10,10,13);_0x14D4.BorderSizePixel=0;_0x14D4.Parent=_0x2E51;Instance.new("UICorner",_0x14D4).CornerRadius=UDim.new(0,7)
local _0xBBA1=Instance.new("UIStroke",_0x14D4);_0xBBA1.Color=Color3.fromRGB(190,25,25);_0xBBA1.Thickness=1.5
local _0x18BC=Instance.new("Frame");_0x18BC.Size=UDim2.new(0,4,1,0);_0x18BC.BackgroundColor3=Color3.fromRGB(210,35,35);_0x18BC.BorderSizePixel=0;_0x18BC.Parent=_0x14D4
local _0x110C=Instance.new("TextLabel");_0x110C.BackgroundTransparency=1;_0x110C.Position=UDim2.new(0,20,0,18);_0x110C.Size=UDim2.new(1,-40,0,28);_0x110C.Font=Enum.Font.GothamBold;_0x110C.Text="ARASAKA // SECURE ACCESS";_0x110C.TextSize=16;_0x110C.TextColor3=Color3.fromRGB(245,245,245);_0x110C.TextXAlignment=Enum.TextXAlignment.Left;_0x110C.Parent=_0x14D4
local _0x24D0=Instance.new("TextLabel");_0x24D0.BackgroundTransparency=1;_0x24D0.Position=UDim2.new(0,20,0,47);_0x24D0.Size=UDim2.new(1,-40,0,20);_0x24D0.Font=Enum.Font.Code;_0x24D0.Text="UID "..UID.." // "..string.upper(_0xA00D);_0x24D0.TextSize=10;_0x24D0.TextColor3=Color3.fromRGB(115,115,120);_0x24D0.TextXAlignment=Enum.TextXAlignment.Left;_0x24D0.Parent=_0x14D4
local _0xC911=Instance.new("TextLabel");_0xC911.BackgroundTransparency=1;_0xC911.Position=UDim2.new(0,20,0,76);_0xC911.Size=UDim2.new(1,-40,0,48);_0xC911.Font=Enum.Font.Gotham;_0xC911.Text="Validando licenca...";_0xC911.TextSize=13;_0xC911.TextWrapped=true;_0xC911.TextColor3=Color3.fromRGB(190,190,195);_0xC911.TextXAlignment=Enum.TextXAlignment.Left;_0xC911.Parent=_0x14D4
local _0x3335=Instance.new("TextBox");_0x3335.Position=UDim2.new(0,20,0,134);_0x3335.Size=UDim2.new(1,-40,0,42);_0x3335.BackgroundColor3=Color3.fromRGB(20,20,25);_0x3335.BorderSizePixel=0;_0x3335.ClearTextOnFocus=false;_0x3335.PlaceholderText="UID liberado pelo Admin ou digite sua key";_0x3335.Text="";_0x3335.TextColor3=Color3.fromRGB(245,245,245);_0x3335.PlaceholderColor3=Color3.fromRGB(95,95,100);_0x3335.Font=Enum.Font.Gotham;_0x3335.TextSize=13;_0x3335.Parent=_0x14D4;Instance.new("UICorner",_0x3335).CornerRadius=UDim.new(0,5)
local _0x8605=Instance.new("TextButton");_0x8605.Position=UDim2.new(0,20,0,188);_0x8605.Size=UDim2.new(1,-40,0,40);_0x8605.BackgroundColor3=Color3.fromRGB(150,20,25);_0x8605.BorderSizePixel=0;_0x8605.Text="VALIDAR / ATIVAR";_0x8605.TextColor3=Color3.fromRGB(255,255,255);_0x8605.Font=Enum.Font.GothamBold;_0x8605.TextSize=12;_0x8605.Parent=_0x14D4;Instance.new("UICorner",_0x8605).CornerRadius=UDim.new(0,5)
local _0xF3E2=Instance.new("TextLabel");_0xF3E2.BackgroundTransparency=1;_0xF3E2.Position=UDim2.new(0,20,0,238);_0xF3E2.Size=UDim2.new(1,-40,0,24);_0xF3E2.Font=Enum.Font.Code;_0xF3E2.Text="Acesso por UID liberado no Admin OU por key // multi-conta liberado";_0xF3E2.TextSize=9;_0xF3E2.TextColor3=Color3.fromRGB(95,95,100);_0xF3E2.TextXAlignment=Enum.TextXAlignment.Left;_0xF3E2.Parent=_0x14D4
local function _0x7325(t,c) _0xC911.Text=tostring(t or "");if c then _0xC911.TextColor3=c end end
local _0x1604=false
local function _0x4F4B(v) _0x1604=v==true;_0x8605.Active=not _0x1604;_0x8605.AutoButtonColor=not _0x1604;_0x8605.Text=_0x1604 and "PROCESSANDO..." or "VALIDAR / ATIVAR" end
local function _0x6D9E() _0x8F76:Create(_0x14D4,TweenInfo.new(.18),{BackgroundTransparency=1}):Play();task.wait(.2);if _0x5D82 then _0x5D82:Destroy() end end

local function _0x2856(inputText)
    if _0x1604 then return end
    _0x4F4B(true)

    _0x7325("Validando UID...",Color3.fromRGB(255,210,80))
    local _0xECEF,_0x55CF=_0x82C5()

    if _0xECEF and _0xECEF.authorized==true then
        -- O Secure Access não pode ficar por cima da loading screen do ARASAKA.
        -- Esconde antes de executar o payload e só volta se houver erro.
        if _0x5D82 then _0x5D82.Enabled=false end
        local _0xCB8A,_0xD614=_0x084D(_0xECEF,_0x7325)
        if not _0xCB8A then
            if _0x5D82 then _0x5D82.Enabled=true end
            _0x7325(_0xD614 or "Falha ao iniciar Hub.",Color3.fromRGB(255,95,95))
            _0x4F4B(false)
            return
        end
        if _0x5D82 then _0x5D82:Destroy() end
        return
    end

    if inputText and inputText~="" then
        _0x7325("Ativando key para este UID...",Color3.fromRGB(255,210,80))
        local _0x3F68,_0x16EA=_0x2A22(inputText)
        if not _0x3F68 then
            _0x7325(_0x16EA or "Falha ao ativar key.",Color3.fromRGB(255,95,95))
            _0x4F4B(false)
            return
        end
        if _0x3F68.success~=true then
            _0x7325(_0x3F68.message or "Key recusada.",Color3.fromRGB(255,95,95))
            _0x4F4B(false)
            return
        end

        _0x7325("Licenca ativada. Criando sessao...",Color3.fromRGB(255,210,80))
        _0xECEF,_0x55CF=_0x82C5()
        if _0xECEF and _0xECEF.authorized==true then
            -- Mesmo comportamento após resgatar key: a loading screen fica limpa.
            if _0x5D82 then _0x5D82.Enabled=false end
            local _0xCB8A,_0xD614=_0x084D(_0xECEF,_0x7325)
            if not _0xCB8A then
                if _0x5D82 then _0x5D82.Enabled=true end
                _0x7325(_0xD614 or "Falha ao iniciar Hub.",Color3.fromRGB(255,95,95))
                _0x4F4B(false)
                return
            end
            if _0x5D82 then _0x5D82:Destroy() end
            return
        end
    end

    if not _0xECEF then
        _0x7325(_0x55CF or "Servidor temporariamente indisponivel.",Color3.fromRGB(255,95,95))
    else
        _0x7325(_0xECEF.message or "UID sem acesso. Libere o UID no Admin ou digite uma key.",Color3.fromRGB(255,170,70))
    end
    _0x4F4B(false)
end

_0x8605.MouseButton1Click:Connect(function() _0x2856(_0x3335.Text) end)
task.spawn(function() task.wait(.2); _0x2856(nil) end)
