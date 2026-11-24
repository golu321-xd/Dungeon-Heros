--====================================================================
-- SID ULTIMATE | UNIVERSAL ENGINE V5.0 (INSTANT EXECUTE EDITION)
-- Created & Owned by Sid | 100% Original Architecture
-- * Instant Launch (< 0.1s, Zero Splash Delay) + Re-Execute Cleanup
-- * Interactive HSV Color Spectrum Studio (Primary + Gradient 2)
-- * Clickable Sidebar Profile Card -> Full Live Player Details Modal
-- * Hold "ULTIMATE" Badge (0.4s) -> Script Info & Auto Last-Updated
-- * 8 Surface Styles | 10 Live BG Animations | 8 Window Animations
-- * Global Search | Dropdown Inline Search | Multi-Profile Configs
-- * Smart Mobile Touch Lock | Live FPS/Ping | Stackable Glass Notifs
--====================================================================

if not game:IsLoaded() then
    pcall(function() game.Loaded:Wait() end)
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local StatsService = game:GetService("Stats")
local MarketplaceService = game:GetService("MarketplaceService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.PlayerAdded:Wait()
    LocalPlayer = Players.LocalPlayer
end

local UI_BUILD_TAG = "v5.0-SidUltimate"
local SESSION_START_TIME = os.clock()

local function GetGuiParent()
    local okHui, hui = pcall(function() return gethui and gethui() end)
    if okHui and hui then return hui end

    local okCore = pcall(function()
        local t = Instance.new("Folder")
        t.Parent = CoreGui
        t:Destroy()
    end)
    if okCore then return CoreGui end

    return LocalPlayer:WaitForChild("PlayerGui")
end

local function SafeDisconnect(Conn)
    if typeof(Conn) == "RBXScriptConnection" then
        pcall(function() Conn:Disconnect() end)
    end
    return nil
end

local function CopyToClipboard(Text)
    local fn = setclipboard or toclipboard or (Clipboard and Clipboard.set)
    if fn then
        pcall(fn, tostring(Text))
        return true
    end
    return false
end

-- Clean up previous execution completely (UI + all connections)
pcall(function()
    if getgenv and type(getgenv()._SidUltimateCleanup) == "function" then
        getgenv()._SidUltimateCleanup()
    end
end)

do
    local Parent = GetGuiParent()
    for _, Name in ipairs({"SidUltimateUI", "SidUltimateNotifStack"}) do
        local Old = Parent:FindFirstChild(Name)
        if Old then Old:Destroy() end
    end
end

-- Private internal state (fully isolated from public Library metatable)
local Internal = {
    DefaultValues = {},
    ConfigSettings = {
        Enabled = true,
        FolderName = "SidUltimateHub",
        FileName = "Game_" .. tostring(game.PlaceId)
    },
    SavePending = false,
    IsLoadingConfig = false,
    ConfigLoadedOnce = false,
    RainbowConn = nil,
    BgAnimConn = nil,
    TelemetryConn = nil,
    ProfileLiveConn = nil,
    GlobalConns = {},
    ActiveNotifs = {},
    ToggleVisibilityFn = nil,
    IsVisibleFn = nil,
    BorderFlowConn = nil,
    AntiAfkConn = nil,
    AfkClockConn = nil,
    ActiveToggleStates = {},
    PinnableRegistry = {},
    PinnedKeys = {},
    FloatingButtons = {},
    RefreshActiveHudFn = nil,
    TogglePinItemFn = nil,
    ToggleFloatingBtnFn = nil,
    SyncToggleExternalsFn = nil,
    ApplyShowUIFn = nil,
    ApplyRadiusFn = nil,
    ApplyFontFn = nil,
    ToggleBorderFlowFn = nil,
    OpenAfkSaverFn = nil,
    LayoutDragConn = nil,
    SavedTabOrders = {},
    SetLayoutEditModeFn = nil,
    ResetTabOrdersFn = nil,
    RegisterReorderCardFn = nil,
}

local function TrackConn(Conn)
    if typeof(Conn) == "RBXScriptConnection" then
        table.insert(Internal.GlobalConns, Conn)
    end
    return Conn
end

local Library = {
    Flags = {},
}

-- ==========================================
-- THEME, 8 SURFACE MODES & COLOR PRESETS
-- ==========================================
local ColorPresets = {
    ["Sid Violet"]     = {Primary = Color3.fromRGB(122, 95, 255),  Secondary = Color3.fromRGB(0, 224, 255)},
    ["Cyber Cyan"]     = {Primary = Color3.fromRGB(0, 195, 255),   Secondary = Color3.fromRGB(80, 255, 220)},
    ["Crimson Blood"]  = {Primary = Color3.fromRGB(245, 55, 85),   Secondary = Color3.fromRGB(255, 130, 75)},
    ["Emerald Neon"]   = {Primary = Color3.fromRGB(0, 220, 135),   Secondary = Color3.fromRGB(90, 255, 190)},
    ["Royal Gold"]     = {Primary = Color3.fromRGB(255, 190, 45),  Secondary = Color3.fromRGB(255, 235, 125)},
    ["Sakura Pink"]    = {Primary = Color3.fromRGB(255, 85, 175),  Secondary = Color3.fromRGB(185, 115, 255)},
    ["Sunset Blaze"]   = {Primary = Color3.fromRGB(255, 105, 45),  Secondary = Color3.fromRGB(255, 195, 65)},
    ["Midnight Ice"]   = {Primary = Color3.fromRGB(70, 145, 255),  Secondary = Color3.fromRGB(175, 225, 255)},
    ["Toxic Lime"]     = {Primary = Color3.fromRGB(130, 255, 45),  Secondary = Color3.fromRGB(0, 235, 165)},
    ["Pure Frost"]     = {Primary = Color3.fromRGB(235, 240, 255), Secondary = Color3.fromRGB(160, 175, 205)},
    ["RGB Rainbow"]    = {Primary = Color3.fromRGB(122, 95, 255),  Secondary = Color3.fromRGB(0, 224, 255), Rainbow = true},
}

local SurfaceModes = {
    -- Ultra Transparent & Glassy Styles
    ["Ultra Phantom"]   = {Main = 0.72, Card = 0.68, Input = 0.60, Stroke = 0.08, MainBg = Color3.fromRGB(10, 12, 20), GradA = Color3.fromRGB(22, 26, 44), GradB = Color3.fromRGB(8, 10, 18)},
    ["Crystal Glass"]   = {Main = 0.54, Card = 0.58, Input = 0.50, Stroke = 0.14, MainBg = Color3.fromRGB(18, 22, 36), GradA = Color3.fromRGB(38, 46, 72), GradB = Color3.fromRGB(16, 20, 32)},
    ["Transparent"]     = {Main = 0.42, Card = 0.48, Input = 0.42, Stroke = 0.24, MainBg = Color3.fromRGB(12, 14, 22), GradA = Color3.fromRGB(24, 28, 44), GradB = Color3.fromRGB(11, 13, 20)},
    ["Liquid Glass"]    = {Main = 0.36, Card = 0.42, Input = 0.34, Stroke = 0.10, MainBg = Color3.fromRGB(24, 34, 54), GradA = Color3.fromRGB(62, 82, 118), GradB = Color3.fromRGB(18, 24, 42)},
    ["Cyber Haze"]      = {Main = 0.32, Card = 0.38, Input = 0.32, Stroke = 0.15, MainBg = Color3.fromRGB(8, 24, 34),  GradA = Color3.fromRGB(16, 52, 68), GradB = Color3.fromRGB(6, 16, 24)},
    ["Frosted Mist"]    = {Main = 0.28, Card = 0.34, Input = 0.28, Stroke = 0.20, MainBg = Color3.fromRGB(28, 33, 48), GradA = Color3.fromRGB(48, 56, 80), GradB = Color3.fromRGB(22, 26, 40)},
    ["Holo Prism"]      = {Main = 0.26, Card = 0.34, Input = 0.26, Stroke = 0.12, MainBg = Color3.fromRGB(26, 16, 44), GradA = Color3.fromRGB(58, 28, 92), GradB = Color3.fromRGB(12, 36, 56)},
    ["Acrylic Frost"]   = {Main = 0.22, Card = 0.30, Input = 0.22, Stroke = 0.24, MainBg = Color3.fromRGB(20, 24, 34), GradA = Color3.fromRGB(36, 42, 58), GradB = Color3.fromRGB(15, 18, 26)},

    -- Balanced Translucent & Tinted Styles
    ["Translucent"]     = {Main = 0.16, Card = 0.24, Input = 0.18, Stroke = 0.28, MainBg = Color3.fromRGB(12, 14, 21), GradA = Color3.fromRGB(22, 26, 40), GradB = Color3.fromRGB(10, 12, 19)},
    ["Crimson Velvet"]  = {Main = 0.15, Card = 0.22, Input = 0.16, Stroke = 0.20, MainBg = Color3.fromRGB(28, 10, 18), GradA = Color3.fromRGB(56, 16, 30), GradB = Color3.fromRGB(16, 6, 12)},
    ["Midnight Glass"]  = {Main = 0.14, Card = 0.20, Input = 0.15, Stroke = 0.22, MainBg = Color3.fromRGB(10, 14, 34), GradA = Color3.fromRGB(20, 28, 62), GradB = Color3.fromRGB(8, 10, 24)},

    -- Stealth, Dark & Solid Styles
    ["Carbon Stealth"]  = {Main = 0.08, Card = 0.14, Input = 0.10, Stroke = 0.36, MainBg = Color3.fromRGB(16, 17, 20), GradA = Color3.fromRGB(26, 28, 32), GradB = Color3.fromRGB(12, 13, 16)},
    ["Smoked Obsidian"] = {Main = 0.06, Card = 0.12, Input = 0.08, Stroke = 0.32, MainBg = Color3.fromRGB(9, 10, 15),  GradA = Color3.fromRGB(16, 18, 28), GradB = Color3.fromRGB(7, 8, 12)},
    ["Neon Dark"]       = {Main = 0.03, Card = 0.07, Input = 0.04, Stroke = 0.06, MainBg = Color3.fromRGB(5, 6, 10),   GradA = Color3.fromRGB(12, 14, 22), GradB = Color3.fromRGB(4, 5, 8)},
    ["Deep Void"]       = {Main = 0.01, Card = 0.05, Input = 0.02, Stroke = 0.14, MainBg = Color3.fromRGB(2, 2, 4),    GradA = Color3.fromRGB(6, 6, 10),   GradB = Color3.fromRGB(0, 0, 2)},
    ["Opaque Solid"]    = {Main = 0.00, Card = 0.00, Input = 0.00, Stroke = 0.34, MainBg = Color3.fromRGB(13, 15, 22), GradA = Color3.fromRGB(20, 24, 36), GradB = Color3.fromRGB(11, 13, 20)},
}


local Theme = {
    MainBg = Color3.fromRGB(12, 14, 21),
    CardBg = Color3.fromRGB(20, 24, 35),
    CardHover = Color3.fromRGB(28, 33, 48),
    InputBg = Color3.fromRGB(15, 18, 27),
    Stroke = Color3.fromRGB(48, 55, 78),
    Accent = Color3.fromRGB(122, 95, 255),
    AccentSecondary = Color3.fromRGB(0, 224, 255),
    Danger = Color3.fromRGB(255, 80, 95),
    Success = Color3.fromRGB(0, 232, 155),
    TextPrimary = Color3.fromRGB(242, 246, 255),
    TextMuted = Color3.fromRGB(155, 165, 190),
    ToggleOff = Color3.fromRGB(42, 48, 66),
}

local LooksState = {
    ThemeName = "Sid Violet",
    SurfaceMode = "Translucent",
    AnimationsEnabled = true,
    BgAnimStyle = "Moving Stars",
    WindowAnimStyle = "Pop & Scale",
    UIScale = 1.0,
    LockPosition = false,
    ShowTelemetry = true,
    SoundsEnabled = true,
    RainbowActive = false,
    ShowActiveHUD = false,
    AntiAfkEnabled = true,
    ShowUICustomEnabled = false,
    ShowUIPosition = "Top-Center (Default)",
    ShowUIShape = "Pill (Default)",
    ShowUISize = 1.0,
    ShowUITransparency = 0.42,
    ShowUIColorMode = "Match Theme",
    ShowUICustomHex = "#00E0FF",
    ShowUIText = "Show UI",
    CornerRadius = 18,
    FlowingBorder = false,
    UIFont = "Gotham",
    EditLayoutMode = false,
}

local Registry = {
    MainFrames = {},
    MainBgGradients = {},
    MainStrokes = {},
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
    WheelRefreshers = {},
    MainCorners = {},
    CardCorners = {},
    AllTextObjs = {},
}

-- ==========================================
-- UTILITY HELPERS & CRISP TOUCH SOUNDS
-- ==========================================
local function Make(ClassName, Props, Parent)
    local Inst = Instance.new(ClassName)
    for k, v in pairs(Props or {}) do
        Inst[k] = v
    end
    if ClassName == "TextLabel" or ClassName == "TextButton" or ClassName == "TextBox" then
        table.insert(Registry.AllTextObjs, Inst)
    end
    if Parent then
        Inst.Parent = Parent
    end
    return Inst
end

local function AddCorner(Parent, Radius)
    local r = Radius or 10
    local c = Make("UICorner", {CornerRadius = UDim.new(0, r)}, Parent)
    if r == 18 then
        table.insert(Registry.MainCorners, c)
    elseif r == 9 then
        table.insert(Registry.CardCorners, c)
    end
    return c
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

local SoundIds = {
    Click  = "rbxassetid://6895079853",
    Toggle = "rbxassetid://6042053626",
    Open   = "rbxassetid://6895079853",
}

local function PlayUISound(SoundType, Pitch)
    if not LooksState.SoundsEnabled or Internal.IsLoadingConfig then return end
    task.spawn(function()
        pcall(function()
            local S = Instance.new("Sound")
            S.SoundId = SoundIds[SoundType] or SoundIds.Click
            S.Volume = 0.24
            S.PlaybackSpeed = Pitch or (SoundType == "Toggle" and 1.15 or 1.0)
            S.Parent = GetGuiParent()
            S:Play()
            task.delay(0.8, function()
                if S and S.Parent then S:Destroy() end
            end)
        end)
    end)
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

local function ColorToHex(Col)
    return string.format("#%02X%02X%02X", math.floor(Col.R * 255 + 0.5), math.floor(Col.G * 255 + 0.5), math.floor(Col.B * 255 + 0.5))
end

local function GetSurfaceSpec(ModeName)
    if ModeName == "Opaque" then ModeName = "Opaque Solid" end
    return SurfaceModes[ModeName] or SurfaceModes["Translucent"]
end

local function ApplyLiveColors(PrimaryCol, SecondaryCol, SkipWheelSync)
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
    if not SkipWheelSync then
        for _, fn in ipairs(Registry.WheelRefreshers) do pcall(fn) end
    end
end

local function ApplySurfaceMode(ModeName)
    if ModeName == "Opaque" then ModeName = "Opaque Solid" end
    local Spec = SurfaceModes[ModeName] or SurfaceModes["Translucent"]
    LooksState.SurfaceMode = SurfaceModes[ModeName] and ModeName or "Translucent"

    for _, Frame in ipairs(Registry.MainFrames) do
        if Frame and Frame.Parent then
            Tween(Frame, 0.2, {BackgroundTransparency = Spec.Main, BackgroundColor3 = Spec.MainBg})
        end
    end
    for _, Grad in ipairs(Registry.MainBgGradients) do
        if Grad and Grad.Parent then
            Grad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Spec.GradA),
                ColorSequenceKeypoint.new(1, Spec.GradB)
            })
        end
    end
    for _, Stk in ipairs(Registry.MainStrokes) do
        if Stk and Stk.Parent then
            Tween(Stk, 0.2, {Transparency = Spec.Stroke})
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
    local Preset = ColorPresets[PresetName] or ColorPresets["Sid Violet"]
    LooksState.ThemeName = ColorPresets[PresetName] and PresetName or "Sid Violet"

    Internal.RainbowConn = SafeDisconnect(Internal.RainbowConn)

    if Preset.Rainbow then
        LooksState.RainbowActive = true
        local Hue = 0
        Internal.RainbowConn = RunService.Heartbeat:Connect(function(dt)
            if not LooksState.RainbowActive then return end
            Hue = (Hue + dt * 0.14) % 1
            local C1 = Color3.fromHSV(Hue, 0.78, 1)
            local C2 = Color3.fromHSV((Hue + 0.15) % 1, 0.78, 1)
            ApplyLiveColors(C1, C2, true)
        end)
    else
        LooksState.RainbowActive = false
        ApplyLiveColors(Preset.Primary, Preset.Secondary)
    end
end

-- ==========================================
-- UNIVERSAL MULTI-PROFILE CONFIG & AUTO-UPDATE TRACKER
-- ==========================================
local function SanitizeFileName(Name)
    local Clean = tostring(Name or ("Game_" .. tostring(game.PlaceId)))
    Clean = string.gsub(Clean, "%.json$", "")
    Clean = string.gsub(Clean, "[^%w_%-%s]", "")
    Clean = string.gsub(Clean, "^%s*(.-)%s*$", "%1")
    return (#Clean > 0) and Clean or ("Game_" .. tostring(game.PlaceId))
end

local function EnsureConfigFolder()
    local Folder = Internal.ConfigSettings.FolderName or "SidUltimateHub"
    if makefolder and isfolder then
        pcall(function()
            if not isfolder(Folder) then makefolder(Folder) end
        end)
    end
    return Folder
end

local function GetConfigPath(CustomProfileName)
    local Folder = Internal.ConfigSettings.FolderName or "SidUltimateHub"
    local File = SanitizeFileName(CustomProfileName or Internal.ConfigSettings.FileName)
    return Folder, Folder .. "/" .. File .. ".json"
end

local function ListAvailableProfiles()
    local Folder = EnsureConfigFolder()
    local Profiles = {}
    local Seen = {}

    local function AddProf(Name)
        Name = SanitizeFileName(Name)
        if not Seen[Name] and not string.find(Name, "^%.") then
            Seen[Name] = true
            table.insert(Profiles, Name)
        end
    end

    AddProf(Internal.ConfigSettings.FileName)

    if listfiles and isfolder then
        local okF, exists = pcall(isfolder, Folder)
        if okF and exists then
            local ok, files = pcall(listfiles, Folder)
            if ok and type(files) == "table" then
                for _, Path in ipairs(files) do
                    local Base = string.match(tostring(Path), "([^/\\]+)$") or ""
                    if string.sub(Base, 1, 1) ~= "." and string.find(Base, "%.json$") then
                        AddProf(string.gsub(Base, "%.json$", ""))
                    end
                end
            end
        end
    end

    table.sort(Profiles)
    return Profiles
end

local function ResolveAutoLastUpdated(WindowTitle, TotalTabs, TotalFlags, ManualOverride)
    if type(ManualOverride) == "string" and #ManualOverride > 0 then
        return ManualOverride
    end

    local TodayStr = os.date("%d %b %Y | %I:%M %p")
    local Folder = EnsureConfigFolder()
    local MetaPath = Folder .. "/.sid_meta_" .. tostring(game.PlaceId) .. ".json"

    local FlagKeys = {}
    for k in pairs(Library.Flags) do
        table.insert(FlagKeys, tostring(k))
    end
    table.sort(FlagKeys)
    local Signature = string.format("%s|%s|%d|%d|%d|%s", UI_BUILD_TAG, tostring(WindowTitle), game.PlaceId, TotalTabs, TotalFlags, table.concat(FlagKeys, ","))

    local SavedMeta = nil
    if readfile and isfile then
        local okEx, exists = pcall(isfile, MetaPath)
        if okEx and exists then
            local ok, raw = pcall(readfile, MetaPath)
            if ok and type(raw) == "string" then
                local okJ, dec = pcall(function() return HttpService:JSONDecode(raw) end)
                if okJ and type(dec) == "table" then
                    SavedMeta = dec
                end
            end
        end
    end

    if SavedMeta and SavedMeta.signature == Signature and type(SavedMeta.lastUpdated) == "string" then
        return SavedMeta.lastUpdated
    end

    if writefile then
        pcall(function()
            writefile(MetaPath, HttpService:JSONEncode({
                signature = Signature,
                lastUpdated = TodayStr,
                build = UI_BUILD_TAG,
                placeId = game.PlaceId
            }))
        end)
    end

    return TodayStr
end

local function SerializeValue(Val)
    if typeof(Val) == "Color3" then
        return {__sidType = "Color3", r = Val.R, g = Val.G, b = Val.B}
    end
    return Val
end

local function DeserializeValue(Val)
    if type(Val) == "table" and Val.__sidType == "Color3" then
        return Color3.new(tonumber(Val.r) or 1, tonumber(Val.g) or 1, tonumber(Val.b) or 1)
    end
    return Val
end

function Library:SaveConfiguration(CustomProfileName, Immediate)
    if not Internal.ConfigSettings.Enabled or Internal.IsLoadingConfig then return end
    if not writefile then return end

    local function DoWrite()
        pcall(function()
            EnsureConfigFolder()
            local _, JsonPath = GetConfigPath(CustomProfileName)

            local Payload = {}
            for FlagName, Obj in pairs(Library.Flags) do
                if type(Obj) == "table" then
                    if Obj.Color ~= nil then
                        Payload[FlagName] = SerializeValue(Obj.Color)
                    elseif Obj.CurrentKeybind ~= nil then
                        Payload[FlagName] = Obj.CurrentKeybind
                    elseif Obj.CurrentOption ~= nil then
                        Payload[FlagName] = Obj.CurrentOption
                    elseif Obj.CurrentValue ~= nil then
                        Payload[FlagName] = SerializeValue(Obj.CurrentValue)
                    end
                end
            end

            writefile(JsonPath, HttpService:JSONEncode(Payload))
        end)
    end

    if Immediate then
        DoWrite()
        return
    end

    if Internal.SavePending then return end
    Internal.SavePending = true
    task.delay(0.35, function()
        Internal.SavePending = false
        DoWrite()
    end)
end

function Library:LoadConfiguration(CustomProfileName)
    if not Internal.ConfigSettings.Enabled then return false end
    if not readfile or not isfile then return false end

    if CustomProfileName then
        Internal.ConfigSettings.FileName = SanitizeFileName(CustomProfileName)
    end

    Internal.ConfigLoadedOnce = true
    Internal.IsLoadingConfig = true

    local LoadedAny = false
    pcall(function()
        local _, JsonPath = GetConfigPath(CustomProfileName)
        if not isfile(JsonPath) then return end

        local Raw = readfile(JsonPath)
        local Decoded = HttpService:JSONDecode(Raw)
        if type(Decoded) ~= "table" then return end

        LoadedAny = true
        for FlagName, SavedEntry in pairs(Decoded) do
            local Obj = Library.Flags[FlagName]
            if Obj and Obj.Set then
                local ActualVal = SavedEntry
                if type(SavedEntry) == "table" and SavedEntry.__sidType == nil then
                    if SavedEntry.CurrentOption ~= nil then
                        ActualVal = SavedEntry.CurrentOption
                    elseif SavedEntry.CurrentValue ~= nil then
                        ActualVal = SavedEntry.CurrentValue
                    elseif SavedEntry.CurrentKeybind ~= nil then
                        ActualVal = SavedEntry.CurrentKeybind
                    elseif SavedEntry.Color ~= nil then
                        ActualVal = SavedEntry.Color
                    end
                end
                ActualVal = DeserializeValue(ActualVal)
                pcall(function()
                    Obj:Set(ActualVal)
                end)
            end
        end
    end)

    Internal.IsLoadingConfig = false
    return LoadedAny
end

function Library:DeleteProfile(ProfileName)
    local Clean = SanitizeFileName(ProfileName)
    local _, JsonPath = GetConfigPath(Clean)
    if delfile and isfile and isfile(JsonPath) then
        pcall(delfile, JsonPath)
        return true
    end
    return false
end

function Library:ResetAllSettings()
    Internal.IsLoadingConfig = true
    for FlagName, DefaultVal in pairs(Internal.DefaultValues) do
        local Obj = Library.Flags[FlagName]
        if Obj and Obj.Set then
            pcall(function()
                Obj:Set(DefaultVal)
            end)
        end
    end
    Internal.IsLoadingConfig = false
    Library:SaveConfiguration(nil, true)
end

function Library:SetVisibility(Visible)
    if type(Internal.ToggleVisibilityFn) == "function" then
        Internal.ToggleVisibilityFn(Visible == true)
    end
end

function Library:IsVisible()
    if type(Internal.IsVisibleFn) == "function" then
        return Internal.IsVisibleFn()
    end
    return false
end

-- ==========================================
-- STACKABLE GLASSMORPHISM NOTIFICATIONS (MAX 3, TAP TO CLOSE)
-- ==========================================
local function GetOrCreateNotifContainer()
    local Parent = GetGuiParent()
    local StackGui = Parent:FindFirstChild("SidUltimateNotifStack")
    if not StackGui then
        StackGui = Make("ScreenGui", {
            Name = "SidUltimateNotifStack",
            IgnoreGuiInset = true,
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 999999
        }, Parent)

        local Holder = Make("Frame", {
            Name = "Holder",
            Size = UDim2.new(0, 310, 0, 220),
            Position = UDim2.new(0.5, -155, 0, 12),
            BackgroundTransparency = 1
        }, StackGui)

        Make("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 6)
        }, Holder)
    end
    return StackGui:FindFirstChild("Holder")
end

function Library:Notify(Opts)
    Opts = Opts or {}
    local TitleText = tostring(Opts.Title or "Sid Ultimate")
    local SubText = tostring(Opts.Content or "")
    local Duration = tonumber(Opts.Duration) or 3.0
    local AccentColor = Opts.Color or Theme.AccentSecondary

    task.spawn(function()
        pcall(function()
            local Holder = GetOrCreateNotifContainer()
            if not Holder then return end

            if #Internal.ActiveNotifs >= 3 then
                local Oldest = table.remove(Internal.ActiveNotifs, 1)
                if Oldest and Oldest.Close then
                    task.spawn(Oldest.Close)
                end
            end

            local Wrapper = Make("Frame", {
                Size = UDim2.new(0, 300, 0, 0),
                BackgroundTransparency = 1,
                ClipsDescendants = true
            }, Holder)

            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 48),
                BackgroundColor3 = Color3.fromRGB(16, 20, 30),
                BackgroundTransparency = 0.16,
                BorderSizePixel = 0,
                ClipsDescendants = true
            }, Wrapper)
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

            local Record = {}
            local Dismissed = false

            function Record.Close()
                if Dismissed then return end
                Dismissed = true

                local Idx = table.find(Internal.ActiveNotifs, Record)
                if Idx then table.remove(Internal.ActiveNotifs, Idx) end

                if Wrapper and Wrapper.Parent then
                    local Out = TweenService:Create(Wrapper, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Size = UDim2.new(0, 300, 0, 0)
                    })
                    TweenService:Create(Card, TweenInfo.new(0.14), {BackgroundTransparency = 1}):Play()
                    Out:Play()
                    Out.Completed:Wait()
                    if Wrapper and Wrapper.Parent then Wrapper:Destroy() end
                end
            end

            table.insert(Internal.ActiveNotifs, Record)

            DismissBtn.Activated:Connect(function()
                PlayUISound("Click", 1.2)
                Record.Close()
            end)
            DismissBtn.MouseButton1Click:Connect(function()
                PlayUISound("Click", 1.2)
                Record.Close()
            end)

            TweenService:Create(Wrapper, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 300, 0, 50)
            }):Play()

            TweenService:Create(BarFill, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
                Size = UDim2.new(0, 0, 1, 0)
            }):Play()

            task.wait(Duration)
            Record.Close()
        end)
    end)
end

