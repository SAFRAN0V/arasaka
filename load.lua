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
