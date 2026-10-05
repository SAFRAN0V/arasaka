local _0x3CDD = game:GetService("Players")
local _0xA21E = game:GetService("HttpService")
local _0xA808 = game:GetService("TweenService")
local _0x1E9E = game:GetService("UserInputService")
local _0x6A1E = _0x3CDD.LocalPlayer
local _0xA993 = _0x6A1E:WaitForChild("PlayerGui")
local _0xC8FC = tostring(_0x6A1E.UserId)
local _0xDDB9 ="https://chatprivado-cwu3.onrender.com"local _0xE4DB ="6.0.0"local _0xA59A = _0xA21E:GenerateGUID(false)
local _0x47AD ="http://127.0.0.1:27183"local _0x37B5 ="ARASAKA"local _0x20DA = _0x37B5 .."/device.json"local _0xA30F = _0x37B5 .."/device_".. _0xC8FC ..".json"local function _0x8981()
if type(getgenv) =="function"then
local _0xF43B, _0x0572 = pcall(getgenv)
if _0xF43B and type(_0x0572) =="table"then return _0x0572 end
end
return _G
end
local _0xB413 = _0x8981()
local function _0x705C()
return request or http_request or (syn and syn.request) or (Fluxus and Fluxus.request) or (http and http.request)
end
local function _0xC4A6(method, url, bodyTable)
local _0xEA78 = _0x705C()
local _0x3127 = bodyTable and _0xA21E:JSONEncode(bodyTable) or nil
if _0xEA78 then
local _0xF43B, _0x1238 = pcall(function()
return _0xEA78({Url=url,Method=method,Headers={["Content-Type"]="application/json",["Cache-Control"]="no-cache"},Body=_0x3127})
end)
if not _0xF43B or type(_0x1238) ~="table"then return nil,nil,"Falha de rede"end
return tonumber(_0x1238.StatusCode or _0x1238.Status or _0x1238.status_code) or 0, tostring(_0x1238.Body or _0x1238.body or""), nil
end
if method =="POST"then
local _0xF43B, _0x09A7 = pcall(function() return game:HttpPost(url, _0x3127 or"{}", Enum.HttpContentType.ApplicationJson) end)
if not _0xF43B then return nil,nil,"Falha de rede"end
return 200,tostring(_0x09A7),nil
end
return nil,nil,"Ambiente sem request HTTP compativel"end
local function _0x3F2D(method, path, bodyTable)
local _0xF949, _0x09A7, _0x4B18 = _0xC4A6(method, _0xDDB9 .. path, bodyTable)
if not _0x09A7 then return nil, _0x4B18 or"Falha de rede", _0xF949 end
local _0xF43B, _0x8750 = pcall(function() return _0xA21E:JSONDecode(_0x09A7) end)
if not _0xF43B or type(_0x8750) ~="table"then return nil,"Resposta invalida do servidor",_0xF949 end
return _0x8750,nil,_0xF949
end
local function _0xB491()
local _0xF43B, _0x0172 = pcall(function() return tostring(_0x1E9E:GetPlatform()) end)
_0x0172 = _0xF43B and string.lower(_0x0172 or"") or""if string.find(_0x0172,"windows",1,true) then return"windows"end
if string.find(_0x0172,"android",1,true) then return"android"end
if string.find(_0x0172,"ios",1,true) then return"ios"end
return"other"end
local _0xB44F = _0xB491()
local function _0x6AFD()
return type(readfile)=="function"and type(writefile)=="function"end
local function _0x1603(_0xD50D)
if not _0x6AFD() then return false,"Este executor nao oferece readfile/writefile para salvar a instalacao."end
if type(makefolder)=="function"then pcall(function() makefolder(_0x37B5) end) end
local _0xF43B, _0x09A7 = pcall(function() return _0xA21E:JSONEncode(_0xD50D) end)
if not _0xF43B then return false,"Falha ao serializar dispositivo."end
local _0xE8B8, _0x8E67 = pcall(function() writefile(_0xA30F, _0x09A7) end)
if not _0xE8B8 then return false,"Falha ao salvar dispositivo: "..tostring(_0x8E67) end
return true
end
local function _0x87C0(path)
local _0x3366 = false
if type(isfile) =="function"then
pcall(function() _0x3366 = isfile(path) end)
else
local _0xF43B = pcall(function() readfile(path) end)
_0x3366 = _0xF43B
end
if not _0x3366 then return nil end
local _0xF43B, _0x09A7 = pcall(function() return readfile(path) end)
if not _0xF43B or type(_0x09A7) ~="string"then return nil end
local _0x96C0, _0x8750 = pcall(function() return _0xA21E:JSONDecode(_0x09A7) end)
if not _0x96C0 or type(_0x8750) ~="table"then return nil end
if tostring(_0x8750.uid or"") ~= _0xC8FC or type(_0x8750.deviceId) ~="string"then return nil end
_0x8750.platform = _0xB44F
return _0x8750
end
local function _0xA09D()
local _0xD50D = {uid=_0xC8FC,platform=_0xB44F,deviceId=_0xA21E:GenerateGUID(false),installToken=nil}
if not _0x6AFD() then return _0xD50D,false endlocal _0x8751 = _0x87C0(_0xA30F)
if _0x8751 then
return _0x8751,true
endlocal _0x217A = _0x87C0(_0x20DA)
if _0x217A then
_0xD50D = _0x217A
pcall(function() _0x1603(_0xD50D) end)
end
return _0xD50D,true
end
local _0x3935, _0xF634 = _0xA09D()
local function _0xC716(path, bodyTable)
local _0xF949, _0x09A7, _0x4B18 = _0xC4A6("POST", _0x47AD .. path, bodyTable)
if not _0x09A7 or (_0xF949~=0 and _0xF949~=200) then return nil,_0x4B18 or"ARASAKA Auth offline"end
local _0xF43B, _0x8750=pcall(function() return _0xA21E:JSONDecode(_0x09A7) end)
if not _0xF43B or type(_0x8750)~="table"then return nil,"Resposta invalida do ARASAKA Auth"end
return _0x8750,nil
end
local function _0x0C15()
if _0xB44F~="windows"then return true end
local _0x55F0,_0x4B18=_0xC716("/register",{api=_0xDDB9,uid=_0xC8FC,deviceId=_0x3935.deviceId,installToken=_0x3935.installToken})
if not _0x55F0 or _0x55F0.success~=true then return false,(_0x55F0 and _0x55F0.message) or _0x4B18 or"Abra ARASAKA Auth.exe"end
return true
end
local function _0x9FF8(useSessionToken)
local _0x3127={uid=_0xC8FC,version=_0xE4DB,deviceId=_0x3935.deviceId}
if useSessionToken then _0x3127.sessionToken=useSessionToken else _0x3127.installToken=_0x3935.installToken end
local _0x9603,_0x4B18=_0x3F2D("POST","/api/device/challenge",_0x3127)
if not _0x9603 then return nil,_0x4B18 end
if _0x9603.required~=true then return {required=false} end
local _0xF608,_0x85AE=_0xC716("/sign",{challengeId=_0x9603.challengeId,nonce=_0x9603.nonce,uid=_0xC8FC,deviceId=_0x3935.deviceId})
if not _0xF608 or _0xF608.success~=true or type(_0xF608.signature)~="string"then return nil,(_0xF608 and _0xF608.message) or _0x85AE or"ARASAKA Auth nao respondeu"end
return {required=true,challengeId=_0x9603.challengeId,signature=_0xF608.signature}
end
local function _0xFFBB()
return _0x3F2D("POST","/api/bootstrap",{
uid=_0xC8FC,
version=_0xE4DB,
fingerprint=_0xA59A
})
end
local function _0x9CF4(keyText)
return _0x3F2D("POST","/api/redeem-key",{key=keyText,uid=_0xC8FC,version=_0xE4DB})
end
local function _0x2ECA(code)
return _0x3F2D("POST","/api/device/enroll-pair",{pairCode=code,uid=_0xC8FC,version=_0xE4DB,platform=_0xB44F,deviceId=_0x3935.deviceId})
end
local function _0xD83E(_0x1238)
if type(_0x1238)~="table"or type(_0x1238.installToken)~="string"or _0x1238.installToken==""then return false,"Servidor nao entregou token da instalacao."end
_0x3935.uid=_0xC8FC;_0x3935.platform=_0xB44F;_0x3935.deviceId=_0x1238.deviceId or _0x3935.deviceId;_0x3935.installToken=_0x1238.installToken
local _0xF43B,_0x4B18=_0x1603(_0x3935)
if not _0xF43B then return false,_0x4B18 end
if _0x1238.companionRequired==true then
local _0xD800,_0x3BCD=_0x0C15()
if not _0xD800 then return false,_0x3BCD end
end
return true
end
local function _0x52D3(sessionToken)
return _0x3F2D("POST","/api/script-ticket",{uid=_0xC8FC,version=_0xE4DB,sessionToken=sessionToken})
end
local function _0xFAA5(ticket,sessionToken)
local _0xF949,_0xE7F8,_0x4B18=_0xC4A6("POST",_0xDDB9.."/api/script",{ticket=ticket,uid=_0xC8FC,version=_0xE4DB,sessionToken=sessionToken})
if not _0xE7F8 then return nil,_0x4B18 or"Falha ao baixar Hub"end
if _0xF949~=0 and _0xF949~=200 then return nil,"Servidor recusou o download (HTTP "..tostring(_0xF949)..")"end
if #_0xE7F8<100 then return nil,"Payload invalido: "..tostring(_0xE7F8) end
return _0xE7F8,nil
end
local function _0xAD16(moduleName,sessionToken)
return _0x3F2D("POST","/api/module-ticket",{
uid=_0xC8FC,
version=_0xE4DB,
module=moduleName,
sessionToken=sessionToken
})
end
local function _0x0243(moduleName,ticket,sessionToken)
local _0xF949,_0xE7F8,_0x4B18=_0xC4A6("POST",_0xDDB9.."/api/module",{
ticket=ticket,
uid=_0xC8FC,
version=_0xE4DB,
module=moduleName,
sessionToken=sessionToken
})
if not _0xE7F8 then return nil,_0x4B18 or"Falha ao baixar modulo"end
if _0xF949~=0 and _0xF949~=200 then
return nil,"Servidor recusou o modulo (HTTP "..tostring(_0xF949).."): "..tostring(_0xE7F8)
end
if #_0xE7F8<20 then return nil,"Modulo invalido: "..tostring(_0xE7F8) end
return _0xE7F8,nil
end
local _0x37D8={}
local _0xCA96={}
local function _0x1E49(moduleName)
moduleName=string.lower(tostring(moduleName or"")):gsub("[^%w_-]","")
if moduleName==""then return nil,"Nome de modulo invalido"end
if _0x37D8[moduleName] then
return _0xCA96[moduleName],nil
end
local _0xC1CC=_0xB413.ARASAKA_BOOTSTRAP_CONTEXT
if type(_0xC1CC)~="table"or type(_0xC1CC.sessionToken)~="string"then
return nil,"Sessao ARASAKA indisponivel"end
local _0x97E7,_0x8C8C=_0xAD16(moduleName,_0xC1CC.sessionToken)
if not _0x97E7 or _0x97E7.success~=true or type(_0x97E7.ticket)~="string"then
return nil,(_0x97E7 and _0x97E7.message) or _0x8C8C or"Falha ao emitir ticket do modulo"end
local _0xE7F8,_0xB254=_0x0243(moduleName,_0x97E7.ticket,_0xC1CC.sessionToken)
if not _0xE7F8 then return nil,_0xB254 end
if type(loadstring)~="function"then
return nil,"Este ambiente nao possui loadstring"end
local _0x1E31,_0x77F4=loadstring(_0xE7F8,"ARASAKA_MODULE_"..string.upper(moduleName))
_0xE7F8=nil
if not _0x1E31 then
return nil,"Falha ao compilar modulo "..moduleName..": "..tostring(_0x77F4)
end
local _0xF43B,_0x2504=pcall(_0x1E31)
_0x1E31=nil
if not _0xF43B then
return nil,"Erro ao iniciar modulo "..moduleName..": "..tostring(_0x2504)
end
local _0xFA0D=_0xB413.ARASAKA_SHARED
if type(_0x2504)=="function"then
local _0x984C,_0x11FB=pcall(_0x2504,_0xFA0D,_0xC1CC)
if not _0x984C then
return nil,"Erro no Init do modulo "..moduleName..": "..tostring(_0x11FB)
end
_0x2504=_0x11FB
elseif type(_0x2504)=="table"and type(_0x2504.Init)=="function"then
local _0x984C,_0x3F47=pcall(function()
_0x2504:Init(_0xFA0D,_0xC1CC)
end)
if not _0x984C then
return nil,"Erro no Init do modulo "..moduleName..": "..tostring(_0x3F47)
end
end
_0x37D8[moduleName]=true
_0xCA96[moduleName]=_0x2504
return _0x2504,nil
end
_0xB413.ARASAKA_MODULE_LOADER={
Load=_0x1E49,
IsLoaded=function(moduleName)
moduleName=string.lower(tostring(moduleName or""))
return _0x37D8[moduleName]==true
end,
Get=function(moduleName)
moduleName=string.lower(tostring(moduleName or""))
return _0xCA96[moduleName]
end
}
local function _0x18DB(_0x1238)
local _0x0335=_0x1238 and _0x1238.sessionToken
if type(_0x0335)~="string"or _0x0335==""then return nil,"Servidor nao entregou sessionToken"end
local _0xC1CC={
api=_0xDDB9,uid=_0xC8FC,version=_0xE4DB,sessionToken=_0x0335,sessionExpiresAt=tonumber(_0x1238.sessionExpiresAt),
licenseExpiresAt=tonumber(_0x1238.expiresAt),isLifetime=_0x1238.isLifetime==true,
heartbeatSeconds=tonumber(_0x1238.heartbeatSeconds) or 60,offlineGraceSeconds=tonumber(_0x1238.offlineGraceSeconds) or 600,
controlEpoch=tonumber(_0x1238.controlEpoch),clientInstanceId=_0xA59A,lastServerOkAt=os.time(),
deviceId=_0x3935.deviceId,platform=_0xB44F,companionRequired=false,companionUrl=nil
}
_0xB413.ARASAKA_BOOTSTRAP_CONTEXT=_0xC1CC
return _0xC1CC
end
local function _0x9EBC(authResponse,_0x6F6D)
local _0xC1CC,_0xEEB0=_0x18DB(authResponse);if not _0xC1CC then return false,_0xEEB0 end
if _0x6F6D then _0x6F6D("Solicitando ticket seguro...",Color3.fromRGB(255,210,80)) end
local _0x07EB,_0xCEB1=_0x52D3(_0xC1CC.sessionToken)
if not _0x07EB or _0x07EB.success~=true or type(_0x07EB.ticket)~="string"then return false,(_0x07EB and _0x07EB.message) or _0xCEB1 or"Falha ao emitir ticket"end
if _0x6F6D then _0x6F6D("Baixando build autorizada...",Color3.fromRGB(255,210,80)) end
local _0xE7F8,_0xCB3D=_0xFAA5(_0x07EB.ticket,_0xC1CC.sessionToken);if not _0xE7F8 then return false,_0xCB3D end
if type(loadstring)~="function"then return false,"Este ambiente nao possui loadstring."end
local _0x1E31,_0x314D=loadstring(_0xE7F8,"ARASAKA_PAYLOAD");_0xE7F8=nil
if not _0x1E31 then return false,"Falha ao compilar payload: "..tostring(_0x314D) end
if _0x6F6D then _0x6F6D("ARASAKA autorizado. Iniciando...",Color3.fromRGB(80,255,120)) end
task.wait(0.25)
local _0xF43B,_0x0D0D=pcall(_0x1E31);_0x1E31=nil
if not _0xF43B then _0xB413.ARASAKA_BOOTSTRAP_CONTEXT=nil;return false,"Erro ao iniciar Hub: "..tostring(_0x0D0D) end
return true
endlocal _0xA948=_0xA993:FindFirstChild("ArasakaSecureLoader");if _0xA948 then _0xA948:Destroy() end
local _0xDA90=Instance.new("ScreenGui");_0xDA90.Name="ArasakaSecureLoader";_0xDA90.ResetOnSpawn=false;_0xDA90.IgnoreGuiInset=true;_0xDA90.DisplayOrder=1000000;_0xDA90.Parent=_0xA993
local _0xF396=Instance.new("Frame");_0xF396.Size=UDim2.fromScale(1,1);_0xF396.BackgroundColor3=Color3.fromRGB(2,2,3);_0xF396.BackgroundTransparency=0.06;_0xF396.BorderSizePixel=0;_0xF396.Parent=_0xDA90
local _0xFEF1=Instance.new("Frame");_0xFEF1.AnchorPoint=Vector2.new(.5,.5);_0xFEF1.Position=UDim2.fromScale(.5,.5);_0xFEF1.Size=UDim2.new(0,420,0,280);_0xFEF1.BackgroundColor3=Color3.fromRGB(10,10,13);_0xFEF1.BorderSizePixel=0;_0xFEF1.Parent=_0xF396;Instance.new("UICorner",_0xFEF1).CornerRadius=UDim.new(0,7)
local _0xF18B=Instance.new("UIStroke",_0xFEF1);_0xF18B.Color=Color3.fromRGB(190,25,25);_0xF18B.Thickness=1.5
local _0xD070=Instance.new("Frame");_0xD070.Size=UDim2.new(0,4,1,0);_0xD070.BackgroundColor3=Color3.fromRGB(210,35,35);_0xD070.BorderSizePixel=0;_0xD070.Parent=_0xFEF1
local _0x1912=Instance.new("TextLabel");_0x1912.BackgroundTransparency=1;_0x1912.Position=UDim2.new(0,20,0,18);_0x1912.Size=UDim2.new(1,-40,0,28);_0x1912.Font=Enum.Font.GothamBold;_0x1912.Text="ARASAKA // SECURE ACCESS";_0x1912.TextSize=16;_0x1912.TextColor3=Color3.fromRGB(245,245,245);_0x1912.TextXAlignment=Enum.TextXAlignment.Left;_0x1912.Parent=_0xFEF1
local _0x8AB2=Instance.new("TextLabel");_0x8AB2.BackgroundTransparency=1;_0x8AB2.Position=UDim2.new(0,20,0,47);_0x8AB2.Size=UDim2.new(1,-40,0,20);_0x8AB2.Font=Enum.Font.Code;_0x8AB2.Text="UID "..UID.." // "..string.upper(_0xB44F);_0x8AB2.TextSize=10;_0x8AB2.TextColor3=Color3.fromRGB(115,115,120);_0x8AB2.TextXAlignment=Enum.TextXAlignment.Left;_0x8AB2.Parent=_0xFEF1
local _0x5094=Instance.new("TextLabel");_0x5094.BackgroundTransparency=1;_0x5094.Position=UDim2.new(0,20,0,76);_0x5094.Size=UDim2.new(1,-40,0,48);_0x5094.Font=Enum.Font.Gotham;_0x5094.Text="Validando licenca...";_0x5094.TextSize=13;_0x5094.TextWrapped=true;_0x5094.TextColor3=Color3.fromRGB(190,190,195);_0x5094.TextXAlignment=Enum.TextXAlignment.Left;_0x5094.Parent=_0xFEF1
local _0x9DA5=Instance.new("TextBox");_0x9DA5.Position=UDim2.new(0,20,0,134);_0x9DA5.Size=UDim2.new(1,-40,0,42);_0x9DA5.BackgroundColor3=Color3.fromRGB(20,20,25);_0x9DA5.BorderSizePixel=0;_0x9DA5.ClearTextOnFocus=false;_0x9DA5.PlaceholderText="UID liberado pelo Admin ou digite sua key";_0x9DA5.Text="";_0x9DA5.TextColor3=Color3.fromRGB(245,245,245);_0x9DA5.PlaceholderColor3=Color3.fromRGB(95,95,100);_0x9DA5.Font=Enum.Font.Gotham;_0x9DA5.TextSize=13;_0x9DA5.Parent=_0xFEF1;Instance.new("UICorner",_0x9DA5).CornerRadius=UDim.new(0,5)
local _0xEA4D=Instance.new("TextButton");_0xEA4D.Position=UDim2.new(0,20,0,188);_0xEA4D.Size=UDim2.new(1,-40,0,40);_0xEA4D.BackgroundColor3=Color3.fromRGB(150,20,25);_0xEA4D.BorderSizePixel=0;_0xEA4D.Text="VALIDAR / ATIVAR";_0xEA4D.TextColor3=Color3.fromRGB(255,255,255);_0xEA4D.Font=Enum.Font.GothamBold;_0xEA4D.TextSize=12;_0xEA4D.Parent=_0xFEF1;Instance.new("UICorner",_0xEA4D).CornerRadius=UDim.new(0,5)
local _0x119E=Instance.new("TextLabel");_0x119E.BackgroundTransparency=1;_0x119E.Position=UDim2.new(0,20,0,238);_0x119E.Size=UDim2.new(1,-40,0,24);_0x119E.Font=Enum.Font.Code;_0x119E.Text="Acesso por UID liberado no Admin OU por key // multi-conta liberado";_0x119E.TextSize=9;_0x119E.TextColor3=Color3.fromRGB(95,95,100);_0x119E.TextXAlignment=Enum.TextXAlignment.Left;_0x119E.Parent=_0xFEF1
local function _0x6F6D(t,c) _0x5094.Text=tostring(t or"");if c then _0x5094.TextColor3=c end end
local _0x900A=false
local function _0x1E97(v) _0x900A=v==true;_0xEA4D.Active=not _0x900A;_0xEA4D.AutoButtonColor=not _0x900A;_0xEA4D.Text=_0x900A and"PROCESSANDO..."or"VALIDAR / ATIVAR"end
local function _0x8E38() _0xA808:Create(_0xFEF1,TweenInfo.new(.18),{BackgroundTransparency=1}):Play();task.wait(.2);if _0xDA90 then _0xDA90:Destroy() end end
local function _0x6F48(inputText)
if _0x900A then return end
_0x1E97(true)
_0x6F6D("Validando UID...",Color3.fromRGB(255,210,80))
local _0x1238,_0x4B18=_0xFFBB()
if _0x1238 and _0x1238.authorized==true thenif _0xDA90 then _0xDA90.Enabled=false end
local _0x5CA8,_0xDD69=_0x9EBC(_0x1238,_0x6F6D)
if not _0x5CA8 then
if _0xDA90 then _0xDA90.Enabled=true end
_0x6F6D(_0xDD69 or"Falha ao iniciar Hub.",Color3.fromRGB(255,95,95))
_0x1E97(false)
return
end
if _0xDA90 then _0xDA90:Destroy() end
return
end
if inputText and inputText~=""then
_0x6F6D("Ativando key para este UID...",Color3.fromRGB(255,210,80))
local _0x9852,_0x5F0C=_0x9CF4(inputText)
if not _0x9852 then
_0x6F6D(_0x5F0C or"Falha ao ativar key.",Color3.fromRGB(255,95,95))
_0x1E97(false)
return
end
if _0x9852.success~=true then
_0x6F6D(_0x9852.message or"Key recusada.",Color3.fromRGB(255,95,95))
_0x1E97(false)
return
end
_0x6F6D("Licenca ativada. Criando sessao...",Color3.fromRGB(255,210,80))
_0x1238,_0x4B18=_0xFFBB()
if _0x1238 and _0x1238.authorized==true thenif _0xDA90 then _0xDA90.Enabled=false end
local _0x5CA8,_0xDD69=_0x9EBC(_0x1238,_0x6F6D)
if not _0x5CA8 then
if _0xDA90 then _0xDA90.Enabled=true end
_0x6F6D(_0xDD69 or"Falha ao iniciar Hub.",Color3.fromRGB(255,95,95))
_0x1E97(false)
return
end
if _0xDA90 then _0xDA90:Destroy() end
return
end
end
if not _0x1238 then
_0x6F6D(_0x4B18 or"Servidor temporariamente indisponivel.",Color3.fromRGB(255,95,95))
else
_0x6F6D(_0x1238.message or"UID sem acesso. Libere o UID no Admin ou digite uma key.",Color3.fromRGB(255,170,70))
end
_0x1E97(false)
end
_0xEA4D.MouseButton1Click:Connect(function() _0x6F48(_0x9DA5.Text) end)
task.spawn(function() task.wait(.2); _0x6F48(nil) end)