-- ==========================================
-- 10 LIVE BACKGROUND ANIMATIONS ENGINE
-- ==========================================

        
local function CreateBackgroundEngine(MainFrame)
    local BgAnimLayer = Make("Frame", {
        Name = "BgAnimLayer",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 1
    }, MainFrame)
    AddCorner(BgAnimLayer, 18)

    local ActiveParticles = {}
    local AuroraGrad = nil

    local function ClearBackgroundAnim()
        Internal.BgAnimConn = SafeDisconnect(Internal.BgAnimConn)
        for _, Child in ipairs(BgAnimLayer:GetChildren()) do
            if not Child:IsA("UICorner") then Child:Destroy() end
        end
        table.clear(ActiveParticles)
        AuroraGrad = nil
    end

    local function RebuildBackgroundAnim()
        ClearBackgroundAnim()
        if not LooksState.AnimationsEnabled or LooksState.BgAnimStyle == "None" then return end

        local Style = LooksState.BgAnimStyle

        if Style == "Moving Stars" then
            for i = 1, 24 do
                local Sz = math.random(2, 4)
                local UseSec = (i % 2 == 0)
                local Dot = Make("Frame", {
                    Size = UDim2.new(0, Sz, 0, Sz),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 0.25, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Dot, Sz)
                table.insert(ActiveParticles, {
                    Obj = Dot, X = math.random(), Y = math.random(),
                    VX = math.random(12, 32) / 1000, VY = math.random(-8, 8) / 1000,
                    Phase = math.random() * 6.28, UseSecondary = UseSec
                })
            end

        elseif Style == "Floating Particles" then
            for i = 1, 20 do
                local Sz = math.random(3, 6)
                local UseSec = (i % 2 == 0)
                local Dot = Make("Frame", {
                    Size = UDim2.new(0, Sz, 0, Sz),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.32, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Dot, Sz)
                table.insert(ActiveParticles, {
                    Obj = Dot, BaseX = math.random(), Y = math.random(),
                    SpeedY = math.random(45, 95) / 1000, SwayAmp = math.random(12, 32) / 1000,
                    Phase = math.random() * 6.28, UseSecondary = UseSec
                })
            end

        elseif Style == "Cyber Rain" then
            for i = 1, 18 do
                local Len = math.random(14, 30)
                local UseSec = (i % 2 == 0)
                local Drop = Make("Frame", {
                    Size = UDim2.new(0, 2, 0, Len),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.35, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Drop, 2)
                table.insert(ActiveParticles, {
                    Obj = Drop, X = math.random(), Y = math.random(),
                    SpeedY = math.random(220, 420) / 1000, UseSecondary = UseSec
                })
            end

        elseif Style == "Glow Orbs" then
            for i = 1, 8 do
                local Sz = math.random(34, 64)
                local UseSec = (i % 2 == 0)
                local Orb = Make("Frame", {
                    Size = UDim2.new(0, Sz, 0, Sz),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.80, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Orb, Sz)
                table.insert(ActiveParticles, {
                    Obj = Orb, X = math.random(), Y = math.random(),
                    VX = (math.random(0, 1) == 1 and 1 or -1) * (math.random(18, 42) / 1000),
                    VY = (math.random(0, 1) == 1 and 1 or -1) * (math.random(18, 42) / 1000),
                    Phase = math.random() * 6.28, UseSecondary = UseSec
                })
            end

        elseif Style == "Aurora Wave" then
            local AuroraFrame = Make("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.78, BorderSizePixel = 0, ZIndex = 1
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
                })
            }, AuroraFrame)

        elseif Style == "Pulse Rings" then
            for i = 1, 5 do
                local UseSec = (i % 2 == 0)
                local Ring = Make("Frame", {
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(math.random(15, 85) / 100, 0, math.random(20, 80) / 100, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Ring, 120)
                local Stk = AddStroke(Ring, UseSec and Theme.AccentSecondary or Theme.Accent, 1.5, 0.5)
                table.insert(ActiveParticles, {
                    Obj = Ring, Stroke = Stk, Progress = (i - 1) / 5,
                    Speed = 0.28 + (i * 0.04), UseSecondary = UseSec
                })
            end

        elseif Style == "Diagonal Beams" then
            for i = 1, 6 do
                local UseSec = (i % 2 == 0)
                local Beam = Make("Frame", {
                    Size = UDim2.new(0, 22, 1.9, 0),
                    Position = UDim2.new(-0.3, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Rotation = 26,
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.88, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                table.insert(ActiveParticles, {
                    Obj = Beam, X = (i - 1) / 5, Speed = 0.14 + (i % 3) * 0.04, UseSecondary = UseSec
                })
            end

        elseif Style == "Snowfall Drift" then
            for i = 1, 24 do
                local Sz = math.random(2, 5)
                local UseSec = (i % 4 == 0)
                local Flake = Make("Frame", {
                    Size = UDim2.new(0, Sz, 0, Sz),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Color3.fromRGB(235, 245, 255),
                    BackgroundTransparency = 0.30, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Flake, Sz)
                table.insert(ActiveParticles, {
                    Obj = Flake, BaseX = math.random(), Y = math.random(),
                    SpeedY = math.random(55, 115) / 1000, SwayAmp = math.random(18, 42) / 1000,
                    Phase = math.random() * 6.28, UseSecondary = UseSec
                })
            end

        elseif Style == "Firefly Swarm" then
            for i = 1, 16 do
                local Sz = math.random(4, 7)
                local UseSec = (i % 2 == 0)
                local Fly = Make("Frame", {
                    Size = UDim2.new(0, Sz, 0, Sz),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.25, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Fly, Sz)
                table.insert(ActiveParticles, {
                    Obj = Fly, CX = math.random(10, 90) / 100, CY = math.random(12, 88) / 100,
                    RX = math.random(4, 12) / 100, RY = math.random(5, 14) / 100,
                    FreqX = math.random(6, 14) / 10, FreqY = math.random(6, 14) / 10,
                    Phase = math.random() * 6.28, UseSecondary = UseSec
                })
            end

        elseif Style == "Matrix Grid" then
            for i = 1, 14 do
                local UseSec = (i % 2 == 0)
                local Col = Make("Frame", {
                    Size = UDim2.new(0, 2, 0, math.random(28, 65)),
                    Position = UDim2.new(i / 15, 0, math.random(), 0),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                Make("UIGradient", {
                    Rotation = 90,
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.8, 0.2),
                        NumberSequenceKeypoint.new(1, 0)
                    })
                }, Col)
                table.insert(ActiveParticles, {
                    Obj = Col, X = i / 15, Y = math.random(),
                    SpeedY = math.random(180, 360) / 1000, UseSecondary = UseSec
                })
            end

        elseif Style == "Shooting Comets" then
            for i = 1, 10 do
                local Len = math.random(32, 62)
                local UseSec = (i % 2 == 0)
                local Comet = Make("Frame", {
                    Size = UDim2.new(0, Len, 0, 2),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    Rotation = 24,
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.18, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Comet, 2)
                Make("UIGradient", {
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.7, 0.25),
                        NumberSequenceKeypoint.new(1, 0)
                    })
                }, Comet)
                table.insert(ActiveParticles, {
                    Obj = Comet, X = math.random(), Y = math.random(),
                    Speed = math.random(320, 560) / 1000, UseSecondary = UseSec
                })
            end

        elseif Style == "Orbiting Vortex" then
            for i = 1, 18 do
                local Sz = math.random(3, 6)
                local UseSec = (i % 2 == 0)
                local Dot = Make("Frame", {
                    Size = UDim2.new(0, Sz, 0, Sz),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.25, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Dot, Sz)
                table.insert(ActiveParticles, {
                    Obj = Dot, Angle = (i / 18) * math.pi * 2,
                    Radius = 0.08 + ((i % 6) * 0.072),
                    AngSpeed = (i % 2 == 0 and 1 or -1) * (0.55 + (i % 4) * 0.25),
                    UseSecondary = UseSec
                })
            end

        elseif Style == "Radar Sweep" then
            for r = 1, 3 do
                local RingSz = r * 86
                local Ring = Make("Frame", {
                    Size = UDim2.new(0, RingSz, 0, RingSz),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Ring, RingSz)
                local Stk = AddStroke(Ring, (r % 2 == 0) and Theme.AccentSecondary or Theme.Accent, 1, 0.72)
                table.insert(ActiveParticles, {Obj = Ring, Stroke = Stk, IsRing = true, UseSecondary = (r % 2 == 0)})
            end

            local Sweep = Make("Frame", {
                Size = UDim2.new(0, 290, 0, 3),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Theme.AccentSecondary,
                BackgroundTransparency = 0.25, BorderSizePixel = 0, ZIndex = 1
            }, BgAnimLayer)
            Make("UIGradient", {
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.49, 1),
                    NumberSequenceKeypoint.new(0.50, 0.15),
                    NumberSequenceKeypoint.new(1, 0.85)
                })
            }, Sweep)
            table.insert(ActiveParticles, {Obj = Sweep, IsSweep = true, UseSecondary = true})

        elseif Style == "Sound Equalizer" then
            local BarCount = 20
            for i = 1, BarCount do
                local UseSec = (i % 2 == 0)
                local Bar = Make("Frame", {
                    Size = UDim2.new(1 / BarCount, -6, 0, 20),
                    Position = UDim2.new((i - 0.5) / BarCount, 0, 1, 0),
                    AnchorPoint = Vector2.new(0.5, 1),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.68, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Bar, 4)
                Make("UIGradient", {
                    Rotation = 90,
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.1),
                        NumberSequenceKeypoint.new(1, 0.85)
                    })
                }, Bar)
                table.insert(ActiveParticles, {
                    Obj = Bar, Phase = i * 0.45,
                    Speed = 2.4 + (i % 4) * 0.55,
                    MaxH = 38 + (i % 5) * 16, UseSecondary = UseSec
                })
            end

        elseif Style == "Rising Embers" then
            for i = 1, 22 do
                local Sz = math.random(2, 5)
                local UseSec = (i % 3 == 0)
                local Spark = Make("Frame", {
                    Size = UDim2.new(0, Sz, 0, Sz),
                    Position = UDim2.new(math.random(), 0, math.random(), 0),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Theme.Accent,
                    BackgroundTransparency = 0.2, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Spark, Sz)
                table.insert(ActiveParticles, {
                    Obj = Spark, BaseX = math.random(), Y = math.random(),
                    SpeedY = math.random(85, 190) / 1000, SwayAmp = math.random(15, 38) / 1000,
                    Phase = math.random() * 6.28, UseSecondary = UseSec
                })
            end

        elseif Style == "Warp Speed" then
            for i = 1, 22 do
                local UseSec = (i % 2 == 0)
                local Star = Make("Frame", {
                    Size = UDim2.new(0, 2, 0, 2),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = UseSec and Theme.AccentSecondary or Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 0.2, BorderSizePixel = 0, ZIndex = 1
                }, BgAnimLayer)
                AddCorner(Star, 4)
                table.insert(ActiveParticles, {
                    Obj = Star, Angle = math.random() * math.pi * 2,
                    Dist = math.random() * 0.55, Speed = math.random(30, 65) / 100,
                    UseSecondary = UseSec
                })
            end
        end

        local TimeAcc = 0
        Internal.BgAnimConn = RunService.Heartbeat:Connect(function(dt)
            if not MainFrame.Visible or not LooksState.AnimationsEnabled then return end
            dt = math.min(dt, 0.05)
            TimeAcc = TimeAcc + dt

            if Style == "Moving Stars" then
                for _, P in ipairs(ActiveParticles) do
                    P.X = P.X + P.VX * dt; P.Y = P.Y + P.VY * dt
                    if P.X > 1.03 then P.X = -0.03; P.Y = math.random() end
                    if P.Y > 1.03 then P.Y = -0.03 elseif P.Y < -0.03 then P.Y = 1.03 end
                    P.Obj.Position = UDim2.new(P.X, 0, P.Y, 0)
                    P.Obj.BackgroundTransparency = 0.30 + 0.45 * (0.5 + 0.5 * math.sin(TimeAcc * 2.8 + P.Phase))
                end

            elseif Style == "Floating Particles" then
                for _, P in ipairs(ActiveParticles) do
                    P.Y = P.Y - P.SpeedY * dt
                    if P.Y < -0.05 then P.Y = 1.05; P.BaseX = math.random() end
                    P.Obj.Position = UDim2.new(P.BaseX + math.sin(TimeAcc * 1.8 + P.Phase) * P.SwayAmp, 0, P.Y, 0)
                end

            elseif Style == "Cyber Rain" or Style == "Matrix Grid" then
                for _, P in ipairs(ActiveParticles) do
                    P.Y = P.Y + P.SpeedY * dt
                    if P.Y > 1.12 then
                        P.Y = -0.18
                        if Style == "Cyber Rain" then P.X = math.random() end
                    end
                    P.Obj.Position = UDim2.new(P.X, 0, P.Y, 0)
                end

            elseif Style == "Glow Orbs" then
                for _, P in ipairs(ActiveParticles) do
                    P.X = P.X + P.VX * dt; P.Y = P.Y + P.VY * dt
                    if P.X < 0.04 or P.X > 0.96 then P.VX = -P.VX end
                    if P.Y < 0.06 or P.Y > 0.94 then P.VY = -P.VY end
                    P.Obj.Position = UDim2.new(P.X, 0, P.Y, 0)
                    P.Obj.BackgroundTransparency = 0.78 + 0.12 * math.sin(TimeAcc * 1.5 + P.Phase)
                end

            elseif Style == "Aurora Wave" and AuroraGrad then
                AuroraGrad.Rotation = (TimeAcc * 32) % 360
                AuroraGrad.Offset = Vector2.new(math.sin(TimeAcc * 0.9) * 0.25, math.cos(TimeAcc * 0.7) * 0.15)

            elseif Style == "Pulse Rings" then
                for _, P in ipairs(ActiveParticles) do
                    P.Progress = P.Progress + P.Speed * dt
                    if P.Progress >= 1 then
                        P.Progress = 0
                        P.Obj.Position = UDim2.new(math.random(12, 88) / 100, 0, math.random(18, 82) / 100, 0)
                    end
                    local Sz = math.floor(14 + P.Progress * 125)
                    P.Obj.Size = UDim2.new(0, Sz, 0, Sz)
                    P.Stroke.Transparency = 0.25 + (P.Progress * 0.75)
                end

            elseif Style == "Diagonal Beams" then
                for _, P in ipairs(ActiveParticles) do
                    P.X = P.X + P.Speed * dt
                    if P.X > 1.35 then P.X = -0.35 end
                    P.Obj.Position = UDim2.new(P.X, 0, 0.5, 0)
                end

            elseif Style == "Snowfall Drift" then
                for _, P in ipairs(ActiveParticles) do
                    P.Y = P.Y + P.SpeedY * dt
                    if P.Y > 1.05 then P.Y = -0.05; P.BaseX = math.random() end
                    P.Obj.Position = UDim2.new(P.BaseX + math.sin(TimeAcc * 1.4 + P.Phase) * P.SwayAmp, 0, P.Y, 0)
                end

            elseif Style == "Firefly Swarm" then
                for _, P in ipairs(ActiveParticles) do
                    local px = P.CX + math.sin(TimeAcc * P.FreqX + P.Phase) * P.RX
                    local py = P.CY + math.cos(TimeAcc * P.FreqY + P.Phase) * P.RY
                    P.Obj.Position = UDim2.new(px, 0, py, 0)
                    P.Obj.BackgroundTransparency = 0.20 + 0.65 * (0.5 + 0.5 * math.sin(TimeAcc * 3.4 + P.Phase))
                end

            elseif Style == "Shooting Comets" then
                for _, P in ipairs(ActiveParticles) do
                    P.X = P.X + P.Speed * dt
                    P.Y = P.Y + (P.Speed * 0.45) * dt
                    if P.X > 1.15 or P.Y > 1.15 then
                        P.X = -0.15; P.Y = math.random(-20, 80) / 100
                    end
                    P.Obj.Position = UDim2.new(P.X, 0, P.Y, 0)
                end

            elseif Style == "Orbiting Vortex" then
                for _, P in ipairs(ActiveParticles) do
                    P.Angle = P.Angle + P.AngSpeed * dt
                    local px = 0.5 + math.cos(P.Angle) * P.Radius
                    local py = 0.5 + math.sin(P.Angle) * (P.Radius * 1.35)
                    P.Obj.Position = UDim2.new(px, 0, py, 0)
                end

            elseif Style == "Radar Sweep" then
                for _, P in ipairs(ActiveParticles) do
                    if P.IsSweep then
                        P.Obj.Rotation = (TimeAcc * 75) % 360
                    end
                end

            elseif Style == "Sound Equalizer" then
                for _, P in ipairs(ActiveParticles) do
                    local wave = 0.5 + 0.5 * math.sin(TimeAcc * P.Speed + P.Phase)
                    local h = math.floor(10 + wave * P.MaxH)
                    P.Obj.Size = UDim2.new(1 / #ActiveParticles, -6, 0, h)
                end

            elseif Style == "Rising Embers" then
                for _, P in ipairs(ActiveParticles) do
                    P.Y = P.Y - P.SpeedY * dt
                    if P.Y < -0.05 then P.Y = 1.05; P.BaseX = math.random() end
                    local x = P.BaseX + math.sin(TimeAcc * 3.2 + P.Phase) * P.SwayAmp
                    P.Obj.Position = UDim2.new(x, 0, P.Y, 0)
                    P.Obj.BackgroundTransparency = math.clamp((1 - P.Y) * 0.78 + 0.15 * math.sin(TimeAcc * 7 + P.Phase), 0.1, 0.92)
                end

            elseif Style == "Warp Speed" then
                for _, P in ipairs(ActiveParticles) do
                    P.Dist = P.Dist + (P.Speed * (0.25 + P.Dist * 2.2)) * dt
                    if P.Dist > 0.72 then
                        P.Dist = 0.02; P.Angle = math.random() * math.pi * 2
                    end
                    local px = 0.5 + math.cos(P.Angle) * P.Dist
                    local py = 0.5 + math.sin(P.Angle) * P.Dist
                    local sz = math.clamp(math.floor(2 + P.Dist * 7), 2, 6)
                    P.Obj.Position = UDim2.new(px, 0, py, 0)
                    P.Obj.Size = UDim2.new(0, sz, 0, sz)
                    P.Obj.BackgroundTransparency = math.clamp(0.85 - P.Dist * 1.1, 0.12, 0.85)
                end
            end
        end)
    end

    table.insert(Registry.BgParticleRefreshers, function()
        for _, P in ipairs(ActiveParticles) do
            if P.Obj and P.Obj.Parent then
                local Col = P.UseSecondary and Theme.AccentSecondary or Theme.Accent
                if (LooksState.BgAnimStyle == "Moving Stars" or LooksState.BgAnimStyle == "Snowfall Drift") and not P.UseSecondary then
                    Col = Color3.fromRGB(255, 255, 255)
                end
                if P.Stroke then
                    P.Stroke.Color = Col
                else
                    P.Obj.BackgroundColor3 = Col
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

    return RebuildBackgroundAnim, ClearBackgroundAnim
end

-- ==========================================
-- HELPER: FULL PLAYER PROFILE MODAL (CLICKABLE SIDEBAR CARD)
-- ==========================================
local function BuildPlayerProfileModal(MainFrame)
    local Overlay = Make("Frame", {
        Name = "PlayerProfileOverlay",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(6, 8, 15),
        BackgroundTransparency = 0.18,
        Visible = false,
        ZIndex = 92
    }, MainFrame)
    AddCorner(Overlay, 18)

    local Box = Make("Frame", {
        Size = UDim2.new(0, 440, 0, 266),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(15, 18, 28),
        BackgroundTransparency = 0.04,
        ClipsDescendants = true,
        ZIndex = 93
    }, Overlay)
    AddCorner(Box, 16)

    local BoxScale = Make("UIScale", {Scale = 1}, Box)
    local BoxStroke = AddStroke(Box, Theme.AccentSecondary, 1.4, 0.22)
    local BoxGrad = Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
            ColorSequenceKeypoint.new(1, Theme.Accent)
        }),
        Rotation = 45
    }, BoxStroke)
    table.insert(Registry.AccentGradients, BoxGrad)

    -- Header Banner with Large Avatar + Player Identity
    local Banner = Make("Frame", {
        Size = UDim2.new(1, 0, 0, 74),
        BackgroundColor3 = Color3.fromRGB(22, 26, 42),
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        ZIndex = 94
    }, Box)

    local BigAvatar = Make("ImageLabel", {
        Size = UDim2.new(0, 52, 0, 52),
        Position = UDim2.new(0, 12, 0.5, -26),
        BackgroundColor3 = Theme.InputBg,
        BorderSizePixel = 0,
        Image = "",
        ZIndex = 95
    }, Banner)
    AddCorner(BigAvatar, 26)
    AddStroke(BigAvatar, Theme.AccentSecondary, 1.6, 0.15)

    local OnlineBadge = Make("Frame", {
        Size = UDim2.new(0, 12, 0, 12),
        Position = UDim2.new(0, 52, 0, 50),
        BackgroundColor3 = Theme.Success,
        BorderSizePixel = 0,
        ZIndex = 96
    }, Banner)
    AddCorner(OnlineBadge, 6)
    AddStroke(OnlineBadge, Color3.fromRGB(15, 18, 28), 2, 0)

    Make("TextLabel", {
        Size = UDim2.new(1, -120, 0, 20),
        Position = UDim2.new(0, 74, 0, 11),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBlack,
        TextSize = 15,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = tostring(LocalPlayer.DisplayName),
        ZIndex = 95
    }, Banner)

    Make("TextLabel", {
        Size = UDim2.new(1, -120, 0, 16),
        Position = UDim2.new(0, 74, 0, 31),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        TextColor3 = Theme.TextMuted,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = "@" .. tostring(LocalPlayer.Name) .. "  •  ID: " .. tostring(LocalPlayer.UserId),
        ZIndex = 95
    }, Banner)

    local IsPrem = (LocalPlayer.MembershipType == Enum.MembershipType.Premium)
    local MemPill = Make("TextLabel", {
        Size = UDim2.new(0, 74, 0, 17),
        Position = UDim2.new(0, 74, 0, 50),
        BackgroundColor3 = IsPrem and Color3.fromRGB(255, 190, 45) or Theme.Accent,
        BackgroundTransparency = 0.78,
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        TextColor3 = IsPrem and Color3.fromRGB(255, 220, 110) or Theme.AccentSecondary,
        Text = IsPrem and "PREMIUM" or "STANDARD",
        ZIndex = 95
    }, Banner)
    AddCorner(MemPill, 6)

    -- Close Button
    local CloseBtn = Make("TextButton", {
        Size = UDim2.new(0, 26, 0, 24),
        Position = UDim2.new(1, -36, 0, 12),
        BackgroundColor3 = Color3.fromRGB(52, 22, 30),
        Text = "",
        AutoButtonColor = false,
        ZIndex = 96
    }, Banner)
    AddCorner(CloseBtn, 7)
    AddStroke(CloseBtn, Theme.Danger, 1, 0.45)
    Make("Frame", {
        Size = UDim2.new(0, 10, 0, 2), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5),
        Rotation = 45, BackgroundColor3 = Theme.Danger, BorderSizePixel = 0, ZIndex = 97
    }, CloseBtn)
    Make("Frame", {
        Size = UDim2.new(0, 10, 0, 2), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5),
        Rotation = -45, BackgroundColor3 = Theme.Danger, BorderSizePixel = 0, ZIndex = 97
    }, CloseBtn)

    -- Quick Copy Actions Strip
    local ActionStrip = Make("Frame", {
        Size = UDim2.new(1, -16, 0, 26),
        Position = UDim2.new(0, 8, 0, 79),
        BackgroundTransparency = 1,
        ZIndex = 94
    }, Box)

    Make("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 6)
    }, ActionStrip)

    local function AddQuickBtn(LabelText, OnClick)
        local B = Make("TextButton", {
            Size = UDim2.new(0.32, 0, 1, 0),
            BackgroundColor3 = Theme.CardBg,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            TextColor3 = Theme.AccentSecondary,
            Text = LabelText,
            AutoButtonColor = false,
            ZIndex = 95
        }, ActionStrip)
        AddCorner(B, 7)
        AddStroke(B, Theme.Stroke, 1, 0.35)
        table.insert(Registry.SecondaryTextObjs, B)
        B.MouseButton1Click:Connect(function()
            PlayUISound("Click", 1.15)
            OnClick()
        end)
    end

    AddQuickBtn("Copy UserID", function()
        CopyToClipboard(LocalPlayer.UserId)
        Library:Notify({Title = "Copied!", Content = "UserId: " .. tostring(LocalPlayer.UserId), Color = Theme.Success, Duration = 2})
    end)
    AddQuickBtn("Copy Username", function()
        CopyToClipboard(LocalPlayer.Name)
        Library:Notify({Title = "Copied!", Content = "Username: @" .. tostring(LocalPlayer.Name), Color = Theme.Success, Duration = 2})
    end)
    AddQuickBtn("Copy JobID", function()
        CopyToClipboard(game.JobId)
        Library:Notify({Title = "Copied!", Content = "Server JobId copied to clipboard", Color = Theme.Success, Duration = 2})
    end)

    -- Scrollable Details List
    local DetailsScroll = Make("ScrollingFrame", {
        Size = UDim2.new(1, -16, 1, -116),
        Position = UDim2.new(0, 8, 0, 110),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 94
    }, Box)
    table.insert(Registry.PrimaryColorObjs, DetailsScroll)

    local DLayout = Make("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 5)}, DetailsScroll)
    DLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        DetailsScroll.CanvasSize = UDim2.new(0, 0, 0, DLayout.AbsoluteContentSize.Y + 8)
    end)

    local function AddDetailRow(Key, InitVal, ValCol)
        local Row = Make("Frame", {
            Size = UDim2.new(1, -4, 0, 24),
            BackgroundColor3 = Color3.fromRGB(22, 26, 40),
            BackgroundTransparency = 0.25,
            ZIndex = 95
        }, DetailsScroll)
        AddCorner(Row, 7)
        AddStroke(Row, Theme.Stroke, 1, 0.48)

        Make("TextLabel", {
            Size = UDim2.new(0.42, -10, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1,
            Font = Enum.Font.GothamSemibold, TextSize = 11, TextColor3 = Theme.TextMuted,
            TextXAlignment = Enum.TextXAlignment.Left, Text = Key, ZIndex = 96
        }, Row)

        local V = Make("TextLabel", {
            Size = UDim2.new(0.58, -10, 1, 0), Position = UDim2.new(0.42, 0, 0, 0), BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = ValCol or Theme.TextPrimary,
            TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, Text = InitVal, ZIndex = 96
        }, Row)
        return V, Row
    end

    local AgeDays = tonumber(LocalPlayer.AccountAge) or 0
    local AgeYears = math.floor((AgeDays / 365) * 10) / 10

    AddDetailRow("Account Age", string.format("%d Days (~%.1f Yrs)", AgeDays, AgeYears), Theme.AccentSecondary)
    local SessionLbl = AddDetailRow("Session Playtime", "00:00:00", Theme.Success)
    local HealthLbl  = AddDetailRow("Character Health", "Loading...", Theme.Success)
    local MoveLbl    = AddDetailRow("Speed / Jump", "WS: 16 | JP: 50", Theme.TextPrimary)
    local PosLbl     = AddDetailRow("Live Position (X,Y,Z)", "0, 0, 0", Theme.AccentSecondary)
    local TeamLbl    = AddDetailRow("Team", LocalPlayer.Team and LocalPlayer.Team.Name or "Neutral", Theme.TextPrimary)
    local ServerLbl  = AddDetailRow("Server Players", "1 / 1", Theme.TextPrimary)
    local PerfLbl    = AddDetailRow("Live Ping", "0 ms", Theme.TextPrimary)
    AddDetailRow("Place ID", tostring(game.PlaceId), Theme.TextMuted)
    AddDetailRow("Server Job ID", (#game.JobId > 0) and string.sub(game.JobId, 1, 20) .. "..." or "Local / Private", Theme.TextMuted)

    local DynamicStatRows = {}

    local function RefreshLivePlayerStats()
        local Elapsed = math.floor(os.clock() - SESSION_START_TIME)
        local hrs = math.floor(Elapsed / 3600)
        local mins = math.floor((Elapsed % 3600) / 60)
        local secs = Elapsed % 60
        SessionLbl.Text = string.format("%02d:%02d:%02d", hrs, mins, secs)

        local Char = LocalPlayer.Character
        local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
        local HRP = Char and Char:FindFirstChild("HumanoidRootPart")

        if Hum then
            HealthLbl.Text = string.format("%d / %d HP", math.floor(Hum.Health + 0.5), math.floor(Hum.MaxHealth + 0.5))
            local jp = Hum.UseJumpPower and math.floor(Hum.JumpPower + 0.5) or math.floor(Hum.JumpHeight + 0.5)
            MoveLbl.Text = string.format("WS: %d  |  %s: %d", math.floor(Hum.WalkSpeed + 0.5), Hum.UseJumpPower and "JP" or "JH", jp)
        else
            HealthLbl.Text = "Character Respawning"
            MoveLbl.Text = "N/A"
        end

        if HRP then
            local p = HRP.Position
            PosLbl.Text = string.format("%d, %d, %d", math.floor(p.X), math.floor(p.Y), math.floor(p.Z))
        else
            PosLbl.Text = "N/A"
        end

        TeamLbl.Text = LocalPlayer.Team and tostring(LocalPlayer.Team.Name) or "Neutral"
        ServerLbl.Text = string.format("%d / %d Online", #Players:GetPlayers(), Players.MaxPlayers)

        local Ping = 0
        pcall(function() Ping = math.floor(StatsService.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5) end)
        PerfLbl.Text = tostring(Ping) .. " ms"

        -- Dynamic leaderstats support (universal across games)
        for _, RowObj in ipairs(DynamicStatRows) do
            if RowObj and RowObj.Parent then RowObj:Destroy() end
        end
        table.clear(DynamicStatRows)

        local ls = LocalPlayer:FindFirstChild("leaderstats")
        if ls then
            for _, StatObj in ipairs(ls:GetChildren()) do
                if StatObj:IsA("ValueBase") then
                    local _, r = AddDetailRow("Stat: " .. StatObj.Name, tostring(StatObj.Value), Theme.AccentSecondary)
                    table.insert(DynamicStatRows, r)
                end
            end
        end
    end

    task.spawn(function()
        local ok, thumb = pcall(function()
            return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        end)
        if ok and thumb and BigAvatar and BigAvatar.Parent then
            BigAvatar.Image = thumb
        end
    end)

    local function CloseProfileModal()
        PlayUISound("Click", 0.9)
        Internal.ProfileLiveConn = SafeDisconnect(Internal.ProfileLiveConn)
        Overlay.Visible = false
    end

    CloseBtn.MouseButton1Click:Connect(CloseProfileModal)

    local function OpenProfileModal()
        PlayUISound("Open", 1.1)
        RefreshLivePlayerStats()
        Overlay.Visible = true

        if LooksState.AnimationsEnabled then
            BoxScale.Scale = 0.86
            Tween(BoxScale, 0.22, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        else
            BoxScale.Scale = 1
        end

        Internal.ProfileLiveConn = SafeDisconnect(Internal.ProfileLiveConn)
        local Tick = 0
        Internal.ProfileLiveConn = RunService.Heartbeat:Connect(function(dt)
            if not Overlay.Visible then
                Internal.ProfileLiveConn = SafeDisconnect(Internal.ProfileLiveConn)
                return
            end
            Tick = Tick + dt
            if Tick >= 0.6 then
                Tick = 0
                RefreshLivePlayerStats()
            end
        end)
    end

    return OpenProfileModal
end

-- ==========================================
-- HELPER: UNIVERSAL SCRIPT DETAILS MODAL (HOLD "ULTIMATE")
-- ==========================================
local function BuildScriptInfoModal(MainFrame, WindowTitle, Config, GetCountsFn)
    local ModalOverlay = Make("Frame", {
        Name = "ScriptInfoOverlay",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(6, 8, 15),
        BackgroundTransparency = 0.20,
        Visible = false,
        ZIndex = 90
    }, MainFrame)
    AddCorner(ModalOverlay, 18)

    local Box = Make("Frame", {
        Size = UDim2.new(0, 420, 0, 250),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(16, 19, 30),
        BackgroundTransparency = 0.05,
        ClipsDescendants = true,
        ZIndex = 91
    }, ModalOverlay)
    AddCorner(Box, 15)

    local BoxScale = Make("UIScale", {Scale = 1}, Box)
    local BoxStroke = AddStroke(Box, Theme.AccentSecondary, 1.4, 0.25)
    local BoxStrokeGrad = Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
            ColorSequenceKeypoint.new(1, Theme.Accent)
        }),
        Rotation = 45
    }, BoxStroke)
    table.insert(Registry.AccentGradients, BoxStrokeGrad)

    local Header = Make("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(22, 26, 40),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ZIndex = 92
    }, Box)

    local HeaderTitle = Make("TextLabel", {
        Size = UDim2.new(1, -56, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBlack,
        TextSize = 14,
        TextColor3 = Theme.AccentSecondary,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = "SID ULTIMATE  |  SCRIPT DETAILS",
        ZIndex = 93
    }, Header)
    table.insert(Registry.SecondaryTextObjs, HeaderTitle)

    local ModalCloseBtn = Make("TextButton", {
        Size = UDim2.new(0, 26, 0, 24),
        Position = UDim2.new(1, -34, 0.5, -12),
        BackgroundColor3 = Color3.fromRGB(52, 22, 30),
        Text = "", AutoButtonColor = false, ZIndex = 93
    }, Header)
    AddCorner(ModalCloseBtn, 7)
    AddStroke(ModalCloseBtn, Theme.Danger, 1, 0.45)
    Make("Frame", {
        Size = UDim2.new(0, 10, 0, 2), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5),
        Rotation = 45, BackgroundColor3 = Theme.Danger, BorderSizePixel = 0, ZIndex = 94
    }, ModalCloseBtn)
    Make("Frame", {
        Size = UDim2.new(0, 10, 0, 2), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5),
        Rotation = -45, BackgroundColor3 = Theme.Danger, BorderSizePixel = 0, ZIndex = 94
    }, ModalCloseBtn)

    local Body = Make("ScrollingFrame", {
        Size = UDim2.new(1, -16, 1, -48),
        Position = UDim2.new(0, 8, 0, 44),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 92
    }, Box)

    local BodyLayout = Make("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6)}, Body)
    BodyLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Body.CanvasSize = UDim2.new(0, 0, 0, BodyLayout.AbsoluteContentSize.Y + 10)
    end)

    local function AddInfoRow(LabelText, ValueText, ValueColor)
        local Row = Make("Frame", {
            Size = UDim2.new(1, -4, 0, 26),
            BackgroundColor3 = Color3.fromRGB(22, 27, 40),
            BackgroundTransparency = 0.25,
            ZIndex = 93
        }, Body)
        AddCorner(Row, 7)
        AddStroke(Row, Theme.Stroke, 1, 0.45)

        Make("TextLabel", {
            Size = UDim2.new(0.40, -10, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1,
            Font = Enum.Font.GothamSemibold, TextSize = 11, TextColor3 = Theme.TextMuted,
            TextXAlignment = Enum.TextXAlignment.Left, Text = LabelText, ZIndex = 94
        }, Row)

        local ValLbl = Make("TextLabel", {
            Size = UDim2.new(0.60, -10, 1, 0), Position = UDim2.new(0.40, 0, 0, 0), BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = ValueColor or Theme.TextPrimary,
            TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, Text = ValueText, ZIndex = 94
        }, Row)
        return ValLbl
    end

    local ExecName = "Mobile / PC Executor"
    pcall(function()
        if identifyexecutor then
            local n, v = identifyexecutor()
            ExecName = tostring(n or "Executor") .. (v and (" " .. tostring(v)) or "")
        end
    end)

    local GameName = "PlaceId: " .. tostring(game.PlaceId)
    task.spawn(function()
        local ok, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
        if ok and info and info.Name then GameName = tostring(info.Name) end
    end)

    AddInfoRow("Script Hub", WindowTitle, Theme.TextPrimary)
    AddInfoRow("Creator / Developer", tostring(Config.Developer or "Sid"), Theme.AccentSecondary)
    local UpdatedValLbl = AddInfoRow("Last Updated (Auto)", "Detecting...", Theme.Success)
    AddInfoRow("Engine Build", tostring(Config.Version or "Sid Ultimate V5.0 Instant"), Theme.TextPrimary)
    local GameValLbl = AddInfoRow("Active Experience", GameName, Theme.TextPrimary)
    AddInfoRow("Executor Runtime", ExecName, Theme.TextPrimary)
    local StatsValLbl = AddInfoRow("Loaded Architecture", "Calculating...", Theme.AccentSecondary)

    local DescCard = Make("Frame", {
        Size = UDim2.new(1, -4, 0, 114),
        BackgroundColor3 = Color3.fromRGB(22, 27, 40),
        BackgroundTransparency = 0.25,
        ZIndex = 93
    }, Body)
    AddCorner(DescCard, 8)
    AddStroke(DescCard, Theme.Accent, 1, 0.45)

    Make("TextLabel", {
        Size = UDim2.new(1, -18, 0, 18), Position = UDim2.new(0, 9, 0, 6), BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Theme.AccentSecondary,
        TextXAlignment = Enum.TextXAlignment.Left, Text = "ABOUT SID ULTIMATE", ZIndex = 94
    }, DescCard)

    Make("TextLabel", {
        Size = UDim2.new(1, -18, 1, -28), Position = UDim2.new(0, 9, 0, 24), BackgroundTransparency = 1,
        Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = Color3.fromRGB(215, 222, 240),
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true,
        Text = tostring(Config.ScriptDescription or (
            "Engineered by Sid for ultra-fast, zero-lag universal execution.\n" ..
            "• Instant <0.1s launch with zero splash delay & clean memory management.\n" ..
            "• Full HSV Color Spectrum Studio, 8 Surface Styles, 10 BG & 8 Window Animations.\n" ..
            "• Mobile-First Touch Engine, Global Search, Player Inspector & Multi-Profile Auto-Save."
        )),
        ZIndex = 94
    }, DescCard)

    ModalCloseBtn.MouseButton1Click:Connect(function()
        PlayUISound("Click", 0.9)
        ModalOverlay.Visible = false
    end)

    local function OpenModal()
        PlayUISound("Open", 1.1)
        local TabCount, FlagCount, ElemCount = GetCountsFn()
        UpdatedValLbl.Text = ResolveAutoLastUpdated(WindowTitle, TabCount, FlagCount, Config.LastUpdated)
        GameValLbl.Text = GameName
        StatsValLbl.Text = string.format("%d Tabs  |  %d Controls  |  %d Saved Flags", TabCount, ElemCount, FlagCount)

        ModalOverlay.Visible = true
        if LooksState.AnimationsEnabled then
            BoxScale.Scale = 0.86
            Tween(BoxScale, 0.22, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        else
            BoxScale.Scale = 1
        end
    end

    return OpenModal
end

-- ==========================================
-- HELPER: CLICKABLE SIDEBAR MINI-PROFILE CARD
-- ==========================================
local function BuildSidebarProfileCard(MainFrame, OnProfileClick)
    local ProfileBtn = Make("TextButton", {
        Name = "MiniProfileCard",
        Size = UDim2.new(0, 122, 0, 40),
        Position = UDim2.new(0, 8, 1, -46),
        BackgroundColor3 = Theme.CardBg,
        BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 7
    }, MainFrame)
    AddCorner(ProfileBtn, 10)
    local PStroke = AddStroke(ProfileBtn, Theme.Stroke, 1, 0.30)
    table.insert(Registry.Cards, ProfileBtn)

    local AvatarImg = Make("ImageLabel", {
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(0, 6, 0.5, -14),
        BackgroundColor3 = Theme.InputBg,
        BorderSizePixel = 0,
        Image = "",
        ZIndex = 8
    }, ProfileBtn)
    AddCorner(AvatarImg, 14)
    AddStroke(AvatarImg, Theme.AccentSecondary, 1.1, 0.30)

    local OnlineDot = Make("Frame", {
        Size = UDim2.new(0, 7, 0, 7),
        Position = UDim2.new(0, 27, 0, 27),
        BackgroundColor3 = Theme.Success,
        BorderSizePixel = 0,
        ZIndex = 9
    }, ProfileBtn)
    AddCorner(OnlineDot, 7)

    Make("TextLabel", {
        Size = UDim2.new(1, -50, 0, 14),
        Position = UDim2.new(0, 38, 0, 6),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = tostring(LocalPlayer.DisplayName),
        ZIndex = 8
    }, ProfileBtn)

    Make("TextLabel", {
        Size = UDim2.new(1, -50, 0, 12),
        Position = UDim2.new(0, 38, 0, 21),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        TextSize = 9,
        TextColor3 = Theme.AccentSecondary,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = "Tap for info",
        ZIndex = 8
    }, ProfileBtn)

    Make("TextLabel", {
        Size = UDim2.new(0, 12, 1, 0),
        Position = UDim2.new(1, -14, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = Theme.TextMuted,
        Text = ">",
        ZIndex = 8
    }, ProfileBtn)

    ProfileBtn.MouseButton1Click:Connect(function()
        Tween(PStroke, 0.08, {Color = Theme.AccentSecondary})
        task.delay(0.18, function() Tween(PStroke, 0.14, {Color = Theme.Stroke}) end)
        if OnProfileClick then OnProfileClick() end
    end)

    task.spawn(function()
        local ok, thumb = pcall(function()
            return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        end)
        if ok and thumb and AvatarImg and AvatarImg.Parent then
            AvatarImg.Image = thumb
        end
    end)
end

-- ==========================================
-- HELPER: INTERACTIVE HSV COLOR SPECTRUM STUDIO (IN LOOKS TAB)
-- ==========================================
local function BuildColorSpectrumStudio(TabPage)
    local Card = Make("Frame", {
        Name = "ColorSpectrumStudio",
        Size = UDim2.new(1, 0, 0, 206),
        BackgroundColor3 = Theme.CardBg,
        BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card,
        ZIndex = 7
    }, TabPage)
    AddCorner(Card, 10)
    AddStroke(Card, Theme.Stroke, 1, 0.30)
    table.insert(Registry.Cards, Card)

    local ActiveChannel = "Primary" -- "Primary" | "Secondary"
    local CurH, CurS, CurV = Color3.toHSV(Theme.Accent)

    -- Top Target Switcher Tabs (Primary Accent vs Gradient Color 2)
    local TabRow = Make("Frame", {
        Size = UDim2.new(1, -16, 0, 26),
        Position = UDim2.new(0, 8, 0, 8),
        BackgroundTransparency = 1,
        ZIndex = 8
    }, Card)

    local PrimTabBtn = Make("TextButton", {
        Size = UDim2.new(0.49, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Theme.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Text = "Primary Color",
        AutoButtonColor = false,
        ZIndex = 9
    }, TabRow)
    AddCorner(PrimTabBtn, 7)

    local SecTabBtn = Make("TextButton", {
        Size = UDim2.new(0.49, 0, 1, 0),
        Position = UDim2.new(0.51, 0, 0, 0),
        BackgroundColor3 = Theme.InputBg,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = Theme.TextMuted,
        Text = "Gradient Color 2",
        AutoButtonColor = false,
        ZIndex = 9
    }, TabRow)
    AddCorner(SecTabBtn, 7)

    -- 2D Saturation-Value Color Pad (Any Shade of Any Hue)
    local SVPad = Make("Frame", {
        Name = "SVPad",
        Size = UDim2.new(1, -16, 0, 102),
        Position = UDim2.new(0, 8, 0, 40),
        BackgroundColor3 = Color3.fromHSV(CurH, 1, 1),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 8
    }, Card)
    AddCorner(SVPad, 8)
    AddStroke(SVPad, Theme.Stroke, 1, 0.35)

    -- White horizontal fade (Left = Desaturated White, Right = Full Hue)
    local WhiteOverlay = Make("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 9
    }, SVPad)
    AddCorner(WhiteOverlay, 8)
    Make("UIGradient", {
        Rotation = 0,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1)
        })
    }, WhiteOverlay)

    -- Black vertical fade (Top = Bright, Bottom = Deep Black)
    local BlackOverlay = Make("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 10
    }, SVPad)
    AddCorner(BlackOverlay, 8)
    Make("UIGradient", {
        Rotation = 90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0)
        })
    }, BlackOverlay)

    -- Selection Ring Cursor on SV Pad
    local SVCursor = Make("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(CurS, 0, 1 - CurV, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromHSV(CurH, CurS, CurV),
        BorderSizePixel = 0,
        ZIndex = 12
    }, SVPad)
    AddCorner(SVCursor, 7)
    AddStroke(SVCursor, Color3.fromRGB(255, 255, 255), 2, 0)

    local SVHitBtn = Make("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 13
    }, SVPad)

    -- Full 360-Degree Rainbow Hue Slider Strip
    local HueBar = Make("Frame", {
        Name = "HueStrip",
        Size = UDim2.new(1, -16, 0, 16),
        Position = UDim2.new(0, 8, 0, 149),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 8
    }, Card)
    AddCorner(HueBar, 8)
    AddStroke(HueBar, Theme.Stroke, 1, 0.4)

    Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.500, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 0, 0)),
        })
    }, HueBar)

    local HueThumb = Make("Frame", {
        Size = UDim2.new(0, 10, 1, 4),
        Position = UDim2.new(CurH, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 10
    }, HueBar)
    AddCorner(HueThumb, 5)
    AddStroke(HueThumb, Color3.fromRGB(15, 18, 28), 1.5, 0)

    local HueHitBtn = Make("TextButton", {
        Size = UDim2.new(1, 0, 0, 26),
        Position = UDim2.new(0, 0, 0.5, -13),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 11
    }, HueBar)

    -- Bottom Live Gradient Preview Bar + Hex Input
    local PreviewGradBar = Make("Frame", {
        Size = UDim2.new(0.54, -10, 0, 24),
        Position = UDim2.new(0, 8, 0, 174),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 8
    }, Card)
    AddCorner(PreviewGradBar, 7)
    AddStroke(PreviewGradBar, Theme.Stroke, 1, 0.35)

    local PrevGrad = Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(1, Theme.AccentSecondary)
        })
    }, PreviewGradBar)
    table.insert(Registry.AccentGradients, PrevGrad)

    Make("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Text = "LIVE GRADIENT",
        ZIndex = 9
    }, PreviewGradBar)

    local HexBox = Make("TextBox", {
        Size = UDim2.new(0.46, -10, 0, 24),
        Position = UDim2.new(0.54, 2, 0, 174),
        BackgroundColor3 = Theme.InputBg,
        BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Input,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = Theme.TextPrimary,
        PlaceholderText = "#7A5FFF",
        Text = ColorToHex(Theme.Accent),
        ClearTextOnFocus = false,
        ZIndex = 9
    }, Card)
    AddCorner(HexBox, 7)
    AddStroke(HexBox, Theme.Stroke, 1, 0.35)
    table.insert(Registry.Inputs, HexBox)

    local function UpdateStudioVisualsFromHSV()
        local Col = Color3.fromHSV(CurH, CurS, CurV)
        SVPad.BackgroundColor3 = Color3.fromHSV(CurH, 1, 1)
        SVCursor.Position = UDim2.new(CurS, 0, 1 - CurV, 0)
        SVCursor.BackgroundColor3 = Col
        HueThumb.Position = UDim2.new(CurH, 0, 0.5, 0)
        HexBox.Text = ColorToHex(Col)

        PrimTabBtn.BackgroundColor3 = (ActiveChannel == "Primary") and Theme.Accent or Theme.InputBg
        PrimTabBtn.TextColor3 = (ActiveChannel == "Primary") and Color3.fromRGB(255, 255, 255) or Theme.TextMuted
        SecTabBtn.BackgroundColor3 = (ActiveChannel == "Secondary") and Theme.AccentSecondary or Theme.InputBg
        SecTabBtn.TextColor3 = (ActiveChannel == "Secondary") and Color3.fromRGB(14, 18, 28) or Theme.TextMuted
    end

    local function SyncFromActiveTheme()
        local TargetCol = (ActiveChannel == "Primary") and Theme.Accent or Theme.AccentSecondary
        CurH, CurS, CurV = Color3.toHSV(TargetCol)
        UpdateStudioVisualsFromHSV()
    end

    table.insert(Registry.WheelRefreshers, SyncFromActiveTheme)

    -- Register Saveable Color Flags so Color Wheel picks persist automatically!
    local PrimColorFlagObj = {Color = Theme.Accent}
    function PrimColorFlagObj:Set(Col)
        if typeof(Col) == "Color3" then
            LooksState.RainbowActive = false
            Internal.RainbowConn = SafeDisconnect(Internal.RainbowConn)
            PrimColorFlagObj.Color = Col
            ApplyLiveColors(Col, Theme.AccentSecondary)
            Library:SaveConfiguration()
        end
    end
    Library.Flags["SidUI_WheelPrimaryColor"] = PrimColorFlagObj
    Internal.DefaultValues["SidUI_WheelPrimaryColor"] = Theme.Accent

    local SecColorFlagObj = {Color = Theme.AccentSecondary}
    function SecColorFlagObj:Set(Col)
        if typeof(Col) == "Color3" then
            LooksState.RainbowActive = false
            Internal.RainbowConn = SafeDisconnect(Internal.RainbowConn)
            SecColorFlagObj.Color = Col
            ApplyLiveColors(Theme.Accent, Col)
            Library:SaveConfiguration()
        end
    end
    Library.Flags["SidUI_WheelSecondaryColor"] = SecColorFlagObj
    Internal.DefaultValues["SidUI_WheelSecondaryColor"] = Theme.AccentSecondary

    local function PushPickedColor()
        LooksState.RainbowActive = false
        Internal.RainbowConn = SafeDisconnect(Internal.RainbowConn)

        local Picked = Color3.fromHSV(CurH, CurS, CurV)
        if ActiveChannel == "Primary" then
            PrimColorFlagObj.Color = Picked
            ApplyLiveColors(Picked, Theme.AccentSecondary, true)
        else
            SecColorFlagObj.Color = Picked
            ApplyLiveColors(Theme.Accent, Picked, true)
        end
        UpdateStudioVisualsFromHSV()
    end

    PrimTabBtn.MouseButton1Click:Connect(function()
        PlayUISound("Click", 1.1)
        ActiveChannel = "Primary"
        SyncFromActiveTheme()
    end)

    SecTabBtn.MouseButton1Click:Connect(function()
        PlayUISound("Click", 1.1)
        ActiveChannel = "Secondary"
        SyncFromActiveTheme()
    end)

    -- Drag Handling (SV Pad & Hue Bar) with Mobile Scroll Lock
    local DragMode = nil -- "SV" | "HUE"
    local ActiveInput = nil

    local function UpdateSVFromPos(Pos)
        CurS = math.clamp((Pos.X - SVPad.AbsolutePosition.X) / math.max(SVPad.AbsoluteSize.X, 1), 0, 1)
        CurV = 1 - math.clamp((Pos.Y - SVPad.AbsolutePosition.Y) / math.max(SVPad.AbsoluteSize.Y, 1), 0, 1)
        PushPickedColor()
    end

    local function UpdateHueFromPos(Pos)
        CurH = math.clamp((Pos.X - HueBar.AbsolutePosition.X) / math.max(HueBar.AbsoluteSize.X, 1), 0, 0.999)
        PushPickedColor()
    end

    SVHitBtn.InputBegan:Connect(function(In)
        if In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch then
            DragMode = "SV"; ActiveInput = In
            TabPage.ScrollingEnabled = false
            UpdateSVFromPos(In.Position)
        end
    end)

    HueHitBtn.InputBegan:Connect(function(In)
        if In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch then
            DragMode = "HUE"; ActiveInput = In
            TabPage.ScrollingEnabled = false
            UpdateHueFromPos(In.Position)
        end
    end)

    TrackConn(UserInputService.InputChanged:Connect(function(In)
        if not DragMode then return end
        if In == ActiveInput or In.UserInputType == Enum.UserInputType.MouseMovement then
            if DragMode == "SV" then
                UpdateSVFromPos(In.Position)
            elseif DragMode == "HUE" then
                UpdateHueFromPos(In.Position)
            end
        end
    end))

    TrackConn(UserInputService.InputEnded:Connect(function(In)
        if DragMode and (In == ActiveInput or In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch) then
            DragMode = nil; ActiveInput = nil
            TabPage.ScrollingEnabled = true
            Library:SaveConfiguration()
        end
    end))

    HexBox.FocusLost:Connect(function()
        local Parsed = ParseColorString(HexBox.Text)
        if Parsed then
            CurH, CurS, CurV = Color3.toHSV(Parsed)
            PushPickedColor()
            Library:SaveConfiguration()
        else
            SyncFromActiveTheme()
        end
    end)

    SyncFromActiveTheme()
