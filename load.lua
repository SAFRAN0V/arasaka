local Players=game:GetService('Players')
local HS=game:GetService('HttpService')
local API='https://chatprivado-cwu3.onrender.com'
local VERSION='6.0.1' 
local FILE='ARASAKA/session_v8.json'
local PG=Players.LocalPlayer:WaitForChild('PlayerGui')
local function req(path,body)
    local fn=request or http_request or (syn and syn.request) or (http and http.request)
    if type(fn)~='function' then return nil,'Executor sem funcao request' end
    local ok,r=pcall(fn,{Url=API..path,Method='POST',Headers={['Content-Type']='application/json'},Body=HS:JSONEncode(body)})
    if not ok or type(r)~='table' then return nil,'Falha de conexao' end
    local code=tonumber(r.StatusCode or r.Status or r.status_code) or 0
    local raw=tostring(r.Body or r.body or '')
    return {code=code,body=raw}
end
local function json(path,body)
    local r,e=req(path,body)
    if not r then return nil,e end
    local ok,v=pcall(HS.JSONDecode,HS,r.body)
    if not ok or type(v)~='table' then return nil,'Resposta invalida: '..tostring(r.code) end
    return v, (r.code==200 and nil or tostring(v.status or 'HTTP '..r.code))
end
local function save(token)
    if type(writefile)~='function' then return false end
    if type(makefolder)=='function' then pcall(makefolder,'ARASAKA') end
    return pcall(writefile,FILE,HS:JSONEncode({sessionToken=token}))
end
local function clear()
    if type(delfile)=='function' then pcall(delfile,FILE)
    elseif type(writefile)=='function' then pcall(writefile,FILE,'{}') end
end
local function stored()
    if type(readfile)~='function' then return nil end
    local ok,v=pcall(readfile,FILE)
    if not ok then return nil end
    local valid,data=pcall(HS.JSONDecode,HS,v)
    if valid and type(data)=='table' and type(data.sessionToken)=='string' then return data.sessionToken end
end
local function launch(token)
    local status,err=json('/api/v8/status',{sessionToken=token})
    if not status or not status.success then return false,err or 'Licenca invalida ou expirada' end
    local result,e=req('/api/v8/script',{sessionToken=token,version=VERSION})
    if not result then return false,e end
    if result.code~=200 then return false,'Script nao disponivel (HTTP '..tostring(result.code)..'): '..result.body:sub(1,120) end
    local compiler=loadstring
    if type(compiler)~='function' then return false,'Executor nao oferece loadstring' end
    local chunk,compErr=compiler(result.body)
    if not chunk then return false,'Falha ao compilar hub: '..tostring(compErr) end
    task.spawn(function()
        local ok, runtimeErr = xpcall(chunk, function(e) return tostring(e) .. '\n' .. tostring(debug and debug.traceback and debug.traceback() or '') end)
        if not ok then
            warn('[ARASAKA V8 HUB ERROR]', runtimeErr)
            info.Text = 'ERRO NO PREMIUM: ' .. tostring(runtimeErr):sub(1,220)
            frame.Visible = true
        else
            info.Text = 'Premium inicializado (execucao principal encerrada). Confirme se a UI abriu.'
        end
    end)
    return true
end
local gui=Instance.new('ScreenGui')
gui.Name='ArasakaSecurityV8';gui.ResetOnSpawn=false
pcall(function() gui.Parent=gethui() end)
if not gui.Parent then gui.Parent=PG end
local frame=Instance.new('Frame',gui)
frame.Size=UDim2.fromOffset(360,210);frame.Position=UDim2.new(.5,-180,.5,-105)
frame.BackgroundColor3=Color3.fromRGB(17,17,22);frame.BorderSizePixel=0
Instance.new('UICorner',frame).CornerRadius=UDim.new(0,12)
local title=Instance.new('TextLabel',frame)
title.Size=UDim2.new(1,-20,0,48);title.Position=UDim2.fromOffset(10,10)
title.Text='ARASAKA  |  LOGIN V8';title.Font=Enum.Font.GothamBold;title.TextSize=19
title.TextColor3=Color3.fromRGB(225,60,65);title.BackgroundTransparency=1
local entry=Instance.new('TextBox',frame)
entry.Size=UDim2.new(1,-32,0,42);entry.Position=UDim2.fromOffset(16,68)
entry.PlaceholderText='Cole sua key Arasaka';entry.Text='';entry.ClearTextOnFocus=false
entry.BackgroundColor3=Color3.fromRGB(35,35,42);entry.TextColor3=Color3.new(1,1,1)
entry.PlaceholderColor3=Color3.fromRGB(165,165,170);entry.Font=Enum.Font.Gotham;entry.TextSize=13
Instance.new('UICorner',entry).CornerRadius=UDim.new(0,8)
local btn=Instance.new('TextButton',frame)
btn.Size=UDim2.new(1,-32,0,40);btn.Position=UDim2.fromOffset(16,120)
btn.Text='ENTRAR';btn.Font=Enum.Font.GothamBold;btn.TextSize=15
btn.TextColor3=Color3.new(1,1,1);btn.BackgroundColor3=Color3.fromRGB(148,30,36)
Instance.new('UICorner',btn).CornerRadius=UDim.new(0,8)
local info=Instance.new('TextLabel',frame)
info.Size=UDim2.new(1,-24,0,40);info.Position=UDim2.fromOffset(12,166)
info.Text='Licenca valida em PC, celular e contas diferentes.'
info.TextWrapped=true;info.TextSize=12;info.Font=Enum.Font.Gotham
info.TextColor3=Color3.fromRGB(210,210,215);info.BackgroundTransparency=1
local busy=false
local function start(token)
   local ok,err=launch(token)
   if ok then info.Text='Login V8 confirmado. Carregando Premium...';return true end
   info.Text=tostring(err or 'Falha no login')
   return false
end
btn.MouseButton1Click:Connect(function()
   if busy then return end
   local key=entry.Text:gsub('^%s+',''):gsub('%s+$','')
   if #key<8 then info.Text='Digite sua key';return end
   busy=true;btn.Text='VERIFICANDO...'
   local login,e=json('/api/v8/login',{key=key})
   if login and login.success and login.sessionToken then
      entry.Text='';save(login.sessionToken)
      start(login.sessionToken)
   else info.Text='Login recusado: '..tostring(e or (login and login.status) or 'erro de rede') end
   busy=false;btn.Text='ENTRAR'
end)
task.spawn(function()
 local token=stored()
 if token then
   info.Text='Verificando login salvo...'
   local ok=start(token)
   if not ok then
      local state=json('/api/v8/status',{sessionToken=token})
      if state and state.status=='session_expired' then clear() end
   end
 end
end)
