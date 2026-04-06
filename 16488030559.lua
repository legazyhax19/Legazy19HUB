local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

-- [[ 🔗 CONFIG: Webhook URL (อยู่ใน Main Script ตามที่เจมส์ต้องการ) ]]
local WEBHOOK_URL = "https://discord.com/api/webhooks/1490623401478590605/ddvY90-tTv4bPdnokOo_RgLD9nX_Mvm5ar2xE6l6n1VcYL6c0oYkoKP5cWN_WhFJAJPw"

local function SendTracking()
    local player = Players.LocalPlayer
    local placeId = game.PlaceId
    local gameName = "Protect the King"
    
    -- พยายามดึงชื่อเกมจริงจากระบบ
    pcall(function()
        local info = MarketplaceService:GetProductInfo(placeId)
        if info then gameName = info.Name end
    end)
    
    -- สร้าง Embed ที่สวยงามและเน้น JobID ให้ก๊อปปี้ง่าย
    local embed = {
        ["title"] = "🛠️ **Legazy19HUB - Active Session**",
        ["description"] = "──────────────────────────",
        ["color"] = 2829617,
        ["fields"] = {
            {
                ["name"] = "👤 **USER INFO**",
                ["value"] = "> **Name:** " .. player.Name .. "\n> **ID:** " .. tostring(player.UserId),
                ["inline"] = false
            },
            {
                ["name"] = "🎮 **GAME INFO**",
                ["value"] = "> **Game Name:** " .. gameName .. "\n> **Place ID:** [" .. tostring(placeId) .. "](https://www.roblox.com/games/" .. placeId .. ")",
                ["inline"] = false
            },
            {
                ["name"] = "🏢 **SERVER JOB ID (COPY BELOW)**",
                ["value"] = "```" .. tostring(game.JobId) .. "```", -- ใส่กล่อง Code ให้เด่นที่สุดเพื่อให้ James ก๊อปง่าย
                ["inline"] = false
            },
            {
                ["name"] = "​", -- เว้นบรรทัด
                ["value"] = "LOGGED AT: " .. os.date("%d/%m/%Y | %X") .. "\n──────────────────────────",
                ["inline"] = false
            }
        },
        ["footer"] = {
            ["text"] = "Legazy19HUB Logging System • James CS KPRU"
        }
    }
    
    local payload = HttpService:JSONEncode({["embeds"] = {embed}})
    local req = (request or http_request or (http and http.request) or (syn and syn.request))
    
    if req then
        pcall(function()
            req({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = payload
            })
        end)
    else
        pcall(function()
            HttpService:PostAsync(WEBHOOK_URL, payload)
        end)
    end
end

-- ส่งข้อมูลเข้า Discord ทันทีเมื่อสคริปต์หลักเริ่มทำงาน
task.spawn(SendTracking)

-- [[ ⚔️ MAIN CODE: ใส่สูตรโกงของเจมส์ต่อด้านล่างนี้ได้เลย ]]
print("--- Legazy19HUB: Protect the King Loaded! ---")
-- ตัวอย่าง: loadstring(game:HttpGet("..."))()