end

-- ==========================================
-- HELPER: POPULATE PRE-REGISTERED "LOOKS" TAB
-- ==========================================
local function PopulateLooksTab(LooksTab, LooksPage, Controls)

    -- PATCH 8B: Premium Studio Hero Banner + 1-Tap Quick Color Swatches
    local HeroBanner = Make("Frame", {
        Name = "LooksHeroBanner",
        Size = UDim2.new(1, 0, 0, 66),
        BackgroundColor3 = Theme.CardBg,
        BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card,
        ClipsDescendants = true, ZIndex = 7
    }, LooksPage)
    AddCorner(HeroBanner, 9)
    local HeroStroke = AddStroke(HeroBanner, Theme.AccentSecondary, 1.2, 0.30)
    local HeroGrad = Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
            ColorSequenceKeypoint.new(1, Theme.Accent)
        }),
        Rotation = 45
    }, HeroStroke)
    table.insert(Registry.AccentGradients, HeroGrad)
    table.insert(Registry.Cards, HeroBanner)

    local HeroTitle = Make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 18), Position = UDim2.new(0, 12, 0, 6), BackgroundTransparency = 1,
        Font = Enum.Font.GothamBlack, TextSize = 13, TextColor3 = Theme.AccentSecondary,
        TextXAlignment = Enum.TextXAlignment.Left, Text = "SID ULTIMATE  •  VISUAL STUDIO", ZIndex = 8
    }, HeroBanner)
    table.insert(Registry.SecondaryTextObjs, HeroTitle)

    Make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 13), Position = UDim2.new(0, 12, 0, 23), BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium, TextSize = 10, TextColor3 = Theme.TextMuted,
        TextXAlignment = Enum.TextXAlignment.Left, Text = "1-Tap Theme Swatches • Live FX • HUD • AFK Saver", ZIndex = 8
    }, HeroBanner)

    local QuickSwatches = {
        {"Sid Violet",    Color3.fromRGB(122, 95, 255)},
        {"Cyber Cyan",    Color3.fromRGB(0, 195, 255)},
        {"Crimson Blood", Color3.fromRGB(245, 55, 85)},
        {"Emerald Neon",  Color3.fromRGB(0, 220, 135)},
        {"Royal Gold",    Color3.fromRGB(255, 190, 45)},
        {"Sakura Pink",   Color3.fromRGB(255, 85, 175)},
        {"RGB Rainbow",   Color3.fromRGB(255, 255, 255)},
    }

    for i, Sw in ipairs(QuickSwatches) do
        local DotBtn = Make("TextButton", {
            Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(0, 12 + (i - 1) * 26, 0, 42),
            BackgroundColor3 = Sw[2], Text = (Sw[1] == "RGB Rainbow") and "R" or "",
            Font = Enum.Font.GothamBlack, TextSize = 9, TextColor3 = Color3.fromRGB(20, 20, 30),
            AutoButtonColor = false, ZIndex = 9
        }, HeroBanner)
        AddCorner(DotBtn, 9); AddStroke(DotBtn, Color3.fromRGB(255, 255, 255), 1, 0.55)
        DotBtn.MouseButton1Click:Connect(function()
            PlayUISound("Click", 1.15)
            SetThemePreset(Sw[1])
            Library:SaveConfiguration()
        end)
    end

    LooksTab:CreateSection("Unlimited Color Spectrum Studio")
    BuildColorSpectrumStudio(LooksPage)

    LooksTab:CreateDropdown({
        Name = "Quick Theme Presets",
        Options = {
            "Sid Violet", "Cyber Cyan", "Crimson Blood", "Emerald Neon",
            "Royal Gold", "Sakura Pink", "Sunset Blaze", "Midnight Ice",
            "Toxic Lime", "Pure Frost", "RGB Rainbow"
        },
        CurrentOption = {"Sid Violet"},
        MultipleOptions = false,
        Flag = "SidUI_LooksColorPreset",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt and ColorPresets[Opt] then
                SetThemePreset(Opt)
                if not ColorPresets[Opt].Rainbow then
                    if Library.Flags["SidUI_WheelPrimaryColor"] then
                        Library.Flags["SidUI_WheelPrimaryColor"].Color = Theme.Accent
                    end
                    if Library.Flags["SidUI_WheelSecondaryColor"] then
                        Library.Flags["SidUI_WheelSecondaryColor"].Color = Theme.AccentSecondary
                    end
                end
            end
        end
    })

    LooksTab:CreateSection("Surface Glass & Layout (8 Styles)")

    LooksTab:CreateDropdown({
        Name = "UI Background Surface Style",
        Options = {
            "Ultra Phantom", "Crystal Glass", "Transparent", "Liquid Glass",
            "Cyber Haze", "Frosted Mist", "Holo Prism", "Acrylic Frost",
            "Translucent", "Crimson Velvet", "Midnight Glass", "Carbon Stealth",
            "Smoked Obsidian", "Neon Dark", "Deep Void", "Opaque Solid"
        },

        CurrentOption = {"Translucent"},
        MultipleOptions = false,
        Flag = "SidUI_LooksSurfaceStyle",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt then ApplySurfaceMode(Opt) end
        end
    })

    LooksTab:CreateSlider({
        Name = "UI Size Scale",
        Range = {0.70, 1.25},
        Increment = 0.05,
        Suffix = "x",
        CurrentValue = 1.0,
        Flag = "SidUI_LooksUIScale",
        Callback = function(Val)
            LooksState.UIScale = tonumber(Val) or 1.0
            Controls.ApplyScale(LooksState.UIScale)
        end
    })

    LooksTab:CreateToggle({
        Name = "Lock Window Position (Prevent Drag)",
        CurrentValue = false,
        Flag = "SidUI_LooksLockPos",
        Callback = function(Val) LooksState.LockPosition = (Val == true) end
    })

    LooksTab:CreateToggle({
        Name = "Show Live FPS & Ping Telemetry",
        CurrentValue = true,
        Flag = "SidUI_LooksShowTelemetry",
        Callback = function(Val)
            LooksState.ShowTelemetry = (Val == true)
            Controls.SetTelemetryVisible(LooksState.ShowTelemetry)
        end
    })

    LooksTab:CreateToggle({
        Name = "Enable Crisp UI Touch Sounds",
        CurrentValue = true,
        Flag = "SidUI_LooksSounds",
        Callback = function(Val) LooksState.SoundsEnabled = (Val == true) end
    })

    LooksTab:CreateSection("Animations (10 BG + 8 Window Styles)")

    LooksTab:CreateToggle({
        Name = "Enable All UI Animations",
        CurrentValue = true,
        Flag = "SidUI_LooksAnimEnabled",
        Callback = function(Val)
            LooksState.AnimationsEnabled = (Val == true)
            Controls.RebuildBgAnim()
        end
    })

    LooksTab:CreateDropdown({
       Name = "Live Background Animation (16 Styles)",
        Options = {
            "Moving Stars", "Floating Particles", "Cyber Rain", "Glow Orbs",
            "Aurora Wave", "Pulse Rings", "Diagonal Beams", "Snowfall Drift",
            "Firefly Swarm", "Matrix Grid", "Shooting Comets", "Orbiting Vortex",
            "Radar Sweep", "Sound Equalizer", "Rising Embers", "Warp Speed", "None"
        },

        CurrentOption = {"Moving Stars"},
        MultipleOptions = false,
        Flag = "SidUI_LooksBgAnimStyle",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt then
                LooksState.BgAnimStyle = Opt
                Controls.RebuildBgAnim()
            end
        end
    })

    LooksTab:CreateDropdown({
        Name = "Window Open/Close Style (12 Styles)",
        Options = {
            "Pop & Scale", "Slide From Top", "Slide From Bottom", "Slide From Left",
            "Slide From Right", "Fade & Glide", "Elastic Bounce", "Flip & Zoom",
            "Horizon Unfold", "Curtain Split", "Spin Portal", "Drop & Bounce"
        },

        CurrentOption = {"Pop & Scale"},
        MultipleOptions = false,
        Flag = "SidUI_LooksAnimStyle",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt then
                LooksState.WindowAnimStyle = Opt
                Controls.PreviewWindowAnim()
            end
        end
    })


    -- ==========================================
    -- PATCH 8C: CORNER, FLOWING BORDER & FONT STUDIO (FEATURE 6)
    -- ==========================================
    LooksTab:CreateSection("Corner Radius, Glow & Font Studio")

    LooksTab:CreateSlider({
        Name = "UI Corner Roundness",
        Range = {0, 24},
        Increment = 1,
        Suffix = "px",
        CurrentValue = 18,
        Flag = "SidUI_LooksCornerRadius",
        Callback = function(Val)
            if Internal.ApplyRadiusFn then Internal.ApplyRadiusFn(Val) end
        end
    })

    LooksTab:CreateToggle({
        Name = "Animated Flowing Border Glow",
        CurrentValue = false,
        Flag = "SidUI_LooksFlowBorder",
        Callback = function(Val)
            if Internal.ToggleBorderFlowFn then Internal.ToggleBorderFlowFn(Val) end
        end
    })

    LooksTab:CreateDropdown({
        Name = "UI Font Style",
        Options = {"Gotham (Default)", "Smooth (Fredoka)", "Cyber Tech (Code)", "Hacker (Mono)", "Clean (Ubuntu)", "Light (SourceSans)"},
        CurrentOption = {"Gotham (Default)"},
        MultipleOptions = false,
        Flag = "SidUI_LooksFont",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt and Internal.ApplyFontFn then Internal.ApplyFontFn(Opt) end
        end
    })

    -- ==========================================
    -- SHOW UI BUTTON STUDIO (FEATURE 5 — 100% OPTIONAL)
    -- ==========================================
    LooksTab:CreateSection("Show UI Button Studio (Optional)")

    local CustomShowUIToggleRef = nil
    CustomShowUIToggleRef = LooksTab:CreateToggle({
        Name = "Customize Show UI Pill (OFF = Classic Default)",
        CurrentValue = false,
        Flag = "SidUI_ShowUICustomEnabled",
        Callback = function(Val)
            LooksState.ShowUICustomEnabled = (Val == true)
            if Internal.ApplyShowUIFn then Internal.ApplyShowUIFn() end
        end
    })

    LooksTab:CreateDropdown({
        Name = "Show UI Position / Mode",
        Options = {"Top-Center (Default)", "Top-Left", "Top-Right", "Middle-Left", "Middle-Right", "Bottom-Left", "Bottom-Right", "Free Draggable"},
        CurrentOption = {"Top-Center (Default)"},
        MultipleOptions = false,
        Flag = "SidUI_ShowUIPosition",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt then
                LooksState.ShowUIPosition = Opt
                if Internal.ApplyShowUIFn then Internal.ApplyShowUIFn() end
            end
        end
    })

    LooksTab:CreateDropdown({
        Name = "Show UI Shape",
        Options = {"Pill (Default)", "Circle (Icon)", "Rounded Square", "Capsule Slim", "Sharp Cyber"},
        CurrentOption = {"Pill (Default)"},
        MultipleOptions = false,
        Flag = "SidUI_ShowUIShape",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt then
                LooksState.ShowUIShape = Opt
                if Internal.ApplyShowUIFn then Internal.ApplyShowUIFn() end
            end
        end
    })

    LooksTab:CreateSlider({
        Name = "Show UI Button Size",
        Range = {0.70, 1.50},
        Increment = 0.05,
        Suffix = "x",
        CurrentValue = 1.0,
        Flag = "SidUI_ShowUISize",
        Callback = function(Val)
            LooksState.ShowUISize = tonumber(Val) or 1.0
            if Internal.ApplyShowUIFn then Internal.ApplyShowUIFn() end
        end
    })

    LooksTab:CreateSlider({
        Name = "Show UI Transparency",
        Range = {0, 0.85},
        Increment = 0.05,
        Suffix = "",
        CurrentValue = 0.42,
        Flag = "SidUI_ShowUITransparency",
        Callback = function(Val)
            LooksState.ShowUITransparency = tonumber(Val) or 0.42
            if Internal.ApplyShowUIFn then Internal.ApplyShowUIFn() end
        end
    })

    LooksTab:CreateDropdown({
        Name = "Show UI Color Style",
        Options = {"Match Theme", "Dark Glass", "Neon Cyan", "Crimson Red", "Royal Gold", "Emerald Green", "Pure White", "Custom Hex"},
        CurrentOption = {"Match Theme"},
        MultipleOptions = false,
        Flag = "SidUI_ShowUIColorMode",
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt then
                LooksState.ShowUIColorMode = Opt
                if Internal.ApplyShowUIFn then Internal.ApplyShowUIFn() end
            end
        end
    })

    LooksTab:CreateInput({
        Name = "Show UI Custom Color (Hex)",
        PlaceholderText = "#00E0FF or 0,224,255",
        RemoveTextAfterFocusLost = false,
        Flag = "SidUI_ShowUICustomHex",
        Callback = function(Text)
            LooksState.ShowUICustomHex = tostring(Text or "#00E0FF")
            if Internal.ApplyShowUIFn then Internal.ApplyShowUIFn() end
        end
    })

    LooksTab:CreateInput({
        Name = "Show UI Custom Label",
        PlaceholderText = "Show UI",
        RemoveTextAfterFocusLost = false,
        Flag = "SidUI_ShowUIText",
        Callback = function(Text)
            LooksState.ShowUIText = tostring(Text or "Show UI")
            if Internal.ApplyShowUIFn then Internal.ApplyShowUIFn() end
        end
    })

    LooksTab:CreateButton({
        Name = "Reset Show UI to Classic Default",
        Callback = function()
            LooksState.ShowUICustomEnabled = false
            LooksState.ShowUIPosition = "Top-Center (Default)"
            LooksState.ShowUIShape = "Pill (Default)"
            LooksState.ShowUISize = 1.0
            LooksState.ShowUITransparency = 0.42
            LooksState.ShowUIColorMode = "Match Theme"
            LooksState.ShowUIText = "Show UI"
            if CustomShowUIToggleRef and CustomShowUIToggleRef.Set then
                CustomShowUIToggleRef:Set(false)
            end
            if Internal.ApplyShowUIFn then Internal.ApplyShowUIFn() end
            Library:Notify({Title = "Show UI Reset", Content = "Restored to classic default pill.", Color = Theme.Success, Duration = 2.2})
        end
    })

    -- ==========================================
    -- ACTIVE HUD & AFK POWER SAVER (FEATURES 2 & 4)
    -- ==========================================
    LooksTab:CreateSection("Active HUD & 20-Min Anti-AFK")

    LooksTab:CreateToggle({
        Name = "Show Active Features Mini HUD",
        CurrentValue = false,
        Flag = "SidUI_LooksActiveHUD",
        Callback = function(Val)
            LooksState.ShowActiveHUD = (Val == true)
            if Internal.RefreshActiveHudFn then Internal.RefreshActiveHudFn() end
        end
    })

    LooksTab:CreateToggle({
        Name = "Permanent Anti-AFK (Block 20-Min Kick)",
        CurrentValue = true,
        Flag = "SidUI_LooksAntiAfk",
        Callback = function(Val)
            LooksState.AntiAfkEnabled = (Val == true)
            if Val then
                pcall(function()
                    local VU = game:GetService("VirtualUser")
                    Internal.AntiAfkConn = SafeDisconnect(Internal.AntiAfkConn)
                    Internal.AntiAfkConn = LocalPlayer.Idled:Connect(function()
                        if LooksState.AntiAfkEnabled then
                            pcall(function() VU:CaptureController(); VU:ClickButton2(Vector2.new()) end)
                        end
                    end)
                end)
            else
                Internal.AntiAfkConn = SafeDisconnect(Internal.AntiAfkConn)
            end
        end
    })

    LooksTab:CreateButton({
        Name = "Activate OLED Black Screen Saver (Battery Mode)",
        Callback = function()
            if Internal.OpenAfkSaverFn then Internal.OpenAfkSaverFn() end
        end
    })

    -- ==========================================
    -- FEATURE LAYOUT REORDER STUDIO (OPTIONAL — DEFAULT OFF)
    -- ==========================================
    LooksTab:CreateSection("Feature Layout Reorder (Optional)")

    LooksTab:CreateToggle({
        Name = "Enable Feature Reorder Mode",
        CurrentValue = false,
        -- Intentionally NO Flag: always starts safe OFF on launch; saved positions still persist!
        Callback = function(Val)
            if Internal.SetLayoutEditModeFn then
                Internal.SetLayoutEditModeFn(Val == true)
            end
            if Val then
                Library:Notify({
                    Title = "Reorder Mode: ON",
                    Content = "Kisi bhi tab me '≡ MOVE' pakad kar features upar-neeche set karo!",
                    Color = Theme.AccentSecondary,
                    Duration = 3.2
                })
            end
        end
    })

    LooksTab:CreateButton({
        Name = "Reset All Feature Positions to Default",
        Callback = function()
            if Internal.ResetTabOrdersFn then
                Internal.ResetTabOrdersFn()
            end
            Library:Notify({
                Title = "Layout Order Reset!",
                Content = "Saare tabs ke features original order me aa gaye.",
                Color = Theme.Success,
                Duration = 2.5
            })
        end
    })

    LooksTab:CreateSection("Config Profiles (" .. tostring(Internal.ConfigSettings.FolderName) .. ")")

    local DefaultFileName = Internal.ConfigSettings.FileName
    local ActiveProfileName = DefaultFileName
    local ProfileDropdownRef = nil

    ProfileDropdownRef = LooksTab:CreateDropdown({
        Name = "Select Saved Profile",
        Options = ListAvailableProfiles(),
        CurrentOption = {ActiveProfileName},
        MultipleOptions = false,
        Callback = function(Opt)
            if type(Opt) == "table" then Opt = Opt[1] end
            if Opt then ActiveProfileName = SanitizeFileName(Opt) end
        end
    })

    LooksTab:CreateInput({
        Name = "Create / Rename Profile",
        PlaceholderText = "e.g. AFKFarm or Boss",
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            if type(Text) == "string" and #Text > 0 then
                ActiveProfileName = SanitizeFileName(Text)
            end
        end
    })

    LooksTab:CreateButton({
        Name = "Save Current Settings to Profile",
        Callback = function()
            Internal.ConfigSettings.FileName = ActiveProfileName
            Library:SaveConfiguration(ActiveProfileName, true)
            if ProfileDropdownRef and ProfileDropdownRef.Refresh then
                ProfileDropdownRef:Refresh(ListAvailableProfiles(), {ActiveProfileName})
            end
            Library:Notify({
                Title = "Profile Saved!",
                Content = tostring(Internal.ConfigSettings.FolderName) .. "/" .. ActiveProfileName .. ".json",
                Color = Theme.Success,
                Duration = 2.6
            })
        end
    })

    LooksTab:CreateButton({
        Name = "Load Selected Profile",
        Callback = function()
            local ok = Library:LoadConfiguration(ActiveProfileName)
            Library:Notify({
                Title = ok and "Profile Loaded!" or "Profile Not Found",
                Content = ok and ("Loaded: " .. ActiveProfileName) or ("No saved file for: " .. ActiveProfileName),
                Color = ok and Theme.AccentSecondary or Theme.Danger,
                Duration = 2.6
            })
        end
    })

    LooksTab:CreateButton({
        Name = "Delete Selected Profile",
        Callback = function()
            if ActiveProfileName == DefaultFileName then
                Library:Notify({
                    Title = "Protected Profile",
                    Content = "Default profile delete nahi hota; Reset button use karo.",
                    Color = Theme.Danger,
                    Duration = 3.0
                })
                return
            end
            local deleted = Library:DeleteProfile(ActiveProfileName)
            ActiveProfileName = DefaultFileName
            Internal.ConfigSettings.FileName = DefaultFileName
            if ProfileDropdownRef and ProfileDropdownRef.Refresh then
                ProfileDropdownRef:Refresh(ListAvailableProfiles(), {DefaultFileName})
            end
            Library:Notify({
                Title = deleted and "Profile Deleted" or "Delete Failed",
                Content = deleted and ("Switched back to " .. DefaultFileName) or "File already removed",
                Color = deleted and Theme.Danger or Theme.TextMuted,
                Duration = 2.5
            })
        end
    })

    LooksTab:CreateButton({
        Name = "Reset All Settings to Default",
        Callback = function()
            Library:ResetAllSettings()
            Library:Notify({
                Title = "Settings Reset!",
                Content = "All toggles, sliders, colors & looks restored.",
                Color = Theme.AccentSecondary,
                Duration = 2.8
            })
        end
    })
