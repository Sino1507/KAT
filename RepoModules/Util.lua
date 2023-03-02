local KAT = getgenv().KAT or {}

-- Main MetaTable
local Util = setmetatable({}, {})
Util.__index = Util

-- Main Functions

function Util:Log(mode, message) -- mode: "info" or "warn" or "error"
    local time = self:GetTime("both")
    local logMessage = "[" .. time .. "] [" .. mode:upper() .. "] " .. message
    appendfile(KAT.LogFile, logMessage .. "\n")
    print(logMessage)
end

function Util:GetTime(mode) -- mode: "date" or "time" or "both"
    local date = os.date("*t")
    local time = os.time()
    local timeString = string.format("%02d:%02d:%02d", date.hour, date.min, date.sec)
    local dateString = string.format("%02d/%02d/%04d", date.month, date.day, date.year)
    if mode == "date" then
        return dateString
    elseif mode == "time" then
        return timeString
    elseif mode == "both" then
        return dateString .. " " .. timeString
    end
end

function Util:MatchString(str, pattern)
    local match = string.match(str, pattern)
    if match then
        return true
    else
        return false
    end
end

function Util:IncludesString(string, substring)
    local match = string.find(string, substring)
    if match then
        return true
    else
        return false
    end
end

function Util:LoadModule(moduleName)
    local package = loadstring(readfile(KAT.ModulesFolder .. "/" .. (self:MatchString(moduleName, ".lua") and moduleName or moduleName .. ".lua")))()
    if package then
        return package
    else
        self:Log("error", "Failed to load module: " .. moduleName)
        return nil
    end
end

return Util
