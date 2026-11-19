--====================================================================
-- KAIXER-STYLE PREMIUM UI LIBRARY (LIGHTWEIGHT & MOBILE OPTIMIZED)
-- 100% Drop-In Compatible with Rayfield API
-- Zero Lag | Instant Load | Touch Sliders | Floating Circle | Configs
--====================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Clean up any existing instance on re-execute
local function GetGuiParent()
    return (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
end

do
    local Parent = GetGuiParent()
    local Old = Parent:FindFirstChild("KaixerCustomUI")
    if Old then Old:Destroy() end
    local OldNotif = Parent:FindFirstChild("KaixerGlassNotif")
    if OldNotif then OldNotif:Destroy() end
end

local Library = {
    Flags = {},
    _ConfigSettings = {
        Enabled = false,
        FolderName = "KaixerConfigs",
        FileName = "DefaultConfig"
    },
    _SavePending = false
}

-- ==========================================
-- THEME PALETTE (KAIXER OBSIDIAN GLASS)
-- ==========================================
local Theme = {
    MainBg = Color3.fromRGB(13, 15, 22),
    SidebarBg = Color3.fromRGB(16, 19, 28),
    TopbarBg = Color3.fromRGB(17, 20, 30),
    CardBg = Color3.fromRGB(21, 25, 36),
    CardHover = Color3.fromRGB(27, 32, 46),
    Stroke = Color3.fromRGB(44, 50, 72),
    Accent = Color3.fromRGB(115, 95, 255),      -- Kaixer Violet
    AccentSecondary = Color3.fromRGB(0, 220, 255), -- Cyan Glow
    Success = Color3.fromRGB(0, 230, 155),
    Danger = Color3.fromRGB(255, 85, 95),
    TextPrimary = Color3.fromRGB(240, 244, 255),
    TextMuted = Color3.fromRGB(150, 160, 185),
    ToggleOff = Color3.fromRGB(42, 47, 64),
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
    return Make("UICorner", {CornerRadius = UDim.new(0, Radius or 8)}, Parent)
end

local function AddStroke(Parent, Color, Thickness, Transparency)
    return Make("UIStroke", {
        Color = Color or Theme.Stroke,
        Thickness = Thickness or 1,
        Transparency = Transparency or 0.25,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }, Parent)
end

local function Tween(Obj, Time, Props, Style, Dir)
    local T = TweenService:Create(
        Obj,
        TweenInfo.new(Time or 0.18, Style or Enum.EasingStyle.Quad, Dir or Enum.EasingDirection.Out),
        Props
    )
    T:Play()
    return T
end

-- Smooth Dragging (Works on Android Touch & Mouse)
local function MakeDraggable(DragHandle, TargetFrame, OnTapCallback)
    local Dragging = false
    local DragStartPos = nil
    local FrameStartPos = nil
    local MovedDistance = 0

    DragHandle.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStartPos = Input.Position
            FrameStartPos = TargetFrame.Position
            MovedDistance = 0
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            local Delta = Input.Position - DragStartPos
            MovedDistance = Delta.Magnitude
            TargetFrame.Position = UDim2.new(
                FrameStartPos.X.Scale,
                FrameStartPos.X.Offset + Delta.X,
                FrameStartPos.Y.Scale,
                FrameStartPos.Y.Offset + Delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Dragging and (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
            Dragging = false
            if OnTapCallback and MovedDistance < 10 then
                OnTapCallback()
            end
        end
    end)
end

-- ==========================================
-- CONFIG SAVING ENGINE (DEBOUNCED / ZERO LAG)
-- ==========================================
local function GetConfigPath()
    local Folder = Library._ConfigSettings.FolderName or "KaixerConfigs"
    local File = Library._ConfigSettings.FileName or "Config"
    return Folder, Folder .. "/" .. File .. ".json"
end

function Library:SaveConfiguration()
    if not Library._ConfigSettings.Enabled then return end
    if not writefile then return end

    if Library._SavePending then return end
    Library._SavePending = true

    task.delay(0.45, function()
        Library._SavePending = false
        pcall(function()
            local Folder, FilePath = GetConfigPath()
            if makefolder and isfolder and not isfolder(Folder) then
                makefolder(Folder)
            end

            local Payload = {}
            for FlagName, Obj in pairs(Library.Flags) do
                if type(Obj) == "table" and Obj.CurrentValue ~= nil then
                    Payload[FlagName] = Obj.CurrentValue
                elseif type(Obj) == "table" and Obj.CurrentOption ~= nil then
                    Payload[FlagName] = Obj.CurrentOption
                end
            end

            writefile(FilePath, HttpService:JSONEncode(Payload))
        end)
    end)
end

function Library:LoadConfiguration()
    if not Library._ConfigSettings.Enabled then return end
    if not readfile or not isfile then return end

    pcall(function()
        local _, FilePath = GetConfigPath()
        if not isfile(FilePath) then return end

        local Raw = readfile(FilePath)
        local Decoded = HttpService:JSONDecode(Raw)
        if type(Decoded) ~= "table" then return end

        for FlagName, SavedValue in pairs(Decoded) do
            local Obj = Library.Flags[FlagName]
            if Obj and Obj.Set then
                pcall(function()
                    Obj:Set(SavedValue)
                end)
            end
        end
    end)
end

-- ==========================================
-- COMPACT GLASSMORPHISM NOTIFICATION (TAP TO DISMISS)
-- ==========================================
function Library:Notify(Opts)
    Opts = Opts or {}
    local TitleText = tostring(Opts.Title or "Notification")
    local SubText = tostring(Opts.Content or "")
    local Duration = tonumber(Opts.Duration) or 3.0
    local AccentColor = Opts.Color or Theme.AccentSecondary

    task.spawn(function()
        pcall(function()
            local Parent = GetGuiParent()
            local Old = Parent:FindFirstChild("KaixerGlassNotif")
            if Old then Old:Destroy() end

            local ScreenGui = Make("ScreenGui", {
                Name = "KaixerGlassNotif",
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
                    local Out = Tween(Card, 0.15, {Position = UDim2.new(0.5, -150, 0, -65), BackgroundTransparency = 1})
                    Out.Completed:Wait()
                end
                if ScreenGui and ScreenGui.Parent then ScreenGui:Destroy() end
            end

            DismissBtn.Activated:Connect(Close)
            DismissBtn.MouseButton1Click:Connect(Close)

            Tween(Card, 0.24, {Position = UDim2.new(0.5, -150, 0, 14)}, Enum.EasingStyle.Back)
            Tween(BarFill, Duration, {Size = UDim2.new(0, 0, 1, 0)}, Enum.EasingStyle.Linear)

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
    local WindowTitle = tostring(Config.Name or "Kaixer Hub")
    local SubTag = tostring(Config.LoadingSubtitle or "PREMIUM")

    if type(Config.ConfigurationSaving) == "table" then
        Library._ConfigSettings.Enabled = Config.ConfigurationSaving.Enabled == true
        Library._ConfigSettings.FolderName = Config.ConfigurationSaving.FolderName or "KaixerConfigs"
        Library._ConfigSettings.FileName = Config.ConfigurationSaving.FileName or "Config"
    end

    local ScreenGui = Make("ScreenGui", {
        Name = "KaixerCustomUI",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        DisplayOrder = 100
    }, GetGuiParent())

    -- Main Window Container (Mobile-friendly size: 510 x 320)
    local MainFrame = Make("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, 510, 0, 320),
        Position = UDim2.new(0.5, -255, 0.5, -160),
        BackgroundColor3 = Theme.MainBg,
        BackgroundTransparency = 0.06,
        BorderSizePixel = 0,
        ClipsDescendants = true
    }, ScreenGui)
    AddCorner(MainFrame, 14)

    local MainStroke = AddStroke(MainFrame, Theme.Accent, 1.3, 0.35)
    Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
            ColorSequenceKeypoint.new(1, Theme.Accent)
        }),
        Rotation = 45
    }, MainStroke)

    -- ==========================================
    -- FLOATING CIRCULAR MINIMIZE BUTTON
    -- ==========================================
    local FloatingBtn = Make("Frame", {
        Name = "FloatingCircle",
        Size = UDim2.new(0, 46, 0, 46),
        Position = UDim2.new(0, 18, 0.5, -23),
        BackgroundColor3 = Color3.fromRGB(18, 21, 32),
        BackgroundTransparency = 0.08,
        Visible = false,
        ZIndex = 50
    }, ScreenGui)
    AddCorner(FloatingBtn, 23)

    local FloatStroke = AddStroke(FloatingBtn, Theme.AccentSecondary, 1.8, 0.1)
    Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(1, Theme.AccentSecondary)
        }),
        Rotation = 45
    }, FloatStroke)

    Make("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBlack,
        TextSize = 18,
        TextColor3 = Theme.AccentSecondary,
        Text = string.sub(WindowTitle, 1, 1):upper(),
        ZIndex = 51
    }, FloatingBtn)

    local function SetMinimized(Minimized)
        if Minimized then
            MainFrame.Visible = false
            FloatingBtn.Visible = true
        else
            FloatingBtn.Visible = false
            MainFrame.Visible = true
        end
    end

    MakeDraggable(FloatingBtn, FloatingBtn, function()
        SetMinimized(false)
    end)

    -- ==========================================
    -- TOPBAR (TITLE + BADGE + MINIMIZE + CLOSE)
    -- ==========================================
    local Topbar = Make("Frame", {
        Name = "Topbar",
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = Theme.TopbarBg,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0
    }, MainFrame)

    MakeDraggable(Topbar, MainFrame)

    -- Bottom Neon Accent Divider under Topbar
    local TopDivider = Make("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.45,
        BorderSizePixel = 0
    }, Topbar)
    Make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(0.5, Theme.AccentSecondary),
            ColorSequenceKeypoint.new(1, Theme.Stroke)
        })
    }, TopDivider)

    -- Glowing Status Dot
    local LogoDot = Make("Frame", {
        Size = UDim2.new(0, 9, 0, 9),
        Position = UDim2.new(0, 14, 0.5, -4),
        BackgroundColor3 = Theme.AccentSecondary,
        BorderSizePixel = 0
    }, Topbar)
    AddCorner(LogoDot, 9)

    Make("TextLabel", {
        Size = UDim2.new(0, 260, 1, 0),
        Position = UDim2.new(0, 30, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = WindowTitle
    }, Topbar)

    -- Badge Pill
    local Badge = Make("TextLabel", {
        Size = UDim2.new(0, 74, 0, 18),
        Position = UDim2.new(1, -152, 0.5, -9),
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.82,
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        TextColor3 = Theme.AccentSecondary,
        Text = string.sub(SubTag, 1, 10):upper()
    }, Topbar)
    AddCorner(Badge, 6)
    AddStroke(Badge, Theme.AccentSecondary, 1, 0.55)

    -- Minimize Button
    local MinBtn = Make("TextButton", {
        Size = UDim2.new(0, 28, 0, 26),
        Position = UDim2.new(1, -68, 0.5, -13),
        BackgroundColor3 = Theme.CardBg,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = Theme.TextPrimary,
        Text = "–",
        AutoButtonColor = false
    }, Topbar)
    AddCorner(MinBtn, 7)
    AddStroke(MinBtn, Theme.Stroke, 1, 0.4)
    MinBtn.MouseButton1Click:Connect(function()
        SetMinimized(true)
    end)

    -- Close Button (Triggers Exit Confirmation Dialog)
    local CloseBtn = Make("TextButton", {
        Size = UDim2.new(0, 28, 0, 26),
        Position = UDim2.new(1, -34, 0.5, -13),
        BackgroundColor3 = Color3.fromRGB(45, 22, 28),
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextColor3 = Theme.Danger,
        Text = "✕",
        AutoButtonColor = false
    }, Topbar)
    AddCorner(CloseBtn, 7)
    AddStroke(CloseBtn, Theme.Danger, 1, 0.55)

    -- ==========================================
    -- EXIT CONFIRMATION MODAL (SAFE FOR MOBILE)
    -- ==========================================
    local ConfirmOverlay = Make("Frame", {
        Name = "ConfirmOverlay",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(6, 8, 14),
        BackgroundTransparency = 0.25,
        Visible = false,
        ZIndex = 80
    }, MainFrame)

    local ConfirmBox = Make("Frame", {
        Size = UDim2.new(0, 250, 0, 118),
        Position = UDim2.new(0.5, -125, 0.5, -59),
        BackgroundColor3 = Theme.CardBg,
        ZIndex = 81
    }, ConfirmOverlay)
    AddCorner(ConfirmBox, 12)
    AddStroke(ConfirmBox, Theme.Danger, 1.2, 0.35)

    Make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 24),
        Position = UDim2.new(0, 10, 0, 12),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.TextPrimary,
        Text = "Close Hub Interface?",
        ZIndex = 82
    }, ConfirmBox)

    Make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 26),
        Position = UDim2.new(0, 10, 0, 36),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        TextColor3 = Theme.TextMuted,
        Text = "Minimize use karo agar UI hide karna hai.",
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

    CloseBtn.MouseButton1Click:Connect(function()
        ConfirmOverlay.Visible = true
    end)
    CancelCloseBtn.MouseButton1Click:Connect(function()
        ConfirmOverlay.Visible = false
    end)
    ConfirmCloseBtn.MouseButton1Click:Connect(function()
        Library:Destroy()
    end)

    -- ==========================================
    -- LEFT SIDEBAR (TAB LIST) & RIGHT CONTENT AREA
    -- ==========================================
    local Sidebar = Make("ScrollingFrame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 130, 1, -42),
        Position = UDim2.new(0, 0, 0, 42),
        BackgroundColor3 = Theme.SidebarBg,
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    }, MainFrame)

    local SidePad = Make("UIPadding", {
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8)
    }, Sidebar)

    local SideLayout = Make("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    }, Sidebar)

    SideLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Sidebar.CanvasSize = UDim2.new(0, 0, 0, SideLayout.AbsoluteContentSize.Y + 16)
    end)

    -- Vertical Separator between Sidebar and Content
    Make("Frame", {
        Size = UDim2.new(0, 1, 1, -42),
        Position = UDim2.new(0, 130, 0, 42),
        BackgroundColor3 = Theme.Stroke,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0
    }, MainFrame)

    local ContentHolder = Make("Frame", {
        Name = "ContentHolder",
        Size = UDim2.new(1, -131, 1, -42),
        Position = UDim2.new(0, 131, 0, 42),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    }, MainFrame)

    -- RightShift Keybind to toggle UI on keyboard (optional)
    UserInputService.InputBegan:Connect(function(Input, Processed)
        if not Processed and Input.KeyCode == Enum.KeyCode.RightShift then
            if ScreenGui and ScreenGui.Parent then
                SetMinimized(MainFrame.Visible)
            end
        end
    end)

    function Library:Destroy()
        if ScreenGui and ScreenGui.Parent then
            ScreenGui:Destroy()
        end
    end

    -- ==========================================
    -- WINDOW OBJECT & TAB SYSTEM
    -- ==========================================
    local Window = {}
    local Tabs = {}
    local ActiveTab = nil

    local function SelectTab(TabRecord)
        if ActiveTab == TabRecord then return end
        for _, Rec in ipairs(Tabs) do
            local IsSelected = (Rec == TabRecord)
            Rec.Page.Visible = IsSelected
            Tween(Rec.Button, 0.16, {
                BackgroundColor3 = IsSelected and Theme.CardHover or Theme.SidebarBg,
                BackgroundTransparency = IsSelected and 0 or 0.5
            })
            Tween(Rec.Label, 0.16, {
                TextColor3 = IsSelected and Theme.TextPrimary or Theme.TextMuted
            })
            Tween(Rec.Indicator, 0.16, {
                Size = IsSelected and UDim2.new(0, 3, 0, 18) or UDim2.new(0, 3, 0, 0),
                BackgroundTransparency = IsSelected and 0 or 1
            })
        end
        ActiveTab = TabRecord
    end

    function Window:CreateTab(TabName, _Icon)
        TabName = tostring(TabName or "Tab")

        -- Sidebar Tab Button
        local TabBtn = Make("TextButton", {
            Name = "Tab_" .. TabName,
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundColor3 = Theme.SidebarBg,
            BackgroundTransparency = 0.5,
            Text = "",
            AutoButtonColor = false
        }, Sidebar)
        AddCorner(TabBtn, 8)

        local Indicator = Make("Frame", {
            Size = UDim2.new(0, 3, 0, 0),
            Position = UDim2.new(0, 3, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Theme.AccentSecondary,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
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
            Text = TabName
        }, TabBtn)

        -- Tab Page (ScrollingFrame)
        local TabPage = Make("ScrollingFrame", {
            Name = "Page_" .. TabName,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false
        }, ContentHolder)

        Make("UIPadding", {
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 14),
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 12)
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
            Page = TabPage
        }
        table.insert(Tabs, TabRecord)

        TabBtn.MouseButton1Click:Connect(function()
            SelectTab(TabRecord)
        end)

        if #Tabs == 1 then
            SelectTab(TabRecord)
        end

        -- ==========================================
        -- TAB ELEMENT CONSTRUCTORS (RAYFIELD API)
        -- ==========================================
        local Tab = {}

        -- 1. CREATE SECTION
        function Tab:CreateSection(SectionTitle)
            local SecFrame = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1
            }, TabPage)

            local SecLabel = Make("TextLabel", {
                Size = UDim2.new(1, -6, 1, 0),
                Position = UDim2.new(0, 2, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextColor3 = Theme.AccentSecondary,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = string.upper(tostring(SectionTitle or "SECTION"))
            }, SecFrame)

            Make("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, -1),
                BackgroundColor3 = Theme.Stroke,
                BackgroundTransparency = 0.55,
                BorderSizePixel = 0
            }, SecFrame)

            return {
                Set = function(_, NewText)
                    SecLabel.Text = string.upper(tostring(NewText))
                end
            }
        end

        -- 2. CREATE LABEL
        function Tab:CreateLabel(Text)
            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundColor3 = Theme.CardBg
            }, TabPage)
            AddCorner(Card, 8)
            AddStroke(Card, Theme.Stroke, 1, 0.45)

            local Lbl = Make("TextLabel", {
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 12,
                TextColor3 = Theme.TextMuted,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = tostring(Text or "")
            }, Card)

            return {
                Set = function(_, NewText)
                    Lbl.Text = tostring(NewText)
                end
            }
        end

        -- 3. CREATE PARAGRAPH
        function Tab:CreateParagraph(Opts)
            Opts = Opts or {}
            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = Theme.CardBg
            }, TabPage)
            AddCorner(Card, 8)
            AddStroke(Card, Theme.Stroke, 1, 0.45)

            local T = Make("TextLabel", {
                Size = UDim2.new(1, -20, 0, 18),
                Position = UDim2.new(0, 10, 0, 6),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = tostring(Opts.Title or "")
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
                Text = tostring(Opts.Content or "")
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
                Text = "",
                AutoButtonColor = false
            }, TabPage)
            AddCorner(Btn, 8)
            local Stroke = AddStroke(Btn, Theme.Stroke, 1, 0.35)

            local TitleLbl = Make("TextLabel", {
                Size = UDim2.new(1, -48, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = tostring(Opts.Name or "Button")
            }, Btn)

            local Tag = Make("TextLabel", {
                Size = UDim2.new(0, 34, 0, 18),
                Position = UDim2.new(1, -44, 0.5, -9),
                BackgroundColor3 = Theme.Accent,
                BackgroundTransparency = 0.8,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                TextColor3 = Theme.AccentSecondary,
                Text = "RUN"
            }, Btn)
            AddCorner(Tag, 5)

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
                Set = function(_, NewName)
                    TitleLbl.Text = tostring(NewName)
                end
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
                Text = "",
                AutoButtonColor = false
            }, TabPage)
            AddCorner(Card, 8)
            local Stroke = AddStroke(Card, Theme.Stroke, 1, 0.35)

            Make("TextLabel", {
                Size = UDim2.new(1, -66, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = tostring(Opts.Name or "Toggle")
            }, Card)

            local SwitchBg = Make("Frame", {
                Size = UDim2.new(0, 40, 0, 20),
                Position = UDim2.new(1, -50, 0.5, -10),
                BackgroundColor3 = State and Theme.Accent or Theme.ToggleOff,
                BorderSizePixel = 0
            }, Card)
            AddCorner(SwitchBg, 10)

            local Knob = Make("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                Position = State and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            }, SwitchBg)
            AddCorner(Knob, 7)

            local ToggleObj = {CurrentValue = State}

            local function UpdateVisual(Val)
                Tween(SwitchBg, 0.14, {BackgroundColor3 = Val and Theme.Accent or Theme.ToggleOff})
                Tween(Knob, 0.14, {Position = Val and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)})
                Tween(Stroke, 0.14, {Color = Val and Theme.Accent or Theme.Stroke})
            end

            function ToggleObj:Set(NewVal)
                NewVal = (NewVal == true)
                State = NewVal
                ToggleObj.CurrentValue = State
                UpdateVisual(State)
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

        -- 6. CREATE SLIDER (TOUCH-OPTIMIZED WITH SCROLL LOCK)
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
                BackgroundColor3 = Theme.CardBg
            }, TabPage)
            AddCorner(Card, 8)
            AddStroke(Card, Theme.Stroke, 1, 0.35)

            Make("TextLabel", {
                Size = UDim2.new(1, -95, 0, 20),
                Position = UDim2.new(0, 12, 0, 5),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = tostring(Opts.Name or "Slider")
            }, Card)

            local ValLabel = Make("TextLabel", {
                Size = UDim2.new(0, 82, 0, 20),
                Position = UDim2.new(1, -92, 0, 5),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextColor3 = Theme.AccentSecondary,
                TextXAlignment = Enum.TextXAlignment.Right,
                Text = tostring(CurrentVal) .. (Suffix ~= "" and (" " .. Suffix) or "")
            }, Card)

            local Track = Make("Frame", {
                Size = UDim2.new(1, -24, 0, 7),
                Position = UDim2.new(0, 12, 0, 31),
                BackgroundColor3 = Theme.ToggleOff,
                BorderSizePixel = 0
            }, Card)
            AddCorner(Track, 4)

            local FillPct = (MaxVal > MinVal) and ((CurrentVal - MinVal) / (MaxVal - MinVal)) or 0
            local Fill = Make("Frame", {
                Size = UDim2.new(FillPct, 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0
            }, Track)
            AddCorner(Fill, 4)

            Make("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Theme.Accent),
                    ColorSequenceKeypoint.new(1, Theme.AccentSecondary)
                })
            }, Fill)

            local Knob = Make("Frame", {
                Size = UDim2.new(0, 13, 0, 13),
                Position = UDim2.new(1, -6, 0.5, -6),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            }, Fill)
            AddCorner(Knob, 7)

            -- Larger invisible touch hitbox for easy Android sliding
            local TouchHitbox = Make("TextButton", {
                Size = UDim2.new(1, 0, 0, 24),
                Position = UDim2.new(0, 0, 0.5, -12),
                BackgroundTransparency = 1,
                Text = ""
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

            local Sliding = false
            local function UpdateFromInput(InputPosX)
                local RelX = math.clamp((InputPosX - Track.AbsolutePosition.X) / math.max(Track.AbsoluteSize.X, 1), 0, 1)
                local RawVal = MinVal + (MaxVal - MinVal) * RelX
                local Rounded = RoundStep(RawVal)
                if Rounded ~= CurrentVal then
                    SliderObj:Set(Rounded)
                end
            end

            TouchHitbox.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Sliding = true
                    TabPage.ScrollingEnabled = false -- Lock page scroll while dragging slider on mobile
                    UpdateFromInput(Input.Position.X)
                end
            end)

            UserInputService.InputChanged:Connect(function(Input)
                if Sliding and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateFromInput(Input.Position.X)
                end
            end)

            UserInputService.InputEnded:Connect(function(Input)
                if Sliding and (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
                    Sliding = false
                    TabPage.ScrollingEnabled = true
                end
            end)

            if FlagName then
                Library.Flags[FlagName] = SliderObj
            end

            return SliderObj
        end

        -- 7. CREATE INPUT (TEXTBOX)
        function Tab:CreateInput(Opts)
            Opts = Opts or {}
            local FlagName = Opts.Flag
            local ClearAfter = Opts.RemoveTextAfterFocusLost == true

            local Card = Make("Frame", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = Theme.CardBg
            }, TabPage)
            AddCorner(Card, 8)
            AddStroke(Card, Theme.Stroke, 1, 0.35)

            Make("TextLabel", {
                Size = UDim2.new(0.52, -12, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextColor3 = Theme.TextPrimary,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = tostring(Opts.Name or "Input")
            }, Card)

            local Box = Make("TextBox", {
                Size = UDim2.new(0.45, -10, 0, 24),
                Position = UDim2.new(0.55, 0, 0.5, -12),
                BackgroundColor3 = Theme.SidebarBg,
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                TextColor3 = Theme.AccentSecondary,
                PlaceholderColor3 = Theme.TextMuted,
                PlaceholderText = tostring(Opts.PlaceholderText or "Type here..."),
                Text = "",
                ClearTextOnFocus = false
            }, Card)
            AddCorner(Box, 6)
            AddStroke(Box, Theme.Stroke, 1, 0.35)

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

            -- Parse initial CurrentOption (supports both string and table)
            if Multi then
                if type(Opts.CurrentOption) == "table" then
                    for _, v in ipairs(Opts.CurrentOption) do
                        SelectedSet[v] = true
                    end
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
                ClipsDescendants = true
            }, TabPage)
            AddCorner(Container, 8)
            local Stroke = AddStroke(Container, Theme.Stroke, 1, 0.35)

            local HeaderBtn = Make("TextButton", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false
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
                Text = tostring(Opts.Name or "Dropdown")
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
                Text = "None"
            }, HeaderBtn)

            local Arrow = Make("TextLabel", {
                Size = UDim2.new(0, 18, 1, 0),
                Position = UDim2.new(1, -24, 0, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextColor3 = Theme.TextMuted,
                Text = "▼"
            }, HeaderBtn)

            local ListScroll = Make("ScrollingFrame", {
                Size = UDim2.new(1, -16, 0, 0),
                Position = UDim2.new(0, 8, 0, 40),
                BackgroundColor3 = Theme.SidebarBg,
                BorderSizePixel = 0,
                ScrollBarThickness = 2,
                ScrollBarImageColor3 = Theme.Accent,
                CanvasSize = UDim2.new(0, 0, 0, 0)
            }, Container)
            AddCorner(ListScroll, 7)

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
                        if SelectedSet[Opt] then
                            table.insert(Arr, Opt)
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

            local function UpdateDropdownHeight()
                local ContentH = DropLayout.AbsoluteContentSize.Y + 8
                ListScroll.CanvasSize = UDim2.new(0, 0, 0, ContentH)
                local VisibleListH = math.min(ContentH, 130)

                if IsOpen then
                    ListScroll.Size = UDim2.new(1, -16, 0, VisibleListH)
                    Tween(Container, 0.16, {Size = UDim2.new(1, 0, 0, 46 + VisibleListH)})
                    Arrow.Text = "▲"
                    Tween(Stroke, 0.16, {Color = Theme.Accent})
                else
                    Tween(Container, 0.16, {Size = UDim2.new(1, 0, 0, 38)})
                    Arrow.Text = "▼"
                    Tween(Stroke, 0.16, {Color = Theme.Stroke})
                end
            end

            local function BuildOptionItems()
                for _, Child in ipairs(ListScroll:GetChildren()) do
                    if Child:IsA("TextButton") then
                        Child:Destroy()
                    end
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
                        AutoButtonColor = false
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
                        for _, v in ipairs(NewVal) do
                            SelectedSet[tostring(v)] = true
                        end
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
                            for _, v in ipairs(NewCurrent) do
                                SelectedSet[tostring(v)] = true
                            end
                        elseif type(NewCurrent) == "string" then
                            SelectedSet[NewCurrent] = true
                        end
                    else
                        SingleSelected = type(NewCurrent) == "table" and NewCurrent[1] or NewCurrent
                    end
                else
                    if Multi then
                        -- Remove selections no longer in options
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

    return Window
end

return Library
