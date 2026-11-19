--====================================================================
-- SID ULTIMATE | PREMIUM CUSTOM UI LIBRARY (V3 - ZERO BUG EDITION)
-- 100% Drop-In Compatible with Rayfield API
-- * FIXED: Smart Mobile Slider Gesture Lock (Vertical Scroll Never Moves Sliders)
-- * FIXED: 5 Live Background Animations + 5 Window Open/Close Animations
-- * "Sid Ultimate" White Splash Logo + Rounded Rectangular Glass UI
-- * Locked Top-Center Transparent "Show UI" Pill + Vector X/Min Icons
-- * Auto-Save/Load (Delta/Workspace/SidDungeonHeroes/SavedConfig.json)
--====================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local function GetGuiParent()
    return (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
end

-- Clean up old instances on re-execute
do
    local Parent = GetGuiParent()
    for _, Name in ipairs({"SidUltimateUI", "SidUltimateSplash", "SidUltimateNotif"}) do
        local Old = Parent:FindFirstChild(Name)
        if Old then Old:Destroy() end
    end
end

local Library = {
    Flags = {},
    _ConfigSettings = {
        Enabled = true,
        FolderName = "SidDungeonHeroes",
        FileName = "SavedConfig"
    },
    _SavePending = false,
    _IsLoadingConfig = false,
    _ConfigLoadedOnce = false,
    _RainbowConn = nil,
    _BgAnimConn = nil,
}

-- ==========================================
-- COLOR PRESETS & LIVE THEME STATE
-- ==========================================
local ColorPresets = {
    ["Kaixer Violet"]   = {Primary = Color3.fromRGB(120, 95, 255),  Secondary = Color3.fromRGB(0, 220, 255)},
    ["Cyber Cyan"]      = {Primary = Color3.fromRGB(0, 195, 255),   Secondary = Color3.fromRGB(80, 255, 220)},
    ["Crimson Blood"]   = {Primary = Color3.fromRGB(245, 55, 85),   Secondary = Color3.fromRGB(255, 130, 75)},
    ["Emerald Neon"]    = {Primary = Color3.fromRGB(0, 220, 135),   Secondary = Color3.fromRGB(90, 255, 190)},
    ["Royal Gold"]      = {Primary = Color3.fromRGB(255, 190, 45),  Secondary = Color3.fromRGB(255, 235, 125)},
    ["Sakura Pink"]     = {Primary = Color3.fromRGB(255, 85, 175),  Secondary = Color3.fromRGB(185, 115, 255)},
    ["Sunset Blaze"]    = {Primary = Color3.fromRGB(255, 105, 45),  Secondary = Color3.fromRGB(255, 195, 65)},
    ["Midnight Ice"]    = {Primary = Color3.fromRGB(70, 145, 255),  Secondary = Color3.fromRGB(175, 225, 255)},
    ["Toxic Lime"]      = {Primary = Color3.fromRGB(130, 255, 45),  Secondary = Color3.fromRGB(0, 235, 165)},
    ["Obsidian White"]  = {Primary = Color3.fromRGB(235, 240, 255), Secondary = Color3.fromRGB(160, 175, 205)},
    ["RGB Rainbow"]     = {Primary = Color3.fromRGB(120, 95, 255),  Secondary = Color3.fromRGB(0, 220, 255), Rainbow = true},
}

local Theme = {
    MainBg = Color3.fromRGB(12, 14, 21),
    CardBg = Color3.fromRGB(20, 24, 35),
    CardHover = Color3.fromRGB(28, 33, 48),
    InputBg = Color3.fromRGB(15, 18, 27),
    Stroke = Color3.fromRGB(48, 55, 78),
    Accent = Color3.fromRGB(120, 95, 255),
    AccentSecondary = Color3.fromRGB(0, 220, 255),
    Danger = Color3.fromRGB(255, 80, 95),
    TextPrimary = Color3.fromRGB(242, 246, 255),
    TextMuted = Color3.fromRGB(155, 165, 190),
    ToggleOff = Color3.fromRGB(42, 48, 66),
}

local LooksState = {
    ThemeName = "Kaixer Violet",
    SurfaceMode = "Translucent",
    AnimationsEnabled = true,
    BgAnimStyle = "Moving Stars",     -- 5 Live Background Animations
    WindowAnimStyle = "Pop & Scale",  -- 5 Window Open/Close Animations
    RainbowActive = false,
}

local SurfaceTransparency = {
    Transparent = {Main = 0.44, Card = 0.50, Input = 0.45},
    Translucent = {Main = 0.16, Card = 0.24, Input = 0.18},
    Opaque      = {Main = 0.00, Card = 0.00, Input = 0.00},
}

local Registry = {
    MainFrames = {},
    Cards = {},
    Inputs = {},
    PrimaryColorObjs = {},
    SecondaryTextObjs = {},
    SecondaryBgObjs = {},
    AccentGradients = {},
    ToggleRefreshers = {},
    DropdownRefreshers = {},
    TabRefreshers = {},
    BgParticleRefreshers = {},
}

-- ==========================================
-- UTILITY HELPERS
-- ==========================================
local function Make(ClassName, Props, Parent)
    local Inst = Instance.new(ClassName)
    for k, v in pairs(Props or {}) do
        Inst[k] = v
    end
    if Parent then
        Inst.Parent = Parent
    end
    return Inst
end

local function AddCorner(Parent, Radius)
    return Make("UICorner", {CornerRadius = UDim.new(0, Radius or 10)}, Parent)
end

local function AddStroke(Parent, Color, Thickness, Transparency)
    return Make("UIStroke", {
        Color = Color or Theme.Stroke,
        Thickness = Thickness or 1,
        Transparency = Transparency or 0.3,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }, Parent)
end

local function Tween(Obj, Time, Props, Style, Dir)
    if not LooksState.AnimationsEnabled or Time <= 0 then
        for k, v in pairs(Props) do
            pcall(function() Obj[k] = v end)
        end
        return nil
    end
    local T = TweenService:Create(
        Obj,
        TweenInfo.new(Time, Style or Enum.EasingStyle.Quad, Dir or Enum.EasingDirection.Out),
        Props
    )
    T:Play()
    return T
end

local function ParseColorString(Text)
    if type(Text) ~= "string" then return nil end
    local Clean = string.gsub(Text, "%s+", "")

    local Hex = string.match(Clean, "^#?([%x][%x][%x][%x][%x][%x])$")
    if Hex then
        local r = tonumber(string.sub(Hex, 1, 2), 16)
        local g = tonumber(string.sub(Hex, 3, 4), 16)
        local b = tonumber(string.sub(Hex, 5, 6), 16)
        if r and g and b then
            return Color3.fromRGB(r, g, b)
        end
    end

    local rStr, gStr, bStr = string.match(Clean, "^(%d+),(%d+),(%d+)$")
    if rStr and gStr and bStr then
        return Color3.fromRGB(
            math.clamp(tonumber(rStr) or 0, 0, 255),
            math.clamp(tonumber(gStr) or 0, 0, 255),
            math.clamp(tonumber(bStr) or 0, 0, 255)
        )
    end

    return nil
end

local function ApplyLiveColors(PrimaryCol, SecondaryCol)
    Theme.Accent = PrimaryCol or Theme.Accent
    Theme.AccentSecondary = SecondaryCol or Theme.AccentSecondary

    local Seq = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.Accent),
        ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
        ColorSequenceKeypoint.new(1, Theme.Accent)
    })

    for _, Grad in ipairs(Registry.AccentGradients) do
        if Grad and Grad.Parent then Grad.Color = Seq end
    end
    for _, Obj in ipairs(Registry.PrimaryColorObjs) do
        if Obj and Obj.Parent then
            if Obj:IsA("ScrollingFrame") then
                Obj.ScrollBarImageColor3 = Theme.Accent
            else
                Obj.BackgroundColor3 = Theme.Accent
            end
        end
    end
    for _, Obj in ipairs(Registry.SecondaryTextObjs) do
        if Obj and Obj.Parent then Obj.TextColor3 = Theme.AccentSecondary end
    end
    for _, Obj in ipairs(Registry.SecondaryBgObjs) do
        if Obj and Obj.Parent then Obj.BackgroundColor3 = Theme.AccentSecondary end
    end
    for _, fn in ipairs(Registry.ToggleRefreshers) do pcall(fn) end
    for _, fn in ipairs(Registry.DropdownRefreshers) do pcall(fn) end
    for _, fn in ipairs(Registry.TabRefreshers) do pcall(fn) end
    for _, fn in ipairs(Registry.BgParticleRefreshers) do pcall(fn) end
end

local function ApplySurfaceMode(ModeName)
    local Spec = SurfaceTransparency[ModeName] or SurfaceTransparency.Translucent
    LooksState.SurfaceMode = SurfaceTransparency[ModeName] and ModeName or "Translucent"

    for _, Frame in ipairs(Registry.MainFrames) do
        if Frame and Frame.Parent then
            Tween(Frame, 0.2, {BackgroundTransparency = Spec.Main})
        end
    end
    for _, Card in ipairs(Registry.Cards) do
        if Card and Card.Parent then
            Tween(Card, 0.2, {BackgroundTransparency = Spec.Card})
        end
    end
    for _, Inp in ipairs(Registry.Inputs) do
        if Inp and Inp.Parent then
            Tween(Inp, 0.2, {BackgroundTransparency = Spec.Input})
        end
    end
end

