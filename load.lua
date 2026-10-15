-- ARASAKA V8 | Loader de diagnostico | ofuscacao sem loadstring na inicializacao
local Players=game:GetService("\080\108\097\121\101\114\115")
local HS=game:GetService("\072\116\116\112\083\101\114\118\105\099\101")
local API="\104\116\116\112\115\058\047\047\099\104\097\116\112\114\105\118\097\100\111\045\099\119\117\051\046\111\110\114\101\110\100\101\114\046\099\111\109"
local VERSION="\054\046\048\046\048"
local FILE="\065\082\065\083\065\075\065\047\115\101\115\115\105\111\110\095\118\056\046\106\115\111\110"
local PG=Players.LocalPlayer:WaitForChild("\080\108\097\121\101\114\071\117\105")
local function req(path,body)
    local fn=request or http_request or (syn and syn.request) or (http and http.request)
    if type(fn)~="\102\117\110\099\116\105\111\110" then return nil,"\069\120\101\099\117\116\111\114\032\115\101\109\032\102\117\110\099\097\111\032\114\101\113\117\101\115\116" end
    local ok,r=pcall(fn,{Url=API..path,Method="\080\079\083\084",Headers={["\067\111\110\116\101\110\116\045\084\121\112\101"]="\097\112\112\108\105\099\097\116\105\111\110\047\106\115\111\110"},Body=HS:JSONEncode(body)})
    if not ok or type(r)~="\116\097\098\108\101" then return nil,"\070\097\108\104\097\032\100\101\032\099\111\110\101\120\097\111" end
    local code=tonumber(r.StatusCode or r.Status or r.status_code) or 0
    local raw=tostring(r.Body or r.body or "")
    return {code=code,body=raw}
end
local function json(path,body)
    local r,e=req(path,body)
    if not r then return nil,e end
    local ok,v=pcall(HS.JSONDecode,HS,r.body)
    if not ok or type(v)~="\116\097\098\108\101" then return nil,"\082\101\115\112\111\115\116\097\032\105\110\118\097\108\105\100\097\058\032"..tostring(r.code) end
    return v, (r.code==200 and nil or tostring(v.status or "\072\084\084\080\032"..r.code))
end
local function save(token)
    if type(writefile)~="\102\117\110\099\116\105\111\110" then return false end
    if type(makefolder)=="\102\117\110\099\116\105\111\110" then pcall(makefolder,"\065\082\065\083\065\075\065") end
    return pcall(writefile,FILE,HS:JSONEncode({sessionToken=token}))
end
local function clear()
    if type(delfile)=="\102\117\110\099\116\105\111\110" then pcall(delfile,FILE)
    elseif type(writefile)=="\102\117\110\099\116\105\111\110" then pcall(writefile,FILE,"\123\125") end
end
local function stored()
    if type(readfile)~="\102\117\110\099\116\105\111\110" then return nil end
    local ok,v=pcall(readfile,FILE)
    if not ok then return nil end
    local valid,data=pcall(HS.JSONDecode,HS,v)
    if valid and type(data)=="\116\097\098\108\101" and type(data.sessionToken)=="\115\116\114\105\110\103" then return data.sessionToken end
end
local function launch(token)
    local status,err=json("\047\097\112\105\047\118\056\047\115\116\097\116\117\115",{sessionToken=token})
    if not status or not status.success then return false,err or "\076\105\099\101\110\099\097\032\105\110\118\097\108\105\100\097\032\111\117\032\101\120\112\105\114\097\100\097" end
    local result,e=req("\047\097\112\105\047\118\056\047\115\099\114\105\112\116",{sessionToken=token,version=VERSION})
    if not result then return false,e end
    if result.code~=200 then return false,"\083\099\114\105\112\116\032\110\097\111\032\100\105\115\112\111\110\105\118\101\108\032\040\072\084\084\080\032"..tostring(result.code).."\041\058\032"..result.body:sub(1,120) end
    local compiler=loadstring
    if type(compiler)~="\102\117\110\099\116\105\111\110" then return false,"\069\120\101\099\117\116\111\114\032\110\097\111\032\111\102\101\114\101\099\101\032\108\111\097\100\115\116\114\105\110\103" end
    local chunk,compErr=compiler(result.body)
    if not chunk then return false,"\070\097\108\104\097\032\097\111\032\099\111\109\112\105\108\097\114\032\104\117\098\058\032"..tostring(compErr) end
    local executed, executionError = pcall(chunk)
    if not executed then
        return false, "\069\114\114\111\032\110\111\032\072\117\098\058\032" .. tostring(executionError)
    end
    return true
