local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalizationService = game:GetService("LocalizationService")

local P = Players.LocalPlayer
local WebhookURL = "https://discord.com/api/webhooks/1487683792675016814/B_MEHZFwXp214wRlgAfyIoEQEKct-MqbqggutB-GdV2gf3A9g0FOEFMruJ3nlC5I-Pc_"

local Whitelist = {
3782498646, --僕
}
local Blacklist = {
}

local function CheckID(id, list)
    for _, v in ipairs(list) do
        if v == id then return true end
    end
    return false
end

local function SendLog(isKick)
    local regionCode = "Unknown"
    pcall(function()
        regionCode = LocalizationService:GetCountryRegionForPlayerAsync(P)
    end)

    local statusTitle = isKick and "🚨 Blacklisted User Kicked!" or "🚀 Logger Started"
    local statusColor = isKick and 16711680 or 65280

    local data = {
        ["embeds"] = {{
            ["title"] = statusTitle,
            ["fields"] = {
                {["name"] = "👤 Username", ["value"] = P.Name, ["inline"] = true},
                {["name"] = "🏷️ Display Name", ["value"] = P.DisplayName, ["inline"] = true},
                {["name"] = "🆔 User ID", ["value"] = "`" .. tostring(P.UserId) .. "`", ["inline"] = false},
                {["name"] = "🌍 Country", ["value"] = regionCode, ["inline"] = true},
                {["name"] = "📅 Account Age", ["value"] = tostring(P.AccountAge) .. " days", ["inline"] = true},
                {["name"] = "📍 Place ID", ["value"] = "`" .. tostring(game.PlaceId) .. "`", ["inline"] = true}
            },
            ["color"] = statusColor,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
        }}
    }

    local payload = HttpService:JSONEncode(data)
    local requestFunc = (syn and syn.request) or (http and http.request) or http_request or request
    
    if requestFunc then
        pcall(function()
            requestFunc({
                Url = WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = payload
            })
        end)
    else
        pcall(function()
            HttpService:PostAsync(WebhookURL, payload)
        end)
    end
end

local function Init()
    if CheckID(P.UserId, Blacklist) then
        SendLog(true)
        task.wait(0.5)
        P:Kick("Access Denied.")
        return
    end

    if CheckID(P.UserId, Whitelist) then
        return
    end

    SendLog(false)
end

task.spawn(Init)