local function SetThemePreset(PresetName)
    local Preset = ColorPresets[PresetName]
    if not Preset then return end
    LooksState.ThemeName = PresetName

    if Library._RainbowConn then
        Library._RainbowConn:Disconnect()
        Library._RainbowConn = nil
    end

    if Preset.Rainbow then
        LooksState.RainbowActive = true
        local Hue = 0
        Library._RainbowConn = RunService.Heartbeat:Connect(function(dt)
            if not LooksState.RainbowActive then return end
            Hue = (Hue + dt * 0.14) % 1
            local C1 = Color3.fromHSV(Hue, 0.78, 1)
            local C2 = Color3.fromHSV((Hue + 0.15) % 1, 0.78, 1)
            ApplyLiveColors(C1, C2)
        end)
    else
        LooksState.RainbowActive = false
        ApplyLiveColors(Preset.Primary, Preset.Secondary)
    end
end

local function MakeDraggable(DragHandle, TargetFrame)
    local Dragging = false
    local ActiveInput = nil
    local DragStartPos = nil
    local FrameStartPos = nil

    DragHandle.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            ActiveInput = Input
            DragStartPos = Input.Position
            FrameStartPos = TargetFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and (Input == ActiveInput or Input.UserInputType == Enum.UserInputType.MouseMovement) then
            local Delta = Input.Position - DragStartPos
            TargetFrame.Position = UDim2.new(
                FrameStartPos.X.Scale,
                FrameStartPos.X.Offset + Delta.X,
                FrameStartPos.Y.Scale,
                FrameStartPos.Y.Offset + Delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Dragging and (Input == ActiveInput or Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
            Dragging = false
            ActiveInput = nil
        end
    end)
end

-- ==========================================
-- CONFIG SAVING ENGINE (SidDungeonHeroes/SavedConfig.json)
-- ==========================================
local function GetConfigPaths()
    local Folder = Library._ConfigSettings.FolderName or "SidDungeonHeroes"
    local File = Library._ConfigSettings.FileName or "SavedConfig"
    File = string.gsub(File, "%.json$", "")
    File = string.gsub(File, "%.rfld$", "")
    return Folder, Folder .. "/" .. File .. ".json", Folder .. "/" .. File .. ".rfld"
end

function Library:SaveConfiguration()
    if not Library._ConfigSettings.Enabled or Library._IsLoadingConfig then return end
    if not writefile then return end

    if Library._SavePending then return end
    Library._SavePending = true

    task.delay(0.35, function()
        Library._SavePending = false
        pcall(function()
            local Folder, JsonPath = GetConfigPaths()
            if makefolder and isfolder and not isfolder(Folder) then
                makefolder(Folder)
            end

            local Payload = {}
            for FlagName, Obj in pairs(Library.Flags) do
                if type(Obj) == "table" then
                    if Obj.CurrentOption ~= nil then
                        Payload[FlagName] = Obj.CurrentOption
                    elseif Obj.CurrentValue ~= nil then
                        Payload[FlagName] = Obj.CurrentValue
                    end
                end
            end

            writefile(JsonPath, HttpService:JSONEncode(Payload))
        end)
    end)
end

function Library:LoadConfiguration()
    if not Library._ConfigSettings.Enabled then return end
    if not readfile or not isfile then return end

    Library._ConfigLoadedOnce = true
    Library._IsLoadingConfig = true

    pcall(function()
        local _, JsonPath, RfldPath = GetConfigPaths()
        local TargetPath = nil

        if isfile(JsonPath) then
            TargetPath = JsonPath
        elseif isfile(RfldPath) then
            TargetPath = RfldPath
        end

        if not TargetPath then return end

        local Raw = readfile(TargetPath)
        local Decoded = HttpService:JSONDecode(Raw)
        if type(Decoded) ~= "table" then return end

        for FlagName, SavedEntry in pairs(Decoded) do
            local Obj = Library.Flags[FlagName]
            if Obj and Obj.Set then
                local ActualVal = SavedEntry
                if type(SavedEntry) == "table" and (SavedEntry.CurrentValue ~= nil or SavedEntry.CurrentOption ~= nil) then
                    ActualVal = (SavedEntry.CurrentOption ~= nil) and SavedEntry.CurrentOption or SavedEntry.CurrentValue
                end
                pcall(function()
                    Obj:Set(ActualVal)
                end)
            end
        end
    end)

    Library._IsLoadingConfig = false
end

-- ==========================================
-- SID ULTIMATE SPLASH SCREEN (WHITE LOGO)
-- ==========================================
local function PlaySidUltimateSplash(OnComplete)
    task.spawn(function()
        pcall(function()
            local Parent = GetGuiParent()
            local SplashGui = Make("ScreenGui", {
                Name = "SidUltimateSplash",
                IgnoreGuiInset = true,
                DisplayOrder = 999998
            }, Parent)

            local Container = Make("Frame", {
                Size = UDim2.new(0, 420, 0, 90),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1
            }, SplashGui)

            local Scale = Make("UIScale", {Scale = 0.85}, Container)

            local LogoHolder = Make("Frame", {
                Size = UDim2.new(0, 62, 0, 62),
                Position = UDim2.new(0, 26, 0.5, -31),
                BackgroundTransparency = 1,
                Rotation = 18
            }, Container)

            local TopLeaf = Make("Frame", {
                Size = UDim2.new(0, 38, 0, 24),
                Position = UDim2.new(0, 8, 0, 7),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Rotation = -28
            }, LogoHolder)
            AddCorner(TopLeaf, 14)

            local BottomLeaf = Make("Frame", {
                Size = UDim2.new(0, 38, 0, 24),
                Position = UDim2.new(0, 16, 0, 31),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Rotation = -28
            }, LogoHolder)
            AddCorner(BottomLeaf, 14)

            local ShadowText = Make("TextLabel", {
                Size = UDim2.new(0, 320, 0, 64),
                Position = UDim2.new(0, 102, 0.5, -30),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBlack,
                TextSize = 44,
                TextColor3 = Color3.fromRGB(0, 0, 0),
                TextTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = "Sid Ultimate"
            }, Container)

            local MainText = Make("TextLabel", {
                Size = UDim2.new(0, 320, 0, 64),
                Position = UDim2.new(0, 100, 0.5, -32),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBlack,
                TextSize = 44,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = "Sid Ultimate"
            }, Container)

            TweenService:Create(Scale, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
            TweenService:Create(TopLeaf, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
            TweenService:Create(BottomLeaf, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
            TweenService:Create(MainText, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
            TweenService:Create(ShadowText, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {TextTransparency = 0.65}):Play()

            task.wait(1.1)

            TweenService:Create(Scale, TweenInfo.new(0.30, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 1.06}):Play()
            TweenService:Create(TopLeaf, TweenInfo.new(0.28, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
            TweenService:Create(BottomLeaf, TweenInfo.new(0.28, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
            TweenService:Create(MainText, TweenInfo.new(0.28, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
            local LastT = TweenService:Create(ShadowText, TweenInfo.new(0.28, Enum.EasingStyle.Quad), {TextTransparency = 1})
            LastT:Play()
            LastT.Completed:Wait()

            if SplashGui and SplashGui.Parent then
                SplashGui:Destroy()
            end
        end)

        if OnComplete then
            OnComplete()
        end
    end)
end

-- ==========================================
-- COMPACT GLASSMORPHISM NOTIFICATION (TAP TO DISMISS)
-- ==========================================
function Library:Notify(Opts)
    Opts = Opts or {}
    local TitleText = tostring(Opts.Title or "Sid Ultimate")
    local SubText = tostring(Opts.Content or "")
    local Duration = tonumber(Opts.Duration) or 3.0
    local AccentColor = Opts.Color or Theme.AccentSecondary

    task.spawn(function()
        pcall(function()
            local Parent = GetGuiParent()
            local Old = Parent:FindFirstChild("SidUltimateNotif")
            if Old then Old:Destroy() end

            local ScreenGui = Make("ScreenGui", {
                Name = "SidUltimateNotif",
                IgnoreGuiInset = true,
                DisplayOrder = 999999
            }, Parent)

            local Card = Make("Frame", {
                Size = UDim2.new(0, 300, 0, 48),
                Position = UDim2.new(0.5, -150, 0, -65),
                BackgroundColor3 = Color3.fromRGB(16, 20, 30),
                BackgroundTransparency = 0.16,
                BorderSizePixel = 0,
                ClipsDescendants = true
            }, ScreenGui)
            AddCorner(Card, 13)

            Make("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(42, 48, 70)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 18, 28))
                }),
                Rotation = 125
            }, Card)

            AddStroke(Card, AccentColor, 1.2, 0.30)

            local Pill = Make("Frame", {
                Size = UDim2.new(0, 4, 0, 26),
                Position = UDim2.new(0, 9, 0.5, -13),
                BackgroundColor3 = AccentColor,
                BorderSizePixel = 0
            }, Card)
            AddCorner(Pill, 4)

            Make("TextLabel", {
                Size = UDim2.new(1, -28, 0, 17),
                Position = UDim2.new(0, 20, 0, 6),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextColor3 = AccentColor,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = TitleText
            }, Card)

            Make("TextLabel", {
                Size = UDim2.new(1, -28, 0, 15),
                Position = UDim2.new(0, 20, 0, 24),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = SubText
            }, Card)

            local BarBg = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 2),
                Position = UDim2.new(0, 0, 1, -2),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.85,
                BorderSizePixel = 0
            }, Card)

            local BarFill = Make("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = AccentColor,
                BorderSizePixel = 0
            }, BarBg)

            local DismissBtn = Make("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 10
            }, Card)

            local Dismissed = false
            local function Close()
                if Dismissed then return end
                Dismissed = true
                if Card and Card.Parent then
                    local Out = TweenService:Create(Card, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Position = UDim2.new(0.5, -150, 0, -65),
                        BackgroundTransparency = 1
                    })
                    Out:Play()
                    Out.Completed:Wait()
                end
                if ScreenGui and ScreenGui.Parent then ScreenGui:Destroy() end
            end

            DismissBtn.Activated:Connect(Close)
            DismissBtn.MouseButton1Click:Connect(Close)

            TweenService:Create(Card, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, -150, 0, 14)
            }):Play()
            TweenService:Create(BarFill, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
                Size = UDim2.new(0, 0, 1, 0)
            }):Play()

            task.wait(Duration)
            Close()
        end)
    end)