end

-- ==========================================
-- CREATE WINDOW (INSTANT <0.1s UNIVERSAL LAUNCH)
-- ==========================================
function Library:CreateWindow(Config)
    Config = Config or {}
    local WindowTitle = tostring(Config.Name or Config.LoadingTitle or "Sid Ultimate")
    local SubTag = tostring(Config.LoadingSubtitle or "ULTIMATE")

    if type(Config.ConfigurationSaving) == "table" then
        Internal.ConfigSettings.Enabled = (Config.ConfigurationSaving.Enabled ~= false)
        if Config.ConfigurationSaving.FolderName and #tostring(Config.ConfigurationSaving.FolderName) > 0 then
            Internal.ConfigSettings.FolderName = tostring(Config.ConfigurationSaving.FolderName)
        else
            Internal.ConfigSettings.FolderName = "SidUltimateHub"
        end
        if Config.ConfigurationSaving.FileName and #tostring(Config.ConfigurationSaving.FileName) > 0 then
            Internal.ConfigSettings.FileName = SanitizeFileName(Config.ConfigurationSaving.FileName)
        else
            Internal.ConfigSettings.FileName = "Game_" .. tostring(game.PlaceId)
        end
    else
        Internal.ConfigSettings.Enabled = true
        Internal.ConfigSettings.FolderName = "SidUltimateHub"
        Internal.ConfigSettings.FileName = "Game_" .. tostring(game.PlaceId)
    end

    local ScreenGui = Make("ScreenGui", {
        Name = "SidUltimateUI",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 50
    }, GetGuiParent())

    local DefaultSurf = GetSurfaceSpec(LooksState.SurfaceMode)
    local CenterPos = UDim2.new(0.5, 0, 0.5, 0)

    local MainFrame = Make("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, 565, 0, 315),
        Position = CenterPos,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = DefaultSurf.MainBg,
        BackgroundTransparency = DefaultSurf.Main,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Active = true,
        Visible = true
    }, ScreenGui)

    table.insert(Registry.MainFrames, MainFrame)
    AddCorner(MainFrame, 18)

    local MainUIScale = Make("UIScale", {Scale = LooksState.UIScale}, MainFrame)

    -- Blocks all taps/clicks inside MainFrame from passing through to game UI behind it
    Make("TextButton", {
        Name = "TouchInputBlocker",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        Active = true,
        Selectable = false,
        ZIndex = 0
    }, MainFrame)

    local MainBgGrad = Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, DefaultSurf.GradA),
            ColorSequenceKeypoint.new(1, DefaultSurf.GradB)
        }),
        Rotation = 135
    }, MainFrame)
    table.insert(Registry.MainBgGradients, MainBgGrad)

    local MainStroke = AddStroke(MainFrame, Theme.Accent, 1.4, DefaultSurf.Stroke)
    table.insert(Registry.MainStrokes, MainStroke)
    local MainStrokeGrad = Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
            ColorSequenceKeypoint.new(1, Theme.Accent)
        }),
        Rotation = 45
    }, MainStroke)
    table.insert(Registry.AccentGradients, MainStrokeGrad)

    -- 10 Live Background Animations Engine
    local RebuildBackgroundAnim, ClearBackgroundAnim = CreateBackgroundEngine(MainFrame)

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
    -- 8-STYLE OPEN / CLOSE ANIMATION ENGINE
    -- ==========================================
    
    local DefaultWinSize = UDim2.new(0, 565, 0, 315)
    local LastSavedPos = CenterPos
    local IsWindowVisible = true
    local AnimToken = 0

    local function AnimateShowUI(Silent)
        AnimToken = AnimToken + 1
        IsWindowVisible = true
        ShowUIBtn.Visible = false
        MainFrame.Visible = true
        MainFrame.Rotation = 0
        MainFrame.Size = DefaultWinSize
        if not Silent then PlayUISound("Open", 1.05) end

        local TargetScale = LooksState.UIScale
        local TargetPos = LastSavedPos
        local TargetTrans = GetSurfaceSpec(LooksState.SurfaceMode).Main

        if not LooksState.AnimationsEnabled then
            MainUIScale.Scale = TargetScale
            MainFrame.Position = TargetPos
            MainFrame.BackgroundTransparency = TargetTrans
            return
        end

        local Style = LooksState.WindowAnimStyle
        if Style == "Pop & Scale" then
            MainFrame.Position = TargetPos; MainFrame.BackgroundTransparency = TargetTrans
            MainUIScale.Scale = TargetScale * 0.84
            Tween(MainUIScale, 0.22, {Scale = TargetScale}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        elseif Style == "Slide From Top" then
            MainUIScale.Scale = TargetScale; MainFrame.BackgroundTransparency = TargetTrans
            MainFrame.Position = UDim2.new(TargetPos.X.Scale, TargetPos.X.Offset, -0.35, 0)
            Tween(MainFrame, 0.30, {Position = TargetPos}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        elseif Style == "Slide From Bottom" then
            MainUIScale.Scale = TargetScale; MainFrame.BackgroundTransparency = TargetTrans
            MainFrame.Position = UDim2.new(TargetPos.X.Scale, TargetPos.X.Offset, 1.35, 0)
            Tween(MainFrame, 0.30, {Position = TargetPos}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        elseif Style == "Slide From Left" then
            MainUIScale.Scale = TargetScale; MainFrame.BackgroundTransparency = TargetTrans
            MainFrame.Position = UDim2.new(-0.35, 0, TargetPos.Y.Scale, TargetPos.Y.Offset)
            Tween(MainFrame, 0.30, {Position = TargetPos}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        elseif Style == "Slide From Right" then
            MainUIScale.Scale = TargetScale; MainFrame.BackgroundTransparency = TargetTrans
            MainFrame.Position = UDim2.new(1.35, 0, TargetPos.Y.Scale, TargetPos.Y.Offset)
            Tween(MainFrame, 0.30, {Position = TargetPos}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        elseif Style == "Fade & Glide" then
            MainUIScale.Scale = TargetScale * 0.94; MainFrame.BackgroundTransparency = 0.92
            MainFrame.Position = UDim2.new(TargetPos.X.Scale, TargetPos.X.Offset, TargetPos.Y.Scale, TargetPos.Y.Offset + 28)
            Tween(MainUIScale, 0.24, {Scale = TargetScale}, Enum.EasingStyle.Quad)
            Tween(MainFrame, 0.26, {Position = TargetPos, BackgroundTransparency = TargetTrans}, Enum.EasingStyle.Quad)
        elseif Style == "Elastic Bounce" then
            MainFrame.Position = TargetPos; MainFrame.BackgroundTransparency = TargetTrans
            MainUIScale.Scale = TargetScale * 0.72
            Tween(MainUIScale, 0.45, {Scale = TargetScale}, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
        elseif Style == "Flip & Zoom" then
            MainFrame.Position = TargetPos; MainFrame.BackgroundTransparency = TargetTrans
            MainUIScale.Scale = TargetScale * 0.78
            MainFrame.Rotation = -7
            Tween(MainUIScale, 0.28, {Scale = TargetScale}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            Tween(MainFrame, 0.28, {Rotation = 0}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        elseif Style == "Horizon Unfold" then
            MainUIScale.Scale = TargetScale; MainFrame.Position = TargetPos; MainFrame.BackgroundTransparency = TargetTrans
            MainFrame.Size = UDim2.new(0, 565, 0, 4)
            Tween(MainFrame, 0.30, {Size = DefaultWinSize}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        elseif Style == "Curtain Split" then
            MainUIScale.Scale = TargetScale; MainFrame.Position = TargetPos; MainFrame.BackgroundTransparency = TargetTrans
            MainFrame.Size = UDim2.new(0, 6, 0, 315)
            Tween(MainFrame, 0.30, {Size = DefaultWinSize}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        elseif Style == "Spin Portal" then
            MainFrame.Position = TargetPos; MainFrame.BackgroundTransparency = TargetTrans
            MainUIScale.Scale = TargetScale * 0.45; MainFrame.Rotation = -18
            Tween(MainUIScale, 0.32, {Scale = TargetScale}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            Tween(MainFrame, 0.32, {Rotation = 0}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        elseif Style == "Drop & Bounce" then
            MainUIScale.Scale = TargetScale; MainFrame.BackgroundTransparency = TargetTrans
            MainFrame.Position = UDim2.new(TargetPos.X.Scale, TargetPos.X.Offset, -0.35, 0)
            Tween(MainFrame, 0.48, {Position = TargetPos}, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
        end
    end

    local function AnimateHideUI()
        if not IsWindowVisible then return end
        AnimToken = AnimToken + 1
        local MyToken = AnimToken

        IsWindowVisible = false
        LastSavedPos = MainFrame.Position
        PlayUISound("Click", 0.85)

        if not LooksState.AnimationsEnabled then
            MainFrame.Visible = false; ShowUIBtn.Visible = true
            return
        end

        local Style = LooksState.WindowAnimStyle
        local DoneTween = nil

        if Style == "Slide From Top" or Style == "Drop & Bounce" then
            DoneTween = Tween(MainFrame, 0.20, {Position = UDim2.new(LastSavedPos.X.Scale, LastSavedPos.X.Offset, -0.35, 0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        elseif Style == "Slide From Bottom" then
            DoneTween = Tween(MainFrame, 0.20, {Position = UDim2.new(LastSavedPos.X.Scale, LastSavedPos.X.Offset, 1.35, 0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        elseif Style == "Slide From Left" then
            DoneTween = Tween(MainFrame, 0.20, {Position = UDim2.new(-0.35, 0, LastSavedPos.Y.Scale, LastSavedPos.Y.Offset)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        elseif Style == "Slide From Right" then
            DoneTween = Tween(MainFrame, 0.20, {Position = UDim2.new(1.35, 0, LastSavedPos.Y.Scale, LastSavedPos.Y.Offset)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        elseif Style == "Fade & Glide" then
            DoneTween = Tween(MainFrame, 0.18, {
                Position = UDim2.new(LastSavedPos.X.Scale, LastSavedPos.X.Offset, LastSavedPos.Y.Scale, LastSavedPos.Y.Offset + 22),
                BackgroundTransparency = 1
            }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        elseif Style == "Horizon Unfold" then
            DoneTween = Tween(MainFrame, 0.18, {Size = UDim2.new(0, 565, 0, 4)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        elseif Style == "Curtain Split" then
            DoneTween = Tween(MainFrame, 0.18, {Size = UDim2.new(0, 6, 0, 315)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        elseif Style == "Flip & Zoom" or Style == "Spin Portal" then
            Tween(MainFrame, 0.18, {Rotation = (Style == "Spin Portal") and 18 or 7}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            DoneTween = Tween(MainUIScale, 0.18, {Scale = LooksState.UIScale * 0.55}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        else
            DoneTween = Tween(MainUIScale, 0.16, {Scale = LooksState.UIScale * 0.82}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        end

        if DoneTween then
            DoneTween.Completed:Connect(function()
                if AnimToken == MyToken and not IsWindowVisible then
                    MainFrame.Visible = false
                    MainFrame.Rotation = 0
                    MainFrame.Size = DefaultWinSize
                    MainUIScale.Scale = LooksState.UIScale
                    MainFrame.Position = LastSavedPos
                    ShowUIBtn.Visible = true
                end
            end)
        else
            MainFrame.Visible = false; ShowUIBtn.Visible = true
        end
    end

    Internal.ToggleVisibilityFn = function(Show)
        if Show then AnimateShowUI() else AnimateHideUI() end
    end
    Internal.IsVisibleFn = function() return IsWindowVisible end

        -- PATCH 6A: Show UI Smart Tap + Optional Free-Drag Handler
    local ShowUICorner = ShowUIBtn:FindFirstChildOfClass("UICorner") or AddCorner(ShowUIBtn, 14)
    local ShowUIScaleObj = Make("UIScale", {Scale = 1.0}, ShowUIBtn)

    do
        local Dragging, ActiveIn, StartPos, FrameStart, Moved = false, nil, nil, nil, 0
        ShowUIBtn.InputBegan:Connect(function(In)
            if In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch then
                Dragging = true; ActiveIn = In; StartPos = In.Position; FrameStart = ShowUIBtn.Position; Moved = 0
            end
        end)
        TrackConn(UserInputService.InputChanged:Connect(function(In)
            if Dragging and LooksState.ShowUICustomEnabled and LooksState.ShowUIPosition == "Free Draggable"
                and (In == ActiveIn or In.UserInputType == Enum.UserInputType.MouseMovement) then
                local Delta = In.Position - StartPos
                Moved = Delta.Magnitude
                ShowUIBtn.Position = UDim2.new(FrameStart.X.Scale, FrameStart.X.Offset + Delta.X, FrameStart.Y.Scale, FrameStart.Y.Offset + Delta.Y)
            end
        end))
        TrackConn(UserInputService.InputEnded:Connect(function(In)
            if Dragging and (In == ActiveIn or In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch) then
                Dragging = false; ActiveIn = nil
                if Moved < 10 then AnimateShowUI(false) end
            end
        end))
    end

    -- ==========================================
    -- TRACKERS & MODALS (SCRIPT INFO + PLAYER PROFILE)
    -- ==========================================
    local Tabs = {}
    local SearchableElements = {}

    local function GetHubCounts()
        local FlagCount = 0
        for _ in pairs(Library.Flags) do FlagCount = FlagCount + 1 end
        return #Tabs, FlagCount, #SearchableElements
    end

    local OpenScriptInfoModal = BuildScriptInfoModal(MainFrame, WindowTitle, Config, GetHubCounts)
    local OpenPlayerProfileModal = BuildPlayerProfileModal(MainFrame)

    -- ==========================================
    -- TOPBAR (TITLE + TELEMETRY + HOLD "ULTIMATE" + MIN + X)
    -- ==========================================
    local Topbar = Make("Frame", {
        Name = "Topbar", Size = UDim2.new(1, 0, 0, 42), BackgroundTransparency = 1, BorderSizePixel = 0, Active = true, ZIndex = 5
    }, MainFrame)

    do
        local Dragging, ActiveInput, DragStartPos, FrameStartPos = false, nil, nil, nil
        Topbar.InputBegan:Connect(function(Input)
            if LooksState.LockPosition then return end
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true; ActiveInput = Input; DragStartPos = Input.Position; FrameStartPos = MainFrame.Position
            end
        end)
        TrackConn(UserInputService.InputChanged:Connect(function(Input)
            if Dragging and not LooksState.LockPosition and (Input == ActiveInput or Input.UserInputType == Enum.UserInputType.MouseMovement) then
                local Delta = Input.Position - DragStartPos
                MainFrame.Position = UDim2.new(FrameStartPos.X.Scale, FrameStartPos.X.Offset + Delta.X, FrameStartPos.Y.Scale, FrameStartPos.Y.Offset + Delta.Y)
            end
        end))
        TrackConn(UserInputService.InputEnded:Connect(function(Input)
            if Dragging and (Input == ActiveInput or Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
                Dragging = false; ActiveInput = nil
            end
        end))
    end

    local TopDivider = Make("Frame", {
        Size = UDim2.new(1, -24, 0, 1), Position = UDim2.new(0, 12, 1, -1),
        BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.45, BorderSizePixel = 0, ZIndex = 6
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
        Size = UDim2.new(0, 9, 0, 9), Position = UDim2.new(0, 15, 0.5, -4),
        BackgroundColor3 = Theme.AccentSecondary, BorderSizePixel = 0, ZIndex = 6
    }, Topbar)
    AddCorner(LogoDot, 9)
    table.insert(Registry.SecondaryBgObjs, LogoDot)

    Make("TextLabel", {
        Size = UDim2.new(0, 225, 1, 0), Position = UDim2.new(0, 30, 0, 0), BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = WindowTitle, ZIndex = 6
    }, Topbar)

    -- LIVE TELEMETRY PILL (FPS | PING)
    local TelemetryPill = Make("TextLabel", {
        Name = "TelemetryPill",
        Size = UDim2.new(0, 96, 0, 20), Position = UDim2.new(1, -254, 0.5, -10),
        BackgroundColor3 = Theme.CardBg, BackgroundTransparency = 0.25,
        Font = Enum.Font.GothamSemibold, TextSize = 10, TextColor3 = Theme.TextMuted,
        Text = "60 FPS | 0ms", Visible = LooksState.ShowTelemetry, ZIndex = 6
    }, Topbar)
    AddCorner(TelemetryPill, 8)
    AddStroke(TelemetryPill, Theme.Stroke, 1, 0.45)

    do
        local FrameCount, LastSample = 0, os.clock()
        Internal.TelemetryConn = RunService.RenderStepped:Connect(function()
            if not MainFrame.Visible or not LooksState.ShowTelemetry then return end
            FrameCount = FrameCount + 1
            local Now = os.clock()
            if Now - LastSample >= 0.5 then
                local FPS = math.floor((FrameCount / (Now - LastSample)) + 0.5)
                FrameCount = 0; LastSample = Now
                local Ping = 0
                pcall(function() Ping = math.floor(StatsService.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5) end)
                TelemetryPill.Text = string.format("%d FPS | %dms", FPS, Ping)
            end
        end)
    end

    -- HOLD-FOR-INFO "ULTIMATE" BADGE (0.4s LONG PRESS)
    local BadgeBtn = Make("TextButton", {
        Name = "UltimateHoldBadge",
        Size = UDim2.new(0, 78, 0, 21), Position = UDim2.new(1, -152, 0.5, -10),
        BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.78,
        Text = "", AutoButtonColor = false, ClipsDescendants = true, ZIndex = 6
    }, Topbar)
    AddCorner(BadgeBtn, 8)
    AddStroke(BadgeBtn, Theme.AccentSecondary, 1, 0.50)

    local HoldFill = Make("Frame", {
        Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = Theme.AccentSecondary,
        BackgroundTransparency = 0.45, BorderSizePixel = 0, ZIndex = 7
    }, BadgeBtn)
    AddCorner(HoldFill, 8)
    table.insert(Registry.SecondaryBgObjs, HoldFill)

    local BadgeText = Make("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
        TextSize = 9, TextColor3 = Theme.AccentSecondary, Text = string.sub(SubTag, 1, 10):upper(), ZIndex = 8
    }, BadgeBtn)
    table.insert(Registry.SecondaryTextObjs, BadgeText)

    do
        local HoldToken, HoldDuration, ActiveTween = 0, 0.40, nil
        BadgeBtn.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                HoldToken = HoldToken + 1
                local MyToken = HoldToken
                if ActiveTween then ActiveTween:Cancel() end
                HoldFill.Size = UDim2.new(0, 0, 1, 0)
                ActiveTween = TweenService:Create(HoldFill, TweenInfo.new(HoldDuration, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
                ActiveTween:Play()
                task.delay(HoldDuration, function()
                    if HoldToken == MyToken then
                        HoldFill.Size = UDim2.new(0, 0, 1, 0)
                        OpenScriptInfoModal()
                    end
                end)
            end
        end)
        BadgeBtn.InputEnded:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                HoldToken = HoldToken + 1
                if ActiveTween then ActiveTween:Cancel() end
                TweenService:Create(HoldFill, TweenInfo.new(0.12), {Size = UDim2.new(0, 0, 1, 0)}):Play()
            end
        end)
    end

    -- VECTOR MINIMIZE & CLOSE BUTTONS
    local MinBtn = Make("TextButton", {
        Size = UDim2.new(0, 26, 0, 25), Position = UDim2.new(1, -68, 0.5, -12),
        BackgroundColor3 = Theme.CardBg, BackgroundTransparency = 0.2, Text = "", AutoButtonColor = false, ZIndex = 6
    }, Topbar)
    AddCorner(MinBtn, 8); AddStroke(MinBtn, Theme.Stroke, 1, 0.35)
    Make("Frame", {
        Size = UDim2.new(0, 11, 0, 2), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.TextPrimary, BorderSizePixel = 0, ZIndex = 7
    }, MinBtn)
    MinBtn.MouseButton1Click:Connect(AnimateHideUI)

    local CloseBtn = Make("TextButton", {
        Size = UDim2.new(0, 26, 0, 25), Position = UDim2.new(1, -36, 0.5, -12),
        BackgroundColor3 = Color3.fromRGB(52, 22, 30), BackgroundTransparency = 0.15, Text = "", AutoButtonColor = false, ZIndex = 6
    }, Topbar)
    AddCorner(CloseBtn, 8); AddStroke(CloseBtn, Theme.Danger, 1, 0.45)
    Make("Frame", {
        Size = UDim2.new(0, 12, 0, 2), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5),
        Rotation = 45, BackgroundColor3 = Theme.Danger, BorderSizePixel = 0, ZIndex = 7
    }, CloseBtn)
    Make("Frame", {
        Size = UDim2.new(0, 12, 0, 2), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5),
        Rotation = -45, BackgroundColor3 = Theme.Danger, BorderSizePixel = 0, ZIndex = 7
    }, CloseBtn)

    -- EXIT CONFIRMATION MODAL
    local ConfirmOverlay = Make("Frame", {
        Name = "ConfirmOverlay", Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(6, 8, 14),
        BackgroundTransparency = 0.25, Visible = false, ZIndex = 80
    }, MainFrame)
    AddCorner(ConfirmOverlay, 18)

    local ConfirmBox = Make("Frame", {
        Size = UDim2.new(0, 256, 0, 118), Position = UDim2.new(0.5, -128, 0.5, -59), BackgroundColor3 = Theme.CardBg, ZIndex = 81
    }, ConfirmOverlay)
    AddCorner(ConfirmBox, 14); AddStroke(ConfirmBox, Theme.Danger, 1.2, 0.35)

    Make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 24), Position = UDim2.new(0, 10, 0, 12), BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Theme.TextPrimary, Text = "Close Sid Ultimate?", ZIndex = 82
    }, ConfirmBox)
    Make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 26), Position = UDim2.new(0, 10, 0, 36), BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = Theme.TextMuted,
        Text = "Hide karne ke liye Minimize (–) button use karo.", TextWrapped = true, ZIndex = 82
    }, ConfirmBox)

    local CancelCloseBtn = Make("TextButton", {
        Size = UDim2.new(0.44, 0, 0, 30), Position = UDim2.new(0.05, 0, 1, -40), BackgroundColor3 = Theme.ToggleOff,
        Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.TextPrimary, Text = "Cancel", ZIndex = 82
    }, ConfirmBox)
    AddCorner(CancelCloseBtn, 8)

    local ConfirmCloseBtn = Make("TextButton", {
        Size = UDim2.new(0.44, 0, 0, 30), Position = UDim2.new(0.51, 0, 1, -40), BackgroundColor3 = Theme.Danger,
        Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Color3.fromRGB(255, 255, 255), Text = "Close UI", ZIndex = 82
    }, ConfirmBox)
    AddCorner(ConfirmCloseBtn, 8)

    CloseBtn.MouseButton1Click:Connect(function() PlayUISound("Click"); ConfirmOverlay.Visible = true end)
    CancelCloseBtn.MouseButton1Click:Connect(function() PlayUISound("Click"); ConfirmOverlay.Visible = false end)
    ConfirmCloseBtn.MouseButton1Click:Connect(function() PlayUISound("Click", 0.8); Library:Destroy() end)

    -- ==========================================
    -- LEFT SIDEBAR: GLOBAL SEARCH + TABS + CLICKABLE PROFILE
    -- ==========================================
    local GlobalSearchBox = Make("TextBox", {
        Name = "GlobalSearchBox",
        Size = UDim2.new(0, 122, 0, 26), Position = UDim2.new(0, 8, 0, 50),
        BackgroundColor3 = Theme.InputBg, BackgroundTransparency = DefaultSurf.Input,
        Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = Theme.AccentSecondary,
        PlaceholderColor3 = Theme.TextMuted, PlaceholderText = "  Search features...",
        Text = "", TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, ZIndex = 7
    }, MainFrame)
    AddCorner(GlobalSearchBox, 8); AddStroke(GlobalSearchBox, Theme.Stroke, 1, 0.35)
    table.insert(Registry.Inputs, GlobalSearchBox)
    table.insert(Registry.SecondaryTextObjs, GlobalSearchBox)

    local Sidebar = Make("ScrollingFrame", {
        Name = "Sidebar", Size = UDim2.new(0, 136, 1, -132), Position = UDim2.new(0, 0, 0, 80),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme.Accent, CanvasSize = UDim2.new(0, 0, 0, 0), ZIndex = 5
    }, MainFrame)
    table.insert(Registry.PrimaryColorObjs, Sidebar)

    Make("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 6)}, Sidebar)
    local SideLayout = Make("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 5)}, Sidebar)
    SideLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Sidebar.CanvasSize = UDim2.new(0, 0, 0, SideLayout.AbsoluteContentSize.Y + 12)
    end)

    BuildSidebarProfileCard(MainFrame, OpenPlayerProfileModal)

    Make("Frame", {
        Size = UDim2.new(0, 1, 1, -56), Position = UDim2.new(0, 138, 0, 48),
        BackgroundColor3 = Theme.Stroke, BackgroundTransparency = 0.5, BorderSizePixel = 0, ZIndex = 5
    }, MainFrame)

    local ContentHolder = Make("Frame", {
        Name = "ContentHolder", Size = UDim2.new(1, -142, 1, -46), Position = UDim2.new(0, 142, 0, 44),
        BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 5
    }, MainFrame)

    local SearchPage = Make("ScrollingFrame", {
        Name = "GlobalSearchResultsPage", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1,
        BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0), Visible = false, ZIndex = 12
    }, ContentHolder)
    table.insert(Registry.PrimaryColorObjs, SearchPage)

    Make("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 14), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 14)}, SearchPage)
    local SearchLayout = Make("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6)}, SearchPage)
    SearchLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        SearchPage.CanvasSize = UDim2.new(0, 0, 0, SearchLayout.AbsoluteContentSize.Y + 20)
    end)

    TrackConn(UserInputService.InputBegan:Connect(function(Input, Processed)
        if not Processed and Input.KeyCode == Enum.KeyCode.RightShift then
            if ScreenGui and ScreenGui.Parent then
                if IsWindowVisible then AnimateHideUI() else AnimateShowUI(false) end
            end
        end
    end))

    function Library:Destroy()
        ClearBackgroundAnim()
        Internal.RainbowConn = SafeDisconnect(Internal.RainbowConn)
        Internal.TelemetryConn = SafeDisconnect(Internal.TelemetryConn)
        Internal.ProfileLiveConn = SafeDisconnect(Internal.ProfileLiveConn)
        Internal.BorderFlowConn = SafeDisconnect(Internal.BorderFlowConn)
        Internal.AntiAfkConn = SafeDisconnect(Internal.AntiAfkConn)
        Internal.AfkClockConn = SafeDisconnect(Internal.AfkClockConn)
        Internal.LayoutDragConn = SafeDisconnect(Internal.LayoutDragConn)
        for _, c in ipairs(Internal.GlobalConns) do SafeDisconnect(c) end
        table.clear(Internal.GlobalConns)
        if ScreenGui and ScreenGui.Parent then ScreenGui:Destroy() end
    end

    if getgenv then
        getgenv()._SidUltimateCleanup = function()
            pcall(function() Library:Destroy() end)
        end
    end

    -- ==========================================
    -- WINDOW OBJECT & TAB SYSTEM
    -- ==========================================
    local Window = {}
    local UserTabCount = 0
    local ActiveTab = nil

    local function SelectTab(TabRecord, Silent)
        if not Silent then PlayUISound("Click", 1.05) end
        SearchPage.Visible = false
        for _, Rec in ipairs(Tabs) do
            local IsSelected = (Rec == TabRecord)
            Rec.Page.Visible = IsSelected
            Rec.Page.ScrollingEnabled = true
            Tween(Rec.Button, 0.15, {
                BackgroundColor3 = IsSelected and Theme.CardHover or Theme.CardBg,
                BackgroundTransparency = IsSelected and 0.15 or 0.75
            })
            Tween(Rec.Label, 0.15, {TextColor3 = IsSelected and Theme.TextPrimary or Theme.TextMuted})
            Tween(Rec.Indicator, 0.15, {
                Size = IsSelected and UDim2.new(0, 3, 0, 18) or UDim2.new(0, 3, 0, 0),
                BackgroundTransparency = IsSelected and 0 or 1
            })
        end
        ActiveTab = TabRecord
    end

    GlobalSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local Query = string.lower(string.gsub(GlobalSearchBox.Text or "", "^%s*(.-)%s*$", "%1"))
        for _, Child in ipairs(SearchPage:GetChildren()) do
            if Child:IsA("GuiObject") then Child:Destroy() end
        end
        if #Query == 0 then
            SearchPage.Visible = false
            if ActiveTab then ActiveTab.Page.Visible = true end
            return
        end
        if ActiveTab then ActiveTab.Page.Visible = false end
        SearchPage.Visible = true

        local MatchCount = 0
        for _, Item in ipairs(SearchableElements) do
            if string.find(string.lower(Item.Name), Query, 1, true) or string.find(string.lower(Item.TabRecord.Name), Query, 1, true) then
                MatchCount = MatchCount + 1
                local ResBtn = Make("TextButton", {
                    Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = Theme.CardBg,
                    BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card,
                    Text = "", AutoButtonColor = false, ZIndex = 13
                }, SearchPage)
                AddCorner(ResBtn, 9); AddStroke(ResBtn, Theme.Stroke, 1, 0.35)

                Make("TextLabel", {
                    Size = UDim2.new(1, -110, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1,
                    Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                    TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = Item.Name, ZIndex = 14
                }, ResBtn)

                local TabPill = Make("TextLabel", {
                    Size = UDim2.new(0, 92, 0, 18), Position = UDim2.new(1, -100, 0.5, -9),
                    BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.78,
                    Font = Enum.Font.GothamBold, TextSize = 9, TextColor3 = Theme.AccentSecondary,
                    Text = Item.TabRecord.Name .. "  >", ZIndex = 14
                }, ResBtn)
                AddCorner(TabPill, 6)

                ResBtn.MouseButton1Click:Connect(function()
                    GlobalSearchBox.Text = ""
                    SelectTab(Item.TabRecord)
                    task.defer(function()
                        pcall(function()
                            local Page = Item.TabRecord.Page
                            local TargetY = math.max(0, Item.Card.AbsolutePosition.Y - Page.AbsolutePosition.Y + Page.CanvasPosition.Y - 12)
                            Tween(Page, 0.25, {CanvasPosition = Vector2.new(0, TargetY)})
                            if Item.Stroke then
                                local OrigColor = Item.Stroke.Color
                                Item.Stroke.Color = Theme.AccentSecondary; Item.Stroke.Thickness = 2
                                task.delay(1.1, function()
                                    if Item.Stroke and Item.Stroke.Parent then
                                        Item.Stroke.Color = OrigColor; Item.Stroke.Thickness = 1
                                    end
                                end)
                            end
                        end)
                    end)
                end)
            end
        end

        if MatchCount == 0 then
            Make("TextLabel", {
                Size = UDim2.new(1, 0, 0, 40), BackgroundTransparency = 1, Font = Enum.Font.GothamMedium,
                TextSize = 12, TextColor3 = Theme.TextMuted, Text = "No matching feature found for '" .. Query .. "'", ZIndex = 13
            }, SearchPage)
        end
    end)

    table.insert(Registry.TabRefreshers, function()
        for _, Rec in ipairs(Tabs) do
            if Rec.Indicator and Rec.Indicator.Parent then Rec.Indicator.BackgroundColor3 = Theme.AccentSecondary end
        end
    end)

    local function CreateTabInternal(TabName, FixedLayoutOrder, IsSystemTab)
        TabName = tostring(TabName or "Tab")
        local Order = FixedLayoutOrder
        if not Order then UserTabCount = UserTabCount + 1; Order = UserTabCount end

        local TabBtn = Make("TextButton", {
            Name = "Tab_" .. TabName, Size = UDim2.new(1, 0, 0, 30), LayoutOrder = Order,
            BackgroundColor3 = Theme.CardBg, BackgroundTransparency = 0.75, Text = "", AutoButtonColor = false, ZIndex = 6
        }, Sidebar)
        AddCorner(TabBtn, 8)

        local Indicator = Make("Frame", {
            Size = UDim2.new(0, 3, 0, 0), Position = UDim2.new(0, 3, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Theme.AccentSecondary, BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 7
        }, TabBtn)
        AddCorner(Indicator, 3)

        local TabLabel = Make("TextLabel", {
            Size = UDim2.new(1, -14, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
            Font = Enum.Font.GothamSemibold, TextSize = 11, TextColor3 = Theme.TextMuted,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = TabName, ZIndex = 7
        }, TabBtn)

        local TabPage = Make("ScrollingFrame", {
            Name = "Page_" .. TabName, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0,
            ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Accent, CanvasSize = UDim2.new(0, 0, 0, 0), Visible = false, ZIndex = 6
        }, ContentHolder)
        table.insert(Registry.PrimaryColorObjs, TabPage)

        Make("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 14), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 14)}, TabPage)
        local PageLayout = Make("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 7)}, TabPage)
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 24)
        end)

        local TabRecord = {Name = TabName, Button = TabBtn, Label = TabLabel, Indicator = Indicator, Page = TabPage, IsSystemTab = IsSystemTab == true}
        table.insert(Tabs, TabRecord)
        if not IsSystemTab then
            TabPage.ChildAdded:Connect(function(Child)
                if Child:IsA("GuiObject") and Child.Name ~= "__SidDropSlot" then
                    task.defer(function()
                        if Child and Child.Parent == TabPage and Internal.RegisterReorderCardFn then
                            Internal.RegisterReorderCardFn(TabRecord, Child)
                        end
                    end)
                end
            end)
        end

        TabBtn.MouseButton1Click:Connect(function() GlobalSearchBox.Text = ""; SelectTab(TabRecord) end)
        if not IsSystemTab and UserTabCount == 1 then SelectTab(TabRecord, true) end

        local Tab = {}
        local function RegisterSearch(ElementName, Card, Stroke)
            table.insert(SearchableElements, {Name = tostring(ElementName), TabRecord = TabRecord, Card = Card, Stroke = Stroke})
        end

        function Tab:CreateSection(SectionTitle)
            local SecFrame = Make("Frame", {Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1, ZIndex = 7}, TabPage)
            local SecLabel = Make("TextLabel", {
                Size = UDim2.new(1, -6, 1, 0), Position = UDim2.new(0, 2, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Theme.AccentSecondary,
                TextXAlignment = Enum.TextXAlignment.Left, Text = string.upper(tostring(SectionTitle or "SECTION")), ZIndex = 7
            }, SecFrame)
            table.insert(Registry.SecondaryTextObjs, SecLabel)
            Make("Frame", {
                Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1),
                BackgroundColor3 = Theme.Stroke, BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 7
            }, SecFrame)
            return {Set = function(_, NewText) SecLabel.Text = string.upper(tostring(NewText)) end}
        end

        function Tab:CreateDivider()
            local Wrap = Make("Frame", {Size = UDim2.new(1, 0, 0, 10), BackgroundTransparency = 1, ZIndex = 7}, TabPage)
            local Line = Make("Frame", {
                Size = UDim2.new(1, -8, 0, 1), Position = UDim2.new(0, 4, 0.5, 0),
                BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 7
            }, Wrap)
            local G = Make("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Theme.Accent),
                    ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
                    ColorSequenceKeypoint.new(1, Theme.Accent)
                })
            }, Line)
            table.insert(Registry.AccentGradients, G)
            return {Set = function(_, Vis) Wrap.Visible = (Vis ~= false) end}
        end

        function Tab:CreateLabel(Text, _Icon, ColorOverride)
            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card, ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9); AddStroke(Card, typeof(ColorOverride) == "Color3" and ColorOverride or Theme.Stroke, 1, 0.45)
            table.insert(Registry.Cards, Card)
            local Lbl = Make("TextLabel", {
                Size = UDim2.new(1, -20, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium, TextSize = 12,
                TextColor3 = typeof(ColorOverride) == "Color3" and ColorOverride or Theme.TextMuted,
                TextXAlignment = Enum.TextXAlignment.Left, Text = tostring(Text or ""), ZIndex = 8
            }, Card)
            return {Set = function(_, NewText) Lbl.Text = tostring(NewText) end}
        end

        function Tab:CreateParagraph(Opts)
            Opts = Opts or {}
            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 52), BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card, ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9); AddStroke(Card, Theme.Stroke, 1, 0.45)
            table.insert(Registry.Cards, Card)
            local T = Make("TextLabel", {
                Size = UDim2.new(1, -20, 0, 18), Position = UDim2.new(0, 10, 0, 6), BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left, Text = tostring(Opts.Title or ""), ZIndex = 8
            }, Card)
            local C = Make("TextLabel", {
                Size = UDim2.new(1, -20, 0, 24), Position = UDim2.new(0, 10, 0, 24), BackgroundTransparency = 1,
                Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = Theme.TextMuted,
                TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, Text = tostring(Opts.Content or ""), ZIndex = 8
            }, Card)
            return {
                Set = function(_, NewOpts)
                    if type(NewOpts) == "table" then
                        if NewOpts.Title then T.Text = tostring(NewOpts.Title) end
                        if NewOpts.Content then C.Text = tostring(NewOpts.Content) end
                    end
                end
            }
        end

        function Tab:CreateButton(Opts)
            Opts = Opts or {}
            local NameStr = tostring(Opts.Name or "Button")
            local Btn = Make("TextButton", {
                Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card,
                Text = "", AutoButtonColor = false, ZIndex = 7
            }, TabPage)
            AddCorner(Btn, 9); local Stroke = AddStroke(Btn, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Btn); RegisterSearch(NameStr, Btn, Stroke)

            local TitleLbl = Make("TextLabel", {
                Size = UDim2.new(1, -54, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = NameStr, ZIndex = 8
            }, Btn)

            local Tag = Make("TextLabel", {
                Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -46, 0.5, -9),
                BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.78,
                Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = Theme.AccentSecondary, Text = "RUN", ZIndex = 8
            }, Btn)
            AddCorner(Tag, 6); table.insert(Registry.SecondaryTextObjs, Tag)

                        -- PATCH 1: External GUI Auto-Front Boost + Touch-Safe Activated + Error Catch
            local LastBtnClick = 0
            local function FireExternalSafeButton()
                local Now = os.clock()
                if Now - LastBtnClick < 0.22 then return end
                LastBtnClick = Now

                PlayUISound("Click", 1.1)
                Tween(Btn, 0.08, {BackgroundColor3 = Theme.CardHover})
                Tween(Stroke, 0.08, {Color = Theme.AccentSecondary})
                task.delay(0.12, function()
                    Tween(Btn, 0.14, {BackgroundColor3 = Theme.CardBg})
                    Tween(Stroke, 0.14, {Color = Theme.Stroke})
                end)

                if type(Opts.Callback) ~= "function" then return end

                -- Snapshot existing ScreenGuis before running script loader
                local Roots = {}
                local gParent = GetGuiParent()
                if gParent then table.insert(Roots, gParent) end
                if CoreGui and CoreGui ~= gParent then table.insert(Roots, CoreGui) end
                local pGui = LocalPlayer:FindFirstChild("PlayerGui")
                if pGui and pGui ~= gParent then table.insert(Roots, pGui) end

                local Existing = {}
                for _, Root in ipairs(Roots) do
                    pcall(function()
                        for _, Obj in ipairs(Root:GetChildren()) do
                            if Obj:IsA("ScreenGui") then Existing[Obj] = true end
                        end
                    end)
                end

                -- Watch for any newly spawned external GUI for 3 seconds and bring it to front!
                task.spawn(function()
                    local WatchStart = os.clock()
                    while os.clock() - WatchStart < 3.0 do
                        for _, Root in ipairs(Roots) do
                            pcall(function()
                                for _, Obj in ipairs(Root:GetChildren()) do
                                    if Obj:IsA("ScreenGui") and not Existing[Obj] and not string.find(Obj.Name, "^SidUltimate") then
                                        Existing[Obj] = true
                                        Obj.Enabled = true
                                        if Obj.DisplayOrder < 150 then
                                            Obj.DisplayOrder = 150
                                        end
                                    end
                                end
                            end)
                        end
                        task.wait(0.12)
                    end
                end)

                -- Execute callback safely and show error toast if script fails
                task.spawn(function()
                    local ok, err = pcall(Opts.Callback)
                    if not ok then
                        warn("[Sid Ultimate Button Error - " .. NameStr .. "]:", err)
                        Library:Notify({
                            Title = "Loader Error: " .. NameStr,
                            Content = tostring(err),
                            Color = Theme.Danger,
                            Duration = 4.0
                        })
                    end
                end)
            end

            Btn.Activated:Connect(FireExternalSafeButton)

            if not IsSystemTab then
                local PinB = Make("TextButton", {
                    Size = UDim2.new(0, 26, 0, 18), Position = UDim2.new(1, -78, 0.5, -9),
                    BackgroundColor3 = Theme.InputBg, BackgroundTransparency = 0.2,
                    Font = Enum.Font.GothamBold, TextSize = 8, TextColor3 = Theme.TextMuted,
                    Text = "PIN", AutoButtonColor = false, ZIndex = 9
                }, Btn)
                AddCorner(PinB, 5)

                Internal.PinnableRegistry[NameStr] = {
                    Kind = "Button",
                    Name = NameStr,
                    Fire = FireExternalSafeButton,
                    UpdatePinVisual = function(IsPinned)
                        if PinB and PinB.Parent then
                            PinB.BackgroundColor3 = IsPinned and Color3.fromRGB(255, 190, 45) or Theme.InputBg
                            PinB.TextColor3 = IsPinned and Color3.fromRGB(16, 18, 26) or Theme.TextMuted
                        end
                    end
                }
                PinB.MouseButton1Click:Connect(function()
                    PlayUISound("Click", 1.15)
                    if Internal.TogglePinItemFn then Internal.TogglePinItemFn(NameStr) end
                end)
            end

            return {Set = function(_, NewName) TitleLbl.Text = tostring(NewName) end}
        end

        function Tab:CreateToggle(Opts)
            Opts = Opts or {}
            local NameStr = tostring(Opts.Name or "Toggle")
            local State = Opts.CurrentValue == true
            local FlagName = Opts.Flag

            local Card = Make("TextButton", {
                Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card,
                Text = "", AutoButtonColor = false, ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9); local Stroke = AddStroke(Card, State and Theme.Accent or Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Card); RegisterSearch(NameStr, Card, Stroke)

            Make("TextLabel", {
                Size = UDim2.new(1, -66, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = NameStr, ZIndex = 8
            }, Card)

            local SwitchBg = Make("Frame", {
                Size = UDim2.new(0, 40, 0, 20), Position = UDim2.new(1, -50, 0.5, -10),
                BackgroundColor3 = State and Theme.Accent or Theme.ToggleOff, BorderSizePixel = 0, ZIndex = 8
            }, Card)
            AddCorner(SwitchBg, 10)

            local Knob = Make("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                Position = State and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ZIndex = 9
            }, SwitchBg)
            AddCorner(Knob, 7)

            -- PATCH 3B: Micro PIN & FLT Shortcut Buttons on User Toggles
            local PinBtn, FltBtn = nil, nil
            if not IsSystemTab then
                PinBtn = Make("TextButton", {
                    Size = UDim2.new(0, 26, 0, 18), Position = UDim2.new(1, -82, 0.5, -9),
                    BackgroundColor3 = Theme.InputBg, BackgroundTransparency = 0.2,
                    Font = Enum.Font.GothamBold, TextSize = 8, TextColor3 = Theme.TextMuted,
                    Text = "PIN", AutoButtonColor = false, ZIndex = 9
                }, Card)
                AddCorner(PinBtn, 5)

                FltBtn = Make("TextButton", {
                    Size = UDim2.new(0, 26, 0, 18), Position = UDim2.new(1, -112, 0.5, -9),
                    BackgroundColor3 = Theme.InputBg, BackgroundTransparency = 0.2,
                    Font = Enum.Font.GothamBold, TextSize = 8, TextColor3 = Theme.TextMuted,
                    Text = "FLT", AutoButtonColor = false, ZIndex = 9
                }, Card)
                AddCorner(FltBtn, 5)
            end

            local ToggleObj = {CurrentValue = State}
            local function UpdateVisual(Val, Instant)
                local Dur = Instant and 0 or 0.14
                Tween(SwitchBg, Dur, {BackgroundColor3 = Val and Theme.Accent or Theme.ToggleOff})
                Tween(Knob, Dur, {Position = Val and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)})
                Tween(Stroke, Dur, {Color = Val and Theme.Accent or Theme.Stroke})
            end

            table.insert(Registry.ToggleRefreshers, function()
                if State then SwitchBg.BackgroundColor3 = Theme.Accent; Stroke.Color = Theme.Accent end
            end)

            function ToggleObj:Set(NewVal)
                NewVal = (NewVal == true)
                State = NewVal; ToggleObj.CurrentValue = State
                UpdateVisual(State, Internal.IsLoadingConfig)
                if not IsSystemTab then
                    Internal.ActiveToggleStates[NameStr] = State
                    if Internal.RefreshActiveHudFn then Internal.RefreshActiveHudFn() end
                    if Internal.SyncToggleExternalsFn then Internal.SyncToggleExternalsFn(NameStr, State) end
                end
                if type(Opts.Callback) == "function" then task.spawn(Opts.Callback, State) end
                Library:SaveConfiguration()
            end

            Card.MouseButton1Click:Connect(function()
                PlayUISound("Toggle", State and 0.95 or 1.2)
                ToggleObj:Set(not State)
            end)

            if FlagName then
                Library.Flags[FlagName] = ToggleObj
                Internal.DefaultValues[FlagName] = State
            end
            if not IsSystemTab then
                Internal.ActiveToggleStates[NameStr] = State
                Internal.PinnableRegistry[NameStr] = {
                    Kind = "Toggle",
                    Name = NameStr,
                    GetState = function() return State end,
                    Toggle = function() ToggleObj:Set(not State) end,
                    UpdatePinVisual = function(IsPinned)
                        if PinBtn and PinBtn.Parent then
                            PinBtn.BackgroundColor3 = IsPinned and Color3.fromRGB(255, 190, 45) or Theme.InputBg
                            PinBtn.TextColor3 = IsPinned and Color3.fromRGB(16, 18, 26) or Theme.TextMuted
                        end
                    end,
                    UpdateFloatVisual = function(IsFloating)
                        if FltBtn and FltBtn.Parent then
                            FltBtn.BackgroundColor3 = IsFloating and Theme.AccentSecondary or Theme.InputBg
                            FltBtn.TextColor3 = IsFloating and Color3.fromRGB(14, 18, 28) or Theme.TextMuted
                        end
                    end
                }
                if PinBtn then
                    PinBtn.MouseButton1Click:Connect(function()
                        PlayUISound("Click", 1.15)
                        if Internal.TogglePinItemFn then Internal.TogglePinItemFn(NameStr) end
                    end)
                end
                if FltBtn then
                    FltBtn.MouseButton1Click:Connect(function()
                        PlayUISound("Click", 1.15)
                        if Internal.ToggleFloatingBtnFn then Internal.ToggleFloatingBtnFn(NameStr) end
                    end)
                end
            end
            return ToggleObj
        end

        function Tab:CreateSlider(Opts)
            Opts = Opts or {}
            local NameStr = tostring(Opts.Name or "Slider")
            local Range = Opts.Range or {0, 100}
            local MinVal = tonumber(Range[1]) or 0
            local MaxVal = tonumber(Range[2]) or 100
            local Increment = tonumber(Opts.Increment) or 1
            local Suffix = tostring(Opts.Suffix or "")
            local CurrentVal = math.clamp(tonumber(Opts.CurrentValue) or MinVal, MinVal, MaxVal)
            local FlagName = Opts.Flag

            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card, Active = false, ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9); local Stroke = AddStroke(Card, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Card); RegisterSearch(NameStr, Card, Stroke)

            Make("TextLabel", {
                Size = UDim2.new(1, -95, 0, 20), Position = UDim2.new(0, 12, 0, 5), BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = NameStr, ZIndex = 8
            }, Card)

            local ValLabel = Make("TextLabel", {
                Size = UDim2.new(0, 82, 0, 20), Position = UDim2.new(1, -92, 0, 5), BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Theme.AccentSecondary,
                TextXAlignment = Enum.TextXAlignment.Right,
                Text = tostring(CurrentVal) .. (Suffix ~= "" and (" " .. Suffix) or ""), ZIndex = 8
            }, Card)
            table.insert(Registry.SecondaryTextObjs, ValLabel)

            local Track = Make("Frame", {
                Size = UDim2.new(1, -24, 0, 7), Position = UDim2.new(0, 12, 0, 31),
                BackgroundColor3 = Theme.ToggleOff, BorderSizePixel = 0, Active = false, ZIndex = 8
            }, Card)
            AddCorner(Track, 4)

            local FillPct = (MaxVal > MinVal) and ((CurrentVal - MinVal) / (MaxVal - MinVal)) or 0
            local Fill = Make("Frame", {
                Size = UDim2.new(FillPct, 0, 1, 0), BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0, Active = false, ZIndex = 9
            }, Track)
            AddCorner(Fill, 4); table.insert(Registry.PrimaryColorObjs, Fill)

            local FillGrad = Make("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Theme.Accent),
                    ColorSequenceKeypoint.new(1, Theme.AccentSecondary)
                })
            }, Fill)
            table.insert(Registry.AccentGradients, FillGrad)

            local Knob = Make("Frame", {
                Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(1, -7, 0.5, -7),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Active = false, ZIndex = 10
            }, Fill)
            AddCorner(Knob, 7)

            local TouchZone = Make("Frame", {
                Size = UDim2.new(1, 8, 0, 26), Position = UDim2.new(0, -4, 0.5, -13),
                BackgroundTransparency = 1, Active = false, ZIndex = 11
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
                CurrentVal = RoundStep(Num); SliderObj.CurrentValue = CurrentVal
                local Pct = (MaxVal > MinVal) and ((CurrentVal - MinVal) / (MaxVal - MinVal)) or 0
                Fill.Size = UDim2.new(Pct, 0, 1, 0)
                ValLabel.Text = tostring(CurrentVal) .. (Suffix ~= "" and (" " .. Suffix) or "")
                if type(Opts.Callback) == "function" then task.spawn(Opts.Callback, CurrentVal) end
                Library:SaveConfiguration()
            end

            local PendingInput, StartPos, Sliding = nil, nil, false
            local function UpdateFromInputX(InputPosX)
                local RelX = math.clamp((InputPosX - Track.AbsolutePosition.X) / math.max(Track.AbsoluteSize.X, 1), 0, 1)
                local Rounded = RoundStep(MinVal + (MaxVal - MinVal) * RelX)
                if Rounded ~= CurrentVal then SliderObj:Set(Rounded) end
            end

            TouchZone.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    PendingInput = Input; Sliding = true; TabPage.ScrollingEnabled = false
                    UpdateFromInputX(Input.Position.X)
                elseif Input.UserInputType == Enum.UserInputType.Touch then
                    PendingInput = Input; StartPos = Input.Position; Sliding = false
                end
            end)

            TrackConn(UserInputService.InputChanged:Connect(function(Input)
                if not PendingInput then return end
                if Sliding then
                    if Input == PendingInput or Input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateFromInputX(Input.Position.X)
                    end
                elseif Input == PendingInput and StartPos then
                    local dx = math.abs(Input.Position.X - StartPos.X)
                    local dy = math.abs(Input.Position.Y - StartPos.Y)
                    if dy > 7 and dy >= dx then
                        PendingInput = nil; StartPos = nil; Sliding = false; TabPage.ScrollingEnabled = true
                    elseif dx > 8 and dx > dy * 1.25 then
                        Sliding = true; TabPage.ScrollingEnabled = false
                        UpdateFromInputX(Input.Position.X)
                    end
                end
            end))

            TrackConn(UserInputService.InputEnded:Connect(function(Input)
                if PendingInput and (Input == PendingInput or Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
                    PendingInput = nil; StartPos = nil; Sliding = false; TabPage.ScrollingEnabled = true
                end
            end))

            if FlagName then
                Library.Flags[FlagName] = SliderObj
                Internal.DefaultValues[FlagName] = CurrentVal
            end
            return SliderObj
        end

        function Tab:CreateInput(Opts)
            Opts = Opts or {}
            local NameStr = tostring(Opts.Name or "Input")
            local FlagName = Opts.Flag
            local ClearAfter = Opts.RemoveTextAfterFocusLost == true
            local InitText = tostring(Opts.CurrentValue or "")

            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card, ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9); local Stroke = AddStroke(Card, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Card); RegisterSearch(NameStr, Card, Stroke)

            Make("TextLabel", {
                Size = UDim2.new(0.52, -12, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = NameStr, ZIndex = 8
            }, Card)

            local Box = Make("TextBox", {
                Size = UDim2.new(0.45, -10, 0, 24), Position = UDim2.new(0.55, 0, 0.5, -12),
                BackgroundColor3 = Theme.InputBg, BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Input,
                Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = Theme.AccentSecondary,
                PlaceholderColor3 = Theme.TextMuted, PlaceholderText = tostring(Opts.PlaceholderText or "Type here..."),
                Text = InitText, ClearTextOnFocus = false, ZIndex = 8
            }, Card)
            AddCorner(Box, 7); AddStroke(Box, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Inputs, Box); table.insert(Registry.SecondaryTextObjs, Box)

            local InputObj = {CurrentValue = InitText}
            function InputObj:Set(TextVal)
                local Str = tostring(TextVal or "")
                InputObj.CurrentValue = Str; Box.Text = Str
                if type(Opts.Callback) == "function" then task.spawn(Opts.Callback, Str) end
                Library:SaveConfiguration()
            end

            Box.FocusLost:Connect(function()
                PlayUISound("Click", 1.05)
                local Typed = Box.Text
                if Opts.NumbersOnly then Typed = string.gsub(Typed, "[^%d%.%-]", ""); Box.Text = Typed end
                InputObj.CurrentValue = Typed
                if type(Opts.Callback) == "function" then task.spawn(Opts.Callback, Typed) end
                Library:SaveConfiguration()
                if ClearAfter then Box.Text = "" end
            end)

            if FlagName then
                Library.Flags[FlagName] = InputObj
                Internal.DefaultValues[FlagName] = InitText
            end
            return InputObj
        end

        function Tab:CreateDropdown(Opts)
            Opts = Opts or {}
            local NameStr = tostring(Opts.Name or "Dropdown")
            local Multi = Opts.MultipleOptions == true
            local FlagName = Opts.Flag
            local OptionsList = Opts.Options or {}
            local SelectedSet, SingleSelected, IsOpen = {}, nil, false

            if Multi then
                if type(Opts.CurrentOption) == "table" then
                    for _, v in ipairs(Opts.CurrentOption) do SelectedSet[tostring(v)] = true end
                elseif type(Opts.CurrentOption) == "string" then SelectedSet[Opts.CurrentOption] = true end
            else
                SingleSelected = (type(Opts.CurrentOption) == "table") and Opts.CurrentOption[1] or Opts.CurrentOption
            end

            local Container = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card, ClipsDescendants = true, ZIndex = 7
            }, TabPage)
            AddCorner(Container, 9); local Stroke = AddStroke(Container, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Container); RegisterSearch(NameStr, Container, Stroke)

            local HeaderBtn = Make("TextButton", {Size = UDim2.new(1, 0, 0, 38), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 8}, Container)
            Make("TextLabel", {
                Size = UDim2.new(0.50, -12, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = NameStr, ZIndex = 9
            }, HeaderBtn)

            local SelectedLabel = Make("TextLabel", {
                Size = UDim2.new(0.46, -24, 1, 0), Position = UDim2.new(0.50, 0, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = Theme.AccentSecondary,
                TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, Text = "None", ZIndex = 9
            }, HeaderBtn)
            table.insert(Registry.SecondaryTextObjs, SelectedLabel)

            local Arrow = Make("TextLabel", {
                Size = UDim2.new(0, 18, 1, 0), Position = UDim2.new(1, -24, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Theme.TextMuted, Text = "v", ZIndex = 9
            }, HeaderBtn)

            local InlineSearch = Make("TextBox", {
                Size = UDim2.new(1, -16, 0, 22), Position = UDim2.new(0, 8, 0, 40),
                BackgroundColor3 = Theme.InputBg, BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Input,
                Font = Enum.Font.GothamMedium, TextSize = 10, TextColor3 = Theme.AccentSecondary,
                PlaceholderColor3 = Theme.TextMuted, PlaceholderText = "  Filter options...",
                Text = "", TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, Visible = false, ZIndex = 9
            }, Container)
            AddCorner(InlineSearch, 6); AddStroke(InlineSearch, Theme.Stroke, 1, 0.40)
            table.insert(Registry.Inputs, InlineSearch)

            local ListScroll = Make("ScrollingFrame", {
                Size = UDim2.new(1, -16, 0, 0), Position = UDim2.new(0, 8, 0, 40),
                BackgroundColor3 = Theme.InputBg, BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Input,
                BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Accent,
                CanvasSize = UDim2.new(0, 0, 0, 0), ZIndex = 8
            }, Container)
            AddCorner(ListScroll, 7); table.insert(Registry.Inputs, ListScroll); table.insert(Registry.PrimaryColorObjs, ListScroll)
            Make("UIPadding", {PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4)}, ListScroll)
            local DropLayout = Make("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4)}, ListScroll)

            local DropdownObj, OptionButtons = {}, {}

            local function GetCurrentReturnTable()
                if Multi then
                    local Arr = {}
                    for _, Opt in ipairs(OptionsList) do
                        if SelectedSet[tostring(Opt)] then table.insert(Arr, tostring(Opt)) end
                    end
                    return Arr
                else
                    return SingleSelected and {tostring(SingleSelected)} or {}
                end
            end

            local function UpdateSelectedText()
                local Arr = GetCurrentReturnTable()
                DropdownObj.CurrentOption = Arr
                if #Arr == 0 then SelectedLabel.Text = "None"
                elseif #Arr == 1 then SelectedLabel.Text = Arr[1]
                else SelectedLabel.Text = string.format("%s (+%d)", Arr[1], #Arr - 1) end
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
                local ShowSearch = (#OptionsList >= 5)
                InlineSearch.Visible = IsOpen and ShowSearch
                local ListTopY = ShowSearch and 66 or 40
                local ContentH = DropLayout.AbsoluteContentSize.Y + 8
                ListScroll.CanvasSize = UDim2.new(0, 0, 0, ContentH)
                local VisibleListH = math.min(math.max(ContentH, 28), 130)

                if IsOpen then
                    ListScroll.Position = UDim2.new(0, 8, 0, ListTopY)
                    ListScroll.Size = UDim2.new(1, -16, 0, VisibleListH)
                    Tween(Container, 0.16, {Size = UDim2.new(1, 0, 0, ListTopY + VisibleListH + 8)})
                    Arrow.Text = "^"; Tween(Stroke, 0.16, {Color = Theme.Accent})
                else
                    Tween(Container, 0.16, {Size = UDim2.new(1, 0, 0, 38)})
                    Arrow.Text = "v"; Tween(Stroke, 0.16, {Color = Theme.Stroke})
                end
            end

            InlineSearch:GetPropertyChangedSignal("Text"):Connect(function()
                local Q = string.lower(string.gsub(InlineSearch.Text or "", "^%s*(.-)%s*$", "%1"))
                for OptStr, Btn in pairs(OptionButtons) do
                    Btn.Visible = (#Q == 0) or (string.find(string.lower(OptStr), Q, 1, true) ~= nil)
                end
                task.defer(UpdateDropdownHeight)
            end)

            local function BuildOptionItems()
                for _, Child in ipairs(ListScroll:GetChildren()) do
                    if Child:IsA("TextButton") then Child:Destroy() end
                end
                table.clear(OptionButtons)

                for _, OptName in ipairs(OptionsList) do
                    local OptStr = tostring(OptName)
                    local OptBtn = Make("TextButton", {
                        Size = UDim2.new(1, 0, 0, 26), BackgroundColor3 = Theme.CardBg,
                        Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = Theme.TextMuted,
                        Text = "  " .. OptStr, TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd, AutoButtonColor = false, ZIndex = 9
                    }, ListScroll)
                    AddCorner(OptBtn, 6); OptionButtons[OptStr] = OptBtn

                    OptBtn.MouseButton1Click:Connect(function()
                        PlayUISound("Click", 1.15)
                        if Multi then
                            SelectedSet[OptStr] = not SelectedSet[OptStr]
                        else
                            SingleSelected = OptStr; IsOpen = false; InlineSearch.Text = ""
                            UpdateDropdownHeight()
                        end
                        UpdateSelectedText(); RefreshButtonStyles()
                        if type(Opts.Callback) == "function" then task.spawn(Opts.Callback, GetCurrentReturnTable()) end
                        Library:SaveConfiguration()
                    end)
                end
                UpdateSelectedText(); RefreshButtonStyles(); task.defer(UpdateDropdownHeight)
            end

            HeaderBtn.MouseButton1Click:Connect(function()
                PlayUISound("Click", IsOpen and 0.95 or 1.1)
                IsOpen = not IsOpen
                if not IsOpen then InlineSearch.Text = "" end
                UpdateDropdownHeight()
            end)

            function DropdownObj:Set(NewVal)
                if Multi then
                    table.clear(SelectedSet)
                    if type(NewVal) == "table" then
                        for _, v in ipairs(NewVal) do SelectedSet[tostring(v)] = true end
                    elseif type(NewVal) == "string" then SelectedSet[NewVal] = true end
                else
                    SingleSelected = (type(NewVal) == "table") and NewVal[1] or NewVal
                end
                UpdateSelectedText(); RefreshButtonStyles()
                if type(Opts.Callback) == "function" then task.spawn(Opts.Callback, GetCurrentReturnTable()) end
                Library:SaveConfiguration()
            end

            function DropdownObj:Refresh(NewOptions, NewCurrent)
                OptionsList = type(NewOptions) == "table" and NewOptions or {}
                if NewCurrent ~= nil then
                    if Multi then
                        table.clear(SelectedSet)
                        if type(NewCurrent) == "table" then
                            for _, v in ipairs(NewCurrent) do SelectedSet[tostring(v)] = true end
                        elseif type(NewCurrent) == "string" then SelectedSet[NewCurrent] = true end
                    else
                        SingleSelected = type(NewCurrent) == "table" and NewCurrent[1] or NewCurrent
                    end
                else
                    if Multi then
                        local ValidMap = {}
                        for _, v in ipairs(OptionsList) do ValidMap[tostring(v)] = true end
                        for k in pairs(SelectedSet) do if not ValidMap[k] then SelectedSet[k] = nil end end
                    else
                        if SingleSelected and not table.find(OptionsList, SingleSelected) then SingleSelected = nil end
                    end
                end
                BuildOptionItems()
            end

            BuildOptionItems()
            if FlagName then
                Library.Flags[FlagName] = DropdownObj
                Internal.DefaultValues[FlagName] = GetCurrentReturnTable()
            end
            return DropdownObj
        end

        function Tab:CreateKeybind(Opts)
            Opts = Opts or {}
            local NameStr = tostring(Opts.Name or "Keybind")
            local CurrentKey = tostring(Opts.CurrentKeybind or "Q")
            local HoldMode = Opts.HoldToInteract == true
            local FlagName = Opts.Flag
            local Listening = false

            local Card = Make("TextButton", {
                Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card,
                Text = "", AutoButtonColor = false, ZIndex = 7
            }, TabPage)
            AddCorner(Card, 9); local Stroke = AddStroke(Card, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Card); RegisterSearch(NameStr, Card, Stroke)

            Make("TextLabel", {
                Size = UDim2.new(1, -100, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = NameStr, ZIndex = 8
            }, Card)

            local KeyBtn = Make("TextButton", {
                Size = UDim2.new(0, 74, 0, 22), Position = UDim2.new(1, -84, 0.5, -11),
                BackgroundColor3 = Theme.InputBg, BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Input,
                Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = Theme.AccentSecondary,
                Text = CurrentKey, AutoButtonColor = false, ZIndex = 9
            }, Card)
            AddCorner(KeyBtn, 6); AddStroke(KeyBtn, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Inputs, KeyBtn); table.insert(Registry.SecondaryTextObjs, KeyBtn)

            local KeybindObj = {CurrentKeybind = CurrentKey}
            function KeybindObj:Set(NewKey)
                CurrentKey = tostring(NewKey or "Q"); KeybindObj.CurrentKeybind = CurrentKey; KeyBtn.Text = CurrentKey
                if type(Opts.OnChanged) == "function" then task.spawn(Opts.OnChanged, CurrentKey) end
                Library:SaveConfiguration()
            end

            Card.MouseButton1Click:Connect(function()
                PlayUISound("Click", 1.1)
                if type(Opts.Callback) == "function" then task.spawn(Opts.Callback, HoldMode and true or CurrentKey) end
            end)
            KeyBtn.MouseButton1Click:Connect(function()
                PlayUISound("Click", 1.0); Listening = not Listening; KeyBtn.Text = Listening and "..." or CurrentKey
            end)

            TrackConn(UserInputService.InputBegan:Connect(function(Input, Processed)
                if Processed then return end
                if Listening and Input.UserInputType == Enum.UserInputType.Keyboard then
                    Listening = false; KeybindObj:Set(Input.KeyCode.Name); return
                end
                if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == CurrentKey then
                    if type(Opts.Callback) == "function" then task.spawn(Opts.Callback, HoldMode and true or CurrentKey) end
                end
            end))

            if HoldMode then
                TrackConn(UserInputService.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == CurrentKey then
                        if type(Opts.Callback) == "function" then task.spawn(Opts.Callback, false) end
                    end
                end))
            end

            if FlagName then
                Library.Flags[FlagName] = KeybindObj
                Internal.DefaultValues[FlagName] = CurrentKey
            end
            return KeybindObj
        end

        function Tab:CreateColorPicker(Opts)
            Opts = Opts or {}
            local NameStr = tostring(Opts.Name or "Color Picker")
            local CurColor = typeof(Opts.Color) == "Color3" and Opts.Color or Color3.fromRGB(122, 95, 255)
            local FlagName = Opts.Flag
            local IsOpen = false

            local Container = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card, ClipsDescendants = true, ZIndex = 7
            }, TabPage)
            AddCorner(Container, 9); local Stroke = AddStroke(Container, Theme.Stroke, 1, 0.35)
            table.insert(Registry.Cards, Container); RegisterSearch(NameStr, Container, Stroke)

            local HeaderBtn = Make("TextButton", {Size = UDim2.new(1, 0, 0, 38), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 8}, Container)
            Make("TextLabel", {
                Size = UDim2.new(1, -90, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = NameStr, ZIndex = 9
            }, HeaderBtn)

            local Swatch = Make("Frame", {
                Size = UDim2.new(0, 34, 0, 18), Position = UDim2.new(1, -46, 0.5, -9),
                BackgroundColor3 = CurColor, BorderSizePixel = 0, ZIndex = 9
            }, HeaderBtn)
            AddCorner(Swatch, 6); AddStroke(Swatch, Color3.fromRGB(255, 255, 255), 1, 0.65)

            local HexInput = Make("TextBox", {
                Size = UDim2.new(1, -24, 0, 24), Position = UDim2.new(0, 12, 0, 42),
                BackgroundColor3 = Theme.InputBg, BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Input,
                Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Theme.TextPrimary,
                Text = ColorToHex(CurColor), ClearTextOnFocus = false, ZIndex = 9
            }, Container)
            AddCorner(HexInput, 6); AddStroke(HexInput, Theme.Stroke, 1, 0.4)

            local ColorObj, ChannelBars = {Color = CurColor}, {}
            local function ApplyColor(NewCol, FireCb)
                CurColor = NewCol; ColorObj.Color = CurColor
                Swatch.BackgroundColor3 = CurColor; HexInput.Text = ColorToHex(CurColor)
                if ChannelBars.R then ChannelBars.R.Size = UDim2.new(CurColor.R, 0, 1, 0) end
                if ChannelBars.G then ChannelBars.G.Size = UDim2.new(CurColor.G, 0, 1, 0) end
                if ChannelBars.B then ChannelBars.B.Size = UDim2.new(CurColor.B, 0, 1, 0) end
                if FireCb and type(Opts.Callback) == "function" then task.spawn(Opts.Callback, CurColor) end
                Library:SaveConfiguration()
            end

            for _, Ch in ipairs({
                {Key = "R", Y = 72, Col = Color3.fromRGB(255, 80, 90)},
                {Key = "G", Y = 94, Col = Color3.fromRGB(60, 235, 130)},
                {Key = "B", Y = 116, Col = Color3.fromRGB(70, 165, 255)},
            }) do
                Make("TextLabel", {
                    Size = UDim2.new(0, 16, 0, 14), Position = UDim2.new(0, 12, 0, Ch.Y),
                    BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = Ch.Col, Text = Ch.Key, ZIndex = 9
                }, Container)
                local BarBg = Make("Frame", {
                    Size = UDim2.new(1, -44, 0, 8), Position = UDim2.new(0, 32, 0, Ch.Y + 3),
                    BackgroundColor3 = Theme.ToggleOff, BorderSizePixel = 0, ZIndex = 9
                }, Container)
                AddCorner(BarBg, 4)

                local InitPct = (Ch.Key == "R" and CurColor.R) or (Ch.Key == "G" and CurColor.G) or CurColor.B
                local BarFill = Make("Frame", {Size = UDim2.new(InitPct, 0, 1, 0), BackgroundColor3 = Ch.Col, BorderSizePixel = 0, ZIndex = 10}, BarBg)
                AddCorner(BarFill, 4); ChannelBars[Ch.Key] = BarFill

                local Hit = Make("TextButton", {Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 0.5, -10), BackgroundTransparency = 1, Text = "", ZIndex = 11}, BarBg)
                local DragC = false
                local function SetChannelX(PosX)
                    local Pct = math.clamp((PosX - BarBg.AbsolutePosition.X) / math.max(BarBg.AbsoluteSize.X, 1), 0, 1)
                    local r, g, b = CurColor.R, CurColor.G, CurColor.B
                    if Ch.Key == "R" then r = Pct elseif Ch.Key == "G" then g = Pct else b = Pct end
                    ApplyColor(Color3.new(r, g, b), true)
                end

                Hit.InputBegan:Connect(function(In)
                    if In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch then
                        DragC = true; TabPage.ScrollingEnabled = false; SetChannelX(In.Position.X)
                    end
                end)
                TrackConn(UserInputService.InputChanged:Connect(function(In)
                    if DragC and (In.UserInputType == Enum.UserInputType.MouseMovement or In.UserInputType == Enum.UserInputType.Touch) then
                        SetChannelX(In.Position.X)
                    end
                end))
                TrackConn(UserInputService.InputEnded:Connect(function(In)
                    if DragC and (In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch) then
                        DragC = false; TabPage.ScrollingEnabled = true
                    end
                end))
            end

            HexInput.FocusLost:Connect(function()
                local Parsed = ParseColorString(HexInput.Text)
                if Parsed then ApplyColor(Parsed, true) else HexInput.Text = ColorToHex(CurColor) end
            end)
            HeaderBtn.MouseButton1Click:Connect(function()
                PlayUISound("Click", 1.1); IsOpen = not IsOpen
                Tween(Container, 0.16, {Size = UDim2.new(1, 0, 0, IsOpen and 140 or 38)})
                Tween(Stroke, 0.16, {Color = IsOpen and Theme.Accent or Theme.Stroke})
            end)

            function ColorObj:Set(NewCol) if typeof(NewCol) == "Color3" then ApplyColor(NewCol, true) end end
            if FlagName then
                Library.Flags[FlagName] = ColorObj
                Internal.DefaultValues[FlagName] = CurColor
            end
            return ColorObj
        end

        return setmetatable(Tab, {
            __index = function() return function() return {Set = function() end, Refresh = function() end} end end
        }), TabPage
    end

    function Window:CreateTab(TabName, _Icon)
        local Tab = CreateTabInternal(TabName, nil, false)
        return Tab
    end

    function Window:ModifyTheme(ThemeIdentifier)
        if type(ThemeIdentifier) == "string" and ColorPresets[ThemeIdentifier] then
            SetThemePreset(ThemeIdentifier)
        end
    end

    -- ==========================================
    -- UNIVERSAL SMOOTH OVERLAY FEATURE REORDER ENGINE
    -- ==========================================
    do
        local DragOverlayLayer = Make("Frame", {
            Name = "LayoutDragOverlay",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ZIndex = 120
        }, ScreenGui)

        local TabItemsMap = {}      -- [TabRecord] = { Entry, ... }
        local TabKeyCounters = {}   -- [TabRecord] = { [BaseKey] = count }
        local TabOrderFlagObj = {CurrentValue = {}}

        local Drag = {
            Active = false,
            PendingEntry = nil,
            Entry = nil,
            InputObj = nil,
            HoldToken = 0,
            StartPos = nil,
            CurPos = nil,
            GrabOffsetY = 0,
            BaseCenterX = 0,
            CardW = 0,
            CardH = 0,
            CurScale = 1,
            GhostWrap = nil,
            GhostScale = nil,
            DropSlot = nil,
            MovedOrder = false,
        }

        local function ExtractStableKey(TabRecord, Card)
            local Base = "Element"
            local Lbl = Card:FindFirstChildWhichIsA("TextLabel", true)
            if Lbl and type(Lbl.Text) == "string" and #Lbl.Text > 0 then
                Base = string.sub(Lbl.Text, 1, 48)
            elseif Card.Name ~= "Frame" and Card.Name ~= "TextButton" then
                Base = Card.Name
            else
                Base = "Divider"
            end

            TabKeyCounters[TabRecord] = TabKeyCounters[TabRecord] or {}
            local Cnt = (TabKeyCounters[TabRecord][Base] or 0) + 1
            TabKeyCounters[TabRecord][Base] = Cnt
            return Base .. "#" .. tostring(Cnt)
        end

        local function ApplyOrderToTab(TabRecord)
            local List = TabItemsMap[TabRecord]
            if not List then return end

            local SavedKeys = Internal.SavedTabOrders[TabRecord.Name]
            if type(SavedKeys) == "table" and #SavedKeys > 0 then
                local Rank = {}
                for idx, k in ipairs(SavedKeys) do
                    Rank[tostring(k)] = idx
                end
                table.sort(List, function(a, b)
                    local ra = Rank[a.Key] or (10000 + a.DefaultOrder)
                    local rb = Rank[b.Key] or (10000 + b.DefaultOrder)
                    if ra ~= rb then return ra < rb end
                    return a.DefaultOrder < b.DefaultOrder
                end)
            else
                table.sort(List, function(a, b)
                    return a.DefaultOrder < b.DefaultOrder
                end)
            end

            for idx, Entry in ipairs(List) do
                if Entry.Card and Entry.Card.Parent then
                    Entry.Card.LayoutOrder = idx
                end
            end
        end

        local function SaveTabOrderNow(TabRecord)
            local List = TabItemsMap[TabRecord]
            if not List then return end
            local KeyArr = {}
            for _, Entry in ipairs(List) do
                table.insert(KeyArr, Entry.Key)
            end
            Internal.SavedTabOrders[TabRecord.Name] = KeyArr
            TabOrderFlagObj.CurrentValue = Internal.SavedTabOrders
            Library:SaveConfiguration(nil, true)
        end

        local function CleanupDragVisuals(SnapSmoothly)
            Internal.LayoutDragConn = SafeDisconnect(Internal.LayoutDragConn)

            local Entry = Drag.Entry
            local Ghost = Drag.GhostWrap
            local GScale = Drag.GhostScale
            local Slot = Drag.DropSlot
            local Moved = Drag.MovedOrder
            local OrigScale = Drag.CurScale

            Drag.Active = false
            Drag.Entry = nil
            Drag.PendingEntry = nil
            Drag.InputObj = nil
            Drag.GhostWrap = nil
            Drag.GhostScale = nil
            Drag.DropSlot = nil
            Drag.MovedOrder = false

            if Entry and Entry.TabRecord and Entry.TabRecord.Page then
                Entry.TabRecord.Page.ScrollingEnabled = true
            end

            local function Finalize()
                if Ghost and Ghost.Parent then Ghost:Destroy() end
                if Slot and Slot.Parent then Slot:Destroy() end
                if Entry and Entry.Card and Entry.Card.Parent then
                    Entry.Card.Visible = true
                end
                if Moved and Entry and Entry.TabRecord then
                    SaveTabOrderNow(Entry.TabRecord)
                    PlayUISound("Toggle", 1.15)
                end
            end

            if SnapSmoothly and Ghost and Ghost.Parent and Slot and Slot.Parent then
                local EndX = (Slot.AbsolutePosition.X - DragOverlayLayer.AbsolutePosition.X) + (Slot.AbsoluteSize.X * 0.5)
                local EndY = (Slot.AbsolutePosition.Y - DragOverlayLayer.AbsolutePosition.Y) + (Slot.AbsoluteSize.Y * 0.5)

                local SnapTween = TweenService:Create(Ghost, TweenInfo.new(0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Position = UDim2.fromOffset(EndX, EndY)
                })
                if GScale and GScale.Parent then
                    TweenService:Create(GScale, TweenInfo.new(0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Scale = OrigScale
                    }):Play()
                end
                SnapTween:Play()

                local Done = false
                SnapTween.Completed:Connect(function()
                    if not Done then Done = true; Finalize() end
                end)
                task.delay(0.18, function()
                    if not Done then Done = true; Finalize() end
                end)
            else
                Finalize()
            end
        end

        local function StartSmoothOverlayDrag(Entry, PointerPos)
            if Drag.Active or not LooksState.EditLayoutMode then return end
            if not Entry.Card or not Entry.Card.Parent then return end

            local Page = Entry.TabRecord.Page
            local CurScale = math.max(MainUIScale.Scale, 0.5)
            local AbsPos = Entry.Card.AbsolutePosition
            local AbsSz = Entry.Card.AbsoluteSize

            Drag.Active = true
            Drag.Entry = Entry
            Drag.CurPos = PointerPos
            Drag.GrabOffsetY = PointerPos.Y - AbsPos.Y
            Drag.BaseCenterX = (AbsPos.X - DragOverlayLayer.AbsolutePosition.X) + (AbsSz.X * 0.5)
            Drag.CardW = AbsSz.X
            Drag.CardH = AbsSz.Y
            Drag.CurScale = CurScale
            Drag.MovedOrder = false

            Page.ScrollingEnabled = false
            PlayUISound("Open", 1.22)

            -- 1. Glowing Drop Slot Placeholder inside TabPage
            local Slot = Instance.new("Frame")
            Slot.Name = "__SidDropSlot"
            Slot.Size = Entry.Card.Size
            Slot.LayoutOrder = Entry.Card.LayoutOrder
            Slot.BackgroundColor3 = Theme.AccentSecondary
            Slot.BackgroundTransparency = 0.86
            Slot.BorderSizePixel = 0
            Slot.ZIndex = 6
            Slot.Parent = Page

            local SlotCorner = Instance.new("UICorner")
            SlotCorner.CornerRadius = UDim.new(0, math.floor((LooksState.CornerRadius or 18) * 0.5))
            SlotCorner.Parent = Slot

            local SlotStroke = Instance.new("UIStroke")
            SlotStroke.Color = Theme.AccentSecondary
            SlotStroke.Thickness = 1.5
            SlotStroke.Transparency = 0.22
            SlotStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            SlotStroke.Parent = Slot

            Drag.DropSlot = Slot

            -- 2. Floating Smooth Overlay Ghost Card (Renders Above Entire UI)
            local InitCenterY = (AbsPos.Y - DragOverlayLayer.AbsolutePosition.Y) + (AbsSz.Y * 0.5)
            local GhostWrap = Instance.new("Frame")
            GhostWrap.Name = "FloatingDragGhost"
            GhostWrap.Size = UDim2.fromOffset(AbsSz.X / CurScale, AbsSz.Y / CurScale)
            GhostWrap.Position = UDim2.fromOffset(Drag.BaseCenterX, InitCenterY)
            GhostWrap.AnchorPoint = Vector2.new(0.5, 0.5)
            GhostWrap.BackgroundTransparency = 1
            GhostWrap.ZIndex = 121
            GhostWrap.Parent = DragOverlayLayer

            local GhostScale = Instance.new("UIScale")
            GhostScale.Scale = CurScale
            GhostScale.Parent = GhostWrap

            -- Soft Drop Shadow behind Lifted Card
            local Shadow = Instance.new("Frame")
            Shadow.Size = UDim2.new(1, 8, 1, 8)
            Shadow.Position = UDim2.new(0.5, 0, 0.5, 6)
            Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
            Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Shadow.BackgroundTransparency = 0.48
            Shadow.BorderSizePixel = 0
            Shadow.ZIndex = 1
            Shadow.Parent = GhostWrap

            local ShCorner = Instance.new("UICorner")
            ShCorner.CornerRadius = UDim.new(0, 12)
            ShCorner.Parent = Shadow

            -- Backing for transparent Section / Divider elements so they look crisp when lifted
            if Entry.Card.BackgroundTransparency >= 0.85 then
                local Backing = Instance.new("Frame")
                Backing.Size = UDim2.new(1, 0, 1, 0)
                Backing.BackgroundColor3 = Theme.CardBg
                Backing.BackgroundTransparency = 0.14
                Backing.BorderSizePixel = 0
                Backing.ZIndex = 2
                Backing.Parent = GhostWrap
                local BkC = Instance.new("UICorner")
                BkC.CornerRadius = UDim.new(0, 9)
                BkC.Parent = Backing
            end

            -- Visual Clone of the Real Card
            local CloneCard = Entry.Card:Clone()
            CloneCard.Name = "GhostVisual"
            CloneCard.Size = UDim2.new(1, 0, 1, 0)
            CloneCard.Position = UDim2.new(0, 0, 0, 0)
            CloneCard.AnchorPoint = Vector2.new(0, 0)
            CloneCard.Visible = true
            CloneCard.ZIndex = 3
            local OldCov = CloneCard:FindFirstChild("__SidDragCover")
            if OldCov then OldCov:Destroy() end
            CloneCard.Parent = GhostWrap

            -- Crisp Glowing Cyan Lift Border
            local GlowRing = Instance.new("Frame")
            GlowRing.Size = UDim2.new(1, 0, 1, 0)
            GlowRing.BackgroundTransparency = 1
            GlowRing.ZIndex = 4
            GlowRing.Parent = GhostWrap

            local GrCorner = Instance.new("UICorner")
            GrCorner.CornerRadius = UDim.new(0, math.floor((LooksState.CornerRadius or 18) * 0.5))
            GrCorner.Parent = GlowRing

            local GrStroke = Instance.new("UIStroke")
            GrStroke.Color = Theme.AccentSecondary
            GrStroke.Thickness = 2
            GrStroke.Transparency = 0.05
            GrStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            GrStroke.Parent = GlowRing

            Drag.GhostWrap = GhostWrap
            Drag.GhostScale = GhostScale

            -- Hide original while lifted & animate lift pop
            Entry.Card.Visible = false
            TweenService:Create(GhostScale, TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = CurScale * 1.045
            }):Play()

            -- 3. Silky-Smooth 60fps Overlay Follow + Edge Auto-Scroll + Live Swap Loop
            Internal.LayoutDragConn = SafeDisconnect(Internal.LayoutDragConn)
            Internal.LayoutDragConn = RunService.RenderStepped:Connect(function(dt)
                if not Drag.Active or not Drag.GhostWrap or not Drag.DropSlot then
                    CleanupDragVisuals(false)
                    return
                end
                dt = math.min(dt, 0.05)

                local Ptr = Drag.CurPos
                local LayerTop = DragOverlayLayer.AbsolutePosition.Y
                local PageTop = Page.AbsolutePosition.Y
                local PageBot = PageTop + Page.AbsoluteSize.Y

                -- Smoothly glide floating overlay card to finger with subtle X sway
                local RawTargetY = (Ptr.Y - Drag.GrabOffsetY - LayerTop) + (Drag.CardH * 0.5)
                local MinY = (PageTop - LayerTop) + (Drag.CardH * 0.25)
                local MaxY = (PageBot - LayerTop) - (Drag.CardH * 0.25)
                local TargetY = math.clamp(RawTargetY, MinY, MaxY)
                local SwayX = Drag.BaseCenterX + math.clamp((Ptr.X - Drag.StartPos.X) * 0.10, -10, 10)

                local Alpha = 1 - math.exp(-dt * 26)
                Drag.GhostWrap.Position = Drag.GhostWrap.Position:Lerp(UDim2.fromOffset(SwayX, TargetY), Alpha)

                -- Smooth auto-scroll near top / bottom edges of TabPage
                if Ptr.Y < PageTop + 36 then
                    local Ratio = math.clamp((PageTop + 36 - Ptr.Y) / 36, 0.25, 1)
                    Page.CanvasPosition = Vector2.new(0, math.max(0, Page.CanvasPosition.Y - (Ratio * 300 * dt)))
                elseif Ptr.Y > PageBot - 36 then
                    local Ratio = math.clamp((Ptr.Y - (PageBot - 36)) / 36, 0.25, 1)
                    local MaxCanvas = math.max(0, Page.CanvasSize.Y.Offset - Page.AbsoluteSize.Y)
                    Page.CanvasPosition = Vector2.new(0, math.min(MaxCanvas, Page.CanvasPosition.Y + (Ratio * 300 * dt)))
                end

                -- Real-time Slot Swap based on Ghost center
                local GhostScreenMidY = Drag.GhostWrap.AbsolutePosition.Y + (Drag.GhostWrap.AbsoluteSize.Y * 0.5)
                local List = TabItemsMap[Entry.TabRecord]
                local CurIdx = List and table.find(List, Entry)
                if not CurIdx then return end

                if CurIdx > 1 then
                    local Above = List[CurIdx - 1]
                    if Above and Above.Card and Above.Card.Parent and Above.Card.Visible then
                        local AboveMidY = Above.Card.AbsolutePosition.Y + (Above.Card.AbsoluteSize.Y * 0.5)
                        if GhostScreenMidY < AboveMidY then
                            List[CurIdx], List[CurIdx - 1] = List[CurIdx - 1], List[CurIdx]
                            Above.Card.LayoutOrder = CurIdx
                            Entry.Card.LayoutOrder = CurIdx - 1
                            Drag.DropSlot.LayoutOrder = CurIdx - 1
                            Drag.MovedOrder = true
                            PlayUISound("Click", 1.26)
                            return
                        end
                    end
                end

                if CurIdx < #List then
                    local Below = List[CurIdx + 1]
                    if Below and Below.Card and Below.Card.Parent and Below.Card.Visible then
                        local BelowMidY = Below.Card.AbsolutePosition.Y + (Below.Card.AbsoluteSize.Y * 0.5)
                        if GhostScreenMidY > BelowMidY then
                            List[CurIdx], List[CurIdx + 1] = List[CurIdx + 1], List[CurIdx]
                            Below.Card.LayoutOrder = CurIdx
                            Entry.Card.LayoutOrder = CurIdx + 1
                            Drag.DropSlot.LayoutOrder = CurIdx + 1
                            Drag.MovedOrder = true
                            PlayUISound("Click", 1.10)
                            return
                        end
                    end
                end
            end)
        end

        -- Shared Global Input Trackers (Zero Memory Leak)
        TrackConn(UserInputService.InputChanged:Connect(function(In)
            if not Drag.PendingEntry and not Drag.Active then return end
            if In ~= Drag.InputObj and In.UserInputType ~= Enum.UserInputType.MouseMovement then return end

            if Drag.Active then
                Drag.CurPos = In.Position
            elseif Drag.PendingEntry and Drag.StartPos then
                -- If user swipes before 0.18s hold completes, cancel hold so normal scrolling works!
                if (In.Position - Drag.StartPos).Magnitude > 9 then
                    Drag.HoldToken = Drag.HoldToken + 1
                    Drag.PendingEntry = nil
                    Drag.InputObj = nil
                end
            end
        end))

        TrackConn(UserInputService.InputEnded:Connect(function(In)
            if not Drag.PendingEntry and not Drag.Active then return end
            if In ~= Drag.InputObj
                and In.UserInputType ~= Enum.UserInputType.MouseButton1
                and In.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            Drag.HoldToken = Drag.HoldToken + 1
            if Drag.Active then
                CleanupDragVisuals(true)
            else
                Drag.PendingEntry = nil
                Drag.InputObj = nil
            end
        end))

        -- Attach Optional Reorder Overlay Cover to Each User-Tab Card
        Internal.RegisterReorderCardFn = function(TabRecord, Card)
            if not TabRecord or not Card or Card:FindFirstChild("__SidDragCover") then return end

            TabItemsMap[TabRecord] = TabItemsMap[TabRecord] or {}
            local List = TabItemsMap[TabRecord]
            local DefaultIdx = #List + 1
            local StableKey = ExtractStableKey(TabRecord, Card)

            local IsSmall = (Card.Size.Y.Offset > 0 and Card.Size.Y.Offset < 24)

            -- Invisible overlay cover (ONLY active when Edit Layout Mode is ON!)
            local Cover = Instance.new("TextButton")
            Cover.Name = "__SidDragCover"
            Cover.Size = UDim2.new(1, 0, 1, 0)
            Cover.BackgroundColor3 = Theme.AccentSecondary
            Cover.BackgroundTransparency = 0.94
            Cover.Text = ""
            Cover.AutoButtonColor = false
            Cover.Visible = LooksState.EditLayoutMode
            Cover.ZIndex = 25
            Cover.Parent = Card

            local CovCorner = Instance.new("UICorner")
            CovCorner.CornerRadius = UDim.new(0, 9)
            CovCorner.Parent = Cover

            local CovStroke = Instance.new("UIStroke")
            CovStroke.Color = Theme.AccentSecondary
            CovStroke.Thickness = 1
            CovStroke.Transparency = 0.55
            CovStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            CovStroke.Parent = Cover

            -- Right-Side Instant Grab Pill (Tap & Slide Immediately!)
            local GripBtn = Instance.new("TextButton")
            GripBtn.Name = "GrabHandle"
            GripBtn.Size = IsSmall and UDim2.new(0, 44, 0, 14) or UDim2.new(0, 52, 0, 22)
            GripBtn.Position = IsSmall and UDim2.new(1, -48, 0.5, -7) or UDim2.new(1, -58, 0.5, -11)
            GripBtn.BackgroundColor3 = Color3.fromRGB(16, 20, 32)
            GripBtn.BackgroundTransparency = 0.12
            GripBtn.Font = Enum.Font.GothamBold
            GripBtn.TextSize = IsSmall and 8 or 10
            GripBtn.TextColor3 = Theme.AccentSecondary
            GripBtn.Text = "≡ MOVE"
            GripBtn.AutoButtonColor = false
            GripBtn.ZIndex = 26
            GripBtn.Parent = Cover

            local GCorner = Instance.new("UICorner")
            GCorner.CornerRadius = UDim.new(0, 6)
            GCorner.Parent = GripBtn

            local GStroke = Instance.new("UIStroke")
            GStroke.Color = Theme.AccentSecondary
            GStroke.Thickness = 1
            GStroke.Transparency = 0.25
            GStroke.Parent = GripBtn

            local Entry = {
                Key = StableKey,
                Card = Card,
                TabRecord = TabRecord,
                DefaultOrder = DefaultIdx,
                Cover = Cover,
            }
            table.insert(List, Entry)

            -- Instant Lift when grabbing the "≡ MOVE" handle
            GripBtn.InputBegan:Connect(function(In)
                if not LooksState.EditLayoutMode then return end
                if In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch then
                    Drag.HoldToken = Drag.HoldToken + 1
                    Drag.InputObj = In
                    Drag.StartPos = In.Position
                    Drag.PendingEntry = nil
                    StartSmoothOverlayDrag(Entry, In.Position)
                end
            end)

            -- Quick 0.18s Hold anywhere on the card body (allows normal scrolling if swiped!)
            Cover.InputBegan:Connect(function(In)
                if not LooksState.EditLayoutMode or Drag.Active then return end
                if In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch then
                    Drag.HoldToken = Drag.HoldToken + 1
                    local MyToken = Drag.HoldToken
                    Drag.InputObj = In
                    Drag.StartPos = In.Position
                    Drag.PendingEntry = Entry

                    task.delay(0.18, function()
                        if Drag.HoldToken == MyToken and Drag.PendingEntry == Entry and LooksState.EditLayoutMode then
                            Drag.PendingEntry = nil
                            StartSmoothOverlayDrag(Entry, Drag.StartPos)
                        end
                    end)
                end
            end)

            ApplyOrderToTab(TabRecord)
        end

        Internal.SetLayoutEditModeFn = function(Enabled)
            LooksState.EditLayoutMode = (Enabled == true)
            if not LooksState.EditLayoutMode and Drag.Active then
                CleanupDragVisuals(false)
            end
            for _, List in pairs(TabItemsMap) do
                for _, Entry in ipairs(List) do
                    if Entry.Cover and Entry.Cover.Parent then
                        Entry.Cover.Visible = LooksState.EditLayoutMode
                    end
                end
            end
        end

        Internal.ResetTabOrdersFn = function()
            if Drag.Active then CleanupDragVisuals(false) end
            table.clear(Internal.SavedTabOrders)
            TabOrderFlagObj.CurrentValue = {}
            for TabRecord in pairs(TabItemsMap) do
                ApplyOrderToTab(TabRecord)
            end
            Library:SaveConfiguration(nil, true)
        end

        -- Persist Custom Tab Feature Orders Automatically in SavedConfig.json
        function TabOrderFlagObj:Set(SavedMap)
            table.clear(Internal.SavedTabOrders)
            if type(SavedMap) == "table" then
                for TabName, KeyList in pairs(SavedMap) do
                    if type(KeyList) == "table" then
                        Internal.SavedTabOrders[tostring(TabName)] = KeyList
                    end
                end
            end
            TabOrderFlagObj.CurrentValue = Internal.SavedTabOrders
            for TabRecord in pairs(TabItemsMap) do
                ApplyOrderToTab(TabRecord)
            end
        end
        Library.Flags["SidUI_CustomTabOrder"] = TabOrderFlagObj
        Internal.DefaultValues["SidUI_CustomTabOrder"] = {}
    end


     -- ==========================================
    -- PATCH 3: ⭐ PINNED TAB (HOLD-TO-REORDER) + FLOATING QUICK-TOGGLES
    -- ==========================================
    local _, PinnedPage = CreateTabInternal("⭐ Pinned", 0, true)

    local FloatingHolder = Make("Frame", {
        Name = "FloatingQuickButtonsHolder",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ZIndex = 55
    }, ScreenGui)

    local PinnedMirrorUpdaters = {}
    local PinnedCardList = {}
    local PinnedFlagObj = {CurrentValue = {}}

    local DragState = {
        Active = false,
        Item = nil,
        InputObj = nil,
        HoldToken = 0,
        StartPos = nil,
        PendingItem = nil,
        MovedOrder = false,
        LastDragEnd = 0,
    }

    local function SwapPinnedOrder(IdxA, IdxB)
        local ItemA = PinnedCardList[IdxA]
        local ItemB = PinnedCardList[IdxB]
        if not ItemA or not ItemB then return end

        -- Swap in UI card list & update LayoutOrder live
        PinnedCardList[IdxA] = ItemB
        PinnedCardList[IdxB] = ItemA
        ItemA.Card.LayoutOrder = IdxB
        ItemB.Card.LayoutOrder = IdxA

        -- Swap in Internal.PinnedKeys for config persistence
        local KeyIdxA = table.find(Internal.PinnedKeys, ItemA.Key)
        local KeyIdxB = table.find(Internal.PinnedKeys, ItemB.Key)
        if KeyIdxA and KeyIdxB then
            Internal.PinnedKeys[KeyIdxA], Internal.PinnedKeys[KeyIdxB] = Internal.PinnedKeys[KeyIdxB], Internal.PinnedKeys[KeyIdxA]
        end

        DragState.MovedOrder = true
    end

    -- Single shared drag controller (zero memory leak across rebuilds)
    TrackConn(UserInputService.InputChanged:Connect(function(In)
        if not DragState.PendingItem and not DragState.Active then return end
        if In ~= DragState.InputObj and In.UserInputType ~= Enum.UserInputType.MouseMovement then return end

        -- Cancel hold if user drags finger before 0.30s (allows normal scrolling)
        if not DragState.Active and DragState.PendingItem and DragState.StartPos then
            if (In.Position - DragState.StartPos).Magnitude > 10 then
                DragState.HoldToken = DragState.HoldToken + 1
                DragState.PendingItem = nil
                DragState.InputObj = nil
            end
            return
        end

        if DragState.Active and DragState.Item then
            local CurY = In.Position.Y
            local CurIdx = table.find(PinnedCardList, DragState.Item)
            if not CurIdx then return end

            -- Auto-scroll PinnedPage near top/bottom edges
            local PageTop = PinnedPage.AbsolutePosition.Y
            local PageBot = PageTop + PinnedPage.AbsoluteSize.Y
            if CurY < PageTop + 26 then
                PinnedPage.CanvasPosition = Vector2.new(0, math.max(0, PinnedPage.CanvasPosition.Y - 12))
            elseif CurY > PageBot - 26 then
                PinnedPage.CanvasPosition = Vector2.new(0, PinnedPage.CanvasPosition.Y + 12)
            end

            -- Swap UP
            if CurIdx > 1 then
                local Above = PinnedCardList[CurIdx - 1]
                if Above and Above.Card and Above.Card.Parent then
                    local AboveCenterY = Above.Card.AbsolutePosition.Y + (Above.Card.AbsoluteSize.Y * 0.5)
                    if CurY < AboveCenterY then
                        SwapPinnedOrder(CurIdx, CurIdx - 1)
                        PlayUISound("Click", 1.28)
                        return
                    end
                end
            end

            -- Swap DOWN
            if CurIdx < #PinnedCardList then
                local Below = PinnedCardList[CurIdx + 1]
                if Below and Below.Card and Below.Card.Parent then
                    local BelowCenterY = Below.Card.AbsolutePosition.Y + (Below.Card.AbsoluteSize.Y * 0.5)
                    if CurY > BelowCenterY then
                        SwapPinnedOrder(CurIdx, CurIdx + 1)
                        PlayUISound("Click", 1.12)
                        return
                    end
                end
            end
        end
    end))

    TrackConn(UserInputService.InputEnded:Connect(function(In)
        if not DragState.PendingItem and not DragState.Active then return end
        if In ~= DragState.InputObj
            and In.UserInputType ~= Enum.UserInputType.MouseButton1
            and In.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        DragState.HoldToken = DragState.HoldToken + 1

        if DragState.Active and DragState.Item then
            local Grabbed = DragState.Item
            if Grabbed.Card and Grabbed.Card.Parent then
                Grabbed.Card.ZIndex = 7
                Tween(Grabbed.Card, 0.14, {BackgroundColor3 = Theme.CardBg})
            end
            if Grabbed.Stroke and Grabbed.Stroke.Parent then
                Grabbed.Stroke.Thickness = 1
                if Grabbed.RestoreStrokeFn then Grabbed.RestoreStrokeFn() end
            end
            if Grabbed.Grip and Grabbed.Grip.Parent then
                Grabbed.Grip.TextColor3 = Theme.TextMuted
            end

            PinnedPage.ScrollingEnabled = true
            DragState.LastDragEnd = os.clock()

            if DragState.MovedOrder then
                PinnedFlagObj.CurrentValue = Internal.PinnedKeys
                Library:SaveConfiguration(nil, true)
                PlayUISound("Toggle", 1.15)
            end
        end

        DragState.Active = false
        DragState.Item = nil
        DragState.PendingItem = nil
        DragState.InputObj = nil
        DragState.MovedOrder = false
    end))

    local function AttachHoldReorder(CardEntry)
        CardEntry.Card.InputBegan:Connect(function(In)
            if In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch then
                DragState.HoldToken = DragState.HoldToken + 1
                local MyToken = DragState.HoldToken
                DragState.InputObj = In
                DragState.StartPos = In.Position
                DragState.PendingItem = CardEntry
                DragState.MovedOrder = false

                task.delay(0.30, function()
                    if DragState.HoldToken == MyToken and DragState.PendingItem == CardEntry
                        and CardEntry.Card and CardEntry.Card.Parent then
                        DragState.Active = true
                        DragState.Item = CardEntry
                        PinnedPage.ScrollingEnabled = false
                        PlayUISound("Open", 1.25)

                        CardEntry.Card.ZIndex = 12
                        Tween(CardEntry.Card, 0.10, {BackgroundColor3 = Theme.CardHover})
                        if CardEntry.Stroke then
                            CardEntry.Stroke.Color = Theme.AccentSecondary
                            CardEntry.Stroke.Thickness = 2
                        end
                        if CardEntry.Grip then
                            CardEntry.Grip.TextColor3 = Theme.AccentSecondary
                        end
                    end
                end)
            end
        end)
    end

    local function RebuildPinnedPage()
        DragState.HoldToken = DragState.HoldToken + 1
        DragState.Active = false
        DragState.Item = nil
        DragState.PendingItem = nil
        PinnedPage.ScrollingEnabled = true

        for _, Child in ipairs(PinnedPage:GetChildren()) do
            if Child:IsA("GuiObject") then Child:Destroy() end
        end
        table.clear(PinnedMirrorUpdaters)
        table.clear(PinnedCardList)

        local Count = 0
        for _, KeyName in ipairs(Internal.PinnedKeys) do
            local Entry = Internal.PinnableRegistry[KeyName]
            if Entry then
                Count = Count + 1

                if Entry.Kind == "Toggle" then
                    local State = Entry.GetState()
                    local Card = Make("TextButton", {
                        Size = UDim2.new(1, 0, 0, 36),
                        LayoutOrder = Count,
                        BackgroundColor3 = Theme.CardBg,
                        BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card,
                        Text = "", AutoButtonColor = false, ZIndex = 7
                    }, PinnedPage)
                    AddCorner(Card, 9)
                    local Stroke = AddStroke(Card, State and Theme.Accent or Theme.Stroke, 1, 0.35)
                    table.insert(Registry.Cards, Card)

                    local Grip = Make("TextLabel", {
                        Size = UDim2.new(0, 14, 1, 0), Position = UDim2.new(0, 6, 0, 0), BackgroundTransparency = 1,
                        Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Theme.TextMuted,
                        Text = "≡", ZIndex = 8
                    }, Card)

                    Make("TextLabel", {
                        Size = UDim2.new(1, -114, 1, 0), Position = UDim2.new(0, 22, 0, 0), BackgroundTransparency = 1,
                        Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
                        Text = Entry.Name, ZIndex = 8
                    }, Card)

                    local UnpinBtn = Make("TextButton", {
                        Size = UDim2.new(0, 26, 0, 18), Position = UDim2.new(1, -84, 0.5, -9),
                        BackgroundColor3 = Color3.fromRGB(55, 24, 32), Font = Enum.Font.GothamBold,
                        TextSize = 9, TextColor3 = Theme.Danger, Text = "DEL", AutoButtonColor = false, ZIndex = 9
                    }, Card)
                    AddCorner(UnpinBtn, 5)

                    local SwitchBg = Make("Frame", {
                        Size = UDim2.new(0, 40, 0, 20), Position = UDim2.new(1, -50, 0.5, -10),
                        BackgroundColor3 = State and Theme.Accent or Theme.ToggleOff, BorderSizePixel = 0, ZIndex = 8
                    }, Card)
                    AddCorner(SwitchBg, 10)

                    local Knob = Make("Frame", {
                        Size = UDim2.new(0, 14, 0, 14),
                        Position = State and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ZIndex = 9
                    }, SwitchBg)
                    AddCorner(Knob, 7)

                    PinnedMirrorUpdaters[KeyName] = function(NewVal)
                        Tween(SwitchBg, 0.14, {BackgroundColor3 = NewVal and Theme.Accent or Theme.ToggleOff})
                        Tween(Knob, 0.14, {Position = NewVal and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)})
                        if not (DragState.Active and DragState.Item and DragState.Item.Key == KeyName) then
                            Tween(Stroke, 0.14, {Color = NewVal and Theme.Accent or Theme.Stroke})
                        end
                    end

                    local CardEntry = {
                        Key = KeyName,
                        Card = Card,
                        Stroke = Stroke,
                        Grip = Grip,
                        RestoreStrokeFn = function()
                            Stroke.Color = Entry.GetState() and Theme.Accent or Theme.Stroke
                        end
                    }
                    table.insert(PinnedCardList, CardEntry)
                    AttachHoldReorder(CardEntry)

                    Card.MouseButton1Click:Connect(function()
                        if DragState.Active or (os.clock() - DragState.LastDragEnd < 0.28) then return end
                        PlayUISound("Toggle", Entry.GetState() and 0.95 or 1.2)
                        Entry.Toggle()
                    end)
                    UnpinBtn.MouseButton1Click:Connect(function()
                        DragState.HoldToken = DragState.HoldToken + 1
                        DragState.PendingItem = nil
                        PlayUISound("Click", 0.9)
                        Internal.TogglePinItemFn(KeyName)
                    end)

                elseif Entry.Kind == "Button" then
                    local Btn = Make("TextButton", {
                        Size = UDim2.new(1, 0, 0, 34),
                        LayoutOrder = Count,
                        BackgroundColor3 = Theme.CardBg,
                        BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card,
                        Text = "", AutoButtonColor = false, ZIndex = 7
                    }, PinnedPage)
                    AddCorner(Btn, 9)
                    local Stroke = AddStroke(Btn, Theme.Stroke, 1, 0.35)
                    table.insert(Registry.Cards, Btn)

                    local Grip = Make("TextLabel", {
                        Size = UDim2.new(0, 14, 1, 0), Position = UDim2.new(0, 6, 0, 0), BackgroundTransparency = 1,
                        Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Theme.TextMuted,
                        Text = "≡", ZIndex = 8
                    }, Btn)

                    Make("TextLabel", {
                        Size = UDim2.new(1, -106, 1, 0), Position = UDim2.new(0, 22, 0, 0), BackgroundTransparency = 1,
                        Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.TextPrimary,
                        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
                        Text = Entry.Name, ZIndex = 8
                    }, Btn)

                    local UnpinBtn = Make("TextButton", {
                        Size = UDim2.new(0, 26, 0, 18), Position = UDim2.new(1, -80, 0.5, -9),
                        BackgroundColor3 = Color3.fromRGB(55, 24, 32), Font = Enum.Font.GothamBold,
                        TextSize = 9, TextColor3 = Theme.Danger, Text = "DEL", AutoButtonColor = false, ZIndex = 9
                    }, Btn)
                    AddCorner(UnpinBtn, 5)

                    local RunTag = Make("TextLabel", {
                        Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -46, 0.5, -9),
                        BackgroundColor3 = Theme.Accent, BackgroundTransparency = 0.78,
                        Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = Theme.AccentSecondary, Text = "RUN", ZIndex = 8
                    }, Btn)
                    AddCorner(RunTag, 6)

                    local CardEntry = {
                        Key = KeyName,
                        Card = Btn,
                        Stroke = Stroke,
                        Grip = Grip,
                        RestoreStrokeFn = function()
                            Stroke.Color = Theme.Stroke
                        end
                    }
                    table.insert(PinnedCardList, CardEntry)
                    AttachHoldReorder(CardEntry)

                    Btn.Activated:Connect(function()
                        if DragState.Active or (os.clock() - DragState.LastDragEnd < 0.28) then return end
                        Entry.Fire()
                    end)
                    UnpinBtn.MouseButton1Click:Connect(function()
                        DragState.HoldToken = DragState.HoldToken + 1
                        DragState.PendingItem = nil
                        PlayUISound("Click", 0.9)
                        Internal.TogglePinItemFn(KeyName)
                    end)
                end
            end
        end

        if Count == 0 then
            local Empty = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 66), BackgroundColor3 = Theme.CardBg,
                BackgroundTransparency = GetSurfaceSpec(LooksState.SurfaceMode).Card, ZIndex = 7
            }, PinnedPage)
            AddCorner(Empty, 9); AddStroke(Empty, Theme.Stroke, 1, 0.45)
            Make("TextLabel", {
                Size = UDim2.new(1, -20, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = Theme.TextMuted, TextWrapped = true,
                Text = "Koi feature pinned nahi hai.\nKisi bhi Toggle ya Button par 'PIN' tap karo — aur Pinned tab me 0.3s hold karke upar/neeche set karo!", ZIndex = 8
            }, Empty)
        end
    end

    -- Persist Pinned Items & Custom Order in Config Automatically
    function PinnedFlagObj:Set(SavedList)
        table.clear(Internal.PinnedKeys)
        if type(SavedList) == "table" then
            for _, k in ipairs(SavedList) do
                table.insert(Internal.PinnedKeys, tostring(k))
            end
        end
        PinnedFlagObj.CurrentValue = Internal.PinnedKeys
        for KeyName, Entry in pairs(Internal.PinnableRegistry) do
            if Entry.UpdatePinVisual then
                Entry.UpdatePinVisual(table.find(Internal.PinnedKeys, KeyName) ~= nil)
            end
        end
        RebuildPinnedPage()
    end
    Library.Flags["SidUI_PinnedItems"] = PinnedFlagObj
    Internal.DefaultValues["SidUI_PinnedItems"] = {}

    Internal.TogglePinItemFn = function(KeyName)
        local Idx = table.find(Internal.PinnedKeys, KeyName)
        local NowPinned = false
        if Idx then
            table.remove(Internal.PinnedKeys, Idx)
            NowPinned = false
        else
            table.insert(Internal.PinnedKeys, KeyName)
            NowPinned = true
        end
        PinnedFlagObj.CurrentValue = Internal.PinnedKeys
        local Entry = Internal.PinnableRegistry[KeyName]
        if Entry and Entry.UpdatePinVisual then Entry.UpdatePinVisual(NowPinned) end
        RebuildPinnedPage()
        Library:SaveConfiguration()
    end

    -- Floating Quick-Toggle Shortcut Spawner (Draggable On-Screen Pill)
    Internal.ToggleFloatingBtnFn = function(KeyName)
        local Existing = Internal.FloatingButtons[KeyName]
        if Existing then
            if Existing.Frame and Existing.Frame.Parent then Existing.Frame:Destroy() end
            Internal.FloatingButtons[KeyName] = nil
            local Entry = Internal.PinnableRegistry[KeyName]
            if Entry and Entry.UpdateFloatVisual then Entry.UpdateFloatVisual(false) end
            return
        end

        local Entry = Internal.PinnableRegistry[KeyName]
        if not Entry or Entry.Kind ~= "Toggle" then return end

        local ActiveCount = 0
        for _ in pairs(Internal.FloatingButtons) do ActiveCount = ActiveCount + 1 end

        local State = Entry.GetState()
        local FloatBtn = Make("Frame", {
            Name = "Float_" .. KeyName,
            Size = UDim2.new(0, 114, 0, 32),
            Position = UDim2.new(0, 18, 0.25, ActiveCount * 38),
            BackgroundColor3 = Color3.fromRGB(14, 17, 26),
            BackgroundTransparency = 0.20,
            ZIndex = 56
        }, FloatingHolder)
        AddCorner(FloatBtn, 16)
        local FStroke = AddStroke(FloatBtn, State and Theme.Success or Theme.Stroke, 1.3, 0.20)

        local Dot = Make("Frame", {
            Size = UDim2.new(0, 8, 0, 8), Position = UDim2.new(0, 10, 0.5, -4),
            BackgroundColor3 = State and Theme.Success or Theme.TextMuted, BorderSizePixel = 0, ZIndex = 57
        }, FloatBtn)
        AddCorner(Dot, 8)

        Make("TextLabel", {
            Size = UDim2.new(1, -42, 1, 0), Position = UDim2.new(0, 23, 0, 0), BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = Theme.TextPrimary,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
            Text = Entry.Name, ZIndex = 57
        }, FloatBtn)

        local RemoveMini = Make("TextButton", {
            Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(1, -22, 0.5, -9),
            BackgroundColor3 = Color3.fromRGB(50, 22, 30), Font = Enum.Font.GothamBold,
            TextSize = 9, TextColor3 = Theme.Danger, Text = "x", AutoButtonColor = false, ZIndex = 58
        }, FloatBtn)
        AddCorner(RemoveMini, 9)

        RemoveMini.MouseButton1Click:Connect(function()
            PlayUISound("Click", 0.9)
            Internal.ToggleFloatingBtnFn(KeyName)
        end)

        -- Draggable + Tap to Toggle (drag >= 10px moves, tap < 10px toggles!)
        local Dragging, ActiveIn, StartPos, FrameStart, Moved = false, nil, nil, nil, 0
        FloatBtn.InputBegan:Connect(function(In)
            if In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch then
                Dragging = true; ActiveIn = In; StartPos = In.Position; FrameStart = FloatBtn.Position; Moved = 0
            end
        end)
        TrackConn(UserInputService.InputChanged:Connect(function(In)
            if Dragging and (In == ActiveIn or In.UserInputType == Enum.UserInputType.MouseMovement) then
                local Delta = In.Position - StartPos
                Moved = Delta.Magnitude
                FloatBtn.Position = UDim2.new(FrameStart.X.Scale, FrameStart.X.Offset + Delta.X, FrameStart.Y.Scale, FrameStart.Y.Offset + Delta.Y)
            end
        end))
        TrackConn(UserInputService.InputEnded:Connect(function(In)
            if Dragging and (In == ActiveIn or In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch) then
                Dragging = false; ActiveIn = nil
                if Moved < 10 then
                    PlayUISound("Toggle", Entry.GetState() and 0.95 or 1.2)
                    Entry.Toggle()
                end
            end
        end))

        Internal.FloatingButtons[KeyName] = {
            Frame = FloatBtn,
            UpdateVisual = function(NewVal)
                Dot.BackgroundColor3 = NewVal and Theme.Success or Theme.TextMuted
                FStroke.Color = NewVal and Theme.Success or Theme.Stroke
            end
        }
        if Entry.UpdateFloatVisual then Entry.UpdateFloatVisual(true) end
    end

    Internal.SyncToggleExternalsFn = function(KeyName, NewVal)
        if PinnedMirrorUpdaters[KeyName] then pcall(PinnedMirrorUpdaters[KeyName], NewVal) end
        local Flt = Internal.FloatingButtons[KeyName]
        if Flt and Flt.UpdateVisual then pcall(Flt.UpdateVisual, NewVal) end
    end

    RebuildPinnedPage()

    -- ==========================================
    -- PATCH 4: ⚡ ACTIVE FEATURES HUD (LIVE MINI PILL)
    -- ==========================================
    local ActiveHudFrame = Make("Frame", {
        Name = "ActiveFeaturesHUD",
        Size = UDim2.new(0, 250, 0, 26),
        Position = UDim2.new(0.5, 0, 0, 44),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(14, 17, 26),
        BackgroundTransparency = 0.26,
        Visible = false,
        ZIndex = 58
    }, ScreenGui)
    AddCorner(ActiveHudFrame, 13)
    AddStroke(ActiveHudFrame, Theme.AccentSecondary, 1.1, 0.35)

    local HudDot = Make("Frame", {
        Size = UDim2.new(0, 7, 0, 7), Position = UDim2.new(0, 10, 0.5, -3),
        BackgroundColor3 = Theme.Success, BorderSizePixel = 0, ZIndex = 59
    }, ActiveHudFrame)
    AddCorner(HudDot, 7)

    local HudLabel = Make("TextLabel", {
        Size = UDim2.new(1, -28, 1, 0), Position = UDim2.new(0, 22, 0, 0), BackgroundTransparency = 1,
        Font = Enum.Font.GothamSemibold, TextSize = 10, TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        Text = "ACTIVE: None", ZIndex = 59
    }, ActiveHudFrame)

    -- Draggable + Tap to Open UI
    do
        local Dragging, ActiveIn, StartPos, FrameStart, Moved = false, nil, nil, nil, 0
        ActiveHudFrame.InputBegan:Connect(function(In)
            if In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch then
                Dragging = true; ActiveIn = In; StartPos = In.Position; FrameStart = ActiveHudFrame.Position; Moved = 0
            end
        end)
        TrackConn(UserInputService.InputChanged:Connect(function(In)
            if Dragging and (In == ActiveIn or In.UserInputType == Enum.UserInputType.MouseMovement) then
                local Delta = In.Position - StartPos
                Moved = Delta.Magnitude
                ActiveHudFrame.Position = UDim2.new(FrameStart.X.Scale, FrameStart.X.Offset + Delta.X, FrameStart.Y.Scale, FrameStart.Y.Offset + Delta.Y)
            end
        end))
        TrackConn(UserInputService.InputEnded:Connect(function(In)
            if Dragging and (In == ActiveIn or In.UserInputType == Enum.UserInputType.MouseButton1 or In.UserInputType == Enum.UserInputType.Touch) then
                Dragging = false; ActiveIn = nil
                if Moved < 10 and not IsWindowVisible then AnimateShowUI(false) end
            end
        end))
    end

    Internal.RefreshActiveHudFn = function()
        local ActiveList = {}
        for Name, IsOn in pairs(Internal.ActiveToggleStates) do
            if IsOn == true then table.insert(ActiveList, Name) end
        end
        table.sort(ActiveList)

        if LooksState.ShowActiveHUD and #ActiveList > 0 then
            HudLabel.Text = string.format("ACTIVE (%d): %s", #ActiveList, table.concat(ActiveList, " • "))
            ActiveHudFrame.Visible = true
        else
            ActiveHudFrame.Visible = false
        end
    end

    -- ==========================================
    -- PATCH 5: 🔋 PERMANENT 20-MIN ANTI-AFK + OLED SCREEN SAVER
    -- ==========================================
    local VirtualUser = game:GetService("VirtualUser")

    local function SetupAntiAfk()
        Internal.AntiAfkConn = SafeDisconnect(Internal.AntiAfkConn)
        if not LooksState.AntiAfkEnabled then return end

        -- Method 1: Official VirtualUser pulse on Idled event (prevents 20-min Roblox kick)
        Internal.AntiAfkConn = LocalPlayer.Idled:Connect(function()
            if not LooksState.AntiAfkEnabled then return end
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end)

        -- Method 2: Backup disable idle-kick listeners if executor supports getconnections
        pcall(function()
            if getconnections then
                for _, conn in ipairs(getconnections(LocalPlayer.Idled)) do
                    if conn ~= Internal.AntiAfkConn and conn.Disable then
                        conn:Disable()
                    end
                end
            end
        end)
    end
    SetupAntiAfk()

    -- OLED Black Screen Power Saver Overlay
    local AfkOverlay = Make("Frame", {
        Name = "SidAfkPowerSaver",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(4, 5, 8),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 200
    }, ScreenGui)

    local AfkTitle = Make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 24), Position = UDim2.new(0, 0, 0.30, 0), BackgroundTransparency = 1,
        Font = Enum.Font.GothamBlack, TextSize = 15, TextColor3 = Theme.AccentSecondary,
        Text = "SID ULTIMATE  •  AFK POWER SAVER", ZIndex = 201
    }, AfkOverlay)
    table.insert(Registry.SecondaryTextObjs, AfkTitle)

    local AfkClock = Make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 48), Position = UDim2.new(0, 0, 0.38, 0), BackgroundTransparency = 1,
        Font = Enum.Font.GothamBlack, TextSize = 38, TextColor3 = Color3.fromRGB(245, 248, 255),
        Text = "00:00:00", ZIndex = 201
    }, AfkOverlay)

    local AfkStats = Make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 22), Position = UDim2.new(0, 0, 0.54, 0), BackgroundTransparency = 1,
        Font = Enum.Font.GothamSemibold, TextSize = 12, TextColor3 = Theme.Success,
        Text = "Anti-AFK: PROTECTED  |  Session: 00:00:00  |  Active: 0", ZIndex = 201
    }, AfkOverlay)

    local WakeBtn = Make("TextButton", {
        Size = UDim2.new(0, 160, 0, 36), Position = UDim2.new(0.5, -80, 0.68, 0),
        BackgroundColor3 = Color3.fromRGB(20, 24, 36), Font = Enum.Font.GothamBold,
        TextSize = 12, TextColor3 = Theme.TextPrimary, Text = "TAP TO WAKE SCREEN",
        AutoButtonColor = false, ZIndex = 202
    }, AfkOverlay)
    AddCorner(WakeBtn, 18); AddStroke(WakeBtn, Theme.AccentSecondary, 1.3, 0.25)

    local function CloseAfkSaver()
        PlayUISound("Open", 1.1)
        AfkOverlay.Visible = false
        Internal.AfkClockConn = SafeDisconnect(Internal.AfkClockConn)
        pcall(function() RunService:Set3dRenderingEnabled(true) end)
    end

    WakeBtn.MouseButton1Click:Connect(CloseAfkSaver)

    Internal.OpenAfkSaverFn = function()
        PlayUISound("Click", 0.9)
        AfkOverlay.Visible = true
        pcall(function() RunService:Set3dRenderingEnabled(false) end)

        Internal.AfkClockConn = SafeDisconnect(Internal.AfkClockConn)
        local Acc = 1
        Internal.AfkClockConn = RunService.Heartbeat:Connect(function(dt)
            if not AfkOverlay.Visible then
                CloseAfkSaver()
                return
            end
            Acc = Acc + dt
            if Acc >= 0.5 then
                Acc = 0
                AfkClock.Text = os.date("%I:%M:%S %p")
                local El = math.floor(os.clock() - SESSION_START_TIME)
                local h, m, s = math.floor(El / 3600), math.floor((El % 3600) / 60), El % 60
                local OnCount = 0
                for _, v in pairs(Internal.ActiveToggleStates) do if v then OnCount = OnCount + 1 end end
                local Ping = 0
                pcall(function() Ping = math.floor(StatsService.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5) end)
                AfkStats.Text = string.format("Anti-AFK: %s  |  Session: %02d:%02d:%02d  |  Active: %d  |  %dms",
                    LooksState.AntiAfkEnabled and "PROTECTED" or "OFF", h, m, s, OnCount, Ping)
            end
        end)
    end

    -- ==========================================
    -- PATCH 6B: SHOW UI BUTTON CUSTOMIZER ENGINE (100% OPTIONAL)
    -- ==========================================
    local ShowUIPositions = {
        ["Top-Center (Default)"] = {Pos = UDim2.new(0.5, 0, 0, 10),   Anchor = Vector2.new(0.5, 0)},
        ["Top-Left"]             = {Pos = UDim2.new(0, 14, 0, 12),    Anchor = Vector2.new(0, 0)},
        ["Top-Right"]            = {Pos = UDim2.new(1, -14, 0, 12),   Anchor = Vector2.new(1, 0)},
        ["Middle-Left"]          = {Pos = UDim2.new(0, 12, 0.5, 0),   Anchor = Vector2.new(0, 0.5)},
        ["Middle-Right"]         = {Pos = UDim2.new(1, -12, 0.5, 0),  Anchor = Vector2.new(1, 0.5)},
        ["Bottom-Left"]          = {Pos = UDim2.new(0, 14, 1, -14),   Anchor = Vector2.new(0, 1)},
        ["Bottom-Right"]         = {Pos = UDim2.new(1, -14, 1, -14),  Anchor = Vector2.new(1, 1)},
    }

    local ShowUIShapes = {
        ["Pill (Default)"] = {Size = UDim2.new(0, 96, 0, 28), Radius = 14, Short = false},
        ["Circle (Icon)"]  = {Size = UDim2.new(0, 44, 0, 44), Radius = 22, Short = true},
        ["Rounded Square"] = {Size = UDim2.new(0, 50, 0, 44), Radius = 12, Short = true},
        ["Capsule Slim"]   = {Size = UDim2.new(0, 86, 0, 22), Radius = 11, Short = false},
        ["Sharp Cyber"]    = {Size = UDim2.new(0, 96, 0, 28), Radius = 3,  Short = false},
    }

    local ShowUIColors = {
        ["Dark Glass"]    = {Bg = Color3.fromRGB(14, 17, 26),   Text = Color3.fromRGB(245, 248, 255)},
        ["Neon Cyan"]     = {Bg = Color3.fromRGB(0, 175, 225),  Text = Color3.fromRGB(10, 14, 22)},
        ["Crimson Red"]   = {Bg = Color3.fromRGB(220, 45, 75),  Text = Color3.fromRGB(255, 255, 255)},
        ["Royal Gold"]    = {Bg = Color3.fromRGB(235, 175, 35), Text = Color3.fromRGB(15, 16, 22)},
        ["Emerald Green"] = {Bg = Color3.fromRGB(0, 195, 120),  Text = Color3.fromRGB(10, 18, 16)},
        ["Pure White"]    = {Bg = Color3.fromRGB(242, 245, 255),Text = Color3.fromRGB(16, 18, 26)},
    }

    Internal.ApplyShowUIFn = function()
        if not LooksState.ShowUICustomEnabled then
            -- Classic Default Mode
            ShowUIBtn.AnchorPoint = Vector2.new(0.5, 0)
            ShowUIBtn.Position = UDim2.new(0.5, 0, 0, 10)
            ShowUIBtn.Size = UDim2.new(0, 96, 0, 28)
            ShowUICorner.CornerRadius = UDim.new(0, 14)
            ShowUIScaleObj.Scale = 1.0
            ShowUIBtn.BackgroundColor3 = Color3.fromRGB(14, 17, 26)
            ShowUIBtn.BackgroundTransparency = 0.42
            ShowUIBtn.TextColor3 = Color3.fromRGB(245, 248, 255)
            ShowUIBtn.Text = "Show UI"
            ShowUIStroke.Color = Theme.AccentSecondary
            return
        end

        -- Apply Shape
        local Sh = ShowUIShapes[LooksState.ShowUIShape] or ShowUIShapes["Pill (Default)"]
        ShowUIBtn.Size = Sh.Size
        ShowUICorner.CornerRadius = UDim.new(0, Sh.Radius)

        -- Apply Position (unless Free Draggable keeps user's dragged spot)
        local PosSpec = ShowUIPositions[LooksState.ShowUIPosition]
        if PosSpec then
            ShowUIBtn.AnchorPoint = PosSpec.Anchor
            ShowUIBtn.Position = PosSpec.Pos
        end

        -- Apply Scale & Transparency
        ShowUIScaleObj.Scale = math.clamp(tonumber(LooksState.ShowUISize) or 1.0, 0.70, 1.50)
        ShowUIBtn.BackgroundTransparency = math.clamp(tonumber(LooksState.ShowUITransparency) or 0.42, 0, 0.85)

        -- Apply Label Text
        local RawTxt = tostring(LooksState.ShowUIText or "Show UI")
        if #RawTxt == 0 then RawTxt = "Show UI" end
        ShowUIBtn.Text = Sh.Short and string.sub(RawTxt, 1, 2):upper() or RawTxt

        -- Apply Color
        local Mode = LooksState.ShowUIColorMode
        if Mode == "Match Theme" then
            ShowUIBtn.BackgroundColor3 = Color3.fromRGB(14, 17, 26)
            ShowUIBtn.TextColor3 = Theme.AccentSecondary
            ShowUIStroke.Color = Theme.AccentSecondary
        elseif Mode == "Custom Hex" then
            local Col = ParseColorString(LooksState.ShowUICustomHex) or Theme.Accent
            ShowUIBtn.BackgroundColor3 = Col
            ShowUIBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            ShowUIStroke.Color = Col
        else
            local C = ShowUIColors[Mode] or ShowUIColors["Dark Glass"]
            ShowUIBtn.BackgroundColor3 = C.Bg
            ShowUIBtn.TextColor3 = C.Text
            ShowUIStroke.Color = C.Bg
        end
    end

    -- ==========================================
    -- PATCH 7: 🎨 CORNER RADIUS, FLOWING BORDER & FONT STUDIO
    -- ==========================================
    local FontMap = {
        ["Gotham (Default)"]   = Enum.Font.GothamSemibold,
        ["Smooth (Fredoka)"]   = Enum.Font.FredokaOne,
        ["Cyber Tech (Code)"]  = Enum.Font.Code,
        ["Hacker (Mono)"]      = Enum.Font.RobotoMono,
        ["Clean (Ubuntu)"]     = Enum.Font.Ubuntu,
        ["Light (SourceSans)"] = Enum.Font.SourceSansSemibold,
    }

    Internal.ApplyRadiusFn = function(Val)
        local MainR = math.clamp(tonumber(Val) or 18, 0, 24)
        local CardR = math.clamp(math.floor(MainR * 0.55), 0, 14)
        LooksState.CornerRadius = MainR

        for _, c in ipairs(Registry.MainCorners) do
            if c and c.Parent then c.CornerRadius = UDim.new(0, MainR) end
        end
        for _, c in ipairs(Registry.CardCorners) do
            if c and c.Parent then c.CornerRadius = UDim.new(0, CardR) end
        end
    end

    Internal.ApplyFontFn = function(FontChoice)
        local TargetFont = FontMap[FontChoice] or Enum.Font.GothamSemibold
        LooksState.UIFont = FontChoice
        for _, Txt in ipairs(Registry.AllTextObjs) do
            if Txt and Txt.Parent then
                pcall(function() Txt.Font = TargetFont end)
            end
        end
    end

    Internal.ToggleBorderFlowFn = function(Enabled)
        LooksState.FlowingBorder = (Enabled == true)
        Internal.BorderFlowConn = SafeDisconnect(Internal.BorderFlowConn)
        if not LooksState.FlowingBorder then return end

        Internal.BorderFlowConn = RunService.Heartbeat:Connect(function(dt)
            if not LooksState.FlowingBorder then return end
            dt = math.min(dt, 0.05)
            if MainFrame.Visible and MainStrokeGrad and MainStrokeGrad.Parent then
                MainStrokeGrad.Rotation = (MainStrokeGrad.Rotation + dt * 85) % 360
            end
            if ShowUIBtn.Visible and ShowUIGrad and ShowUIGrad.Parent then
                ShowUIGrad.Rotation = (ShowUIGrad.Rotation + dt * 85) % 360
            end
        end)
    end

    -- Pre-Registered "Looks" Tab (Always Last: LayoutOrder = 9999)
        local LooksTab, LooksPage = CreateTabInternal("✨ Looks", 9999, true)
    -- Give ✨ Looks sidebar tab a sleek glowing accent border
    for _, Rec in ipairs(Tabs) do
        if Rec.Name == "✨ Looks" and Rec.Button then
            AddStroke(Rec.Button, Theme.AccentSecondary, 1, 0.55)
        end
    end

    PopulateLooksTab(LooksTab, LooksPage, {
        ApplyScale = function(NewScale)
            if IsWindowVisible then Tween(MainUIScale, 0.14, {Scale = NewScale})
            else MainUIScale.Scale = NewScale end
        end,
        SetTelemetryVisible = function(Vis) TelemetryPill.Visible = Vis end,
        RebuildBgAnim = RebuildBackgroundAnim,
        PreviewWindowAnim = function()
            if not Internal.IsLoadingConfig and IsWindowVisible and LooksState.AnimationsEnabled then
                LastSavedPos = MainFrame.Position
                AnimateShowUI(false)
            end
        end
    })

    RebuildBackgroundAnim()

    -- Instant reveal (no splash wait!)
    AnimateShowUI(true)

    -- Fast config autoload fallback & auto Last-Updated stamp
    task.delay(0.25, function()
        if not Internal.ConfigLoadedOnce then
            Library:LoadConfiguration()
        end
        local tCount, fCount = GetHubCounts()
        ResolveAutoLastUpdated(WindowTitle, tCount, fCount, Config.LastUpdated)
    end)

    return setmetatable(Window, {
        __index = function() return function() return {} end end
    })
end

return setmetatable(Library, {
    __index = function(_, Key)
        if type(Key) == "string" and string.sub(Key, 1, 1) == "_" then
            return nil
        end
        return function() return {} end
    end
})