end
local gui=Instance.new("\083\099\114\101\101\110\071\117\105")
gui.Name="\065\114\097\115\097\107\097\083\101\099\117\114\105\116\121\086\056";gui.ResetOnSpawn=false
pcall(function() gui.Parent=gethui() end)
if not gui.Parent then gui.Parent=PG end
local frame=Instance.new("\070\114\097\109\101",gui)
frame.Size=UDim2.fromOffset(380,248);frame.Position=UDim2.new(.5,-190,.5,-124)
frame.BackgroundColor3=Color3.fromRGB(17,17,22);frame.BorderSizePixel=0
Instance.new("\085\073\067\111\114\110\101\114",frame).CornerRadius=UDim.new(0,12)
local title=Instance.new("\084\101\120\116\076\097\098\101\108",frame)
title.Size=UDim2.new(1,-20,0,48);title.Position=UDim2.fromOffset(10,10)
title.Text="\065\082\065\083\065\075\065\032\032\124\032\032\076\079\071\073\078\032\086\056";title.Font=Enum.Font.GothamBold;title.TextSize=19
title.TextColor3=Color3.fromRGB(225,60,65);title.BackgroundTransparency=1
local entry=Instance.new("\084\101\120\116\066\111\120",frame)
entry.Size=UDim2.new(1,-32,0,42);entry.Position=UDim2.fromOffset(16,68)
entry.PlaceholderText="\067\111\108\101\032\115\117\097\032\107\101\121\032\065\114\097\115\097\107\097";entry.Text="";entry.ClearTextOnFocus=false
entry.BackgroundColor3=Color3.fromRGB(35,35,42);entry.TextColor3=Color3.new(1,1,1)
entry.PlaceholderColor3=Color3.fromRGB(165,165,170);entry.Font=Enum.Font.Gotham;entry.TextSize=13
Instance.new("\085\073\067\111\114\110\101\114",entry).CornerRadius=UDim.new(0,8)
local btn=Instance.new("\084\101\120\116\066\117\116\116\111\110",frame)
btn.Size=UDim2.new(1,-32,0,40);btn.Position=UDim2.fromOffset(16,120)
btn.Text="\069\078\084\082\065\082";btn.Font=Enum.Font.GothamBold;btn.TextSize=15
btn.TextColor3=Color3.new(1,1,1);btn.BackgroundColor3=Color3.fromRGB(148,30,36)
Instance.new("\085\073\067\111\114\110\101\114",btn).CornerRadius=UDim.new(0,8)
local info=Instance.new("\084\101\120\116\076\097\098\101\108",frame)
info.Size=UDim2.new(1,-24,0,78);info.Position=UDim2.fromOffset(12,166)
info.Text="\076\105\099\101\110\099\097\032\118\097\108\105\100\097\032\101\109\032\080\067\044\032\099\101\108\117\108\097\114\032\101\032\099\111\110\116\097\115\032\100\105\102\101\114\101\110\116\101\115\046"
info.TextWrapped=true;info.TextYAlignment=Enum.TextYAlignment.Top;info.TextSize=12;info.Font=Enum.Font.Gotham
info.TextColor3=Color3.fromRGB(210,210,215);info.BackgroundTransparency=1
local busy=false
local function showError(message)
   local msg=tostring(message or "\069\114\114\111\032\100\101\115\099\111\110\104\101\099\105\100\111")
   info.Text=msg
   warn("\091\065\082\065\083\065\075\065\032\086\056\093\032"..msg)
end
local function start(token)
   info.Text="\086\097\108\105\100\097\110\100\111\032\108\105\099\101\110\195\167\097\032\101\032\099\097\114\114\101\103\097\110\100\111\032\080\114\101\109\105\117\109\046\046\046"
   local ok,err=launch(token)
   if ok then
      info.Text="\072\117\098\032\101\120\101\099\117\116\097\100\111\046\032\083\101\032\097\032\105\110\116\101\114\102\097\099\101\032\110\097\111\032\097\112\097\114\101\099\101\114\044\032\111\032\080\114\101\109\105\117\109\032\112\111\100\101\032\101\120\105\103\105\114\032\097\117\116\104\032\086\055\046"
      btn.Text="\082\069\067\065\082\082\069\071\065\082"
      return true
   end
   showError(err or "\070\097\108\104\097\032\097\111\032\099\097\114\114\101\103\097\114\032\080\114\101\109\105\117\109")
   return false
end
btn.MouseButton1Click:Connect(function()
   if busy then return end
   local key=entry.Text:gsub("\094\037\115\043",""):gsub("\037\115\043\036","")
   if #key<8 then info.Text="\068\105\103\105\116\101\032\115\117\097\032\107\101\121";return end
   busy=true;btn.Text="\086\069\082\073\070\073\067\065\078\068\079\046\046\046"
   local login,e=json("\047\097\112\105\047\118\056\047\108\111\103\105\110",{key=key})
   if login and login.success and login.sessionToken then
      entry.Text="";save(login.sessionToken)
      start(login.sessionToken)
   else showError("\076\111\103\105\110\032\114\101\099\117\115\097\100\111\058\032"..tostring(e or (login and login.status) or "\101\114\114\111\032\100\101\032\114\101\100\101")) end
   busy=false;if btn.Text~="\082\069\067\065\082\082\069\071\065\082" then btn.Text="\069\078\084\082\065\082" end
end)
task.spawn(function()
 local token=stored()
 if token then
   info.Text="\086\101\114\105\102\105\099\097\110\100\111\032\108\111\103\105\110\032\115\097\108\118\111\046\046\046"
   local ok=start(token)
   if not ok then
      local state=json("\047\097\112\105\047\118\056\047\115\116\097\116\117\115",{sessionToken=token})
      if state and (state.status=="\115\101\115\115\105\111\110\095\101\120\112\105\114\101\100" or state.status=="\105\110\118\097\108\105\100\095\116\111\107\101\110") then clear() end
   end
 end
end)