end

-- ==========================================
-- CREATE WINDOW
-- ==========================================
function Library:CreateWindow(Config)
    Config = Config or {}
    local WindowTitle = tostring(Config.Name or "Sid Ultimate")
    local SubTag = tostring(Config.LoadingSubtitle or "ULTIMATE")

    if type(Config.ConfigurationSaving) == "table" then
        Library._ConfigSettings.Enabled = (Config.ConfigurationSaving.Enabled ~= false)
        if Config.ConfigurationSaving.FolderName and #tostring(Config.ConfigurationSaving.FolderName) > 0 then
            Library._ConfigSettings.FolderName = tostring(Config.ConfigurationSaving.FolderName)
        end
        if Config.ConfigurationSaving.FileName and #tostring(Config.ConfigurationSaving.FileName) > 0 then
            Library._ConfigSettings.FileName = tostring(Config.ConfigurationSaving.FileName)
        end
    end

    local ScreenGui = Make("ScreenGui", {
        Name = "SidUltimateUI",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        DisplayOrder = 100
    }, GetGuiParent())

    -- Wide Rectangular MainFrame with Smooth Rounded Corners (555 x 300)
    local CenterPos = UDim2.new(0.5, 0, 0.5, 0)
    local MainFrame = Make("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, 555, 0, 300),
        Position = CenterPos,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.MainBg,
        BackgroundTransparency = SurfaceTransparency.Translucent.Main,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Visible = false
    }, ScreenGui)
    table.insert(Registry.MainFrames, MainFrame)

    AddCorner(MainFrame, 18)

    local MainUIScale = Make("UIScale", {Scale = 1}, MainFrame)

    Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 26, 40)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 19))
        }),
        Rotation = 135
    }, MainFrame)

    local MainStroke = AddStroke(MainFrame, Theme.Accent, 1.4, 0.25)
    local MainStrokeGrad = Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
            ColorSequenceKeypoint.new(1, Theme.Accent)
        }),
        Rotation = 45
    }, MainStroke)
    table.insert(Registry.AccentGradients, MainStrokeGrad)

    -- ==========================================
    -- 5 LIVE BACKGROUND ANIMATIONS ENGINE (ZERO LAG)
    -- ==========================================
    local BgAnimLayer = Make("Frame", {
        Name = "BgAnimLayer",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 1
    }, MainFrame)
    AddCorner(BgAnimLayer, 18)

    local ActiveParticles = {}
    local AuroraFrame = nil
    local AuroraGrad = nil

    local function ClearBackgroundAnim()
        if Library._BgAnimConn then
            Library._BgAnimConn:Disconnect()
            Library._BgAnimConn = nil
        end
        for _, Child in ipairs(BgAnimLayer:GetChildren()) do
            if not Child:IsA("UICorner") then
                Child:Destroy()
            end
        end
        table.clear(ActiveParticles)
        AuroraFrame = nil
        AuroraGrad = nil
    end

    local function RebuildBackgroundAnim()
        ClearBackgroundAnim()

        if not LooksState.AnimationsEnabled then
            return
        end

        local Style = LooksState.BgAnimStyle
        if Style == "None" then
            return
        end

        if Style == "Moving Stars" then
            for i = 1, 24 do
                local Size = math.random(2, 4)
                local UseSecondary = (i % 2 == 0)
                local Dot = Make("Frame", {
                    Size = UDim2.new(0, Size, 0, Size),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    BackgroundColor3 = UseSecondary and Theme.AccentSecondary or Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 0.25,
                    BorderSizePixel = 0,
                    ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Dot, Size)

                table.insert(ActiveParticles, {
                    Obj = Dot,
                    X = math.random(),
                    Y = math.random(),
                    VX = (math.random(12, 32) / 1000),
                    VY = (math.random(-8, 8) / 1000),
                    Phase = math.random() * math.pi * 2,
                    UseSecondary = UseSecondary
                })
            end

        elseif Style == "Floating Particles" then
            for i = 1, 20 do
                local Size = math.random(3, 6)
                local UseSecondary = (i % 2 == 0)
                local Dot = Make("Frame", {
                    Size = UDim2.new(0, Size, 0, Size),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    BackgroundColor3 = UseSecondary and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.32,
                    BorderSizePixel = 0,
                    ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Dot, Size)

                table.insert(ActiveParticles, {
                    Obj = Dot,
                    BaseX = math.random(),
                    X = math.random(),
                    Y = math.random(),
                    SpeedY = math.random(45, 95) / 1000,
                    SwayAmp = math.random(12, 32) / 1000,
                    Phase = math.random() * math.pi * 2,
                    UseSecondary = UseSecondary
                })
            end

        elseif Style == "Cyber Rain" then
            for i = 1, 18 do
                local Len = math.random(14, 30)
                local UseSecondary = (i % 2 == 0)
                local Drop = Make("Frame", {
                    Size = UDim2.new(0, 2, 0, Len),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    BackgroundColor3 = UseSecondary and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.35,
                    BorderSizePixel = 0,
                    ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Drop, 2)

                table.insert(ActiveParticles, {
                    Obj = Drop,
                    X = math.random(),
                    Y = math.random(),
                    SpeedY = math.random(220, 420) / 1000,
                    UseSecondary = UseSecondary
                })
            end

        elseif Style == "Glow Orbs" then
            for i = 1, 8 do
                local Size = math.random(34, 62)
                local UseSecondary = (i % 2 == 0)
                local Orb = Make("Frame", {
                    Size = UDim2.new(0, Size, 0, Size),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = UseSecondary and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.80,
                    BorderSizePixel = 0,
                    ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Orb, Size)

                table.insert(ActiveParticles, {
                    Obj = Orb,
                    X = math.random(),
                    Y = math.random(),
                    VX = (math.random(0, 1) == 1 and 1 or -1) * (math.random(18, 42) / 1000),
                    VY = (math.random(0, 1) == 1 and 1 or -1) * (math.random(18, 42) / 1000),
                    Phase = math.random() * math.pi * 2,
                    UseSecondary = UseSecondary
                })
            end

        elseif Style == "Aurora Wave" then
            AuroraFrame = Make("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.78,
                BorderSizePixel = 0,
                ZIndex = 1
            }, BgAnimLayer)
            AddCorner(AuroraFrame, 18)

            AuroraGrad = Make("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Theme.Accent),
                    ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
                    ColorSequenceKeypoint.new(1, Theme.Accent)
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.25),
                    NumberSequenceKeypoint.new(0.5, 0.75),
                    NumberSequenceKeypoint.new(1, 0.25)
                }),
                Rotation = 0
            }, AuroraFrame)
        end

        local TimeAcc = 0
        Library._BgAnimConn = RunService.Heartbeat:Connect(function(dt)
            if not MainFrame.Visible or not LooksState.AnimationsEnabled then
                return
            end
            dt = math.min(dt, 0.05)
            TimeAcc = TimeAcc + dt

            if Style == "Moving Stars" then
                for _, P in ipairs(ActiveParticles) do
                    P.X = P.X + P.VX * dt
                    P.Y = P.Y + P.VY * dt
                    if P.X > 1.03 then P.X = -0.03; P.Y = math.random() end
                    if P.Y > 1.03 then P.Y = -0.03 elseif P.Y < -0.03 then P.Y = 1.03 end
                    P.Obj.Position = UDim2.new(P.X, 0, P.Y, 0)
                    P.Obj.BackgroundTransparency = 0.30 + 0.45 * (0.5 + 0.5 * math.sin(TimeAcc * 2.8 + P.Phase))
                end

            elseif Style == "Floating Particles" then
                for _, P in ipairs(ActiveParticles) do
                    P.Y = P.Y - P.SpeedY * dt
                    if P.Y < -0.05 then
                        P.Y = 1.05
                        P.BaseX = math.random()
                    end
                    local DrawX = P.BaseX + math.sin(TimeAcc * 1.8 + P.Phase) * P.SwayAmp
                    P.Obj.Position = UDim2.new(DrawX, 0, P.Y, 0)
                end

            elseif Style == "Cyber Rain" then
                for _, P in ipairs(ActiveParticles) do
                    P.Y = P.Y + P.SpeedY * dt
                    if P.Y > 1.08 then
                        P.Y = -0.12
                        P.X = math.random()
                    end
                    P.Obj.Position = UDim2.new(P.X, 0, P.Y, 0)
                end

            elseif Style == "Glow Orbs" then
                for _, P in ipairs(ActiveParticles) do
                    P.X = P.X + P.VX * dt
                    P.Y = P.Y + P.VY * dt
                    if P.X < 0.04 or P.X > 0.96 then P.VX = -P.VX end
                    if P.Y < 0.06 or P.Y > 0.94 then P.VY = -P.VY end
                    P.Obj.Position = UDim2.new(P.X, 0, P.Y, 0)
                    P.Obj.BackgroundTransparency = 0.78 + 0.12 * math.sin(TimeAcc * 1.5 + P.Phase)
                end

            elseif Style == "Aurora Wave" and AuroraGrad then
                AuroraGrad.Rotation = (TimeAcc * 32) % 360
                AuroraGrad.Offset = Vector2.new(math.sin(TimeAcc * 0.9) * 0.25, math.cos(TimeAcc * 0.7) * 0.15)
            end
        end)
    end

    table.insert(Registry.BgParticleRefreshers, function()
        for _, P in ipairs(ActiveParticles) do
            if P.Obj and P.Obj.Parent then
                if LooksState.BgAnimStyle == "Moving Stars" then
                    P.Obj.BackgroundColor3 = P.UseSecondary and Theme.AccentSecondary or Color3.fromRGB(255, 255, 255)
                else
                    P.Obj.BackgroundColor3 = P.UseSecondary and Theme.AccentSecondary or Theme.Accent
                end
            end
        end
        if AuroraGrad and AuroraGrad.Parent then
            AuroraGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Theme.Accent),
                ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
                ColorSequenceKeypoint.new(1, Theme.Accent)
            })
        end
    end)

    -- ==========================================
    -- LOCKED TOP-CENTER TRANSPARENT "Show UI" PILL
    -- ==========================================
    local ShowUIBtn = Make("TextButton", {
        Name = "ShowUILockedPill",
        Size = UDim2.new(0, 96, 0, 28),
        Position = UDim2.new(0.5, 0, 0, 10),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(14, 17, 26),
        BackgroundTransparency = 0.42,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextColor3 = Color3.fromRGB(245, 248, 255),
        Text = "Show UI",
        AutoButtonColor = false,
        Visible = false,
        ZIndex = 60
    }, ScreenGui)
    AddCorner(ShowUIBtn, 14)

    local ShowUIStroke = AddStroke(ShowUIBtn, Theme.AccentSecondary, 1.1, 0.45)
    local ShowUIGrad = Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(1, Theme.AccentSecondary)
        }),
        Rotation = 45
    }, ShowUIStroke)
    table.insert(Registry.AccentGradients, ShowUIGrad)

    -- ==========================================
    -- 5-STYLE OPEN / CLOSE ANIMATION ENGINE (RACE-SAFE)
    -- ==========================================
    local LastSavedPos = CenterPos
    local IsWindowVisible = false
    local AnimToken = 0

    local function AnimateShowUI()
        AnimToken = AnimToken + 1
        IsWindowVisible = true
        ShowUIBtn.Visible = false
        MainFrame.Visible = true

        local TargetPos = LastSavedPos
        local TargetTrans = (SurfaceTransparency[LooksState.SurfaceMode] or SurfaceTransparency.Translucent).Main

        if not LooksState.AnimationsEnabled then
            MainUIScale.Scale = 1
            MainFrame.Position = TargetPos
            MainFrame.BackgroundTransparency = TargetTrans
            return
        end

        local Style = LooksState.WindowAnimStyle
        if Style == "Pop & Scale" then
            MainFrame.Position = TargetPos
            MainFrame.BackgroundTransparency = TargetTrans
            MainUIScale.Scale = 0.80
            Tween(MainUIScale, 0.30, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

        elseif Style == "Slide From Top" then
            MainUIScale.Scale = 1
            MainFrame.BackgroundTransparency = TargetTrans
            MainFrame.Position = UDim2.new(TargetPos.X.Scale, TargetPos.X.Offset, -0.35, 0)
            Tween(MainFrame, 0.36, {Position = TargetPos}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        elseif Style == "Slide From Bottom" then
            MainUIScale.Scale = 1
            MainFrame.BackgroundTransparency = TargetTrans
            MainFrame.Position = UDim2.new(TargetPos.X.Scale, TargetPos.X.Offset, 1.35, 0)
            Tween(MainFrame, 0.36, {Position = TargetPos}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        elseif Style == "Fade & Glide" then
            MainUIScale.Scale = 0.94
            MainFrame.BackgroundTransparency = 0.95
            MainFrame.Position = UDim2.new(TargetPos.X.Scale, TargetPos.X.Offset, TargetPos.Y.Scale, TargetPos.Y.Offset + 32)
            Tween(MainUIScale, 0.28, {Scale = 1}, Enum.EasingStyle.Quad)
            Tween(MainFrame, 0.30, {Position = TargetPos, BackgroundTransparency = TargetTrans}, Enum.EasingStyle.Quad)

        elseif Style == "Elastic Bounce" then
            MainFrame.Position = TargetPos
            MainFrame.BackgroundTransparency = TargetTrans
            MainUIScale.Scale = 0.68
            Tween(MainUIScale, 0.52, {Scale = 1}, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
        end
    end

    local function AnimateHideUI()
        if not IsWindowVisible then return end
        AnimToken = AnimToken + 1
        local MyToken = AnimToken

        IsWindowVisible = false
        LastSavedPos = MainFrame.Position

        if not LooksState.AnimationsEnabled then
            MainFrame.Visible = false
            ShowUIBtn.Visible = true
            return
        end

        local Style = LooksState.WindowAnimStyle
        local DoneTween = nil

        if Style == "Slide From Top" then
            DoneTween = Tween(MainFrame, 0.22, {Position = UDim2.new(LastSavedPos.X.Scale, LastSavedPos.X.Offset, -0.35, 0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        elseif Style == "Slide From Bottom" then
            DoneTween = Tween(MainFrame, 0.22, {Position = UDim2.new(LastSavedPos.X.Scale, LastSavedPos.X.Offset, 1.35, 0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        elseif Style == "Fade & Glide" then
            DoneTween = Tween(MainFrame, 0.18, {
                Position = UDim2.new(LastSavedPos.X.Scale, LastSavedPos.X.Offset, LastSavedPos.Y.Scale, LastSavedPos.Y.Offset + 24),
                BackgroundTransparency = 1
            }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        else
            DoneTween = Tween(MainUIScale, 0.16, {Scale = 0.82}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        end

        if DoneTween then
            DoneTween.Completed:Connect(function()
                if AnimToken == MyToken and not IsWindowVisible then
                    MainFrame.Visible = false
                    MainUIScale.Scale = 1
                    MainFrame.Position = LastSavedPos
                    ShowUIBtn.Visible = true
                end
            end)
        else
            MainFrame.Visible = false
            ShowUIBtn.Visible = true
        end
    end

    ShowUIBtn.MouseButton1Click:Connect(function()
        AnimateShowUI()
    end)

    -- ==========================================
    -- TOPBAR (ZINDEX 5 ABOVE BG ANIMATIONS)
    -- ==========================================
    local Topbar = Make("Frame", {
        Name = "Topbar",
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5
    }, MainFrame)

    MakeDraggable(Topbar, MainFrame)

    local TopDivider = Make("Frame", {
        Size = UDim2.new(1, -24, 0, 1),
        Position = UDim2.new(0, 12, 1, -1),
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.45,
        BorderSizePixel = 0,
        ZIndex = 6
    }, Topbar)
    local TopDivGrad = Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
            ColorSequenceKeypoint.new(1, Theme.Accent)
        })
    }, TopDivider)
    table.insert(Registry.AccentGradients, TopDivGrad)

    local LogoDot = Make("Frame", {
        Size = UDim2.new(0, 9, 0, 9),
        Position = UDim2.new(0, 16, 0.5, -4),
        BackgroundColor3 = Theme.AccentSecondary,
        BorderSizePixel = 0,
        ZIndex = 6
    }, Topbar)
    AddCorner(LogoDot, 9)
    table.insert(Registry.SecondaryBgObjs, LogoDot)

    Make("TextLabel", {
        Size = UDim2.new(0, 290, 1, 0),
        Position = UDim2.new(0, 32, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = WindowTitle,
        ZIndex = 6
    }, Topbar)

    local Badge = Make("TextLabel", {
        Size = UDim2.new(0, 76, 0, 19),
        Position = UDim2.new(1, -158, 0.5, -9),
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.80,
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        TextColor3 = Theme.AccentSecondary,
        Text = string.sub(SubTag, 1, 10):upper(),
        ZIndex = 6
    }, Topbar)
    AddCorner(Badge, 8)
    AddStroke(Badge, Theme.AccentSecondary, 1, 0.55)
    table.insert(Registry.SecondaryTextObjs, Badge)

    -- MINIMIZE BUTTON (CRISP VECTOR BAR)
    local MinBtn = Make("TextButton", {
        Size = UDim2.new(0, 28, 0, 26),
        Position = UDim2.new(1, -72, 0.5, -13),
        BackgroundColor3 = Theme.CardBg,
        BackgroundTransparency = 0.2,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 6
    }, Topbar)
    AddCorner(MinBtn, 8)
    AddStroke(MinBtn, Theme.Stroke, 1, 0.35)

    local MinBar = Make("Frame", {
        Size = UDim2.new(0, 11, 0, 2),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.TextPrimary,
        BorderSizePixel = 0,
        ZIndex = 7
    }, MinBtn)
    AddCorner(MinBar, 2)

    MinBtn.MouseButton1Click:Connect(function()
        AnimateHideUI()
    end)

    -- CLOSE (X) BUTTON (CRISP VECTOR CROSSED BARS)
    local CloseBtn = Make("TextButton", {
        Size = UDim2.new(0, 28, 0, 26),
        Position = UDim2.new(1, -38, 0.5, -13),
        BackgroundColor3 = Color3.fromRGB(52, 22, 30),
        BackgroundTransparency = 0.15,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 6
    }, Topbar)
    AddCorner(CloseBtn, 8)
    AddStroke(CloseBtn, Theme.Danger, 1, 0.45)

    local XBar1 = Make("Frame", {
        Size = UDim2.new(0, 12, 0, 2),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Rotation = 45,
        BackgroundColor3 = Theme.Danger,
        BorderSizePixel = 0,
        ZIndex = 7
    }, CloseBtn)
    AddCorner(XBar1, 2)

    local XBar2 = Make("Frame", {
        Size = UDim2.new(0, 12, 0, 2),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Rotation = -45,
        BackgroundColor3 = Theme.Danger,
        BorderSizePixel = 0,
        ZIndex = 7
    }, CloseBtn)
    AddCorner(XBar2, 2)

    -- ==========================================
    -- EXIT CONFIRMATION MODAL
    -- ==========================================
    local ConfirmOverlay = Make("Frame", {
        Name = "ConfirmOverlay",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(6, 8, 14),
        BackgroundTransparency = 0.25,
        Visible = false,
        ZIndex = 80
    }, MainFrame)
    AddCorner(ConfirmOverlay, 18)

    local ConfirmBox = Make("Frame", {
        Size = UDim2.new(0, 256, 0, 118),
        Position = UDim2.new(0.5, -128, 0.5, -59),
        BackgroundColor3 = Theme.CardBg,
        ZIndex = 81
    }, ConfirmOverlay)
    AddCorner(ConfirmBox, 14)
    AddStroke(ConfirmBox, Theme.Danger, 1.2, 0.35)

    Make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 24),
        Position = UDim2.new(0, 10, 0, 12),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        Text = "Close Sid Ultimate?",
        ZIndex = 82
    }, ConfirmBox)

    Make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 26),
        Position = UDim2.new(0, 10, 0, 36),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        TextColor3 = Theme.TextMuted,
        Text = "Hide karne ke liye Minimize (–) button use karo.",
        TextWrapped = true,
        ZIndex = 82
    }, ConfirmBox)

    local CancelCloseBtn = Make("TextButton", {
        Size = UDim2.new(0.44, 0, 0, 30),
        Position = UDim2.new(0.05, 0, 1, -40),
        BackgroundColor3 = Theme.ToggleOff,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = Theme.TextPrimary,
        Text = "Cancel",
        ZIndex = 82
    }, ConfirmBox)
    AddCorner(CancelCloseBtn, 8)

    local ConfirmCloseBtn = Make("TextButton", {
        Size = UDim2.new(0.44, 0, 0, 30),
        Position = UDim2.new(0.51, 0, 1, -40),
        BackgroundColor3 = Theme.Danger,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Text = "Close UI",
        ZIndex = 82
    }, ConfirmBox)
    AddCorner(ConfirmCloseBtn, 8)

    CloseBtn.MouseButton1Click:Connect(function() ConfirmOverlay.Visible = true end)
    CancelCloseBtn.MouseButton1Click:Connect(function() ConfirmOverlay.Visible = false end)
    ConfirmCloseBtn.MouseButton1Click:Connect(function() Library:Destroy() end)

    -- ==========================================
    -- LEFT SIDEBAR & RIGHT CONTENT HOLDER (ZINDEX 5)
    -- ==========================================
    local Sidebar = Make("ScrollingFrame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 134, 1, -44),
        Position = UDim2.new(0, 0, 0, 44),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 5
    }, MainFrame)
    table.insert(Registry.PrimaryColorObjs, Sidebar)

    Make("UIPadding", {
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 8)
    }, Sidebar)

    local SideLayout = Make("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    }, Sidebar)

    SideLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Sidebar.CanvasSize = UDim2.new(0, 0, 0, SideLayout.AbsoluteContentSize.Y + 18)
    end)

    Make("Frame", {
        Size = UDim2.new(0, 1, 1, -56),
        Position = UDim2.new(0, 135, 0, 48),
        BackgroundColor3 = Theme.Stroke,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        ZIndex = 5
    }, MainFrame)

    local ContentHolder = Make("Frame", {
        Name = "ContentHolder",
        Size = UDim2.new(1, -138, 1, -44),
        Position = UDim2.new(0, 138, 0, 44),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 5
    }, MainFrame)

    UserInputService.InputBegan:Connect(function(Input, Processed)
        if not Processed and Input.KeyCode == Enum.KeyCode.RightShift then
            if ScreenGui and ScreenGui.Parent then
                if IsWindowVisible then AnimateHideUI() else AnimateShowUI() end
            end
        end
    end)

    function Library:Destroy()
        ClearBackgroundAnim()
        if Library._RainbowConn then
            Library._RainbowConn:Disconnect()
            Library._RainbowConn = nil
        end
        if ScreenGui and ScreenGui.Parent then
            ScreenGui:Destroy()
        end
    end

    -- ==========================================
    -- WINDOW OBJECT & TAB SYSTEM
    -- ==========================================
    local Window = {}
    local Tabs = {}
    local UserTabCount = 0
    local ActiveTab = nil

    local function SelectTab(TabRecord)
        if ActiveTab == TabRecord then return end
        for _, Rec in ipairs(Tabs) do
            local IsSelected = (Rec == TabRecord)
            Rec.Page.Visible = IsSelected
            Rec.Page.ScrollingEnabled = true -- Failsafe unlock scrolling on tab switch
            Tween(Rec.Button, 0.15, {
                BackgroundColor3 = IsSelected and Theme.CardHover or Theme.CardBg,
                BackgroundTransparency = IsSelected and 0.15 or 0.75
            })
            Tween(Rec.Label, 0.15, {
                TextColor3 = IsSelected and Theme.TextPrimary or Theme.TextMuted
            })
            Tween(Rec.Indicator, 0.15, {
                Size = IsSelected and UDim2.new(0, 3, 0, 18) or UDim2.new(0, 3, 0, 0),
                BackgroundTransparency = IsSelected and 0 or 1
            })
        end
        ActiveTab = TabRecord
    end

    table.insert(Registry.TabRefreshers, function()
        for _, Rec in ipairs(Tabs) do
            if Rec.Indicator and Rec.Indicator.Parent then
                Rec.Indicator.BackgroundColor3 = Theme.AccentSecondary
            end
        end
    end)

    local function CreateTabInternal(TabName, FixedLayoutOrder, IsSystemTab)
        TabName = tostring(TabName or "Tab")
        local Order = FixedLayoutOrder
        if not Order then
            UserTabCount = UserTabCount + 1
            Order = UserTabCount
        end

        local TabBtn = Make("TextButton", {
            Name = "Tab_" .. TabName,
            Size = UDim2.new(1, 0, 0, 32),
            LayoutOrder = Order,
            BackgroundColor3 = Theme.CardBg,
            BackgroundTransparency = 0.75,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 6
        }, Sidebar)
        AddCorner(TabBtn, 9)

        local Indicator = Make("Frame", {
            Size = UDim2.new(0, 3, 0, 0),
            Position = UDim2.new(0, 3, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Theme.AccentSecondary,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 7
        }, TabBtn)
        AddCorner(Indicator, 3)

        local TabLabel = Make("TextLabel", {
            Size = UDim2.new(1, -14, 1, 0),
            Position = UDim2.new(0, 12, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamSemibold,
            TextSize = 12,
            TextColor3 = Theme.TextMuted,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Text = TabName,
            ZIndex = 7
        }, TabBtn)

        local TabPage = Make("ScrollingFrame", {
            Name = "Page_" .. TabName,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            ZIndex = 6
        }, ContentHolder)
        table.insert(Registry.PrimaryColorObjs, TabPage)

        Make("UIPadding", {
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 14),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 14)
        }, TabPage)

        local PageLayout = Make("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 7)
        }, TabPage)

        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 24)
        end)

        local TabRecord = {
            Button = TabBtn,
            Label = TabLabel,
            Indicator = Indicator,
            Page = TabPage,
            IsSystemTab = IsSystemTab == true
        }
        table.insert(Tabs, TabRecord)

        TabBtn.MouseButton1Click:Connect(function()
            SelectTab(TabRecord)
        end)

        if not IsSystemTab and UserTabCount == 1 then
            SelectTab(TabRecord)
        end

        local Tab = {}

        -- 1. CREATE SECTION
        function Tab:CreateSection(SectionTitle)
            local SecFrame = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                ZIndex = 7
            }, TabPage)

            local SecLabel = Make("TextLabel", {
                Size = UDim2.new(1, -6, 1, 0),
                Position = UDim2.new(0, 2, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextColor3 = Theme.AccentSecondary,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = string.upper(tostring(SectionTitle or "SECTION")),
                ZIndex = 7
            }, SecFrame)
            table.insert(Registry.SecondaryTextObjs, SecLabel)

            Make("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, -1),
                BackgroundColor3 = Theme.Stroke,
                BackgroundTransparency = 0.55,
                BorderSizePixel = 0,
                ZIndex = 7
            }, SecFrame)

            return {
                Set = function(_, NewText) SecLabel.Text = string.upper(tostring(NewText)) end
            }
        end

        -- 2. CREATE LABEL
        function Tab:CreateLabel(Text)
            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = (SurfaceTransparency[LooksState.SurfaceMode] or SurfaceTransparency.Translucent).Card,
                ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9)
            AddStroke(Card, Theme.Stroke, 1, 0.45)
            table.insert(Registry.Cards, Card)

            local Lbl = Make("TextLabel", {
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 12,
                TextColor3 = Theme.TextMuted,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = tostring(Text or ""),
                ZIndex = 8
            }, Card)

            return {
                Set = function(_, NewText) Lbl.Text = tostring(NewText) end
            }
        end

        -- 3. CREATE PARAGRAPH
        function Tab:CreateParagraph(Opts)
            Opts = Opts or {}
            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = (SurfaceTransparency[LooksState.SurfaceMode] or SurfaceTransparency.Translucent).Card,
                ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9)
            AddStroke(Card, Theme.Stroke, 1, 0.45)
            table.insert(Registry.Cards, Card)

            local T = Make("TextLabel", {
                Size = UDim2.new(1, -20, 0, 18),
                Position = UDim2.new(0, 10, 0, 6),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = tostring(Opts.Title or ""),
                ZIndex = 8
            }, Card)

            local C = Make("TextLabel", {
                Size = UDim2.new(1, -20, 0, 24),
                Position = UDim2.new(0, 10, 0, 24),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                TextSize = 11,
                TextColor3 = Theme.TextMuted,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Text = tostring(Opts.Content or ""),
                ZIndex = 8
            }, Card)

            return {
                Set = function(_, NewOpts)
                    if NewOpts.Title then T.Text = tostring(NewOpts.Title) end
                    if NewOpts.Content then C.Text = tostring(NewOpts.Content) end
                end
            }
        end

        -- 4. CREATE BUTTON
        function Tab:CreateButton(Opts)
            Opts = Opts or {}
            local Btn = Make("TextButton", {
                Size = UDim2.new(1, 0, 0, 34),
                BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = (SurfaceTransparency[LooksState.SurfaceMode] or SurfaceTransparency.Translucent).Card,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 7
            }, TabPage)
            AddCorner(Btn, 9)
            local Stroke = AddStroke(Btn, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Btn)

            local TitleLbl = Make("TextLabel", {
                Size = UDim2.new(1, -54, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = tostring(Opts.Name or "Button"),
                ZIndex = 8
            }, Btn)

            local Tag = Make("TextLabel", {
                Size = UDim2.new(0, 36, 0, 18),
                Position = UDim2.new(1, -46, 0.5, -9),
                BackgroundColor3 = Theme.Accent,
                BackgroundTransparency = 0.78,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                TextColor3 = Theme.AccentSecondary,
                Text = "RUN",
                ZIndex = 8
            }, Btn)
            AddCorner(Tag, 6)
            table.insert(Registry.SecondaryTextObjs, Tag)

            Btn.MouseButton1Click:Connect(function()
                Tween(Btn, 0.08, {BackgroundColor3 = Theme.CardHover})
                Tween(Stroke, 0.08, {Color = Theme.AccentSecondary})
                task.delay(0.12, function()
                    Tween(Btn, 0.14, {BackgroundColor3 = Theme.CardBg})
                    Tween(Stroke, 0.14, {Color = Theme.Stroke})
                end)
                if type(Opts.Callback) == "function" then
                    task.spawn(Opts.Callback)
                end
            end)

            return {
                Set = function(_, NewName) TitleLbl.Text = tostring(NewName) end
            }
        end

        -- 5. CREATE TOGGLE
        function Tab:CreateToggle(Opts)
            Opts = Opts or {}
            local State = Opts.CurrentValue == true
            local FlagName = Opts.Flag

            local Card = Make("TextButton", {
                Size = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = (SurfaceTransparency[LooksState.SurfaceMode] or SurfaceTransparency.Translucent).Card,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9)
            local Stroke = AddStroke(Card, State and Theme.Accent or Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Card)

            Make("TextLabel", {
                Size = UDim2.new(1, -66, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = tostring(Opts.Name or "Toggle"),
                ZIndex = 8
            }, Card)

            local SwitchBg = Make("Frame", {
                Size = UDim2.new(0, 40, 0, 20),
                Position = UDim2.new(1, -50, 0.5, -10),
                BackgroundColor3 = State and Theme.Accent or Theme.ToggleOff,
                BorderSizePixel = 0,
                ZIndex = 8
            }, Card)
            AddCorner(SwitchBg, 10)

            local Knob = Make("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                Position = State and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ZIndex = 9
            }, SwitchBg)
            AddCorner(Knob, 7)

            local ToggleObj = {CurrentValue = State}

            local function UpdateVisual(Val, Instant)
                local Dur = Instant and 0 or 0.14
                Tween(SwitchBg, Dur, {BackgroundColor3 = Val and Theme.Accent or Theme.ToggleOff})
                Tween(Knob, Dur, {Position = Val and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)})
                Tween(Stroke, Dur, {Color = Val and Theme.Accent or Theme.Stroke})
            end

            table.insert(Registry.ToggleRefreshers, function()
                if State then
                    SwitchBg.BackgroundColor3 = Theme.Accent
                    Stroke.Color = Theme.Accent
                end
            end)

            function ToggleObj:Set(NewVal)
                NewVal = (NewVal == true)
                State = NewVal
                ToggleObj.CurrentValue = State
                UpdateVisual(State, Library._IsLoadingConfig)
                if type(Opts.Callback) == "function" then
                    task.spawn(Opts.Callback, State)
                end
                Library:SaveConfiguration()
            end

            Card.MouseButton1Click:Connect(function()
                ToggleObj:Set(not State)
            end)

            if FlagName then
                Library.Flags[FlagName] = ToggleObj
            end

            return ToggleObj
        end

        -- 6. CREATE SLIDER (SMART MOBILE DIRECTION LOCK — NEVER ACCIDENTALLY MOVES ON SCROLL!)
        function Tab:CreateSlider(Opts)
            Opts = Opts or {}
            local Range = Opts.Range or {0, 100}
            local MinVal = tonumber(Range[1]) or 0
            local MaxVal = tonumber(Range[2]) or 100
            local Increment = tonumber(Opts.Increment) or 1
            local Suffix = tostring(Opts.Suffix or "")
            local CurrentVal = math.clamp(tonumber(Opts.CurrentValue) or MinVal, MinVal, MaxVal)
            local FlagName = Opts.Flag

            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 48),
                BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = (SurfaceTransparency[LooksState.SurfaceMode] or SurfaceTransparency.Translucent).Card,
                Active = false,
                ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9)
            AddStroke(Card, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Card)

            Make("TextLabel", {
                Size = UDim2.new(1, -95, 0, 20),
                Position = UDim2.new(0, 12, 0, 5),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = tostring(Opts.Name or "Slider"),
                ZIndex = 8
            }, Card)

            local ValLabel = Make("TextLabel", {
                Size = UDim2.new(0, 82, 0, 20),
                Position = UDim2.new(1, -92, 0, 5),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextColor3 = Theme.AccentSecondary,
                TextXAlignment = Enum.TextXAlignment.Right,
                Text = tostring(CurrentVal) .. (Suffix ~= "" and (" " .. Suffix) or ""),
                ZIndex = 8
            }, Card)
            table.insert(Registry.SecondaryTextObjs, ValLabel)

            local Track = Make("Frame", {
                Size = UDim2.new(1, -24, 0, 7),
                Position = UDim2.new(0, 12, 0, 31),
                BackgroundColor3 = Theme.ToggleOff,
                BorderSizePixel = 0,
                Active = false,
                ZIndex = 8
            }, Card)
            AddCorner(Track, 4)

            local FillPct = (MaxVal > MinVal) and ((CurrentVal - MinVal) / (MaxVal - MinVal)) or 0
            local Fill = Make("Frame", {
                Size = UDim2.new(FillPct, 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
                Active = false,
                ZIndex = 9
            }, Track)
            AddCorner(Fill, 4)
            table.insert(Registry.PrimaryColorObjs, Fill)

            local FillGrad = Make("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Theme.Accent),
                    ColorSequenceKeypoint.new(1, Theme.AccentSecondary)
                })
            }, Fill)
            table.insert(Registry.AccentGradients, FillGrad)

            local Knob = Make("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new(1, -7, 0.5, -7),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Active = false,
                ZIndex = 10
            }, Fill)
            AddCorner(Knob, 7)

            -- Transparent Frame (Active = false so ScrollingFrame receives vertical swipes natively!)
            local TouchZone = Make("Frame", {
                Size = UDim2.new(1, 8, 0, 26),
                Position = UDim2.new(0, -4, 0.5, -13),
                BackgroundTransparency = 1,
                Active = false,
                ZIndex = 11
            }, Track)

            local SliderObj = {CurrentValue = CurrentVal}

            local function RoundStep(Val)
                local Stepped = math.floor(((Val - MinVal) / Increment) + 0.5) * Increment + MinVal
                Stepped = math.clamp(Stepped, MinVal, MaxVal)
                if Increment < 1 then
                    local Decimals = math.ceil(-math.log10(Increment))
                    local Mult = 10 ^ Decimals
                    Stepped = math.floor(Stepped * Mult + 0.5) / Mult
                end
                return Stepped
            end

            function SliderObj:Set(NewVal)
                local Num = tonumber(NewVal)
                if not Num then return end
                CurrentVal = RoundStep(Num)
                SliderObj.CurrentValue = CurrentVal
                local Pct = (MaxVal > MinVal) and ((CurrentVal - MinVal) / (MaxVal - MinVal)) or 0
                Fill.Size = UDim2.new(Pct, 0, 1, 0)
                ValLabel.Text = tostring(CurrentVal) .. (Suffix ~= "" and (" " .. Suffix) or "")
                if type(Opts.Callback) == "function" then
                    task.spawn(Opts.Callback, CurrentVal)
                end
                Library:SaveConfiguration()
            end

            local PendingInput = nil
            local StartPos = nil
            local Sliding = false

            local function UpdateFromInputX(InputPosX)
                local RelX = math.clamp((InputPosX - Track.AbsolutePosition.X) / math.max(Track.AbsoluteSize.X, 1), 0, 1)
                local RawVal = MinVal + (MaxVal - MinVal) * RelX
                local Rounded = RoundStep(RawVal)
                if Rounded ~= CurrentVal then
                    SliderObj:Set(Rounded)
                end
            end

            TouchZone.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    -- Mouse: instant slide
                    PendingInput = Input
                    Sliding = true
                    TabPage.ScrollingEnabled = false
                    UpdateFromInputX(Input.Position.X)
                elseif Input.UserInputType == Enum.UserInputType.Touch then
                    -- Touch: DO NOT move yet! Wait to see if user is scrolling vertically or sliding horizontally
                    PendingInput = Input
                    StartPos = Input.Position
                    Sliding = false
                end
            end)

            UserInputService.InputChanged:Connect(function(Input)
                if not PendingInput then return end

                if Sliding then
                    if Input == PendingInput or Input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateFromInputX(Input.Position.X)
                    end
                elseif Input == PendingInput and StartPos then
                    local dx = math.abs(Input.Position.X - StartPos.X)
                    local dy = math.abs(Input.Position.Y - StartPos.Y)

                    -- Threshold check (8px) to separate vertical page scroll from horizontal slider drag
                    if dy > 7 and dy >= dx then
                        -- User is scrolling vertically -> immediately abort slider capture!
                        PendingInput = nil
                        StartPos = nil
                        Sliding = false
                        TabPage.ScrollingEnabled = true
                    elseif dx > 8 and dx > dy * 1.25 then
                        -- User intentionally dragged horizontally -> lock into slider mode!
                        Sliding = true
                        TabPage.ScrollingEnabled = false
                        UpdateFromInputX(Input.Position.X)
                    end
                end
            end)

            UserInputService.InputEnded:Connect(function(Input)
                if PendingInput and (Input == PendingInput or Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
                    PendingInput = nil
                    StartPos = nil
                    Sliding = false
                    TabPage.ScrollingEnabled = true
                end
            end)

            if FlagName then
                Library.Flags[FlagName] = SliderObj
            end

            return SliderObj
        end

        -- 7. CREATE INPUT
        function Tab:CreateInput(Opts)
            Opts = Opts or {}
            local FlagName = Opts.Flag
            local ClearAfter = Opts.RemoveTextAfterFocusLost == true

            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = (SurfaceTransparency[LooksState.SurfaceMode] or SurfaceTransparency.Translucent).Card,
                ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9)
            AddStroke(Card, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Card)

            Make("TextLabel", {
                Size = UDim2.new(0.52, -12, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = tostring(Opts.Name or "Input"),
                ZIndex = 8
            }, Card)

            local Box = Make("TextBox", {
                Size = UDim2.new(0.45, -10, 0, 24),
                Position = UDim2.new(0.55, 0, 0.5, -12),
                BackgroundColor3 = Theme.InputBg,
                BackgroundTransparency = (SurfaceTransparency[LooksState.SurfaceMode] or SurfaceTransparency.Translucent).Input,
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                TextColor3 = Theme.AccentSecondary,
                PlaceholderColor3 = Theme.TextMuted,
                PlaceholderText = tostring(Opts.PlaceholderText or "Type here..."),
                Text = "",
                ClearTextOnFocus = false,
                ZIndex = 8
            }, Card)
            AddCorner(Box, 7)
            AddStroke(Box, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Inputs, Box)
            table.insert(Registry.SecondaryTextObjs, Box)

            local InputObj = {CurrentValue = ""}

            function InputObj:Set(TextVal)
                local Str = tostring(TextVal or "")
                InputObj.CurrentValue = Str
                Box.Text = Str
                if type(Opts.Callback) == "function" then
                    task.spawn(Opts.Callback, Str)
                end
                Library:SaveConfiguration()
            end

            Box.FocusLost:Connect(function()
                local Typed = Box.Text
                InputObj.CurrentValue = Typed
                if type(Opts.Callback) == "function" then
                    task.spawn(Opts.Callback, Typed)
                end
                Library:SaveConfiguration()
                if ClearAfter then
                    Box.Text = ""
                end
            end)

            if FlagName then
                Library.Flags[FlagName] = InputObj
            end

            return InputObj
        end

        -- 8. CREATE DROPDOWN (SINGLE + MULTI-SELECT + REFRESH)
        function Tab:CreateDropdown(Opts)
            Opts = Opts or {}
            local Multi = Opts.MultipleOptions == true
            local FlagName = Opts.Flag
            local OptionsList = Opts.Options or {}
            local SelectedSet = {}
            local SingleSelected = nil
            local IsOpen = false

            if Multi then
                if type(Opts.CurrentOption) == "table" then
                    for _, v in ipairs(Opts.CurrentOption) do SelectedSet[tostring(v)] = true end
                elseif type(Opts.CurrentOption) == "string" then
                    SelectedSet[Opts.CurrentOption] = true
                end
            else
                if type(Opts.CurrentOption) == "table" then
                    SingleSelected = Opts.CurrentOption[1]
                elseif type(Opts.CurrentOption) == "string" then
                    SingleSelected = Opts.CurrentOption
                end
            end

            local Container = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = (SurfaceTransparency[LooksState.SurfaceMode] or SurfaceTransparency.Translucent).Card,
                ClipsDescendants = true,
                ZIndex = 7
            }, TabPage)
            AddCorner(Container, 9)
            local Stroke = AddStroke(Container, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Container)

            local HeaderBtn = Make("TextButton", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 8
            }, Container)

            Make("TextLabel", {
                Size = UDim2.new(0.50, -12, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = tostring(Opts.Name or "Dropdown"),
                ZIndex = 9
            }, HeaderBtn)

            local SelectedLabel = Make("TextLabel", {
                Size = UDim2.new(0.46, -24, 1, 0),
                Position = UDim2.new(0.50, 0, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                TextColor3 = Theme.AccentSecondary,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = "None",
                ZIndex = 9
            }, HeaderBtn)
            table.insert(Registry.SecondaryTextObjs, SelectedLabel)

            local Arrow = Make("TextLabel", {
                Size = UDim2.new(0, 18, 1, 0),
                Position = UDim2.new(1, -24, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextColor3 = Theme.TextMuted,
                Text = "v",
                ZIndex = 9
            }, HeaderBtn)

            local ListScroll = Make("ScrollingFrame", {
                Size = UDim2.new(1, -16, 0, 0),
                Position = UDim2.new(0, 8, 0, 40),
                BackgroundColor3 = Theme.InputBg,
                BackgroundTransparency = (SurfaceTransparency[LooksState.SurfaceMode] or SurfaceTransparency.Translucent).Input,
                BorderSizePixel = 0,
                ScrollBarThickness = 2,
                ScrollBarImageColor3 = Theme.Accent,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ZIndex = 8
            }, Container)
            AddCorner(ListScroll, 7)
            table.insert(Registry.Inputs, ListScroll)
            table.insert(Registry.PrimaryColorObjs, ListScroll)

            Make("UIPadding", {
                PaddingTop = UDim.new(0, 4),
                PaddingBottom = UDim.new(0, 4),
                PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4)
            }, ListScroll)

            local DropLayout = Make("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 4)
            }, ListScroll)

            local DropdownObj = {}
            local OptionButtons = {}

            local function GetCurrentReturnValue()
                if Multi then
                    local Arr = {}
                    for _, Opt in ipairs(OptionsList) do
                        if SelectedSet[tostring(Opt)] then
                            table.insert(Arr, tostring(Opt))
                        end
                    end
                    return Arr
                else
                    return SingleSelected
                end
            end

            local function UpdateSelectedText()
                if Multi then
                    local Arr = GetCurrentReturnValue()
                    DropdownObj.CurrentOption = Arr
                    if #Arr == 0 then
                        SelectedLabel.Text = "None"
                    elseif #Arr == 1 then
                        SelectedLabel.Text = Arr[1]
                    else
                        SelectedLabel.Text = string.format("%s (+%d)", Arr[1], #Arr - 1)
                    end
                else
                    DropdownObj.CurrentOption = SingleSelected
                    SelectedLabel.Text = SingleSelected and tostring(SingleSelected) or "None"
                end
            end

            local function RefreshButtonStyles()
                for OptName, Btn in pairs(OptionButtons) do
                    local Active = Multi and (SelectedSet[OptName] == true) or (SingleSelected == OptName)
                    Btn.BackgroundColor3 = Active and Theme.Accent or Theme.CardBg
                    Btn.TextColor3 = Active and Color3.fromRGB(255, 255, 255) or Theme.TextMuted
                end
            end

            table.insert(Registry.DropdownRefreshers, function()
                RefreshButtonStyles()
                if IsOpen then Stroke.Color = Theme.Accent end
            end)

            local function UpdateDropdownHeight()
                local ContentH = DropLayout.AbsoluteContentSize.Y + 8
                ListScroll.CanvasSize = UDim2.new(0, 0, 0, ContentH)
                local VisibleListH = math.min(ContentH, 130)

                if IsOpen then
                    ListScroll.Size = UDim2.new(1, -16, 0, VisibleListH)
                    Tween(Container, 0.16, {Size = UDim2.new(1, 0, 0, 46 + VisibleListH)})
                    Arrow.Text = "^"
                    Tween(Stroke, 0.16, {Color = Theme.Accent})
                else
                    Tween(Container, 0.16, {Size = UDim2.new(1, 0, 0, 38)})
                    Arrow.Text = "v"
                    Tween(Stroke, 0.16, {Color = Theme.Stroke})
                end
            end

            local function BuildOptionItems()
                for _, Child in ipairs(ListScroll:GetChildren()) do
                    if Child:IsA("TextButton") then Child:Destroy() end
                end
                table.clear(OptionButtons)

                for _, OptName in ipairs(OptionsList) do
                    local OptStr = tostring(OptName)
                    local OptBtn = Make("TextButton", {
                        Size = UDim2.new(1, 0, 0, 26),
                        BackgroundColor3 = Theme.CardBg,
                        Font = Enum.Font.GothamMedium,
                        TextSize = 11,
                        TextColor3 = Theme.TextMuted,
                        Text = "  " .. OptStr,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        AutoButtonColor = false,
                        ZIndex = 9
                    }, ListScroll)
                    AddCorner(OptBtn, 6)

                    OptionButtons[OptStr] = OptBtn

                    OptBtn.MouseButton1Click:Connect(function()
                        if Multi then
                            SelectedSet[OptStr] = not SelectedSet[OptStr]
                        else
                            SingleSelected = OptStr
                            IsOpen = false
                            UpdateDropdownHeight()
                        end

                        UpdateSelectedText()
                        RefreshButtonStyles()

                        if type(Opts.Callback) == "function" then
                            task.spawn(Opts.Callback, GetCurrentReturnValue())
                        end
                        Library:SaveConfiguration()
                    end)
                end

                UpdateSelectedText()
                RefreshButtonStyles()
                task.defer(UpdateDropdownHeight)
            end

            HeaderBtn.MouseButton1Click:Connect(function()
                IsOpen = not IsOpen
                UpdateDropdownHeight()
            end)

            function DropdownObj:Set(NewVal)
                if Multi then
                    table.clear(SelectedSet)
                    if type(NewVal) == "table" then
                        for _, v in ipairs(NewVal) do SelectedSet[tostring(v)] = true end
                    elseif type(NewVal) == "string" then
                        SelectedSet[NewVal] = true
                    end
                else
                    if type(NewVal) == "table" then
                        SingleSelected = NewVal[1]
                    else
                        SingleSelected = NewVal
                    end
                end

                UpdateSelectedText()
                RefreshButtonStyles()

                if type(Opts.Callback) == "function" then
                    task.spawn(Opts.Callback, GetCurrentReturnValue())
                end
                Library:SaveConfiguration()
            end

            function DropdownObj:Refresh(NewOptions, NewCurrent)
                OptionsList = type(NewOptions) == "table" and NewOptions or {}
                if NewCurrent ~= nil then
                    if Multi then
                        table.clear(SelectedSet)
                        if type(NewCurrent) == "table" then
                            for _, v in ipairs(NewCurrent) do SelectedSet[tostring(v)] = true end
                        elseif type(NewCurrent) == "string" then
                            SelectedSet[NewCurrent] = true
                        end
                    else
                        SingleSelected = type(NewCurrent) == "table" and NewCurrent[1] or NewCurrent
                    end
                else
                    if Multi then
                        local ValidMap = {}
                        for _, v in ipairs(OptionsList) do ValidMap[tostring(v)] = true end
                        for k in pairs(SelectedSet) do
                            if not ValidMap[k] then SelectedSet[k] = nil end
                        end
                    else
                        if SingleSelected and not table.find(OptionsList, SingleSelected) then
                            SingleSelected = nil
                        end
                    end
                end
                BuildOptionItems()
            end

            BuildOptionItems()

            if FlagName then
                Library.Flags[FlagName] = DropdownObj
            end

            return DropdownObj
        end

        return Tab
    end

    function Window:CreateTab(TabName, _Icon)
        return CreateTabInternal(TabName, nil, false)
    end

    -- ==========================================
    -- PRE-REGISTERED "LOOKS" TAB (ALWAYS LAST)
    -- ==========================================
    local LooksTab = CreateTabInternal("Looks", 9999, true)

    LooksTab:CreateSection("Color & Gradient Theme")

    local PresetNames = {
        "Kaixer Violet",
        "Cyber Cyan",
        "Crimson Blood",
        "Emerald Neon",
        "Royal Gold",
        "Sakura Pink",
        "Sunset Blaze",
        "Midnight Ice",
        "Toxic Lime",
        "Obsidian White",
        "RGB Rainbow"
    }

    LooksTab:CreateDropdown({
        Name = "Gradient Color Preset",
        Options = PresetNames,
        CurrentOption = "Kaixer Violet",
        MultipleOptions = false,
        Flag = "SidUI_LooksColorPreset",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt and ColorPresets[Opt] then
                SetThemePreset(Opt)
            end
        end
    })

    LooksTab:CreateInput({
        Name = "Custom Primary Color (Hex / R,G,B)",
        PlaceholderText = "#785FFF or 120,95,255",
        RemoveTextAfterFocusLost = false,
        Flag = "SidUI_LooksCustomPrimary",
        Callback = function(Text)
            local Col = ParseColorString(Text)
            if Col then
                LooksState.RainbowActive = false
                if Library._RainbowConn then
                    Library._RainbowConn:Disconnect()
                    Library._RainbowConn = nil
                end
                ApplyLiveColors(Col, Theme.AccentSecondary)
            end
        end
    })

    LooksTab:CreateInput({
        Name = "Custom Gradient Color 2 (Hex / R,G,B)",
        PlaceholderText = "#00DCFF or 0,220,255",
        RemoveTextAfterFocusLost = false,
        Flag = "SidUI_LooksCustomSecondary",
        Callback = function(Text)
            local Col = ParseColorString(Text)
            if Col then
                LooksState.RainbowActive = false
                if Library._RainbowConn then
                    Library._RainbowConn:Disconnect()
                    Library._RainbowConn = nil
                end
                ApplyLiveColors(Theme.Accent, Col)
            end
        end
    })

    LooksTab:CreateSection("UI Surface & Transparency")

    LooksTab:CreateDropdown({
        Name = "UI Background Style",
        Options = {"Transparent", "Translucent", "Opaque"},
        CurrentOption = "Translucent",
        MultipleOptions = false,
        Flag = "SidUI_LooksSurfaceStyle",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt then
                ApplySurfaceMode(Opt)
            end
        end
    })

    LooksTab:CreateSection("UI Animations (Background + Open/Close)")

    LooksTab:CreateToggle({
        Name = "Enable All UI Animations",
        CurrentValue = true,
        Flag = "SidUI_LooksAnimEnabled",
        Callback = function(Val)
            LooksState.AnimationsEnabled = (Val == true)
            RebuildBackgroundAnim()
        end
    })

    LooksTab:CreateDropdown({
        Name = "Live Background Animation (5 Styles)",
        Options = {
            "Moving Stars",
            "Floating Particles",
            "Cyber Rain",
            "Glow Orbs",
            "Aurora Wave",
            "None"
        },
        CurrentOption = "Moving Stars",
        MultipleOptions = false,
        Flag = "SidUI_LooksBgAnimStyle",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt then
                LooksState.BgAnimStyle = Opt
                RebuildBackgroundAnim()
            end
        end
    })

    LooksTab:CreateDropdown({
        Name = "Window Open/Close Style (5 Styles)",
        Options = {
            "Pop & Scale",
            "Slide From Top",
            "Slide From Bottom",
            "Fade & Glide",
            "Elastic Bounce"
        },
        CurrentOption = "Pop & Scale",
        MultipleOptions = false,
        Flag = "SidUI_LooksAnimStyle",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt then
                LooksState.WindowAnimStyle = Opt
                -- Play instant live preview when user manually switches style!
                if not Library._IsLoadingConfig and IsWindowVisible and LooksState.AnimationsEnabled then
                    LastSavedPos = MainFrame.Position
                    AnimateShowUI()
                end
            end
        end
    })

    LooksTab:CreateSection("Saved Configuration")

    LooksTab:CreateButton({
        Name = "Save All Settings Now",
        Callback = function()
            Library:SaveConfiguration()
            Library:Notify({
                Title = "Config Saved!",
                Content = tostring(Library._ConfigSettings.FolderName) .. "/" .. tostring(Library._ConfigSettings.FileName) .. ".json",
                Duration = 2.5
            })
        end
    })

    -- Initialize default background animation
    RebuildBackgroundAnim()

    -- Auto-load saved settings if script doesn't manually call LoadConfiguration()
    task.delay(0.65, function()
        if not Library._ConfigLoadedOnce then
            Library:LoadConfiguration()
        end
    end)

    -- Show "Sid Ultimate" Splash -> Open Main UI!
    PlaySidUltimateSplash(function()
        if ScreenGui and ScreenGui.Parent then
            AnimateShowUI()
        end
    end)

    return Window
end

return Library
