-- Made by techy
_G.UI = "HorizonUI"

local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Horizon Bar Interface Management
local HorizonBarUI = Instance.new("ScreenGui")
local uiparent = (gethui and gethui()) or Players.LocalPlayer.PlayerGui
HorizonBarUI.Name = _G.UI
if uiparent:FindFirstChild(_G.UI) then
    uiparent:FindFirstChild(_G.UI).Parent = nil
end

HorizonBarUI.Parent = uiparent

-- Color Palette
local ColorPalette = {
    Black = Color3.fromRGB(0, 0, 0),
    Dark = Color3.fromRGB(25, 25, 25),
    Gray = Color3.fromRGB(185, 185, 185),
    DarkGray = Color3.fromRGB(50, 50, 50),
    White = Color3.fromRGB(255, 255, 255),
    Primary = Color3.fromRGB(87, 166, 199)
}

-- Storage
local Storage = {
    Icons = {
        DownArrowHead = "rbxassetid://14290444235",
        Click = "rbxassetid://11243256070",
        WhitelistStatus = "rbxassetid://14333382642",
        Time = "rbxassetid://14358459327",
        Ping = "rbxassetid://14334409497",
        Version = "rbxassetid://14334419052",
        Execution = "rbxassetid://14358439491",
        Money = "rbxassetid://14358718160"
    },
    Images = {}
}

-- Create Function
local function Create(Object_Type, Object_Properties)
    -- Creating Object
    local Object = Instance.new(Object_Type)
    -- Setting Object Properties
    for Property, Value in next, Object_Properties do
        Object[Property] = Value
    end
    -- Return Object
    return Object
end

-- Tween Function
local function CreateTween(Object, Tween_Duration, Tween_Easing_Style, Tween_Properties)
    -- Tween Info
    local TweenInfo = TweenInfo.new(Tween_Duration, Tween_Easing_Style)
    -- Creating Tween
    local Tween = TweenService:Create(Object, TweenInfo, Tween_Properties)
    -- Playing Tween
    Tween:Play()
end

-- Bubble Effect
local function BubbleEffect(Bubble_Object)
    -- Mouse
    local Mouse = Players.LocalPlayer:GetMouse()

    local RelativeX = Mouse.X - Bubble_Object.AbsolutePosition.X
    local RelativeY = Mouse.Y - Bubble_Object.AbsolutePosition.Y

    -- Bubble Frame
    local BubbleFrame =
        Create(
        "Frame",
        {
            Parent = Bubble_Object,
            Name = "BubbleFrame",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, RelativeX, 0, RelativeY),
            Rotation = 0,
            Size = UDim2.new(0, 0, 0, 0),
            Visible = true,
            ClipsDescendants = false
        }
    )

    -- Bubble Frame UICorner
    local BubbleFrame_UICorner =
        Create(
        "UICorner",
        {
            Parent = BubbleFrame,
            CornerRadius = UDim.new(1, 0)
        }
    )

    -- Bubble Tween
    CreateTween(
        BubbleFrame,
        0.6,
        Enum.EasingStyle.Exponential,
        {
            Size = UDim2.new(0, 150, 0, 150),
            Position = UDim2.new(0, RelativeX - 75, 0, RelativeY - 75),
            BackgroundTransparency = 1
        }
    )

    delay(
        0.5,
        function()
            -- Destroy Bubble Frame
            BubbleFrame:Destroy()
        end
    )
end

-- Shadow Function
local function Shadow(ShadowProperties)
    -- Shadow Frame
    local ShadowFrame =
        Create(
        "Frame",
        {
            Parent = ShadowProperties.Parent,
            Name = "ShadowFrame",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = false
        }
    )

    -- Shadow Frame UICorner
    local ShadowFrame_UICorner =
        Create(
        "UICorner",
        {
            Parent = ShadowFrame,
            CornerRadius = UDim.new(0, ShadowProperties.CornerRadius)
        }
    )

    -- Shadow Frame UIStroke
    local ShadowFrame_UIStroke =
        Create(
        "UIStroke",
        {
            Parent = ShadowFrame,
            Color = ColorPalette.Black,
            Thickness = ShadowProperties.Thickness,
            Transparency = ShadowProperties.Transparency
        }
    )
end

-- Gradient Function
local function Gradient(GradientProperties)
    -- Gradient Frame
    local GradientFrame =
        Create(
        "Frame",
        {
            Parent = GradientProperties.Parent,
            Name = "GradientFrame",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = false
        }
    )

    -- Gradient Frame UICorner
    local GradientFrame_UICorner =
        Create(
        "UICorner",
        {
            Parent = GradientFrame,
            CornerRadius = UDim.new(0, GradientProperties.CornerRadius)
        }
    )

    -- Gradient Frame UIGradient
    local GradientFrame_UIGradient =
        Create(
        "UIGradient",
        {
            Parent = GradientFrame,
            Color = GradientProperties.Color,
            Rotation = GradientProperties.Rotation,
            Transparency = GradientProperties.Transparency
        }
    )
end

-- Draggable Function
local function Draggable(Window, Inset)
    -- User Input Service
    local UserInputService = game:GetService("UserInputService")
    -- Dragging Variable
    local Window_Dragging = false

    -- Offsets
    local OffsetX, OffsetY

    -- Input Began
    UserInputService.InputBegan:Connect(
        function(Input, GameProcessed)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                local MousePosition = UserInputService:GetMouseLocation()
                local MousePositionX = MousePosition.X
                local MousePositionY = MousePosition.Y - 36
                if
                    MousePositionX >= Window.AbsolutePosition.X and
                        MousePositionX <= Window.AbsolutePosition.X + Window.AbsoluteSize.X and
                        MousePositionY >= Window.AbsolutePosition.Y and
                        MousePositionY <= Window.AbsolutePosition.Y + Inset
                 then
                    Window_Dragging = true
                    OffsetX = MousePositionX - Window.AbsolutePosition.X
                    OffsetY = MousePositionY - Window.AbsolutePosition.Y
                end
            end
        end
    )

    -- Input Ended
    UserInputService.InputEnded:Connect(
        function(Input, GameProcessed)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Window_Dragging = false
            end
        end
    )

    -- Dragging Function
    game:GetService("RunService").RenderStepped:Connect(
        function()
            if Window_Dragging then
                local MousePosition = UserInputService:GetMouseLocation()
                local MousePositionX = MousePosition.X
                local MousePositionY = MousePosition.Y - 36
                TweenService:Create(
                    Window,
                    TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                    {
                        Position = UDim2.new(0, MousePositionX - OffsetX, 0, MousePositionY - OffsetY)
                    }
                ):Play()
            end
        end
    )
end

-- HorizonBarLibrary
local HorizonBarLibrary = {}

-- Create Window Function
function HorizonBarLibrary:CreateWindow(WindowProperties)
    -- Window Properties
    local Window_Name = WindowProperties.Name

    -- Window
    local Window =
        Create(
        "Frame",
        {
            Parent = HorizonBarUI,
            Name = "Window",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.Dark,
            BackgroundTransparency = 0,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, -240, 0.5, -175),
            Rotation = 0,
            Size = UDim2.new(0, 288, 0, 391),
            Visible = true,
            ClipsDescendants = false
        }
    )

    -- Draggable Functionality
    Draggable(Window, 40)

    -- Window UICorner
    local Window_UICorner =
        Create(
        "UICorner",
        {
            Parent = Window,
            CornerRadius = UDim.new(0, 10)
        }
    )

    -- Window UIStroke
    local Window_UIStroke =
        Create(
        "UIStroke",
        {
            Parent = Window,
            Color = ColorPalette.White,
            Thickness = 1.5,
            Transparency = 0.8
        }
    )

    -- Window Shadow Folder
    local WindowShadowFolder =
        Create(
        "Folder",
        {
            Parent = Window,
            Name = "Shadow"
        }
    )

    -- Window Shadow
    Shadow(
        {
            Parent = WindowShadowFolder,
            Thickness = 1,
            Transparency = 0.95,
            CornerRadius = 10
        }
    )

    Shadow(
        {
            Parent = WindowShadowFolder,
            Thickness = 3,
            Transparency = 0.95,
            CornerRadius = 10
        }
    )

    Shadow(
        {
            Parent = WindowShadowFolder,
            Thickness = 5,
            Transparency = 0.95,
            CornerRadius = 10
        }
    )

    Shadow(
        {
            Parent = WindowShadowFolder,
            Thickness = 7,
            Transparency = 0.95,
            CornerRadius = 10
        }
    )

    -- Window Gradient Folder
    local WindowGradientFolder =
        Create(
        "Folder",
        {
            Parent = Window,
            Name = "Gradient"
        }
    )

    -- Window Gradient
    Gradient(
        {
            Parent = WindowGradientFolder,
            Color = ColorSequence.new {
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(87, 166, 199)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 24, 24))
            },
            Rotation = -60,
            Transparency = NumberSequence.new {
                NumberSequenceKeypoint.new(0.00, 0.27),
                NumberSequenceKeypoint.new(0.44, 1.00),
                NumberSequenceKeypoint.new(1.00, 0.98)
            },
            CornerRadius = 10
        }
    )

    Gradient(
        {
            Parent = WindowGradientFolder,
            Color = ColorSequence.new {
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(87, 166, 199)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 24, 24))
            },
            Rotation = -120,
            Transparency = NumberSequence.new {
                NumberSequenceKeypoint.new(0.00, 0.27),
                NumberSequenceKeypoint.new(0.44, 1.00),
                NumberSequenceKeypoint.new(1.00, 0.98)
            },
            CornerRadius = 10
        }
    )

    -- Window Name
    local WindowName =
        Create(
        "TextLabel",
        {
            Parent = Window,
            Name = "Name",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, -20, 0, 35),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold),
            Text = Window_Name,
            TextColor3 = ColorPalette.White,
            TextSize = 15,
            TextStrokeColor3 = ColorPalette.Black,
            RichText = true,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        }
    )

    -- Window Collapse Icon
    local WindowCollapseIcon =
        Create(
        "ImageButton",
        {
            Parent = Window,
            Name = "Icon",
            AnchorPoint = Vector2.new(0, 0),
            AutoButtonColor = false,
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(1, -35, 0, 5),
            Rotation = 0,
            Size = UDim2.new(0, 25, 0, 25),
            Visible = true,
            ClipsDescendants = false,
            Image = Storage.Icons.DownArrowHead,
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        }
    )

    -- Window Separator
    local WindowSeparator =
        Create(
        "Frame",
        {
            Parent = Window,
            Name = "Separator",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 35),
            Rotation = 0,
            Size = UDim2.new(1, 0, 0, 2),
            Visible = true,
            ClipsDescendants = false
        }
    )

    -- Main Container
    local MainContainer =
        Create(
        "Frame",
        {
            Parent = Window,
            Name = "MainContainer",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 35),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, -35),
            Visible = true,
            ClipsDescendants = true
        }
    )

    -- Window Status
    local Window_Status = false

    -- Window Collapse Icon Interaction
    WindowCollapseIcon.MouseButton1Down:Connect(
        function()
            if not Window_Status then
                CreateTween(
                    WindowCollapseIcon,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        Rotation = 180
                    }
                )
                CreateTween(
                    WindowSeparator,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundTransparency = 1
                    }
                )
                CreateTween(
                    MainContainer,
                    0.35,
                    Enum.EasingStyle.Exponential,
                    {
                        Size = UDim2.new(1, 0, 0, 50)
                    }
                )
                MainContainer.Visible = false
                CreateTween(
                    Window,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        Size = UDim2.new(0, 288, 0, 40)
                    }
                )
                Window_Status = not Window_Status
            else
                CreateTween(
                    WindowCollapseIcon,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        Rotation = 0
                    }
                )
                CreateTween(
                    WindowSeparator,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundTransparency = 0.9
                    }
                )
                CreateTween(
                    MainContainer,
                    0.35,
                    Enum.EasingStyle.Exponential,
                    {
                        Size = UDim2.new(1, 0, 1, -35)
                    }
                )
                MainContainer.Visible = true
                CreateTween(
                    Window,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        Size = UDim2.new(0, 288, 0, 391)
                    }
                )
                Window_Status = not Window_Status
            end
        end
    )

    -- Tab Button Container
    local TabButtonContainer =
        Create(
        "Frame",
        {
            Parent = MainContainer,
            Name = "Container",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.Black,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 294),
            Rotation = 0,
            Size = UDim2.new(1, -20, 0, 51),
            Visible = true,
            ClipsDescendants = false
        }
    )

    -- Tab Button Container UICorner
    local TabButtonContainer_UICorner =
        Create(
        "UICorner",
        {
            Parent = TabButtonContainer,
            CornerRadius = UDim.new(0, 6)
        }
    )

    -- Tab Button Container UIListLayout
    local TabButtonContainer_UIListLayout =
        Create(
        "UIListLayout",
        {
            Parent = TabButtonContainer,
            Padding = UDim.new(0, 8),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }
    )

    ---- Tab Button Container UIPadding
    --local TabButtonContainer_UIPadding = Create("UIPadding", {
    --	Parent = TabButtonContainer,
    --	PaddingTop = UDim.new(0, 3),
    --	PaddingBottom = UDim.new(0, 8),
    --	PaddingLeft = UDim.new(0, 0),
    --	PaddingRight = UDim.new(0, 0)
    --})

    -- Tabs Folder
    local TabsFolder =
        Create(
        "Folder",
        {
            Parent = MainContainer,
            Name = "Tabs"
        }
    )

    -- Horizon Bar Window
    local Window = {}

    -- Create Console Tab Function
    function Window:CreateConsoleTab(ConsoleTabProperties)
        -- Console Tab Properties
        local ConsoleTab_Name = ConsoleTabProperties.Name
        local ConsoleTab_Icon = ConsoleTabProperties.Icon
        local FirstWindow = ConsoleTabProperties.FirstWindow

        -- Console Button Wrapper
        local ConsoleTabButtonWrapper =
            Create(
            "Frame",
            {
                Parent = TabButtonContainer,
                Name = "Wrapper",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(0, 35, 0, 35),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- Console Tab Button Wrapper
        local ConsoleTabButtonWrapper_UIListLayout =
            Create(
            "UIListLayout",
            {
                Parent = ConsoleTabButtonWrapper,
                Padding = UDim.new(0, 0),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        -- Console Button
        local ConsoleTabButton =
            Create(
            "Frame",
            {
                Parent = ConsoleTabButtonWrapper,
                Name = "Button",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.80,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- Console Tab Button UICorner
        local ConsoleTabButton_UICorner =
            Create(
            "UICorner",
            {
                Parent = ConsoleTabButton,
                CornerRadius = UDim.new(0, 6)
            }
        )

        -- Console Tab Button Interact
        local ConsoleTabButtonInteract =
            Create(
            "TextButton",
            {
                Parent = ConsoleTabButton,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            }
        )

        -- Console Tab Button Icon
        local ConsoleTabButtonIcon =
            Create(
            "ImageLabel",
            {
                Parent = ConsoleTabButton,
                Name = "Icon",
                AnchorPoint = Vector2.new(0.5, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Rotation = 0,
                Size = UDim2.new(1, -5, 1, -5),
                Visible = true,
                ClipsDescendants = false,
                Image = ConsoleTab_Icon,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            }
        )

        -- Console Tab
        local ConsoleTab =
            Create(
            "Frame",
            {
                Parent = TabsFolder,
                Name = "Tab",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, -1, -25),
                Rotation = 0,
                Size = UDim2.new(1, -20, 1, -80),
                Visible = true,
                ClipsDescendants = true
            }
        )

        -- First Window
        if FirstWindow then
            ConsoleTab.Position = UDim2.new(0, 10, 0, 10)
        end

        -- Console Tab UICorner
        local ConsoleTab_UICorner =
            Create(
            "UICorner",
            {
                Parent = ConsoleTab,
                CornerRadius = UDim.new(0, 6)
            }
        )

        --  Console Container
        local ConsoleContainer =
            Create(
            "ScrollingFrame",
            {
                Parent = ConsoleTab,
                Name = "ConsoleContainer",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 10),
                Rotation = 0,
                Size = UDim2.new(1, -20, 1, -20),
                Visible = true,
                ClipsDescendants = true,
                AutomaticCanvasSize = 2,
                CanvasPosition = Vector2.new(0, 0),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarImageColor3 = ColorPalette.Black,
                ScrollBarThickness = 0,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ScrollingEnabled = true
            }
        )

        -- Console Container UIListLayout
        local ConsoleContainer_UIListLayout =
            Create(
            "UIListLayout",
            {
                Parent = ConsoleContainer,
                Padding = UDim.new(0, 0),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        -- Console Tab Button Mouse Enter Interaction
        ConsoleTabButtonInteract.MouseEnter:Connect(
            function()
                CreateTween(
                    ConsoleTabButton,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundTransparency = 0.75
                    }
                )
            end
        )

        -- Console Tab Button Mouse Leave Interaction
        ConsoleTabButtonInteract.MouseLeave:Connect(
            function()
                CreateTween(
                    ConsoleTabButton,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundTransparency = 0.80
                    }
                )
            end
        )

        -- Console Tab Button Interact
        ConsoleTabButtonInteract.MouseButton1Down:Connect(
            function()
                local Tabs = TabsFolder:GetChildren()
                for Index, Tab in next, Tabs do
                    if Tab:IsA("Frame") and Tab ~= ConsoleTab then
                        CreateTween(
                            Tab,
                            0.5,
                            Enum.EasingStyle.Exponential,
                            {
                                Position = UDim2.new(0, 10, -1, -25)
                            }
                        )
                    end
                end
                ConsoleTab.Position = UDim2.new(0, 10, -1, -25)
                CreateTween(
                    ConsoleTab,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        Position = UDim2.new(0, 10, 0, 10)
                    }
                )
            end
        )

        local Console = {}

        -- Create Console Alert Function
        function Console:CreateConsoleAlert(ConsoleAlertProperties)
            if #ConsoleContainer:GetChildren() >= 2546 then
                ConsoleContainer:ClearAllChildren()
            end
            local Alls = 0
            for i, v in pairs(ConsoleContainer:GetChildren()) do
                if v and v:IsA("GuiObject") then
                    local sizeY = 0
                    if v.AbsoluteSize and typeof(v.AbsoluteSize.Y) == "number" then
                        sizeY = v.AbsoluteSize.Y
                    elseif v.Size and v.Size.Y and v.Size.Y.Offset then
                        sizeY = v.Size.Y.Offset
                    end
                    Alls = Alls + sizeY
                end
            end

            -- Console Alert Properties
            local Status = ConsoleAlertProperties.Status

            -- Robbery Location Icons
            local RobberyLocationIcons = {
                ["Powerplant"] = "rbxassetid://14291151729",
                ["Jewelry Store"] = "rbxassetid://14291198522",
                ["Bank"] = "rbxassetid://14291211915",
                ["Museum"] = "rbxassetid://14291182235",
                ["Casino"] = "rbxassetid://14291221227",
                ["Tomb"] = "rbxassetid://14291280449",
                ["Gas Station"] = "rbxassetid://14291294183",
                ["Donut Shop"] = "rbxassetid://14291308561",
                ["Airdrop"] = "rbxassetid://14291273841",
                ["Cargo Plane"] = "rbxassetid://14295690525",
                ["Cargo Ship"] = "rbxassetid://14295685103",
                ["Cargo Train"] = "rbxassetid://14295675152"
            }

            -- Console Alert
            local ConsoleAlert =
                Create(
                "Frame",
                {
                    Parent = ConsoleContainer,
                    Name = "ConsoleAlert",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 0, 18),
                    Visible = true,
                    ClipsDescendants = false
                }
            )

            -- Console Alert Text
            local ConsoleAlertText =
                Create(
                "TextLabel",
                {
                    Parent = ConsoleAlert,
                    Name = "Text",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    Text = Status,
                    TextColor3 = ColorPalette.White,
                    TextSize = 12,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextWrapped = false,
                    RichText = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )

            -- ensure canvas includes new alert + small padding, then scroll to bottom
            task.spawn(function()
                local padding = 8
                local newHeight = Alls + ConsoleAlertText.TextBounds.Y + padding
                ConsoleContainer.CanvasSize = UDim2.new(0, 0, 0, newHeight)

                -- wait until container has a valid AbsoluteSize so scrolling calculation is correct
                local tries = 0
                while (ConsoleContainer.AbsoluteSize.Y == 0) and tries < 30 do
                    tries = tries + 1
                    task.wait(0.01)
                end

                local visibleH = math.max(1, ConsoleContainer.AbsoluteSize.Y)
                local scrollTo = math.max(0, newHeight - visibleH)
                ConsoleContainer.CanvasPosition = Vector2.new(0, scrollTo)
            end)

            return {
                SetText = function(Status)
                    ConsoleAlertText.Text = Status
                end,
                Destroy = function()
                    ConsoleAlert:Destroy()
                end
            }
        end
        return Console
    end

    -- Create Locations Tab Function
    function Window:CreateLocationsTab(LocationsTabProperties)
        -- Locations Tab Properties
        local LocationsTab_Name = LocationsTabProperties.Name
        local LocationsTab_Icon = LocationsTabProperties.Icon
        local FirstWindow = LocationsTabProperties.FirstWindow

        -- Locations Button Wrapper
        local LocationsTabButtonWrapper =
            Create(
            "Frame",
            {
                Parent = TabButtonContainer,
                Name = "Wrapper",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(0, 35, 0, 35),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- Locations Tab Button Wrapper
        local LocationsTabButtonWrapper_UIListLayout =
            Create(
            "UIListLayout",
            {
                Parent = LocationsTabButtonWrapper,
                Padding = UDim.new(0, 0),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        -- Locations Button
        local LocationsTabButton =
            Create(
            "Frame",
            {
                Parent = LocationsTabButtonWrapper,
                Name = "Button",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.80,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- Locations Tab Button UICorner
        local LocationsTabButton_UICorner =
            Create(
            "UICorner",
            {
                Parent = LocationsTabButton,
                CornerRadius = UDim.new(0, 6)
            }
        )

        -- Locations Tab Button Interact
        local LocationsTabButtonInteract =
            Create(
            "TextButton",
            {
                Parent = LocationsTabButton,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            }
        )

        -- Locations Tab Button Icon
        local LocationsTabButtonIcon =
            Create(
            "ImageLabel",
            {
                Parent = LocationsTabButton,
                Name = "Icon",
                AnchorPoint = Vector2.new(0.5, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Rotation = 0,
                Size = UDim2.new(1, -5, 1, -5),
                Visible = true,
                ClipsDescendants = false,
                Image = LocationsTab_Icon,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            }
        )

        -- Locations Tab
        local LocationsTab =
            Create(
            "Frame",
            {
                Parent = TabsFolder,
                Name = "Tab",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, -1, -25),
                Rotation = 0,
                Size = UDim2.new(1, -20, 1, -80),
                Visible = true,
                ClipsDescendants = true
            }
        )

        -- First Window
        if FirstWindow then
            LocationsTab.Position = UDim2.new(0, 10, 0, 10)
        end

        -- Locations Tab UICorner
        local LocationsTab_UICorner =
            Create(
            "UICorner",
            {
                Parent = LocationsTab,
                CornerRadius = UDim.new(0, 6)
            }
        )

        --  Locations Container
        local LocationsContainer =
            Create(
            "ScrollingFrame",
            {
                Parent = LocationsTab,
                Name = "LocationsContainer",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 10),
                Rotation = 0,
                Size = UDim2.new(1, -20, 1, -20),
                Visible = true,
                ClipsDescendants = true,
                AutomaticCanvasSize = 2,
                CanvasPosition = Vector2.new(0, 0),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarImageColor3 = ColorPalette.Black,
                ScrollBarThickness = 0,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ScrollingEnabled = true
            }
        )

        -- Locations Container UIListLayout
        local LocationsContainer_UIListLayout =
            Create(
            "UIListLayout",
            {
                Parent = LocationsContainer,
                Padding = UDim.new(0, 0),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        -- Locations Tab Button Mouse Enter Interaction
        LocationsTabButtonInteract.MouseEnter:Connect(
            function()
                CreateTween(
                    LocationsTabButton,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundTransparency = 0.75
                    }
                )
            end
        )

        -- Locations Tab Button Mouse Leave Interaction
        LocationsTabButtonInteract.MouseLeave:Connect(
            function()
                CreateTween(
                    LocationsTabButton,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundTransparency = 0.80
                    }
                )
            end
        )

        -- Locations Tab Button Interact
        LocationsTabButtonInteract.MouseButton1Down:Connect(
            function()
                local Tabs = TabsFolder:GetChildren()
                for Index, Tab in next, Tabs do
                    if Tab:IsA("Frame") and Tab ~= LocationsTab then
                        CreateTween(
                            Tab,
                            0.5,
                            Enum.EasingStyle.Exponential,
                            {
                                Position = UDim2.new(0, 10, -1, -25)
                            }
                        )
                    end
                end
                LocationsTab.Position = UDim2.new(0, 10, -1, -25)
                CreateTween(
                    LocationsTab,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        Position = UDim2.new(0, 10, 0, 10)
                    }
                )
            end
        )

        -- Locations
        local Locations = {}

        -- Create Locations Toggle Function
        function Locations:CreateToggle(ToggleProperties)
            -- Toggle Properties
            local Robbery_Location = ToggleProperties.RobberyLocation
            local Toggle_Value = ToggleProperties.Toggle_Value

            -- Robbery Location Icons
            local RobberyLocationIcons = {
                ["Powerplant"] = "rbxassetid://14291151729",
                ["Jewelry Store"] = "rbxassetid://14291198522",
                ["Bank"] = "rbxassetid://14291211915",
                ["Museum"] = "rbxassetid://14291182235",
                ["Crown Jewel"] = "rbxassetid://14291221227",
                ["Tomb"] = "rbxassetid://14291280449",
                ["Gas Station"] = "rbxassetid://14291294183",
                ["Donut Shop"] = "rbxassetid://14291308561",
                ["Airdrop"] = "rbxassetid://14291273841",
                ["Cargo Plane"] = "rbxassetid://14295690525",
                ["Cargo Ship"] = "rbxassetid://14295685103",
                ["Cargo Train"] = "rbxassetid://14295675152"
            }

            -- Toggle
            local Toggle =
                Create(
                "Frame",
                {
                    Parent = LocationsContainer,
                    Name = "Toggle",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 0, 34),
                    Visible = true,
                    ClipsDescendants = true
                }
            )

            -- Toggle UICorner
            local Toggle_UICorner =
                Create(
                "UICorner",
                {
                    Parent = Toggle,
                    CornerRadius = UDim.new(0, 6)
                }
            )

            -- Toggle Interact
            local ToggleInteract =
                Create(
                "TextButton",
                {
                    Parent = Toggle,
                    Name = "Interact",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    Text = "",
                    TextColor3 = ColorPalette.Black,
                    TextSize = 0,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.None,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )

            -- Toggle Icon
            local ToggleIcon =
                Create(
                "ImageLabel",
                {
                    Parent = Toggle,
                    Name = "Icon",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 9),
                    Rotation = 0,
                    Size = UDim2.new(0, 16, 0, 16),
                    Visible = true,
                    ClipsDescendants = false,
                    Image = RobberyLocationIcons[Robbery_Location],
                    ImageColor3 = ColorPalette.White,
                    ImageTransparency = 0,
                    ScaleType = Enum.ScaleType.Stretch
                }
            )

            -- Toggle Text
            local ToggleText =
                Create(
                "TextLabel",
                {
                    Parent = Toggle,
                    Name = "Text",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 25, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, -25, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    Text = Robbery_Location,
                    TextColor3 = ColorPalette.White,
                    TextSize = 13,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )

            -- Toggle Box
            local ToggleBox =
                Create(
                "Frame",
                {
                    Parent = Toggle,
                    Name = "ToggleBox",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.Black,
                    BackgroundTransparency = 0.60,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -40, 0, 7),
                    Rotation = 0,
                    Size = UDim2.new(0, 40, 0, 20),
                    Visible = true,
                    ClipsDescendants = false
                }
            )

            -- Toggle Box UICorner
            local ToggleBox_UICorner =
                Create(
                "UICorner",
                {
                    Parent = ToggleBox,
                    CornerRadius = UDim.new(1, 0)
                }
            )

            -- Toggle Ball
            local ToggleBall =
                Create(
                "Frame",
                {
                    Parent = ToggleBox,
                    Name = "ToggleBall",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 0,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 3, 0, 3),
                    Rotation = 0,
                    Size = UDim2.new(0, 14, 0, 14),
                    Visible = true,
                    ClipsDescendants = false
                }
            )

            -- Toggle Ball UICorner
            local ToggleBall_UICorner =
                Create(
                "UICorner",
                {
                    Parent = ToggleBall,
                    CornerRadius = UDim.new(1, 0)
                }
            )

            -- Toggle Value Configuration
            if Toggle_Value then
                CreateTween(
                    ToggleBall,
                    0.25,
                    Enum.EasingStyle.Exponential,
                    {
                        Position = UDim2.new(1, -17, 0, 3)
                    }
                )
                CreateTween(
                    ToggleBox,
                    0.25,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundColor3 = ColorPalette.Primary,
                        BackgroundTransparency = 0
                    }
                )
            end

            -- Toggle Interaction
            ToggleInteract.MouseButton1Down:Connect(
                function()
                    BubbleEffect(Toggle)
                    if not Toggle_Value then
                        CreateTween(
                            ToggleBall,
                            0.25,
                            Enum.EasingStyle.Exponential,
                            {
                                Position = UDim2.new(1, -17, 0, 3)
                            }
                        )
                        CreateTween(
                            ToggleBox,
                            0.25,
                            Enum.EasingStyle.Exponential,
                            {
                                BackgroundColor3 = ColorPalette.Primary,
                                BackgroundTransparency = 0
                            }
                        )
                        Toggle_Value = not Toggle_Value
                    else
                        CreateTween(
                            ToggleBall,
                            0.25,
                            Enum.EasingStyle.Exponential,
                            {
                                Position = UDim2.new(0, 3, 0, 3)
                            }
                        )
                        CreateTween(
                            ToggleBox,
                            0.25,
                            Enum.EasingStyle.Exponential,
                            {
                                BackgroundColor3 = ColorPalette.Black,
                                BackgroundTransparency = 0.60
                            }
                        )
                        Toggle_Value = not Toggle_Value
                    end
                    local Success, Error =
                        pcall(
                        function()
                            ToggleProperties.Callback(Toggle_Value)
                        end
                    )
                    if not Success then
                        print("[Horizon Bar Error]: " .. Error)
                    end
                end
            )

            return {
				SetOpenColor = function(color)
					ToggleIcon.ImageColor3 = color
				end
			}
        end
        return Locations
    end

    -- Create Miscellaneous Tab Function
    function Window:CreateTab(MiscellaneousTabProperties)
        -- Miscellaneous Tab Properties
        local MiscellaneousTab_Name = MiscellaneousTabProperties.Name
        local MiscellaneousTab_Icon = MiscellaneousTabProperties.Icon
        local FirstWindow = MiscellaneousTabProperties.FirstWindow

        -- Miscellaneous Button Wrapper
        local MiscellaneousTabButtonWrapper =
            Create(
            "Frame",
            {
                Parent = TabButtonContainer,
                Name = "Wrapper",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(0, 35, 0, 35),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- Miscellaneous Tab Button Wrapper
        local MiscellaneousTabButtonWrapper_UIListLayout =
            Create(
            "UIListLayout",
            {
                Parent = MiscellaneousTabButtonWrapper,
                Padding = UDim.new(0, 0),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        -- Miscellaneous Button
        local MiscellaneousTabButton =
            Create(
            "Frame",
            {
                Parent = MiscellaneousTabButtonWrapper,
                Name = "Button",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.80,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- Miscellaneous Tab Button UICorner
        local MiscellaneousTabButton_UICorner =
            Create(
            "UICorner",
            {
                Parent = MiscellaneousTabButton,
                CornerRadius = UDim.new(0, 6)
            }
        )

        -- Miscellaneous Tab Button Interact
        local MiscellaneousTabButtonInteract =
            Create(
            "TextButton",
            {
                Parent = MiscellaneousTabButton,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            }
        )

        -- Miscellaneous Tab Button Icon
        local MiscellaneousTabButtonIcon =
            Create(
            "ImageLabel",
            {
                Parent = MiscellaneousTabButton,
                Name = "Icon",
                AnchorPoint = Vector2.new(0.5, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Rotation = 0,
                Size = UDim2.new(1, -5, 1, -5),
                Visible = true,
                ClipsDescendants = false,
                Image = MiscellaneousTab_Icon,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            }
        )

        -- Miscellaneous Tab
        local MiscellaneousTab =
            Create(
            "Frame",
            {
                Parent = TabsFolder,
                Name = "Tab",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, -1, -25),
                Rotation = 0,
                Size = UDim2.new(1, -20, 1, -80),
                Visible = true,
                ClipsDescendants = true
            }
        )

        -- First Window
        if FirstWindow then
            MiscellaneousTab.Position = UDim2.new(0, 10, 0, 10)
        end

        -- Miscellaneous Tab UICorner
        local MiscellaneousTab_UICorner =
            Create(
            "UICorner",
            {
                Parent = MiscellaneousTab,
                CornerRadius = UDim.new(0, 6)
            }
        )

        --  Miscellaneous Container
        local MiscellaneousContainer =
            Create(
            "ScrollingFrame",
            {
                Parent = MiscellaneousTab,
                Name = "MiscellaneousContainer",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 5),
                Rotation = 0,
                Size = UDim2.new(1, -20, 1, -20),
                Visible = true,
                ClipsDescendants = true,
                AutomaticCanvasSize = 2,
                CanvasPosition = Vector2.new(0, 0),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarImageColor3 = ColorPalette.Black,
                ScrollBarThickness = 0,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ScrollingEnabled = true
            }
        )

        -- Miscellaneous Container UIListLayout
        local MiscellaneousContainer_UIListLayout =
            Create(
            "UIListLayout",
            {
                Parent = MiscellaneousContainer,
                Padding = UDim.new(0, 0),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        -- Miscellaneous Tab Button Mouse Enter Interaction
        MiscellaneousTabButtonInteract.MouseEnter:Connect(
            function()
                CreateTween(
                    MiscellaneousTabButton,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundTransparency = 0.75
                    }
                )
            end
        )

        -- Miscellaneous Tab Button Mouse Leave Interaction
        MiscellaneousTabButtonInteract.MouseLeave:Connect(
            function()
                CreateTween(
                    MiscellaneousTabButton,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundTransparency = 0.80
                    }
                )
            end
        )

        -- Miscellaneous Tab Button Interact
        MiscellaneousTabButtonInteract.MouseButton1Down:Connect(
            function()
                local Tabs = TabsFolder:GetChildren()
                for Index, Tab in next, Tabs do
                    if Tab:IsA("Frame") and Tab ~= MiscellaneousTab then
                        CreateTween(
                            Tab,
                            0.5,
                            Enum.EasingStyle.Exponential,
                            {
                                Position = UDim2.new(0, 10, -1, -25)
                            }
                        )
                    end
                end
                MiscellaneousTab.Position = UDim2.new(0, 10, -1, -25)
                CreateTween(
                    MiscellaneousTab,
                    0.5,
                    Enum.EasingStyle.Exponential,
                    {
                        Position = UDim2.new(0, 10, 0, 10)
                    }
                )
            end
        )

        -- Miscellaneous
        local Miscellaneous = {}

        -- Create Miscellaneous Section Function
        function Miscellaneous:CreateSection(SectionProperties)
            -- Section Properties
            local Section_Name = SectionProperties.Name

            -- Section
            local Section =
                Create(
                "Frame",
                {
                    Parent = MiscellaneousContainer,
                    Name = "Section",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 0, 20),
                    Visible = true,
                    ClipsDescendants = false
                }
            )

            -- Section Name
            local SectionName =
                Create(
                "TextLabel",
                {
                    Parent = Section,
                    Name = "Name",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold),
                    Text = Section_Name,
                    TextColor3 = ColorPalette.White,
                    TextSize = 13,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )
        end

        -- Create Miscellaneous Button Function
        function Miscellaneous:CreateButton(ButtonProperties)
            -- Button Properties
            local Button_Name = ButtonProperties.Name

            -- Button
            local Button =
                Create(
                "Frame",
                {
                    Parent = MiscellaneousContainer,
                    Name = "Button",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.Black,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 0, 34),
                    Visible = true,
                    ClipsDescendants = true
                }
            )

            -- Button UICorner
            local Button_UICorner =
                Create(
                "UICorner",
                {
                    Parent = Button,
                    CornerRadius = UDim.new(0, 6)
                }
            )

            -- Button Interact
            local ButtonInteract =
                Create(
                "TextButton",
                {
                    Parent = Button,
                    Name = "Interact",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    Text = "",
                    TextColor3 = ColorPalette.Black,
                    TextSize = 0,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.None,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )

            -- Button Text
            local ButtonText =
                Create(
                "TextLabel",
                {
                    Parent = Button,
                    Name = "Text",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, -80, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    Text = Button_Name,
                    TextColor3 = ColorPalette.White,
                    TextSize = 13,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )

            -- Button Icon
            local ButtonIcon =
                Create(
                "ImageLabel",
                {
                    Parent = Button,
                    Name = "Icon",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -20, 0, 7),
                    Rotation = 0,
                    Size = UDim2.new(0, 20, 0, 20),
                    Visible = true,
                    ClipsDescendants = false,
                    Image = Storage.Icons.Click,
                    ImageColor3 = ColorPalette.White,
                    ImageTransparency = 0,
                    ScaleType = Enum.ScaleType.Stretch
                }
            )

            -- Button Interaction
            ButtonInteract.MouseButton1Down:Connect(
                function()
                    local Success, Error =
                        pcall(
                        function()
                            BubbleEffect(Button)
                            ButtonProperties.Callback()
                        end
                    )
                    if not Success then
                        print("[Horizon Bar Error]: " .. Error)
                    end
                end
            )
        end

        -- Create Miscellaneous Toggle Function
        function Miscellaneous:CreateToggle(ToggleProperties)
            -- Toggle Properties
            local Toggle_Name = ToggleProperties.Name
            local Toggle_Value = ToggleProperties.Toggle_Value

            -- Toggle
            local Toggle =
                Create(
                "Frame",
                {
                    Parent = MiscellaneousContainer,
                    Name = "Toggle",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 0, 34),
                    Visible = true,
                    ClipsDescendants = true
                }
            )

            -- Toggle UICorner
            local Toggle_UICorner =
                Create(
                "UICorner",
                {
                    Parent = Toggle,
                    CornerRadius = UDim.new(0, 6)
                }
            )

            -- Toggle Interact
            local ToggleInteract =
                Create(
                "TextButton",
                {
                    Parent = Toggle,
                    Name = "Interact",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    Text = "",
                    TextColor3 = ColorPalette.Black,
                    TextSize = 0,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.None,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )

            -- Toggle Text
            local ToggleText =
                Create(
                "TextLabel",
                {
                    Parent = Toggle,
                    Name = "Text",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, -80, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    Text = Toggle_Name,
                    TextColor3 = ColorPalette.White,
                    TextSize = 13,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )

            -- Toggle Box
            local ToggleBox =
                Create(
                "Frame",
                {
                    Parent = Toggle,
                    Name = "ToggleBox",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.Black,
                    BackgroundTransparency = 0.60,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -40, 0, 7),
                    Rotation = 0,
                    Size = UDim2.new(0, 40, 0, 20),
                    Visible = true,
                    ClipsDescendants = false
                }
            )

            -- Toggle Box UICorner
            local ToggleBox_UICorner =
                Create(
                "UICorner",
                {
                    Parent = ToggleBox,
                    CornerRadius = UDim.new(1, 0)
                }
            )

            -- Toggle Ball
            local ToggleBall =
                Create(
                "Frame",
                {
                    Parent = ToggleBox,
                    Name = "ToggleBall",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 0,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 3, 0, 3),
                    Rotation = 0,
                    Size = UDim2.new(0, 14, 0, 14),
                    Visible = true,
                    ClipsDescendants = false
                }
            )

            -- Toggle Ball UICorner
            local ToggleBall_UICorner =
                Create(
                "UICorner",
                {
                    Parent = ToggleBall,
                    CornerRadius = UDim.new(1, 0)
                }
            )

            -- Toggle Value Configuration
            if Toggle_Value then
                CreateTween(
                    ToggleBall,
                    0.25,
                    Enum.EasingStyle.Exponential,
                    {
                        Position = UDim2.new(1, -17, 0, 3)
                    }
                )
                CreateTween(
                    ToggleBox,
                    0.25,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundColor3 = ColorPalette.Primary,
                        BackgroundTransparency = 0
                    }
                )
            end

            -- Toggle Interaction
            ToggleInteract.MouseButton1Down:Connect(
                function()
                    BubbleEffect(Toggle)
                    if not Toggle_Value then
                        CreateTween(
                            ToggleBall,
                            0.25,
                            Enum.EasingStyle.Exponential,
                            {
                                Position = UDim2.new(1, -17, 0, 3)
                            }
                        )
                        CreateTween(
                            ToggleBox,
                            0.25,
                            Enum.EasingStyle.Exponential,
                            {
                                BackgroundColor3 = ColorPalette.Primary,
                                BackgroundTransparency = 0
                            }
                        )
                        Toggle_Value = not Toggle_Value
                    else
                        CreateTween(
                            ToggleBall,
                            0.25,
                            Enum.EasingStyle.Exponential,
                            {
                                Position = UDim2.new(0, 3, 0, 3)
                            }
                        )
                        CreateTween(
                            ToggleBox,
                            0.25,
                            Enum.EasingStyle.Exponential,
                            {
                                BackgroundColor3 = ColorPalette.Black,
                                BackgroundTransparency = 0.60
                            }
                        )
                        Toggle_Value = not Toggle_Value
                    end
                    local Success, Error =
                        pcall(
                        function()
                            ToggleProperties.Callback(Toggle_Value)
                        end
                    )
                    if not Success then
                        print("[Horizon Bar Error]: " .. Error)
                    end
                end
            )
        end

        function Miscellaneous:CreateSlider(Properties)
            local Name        = Properties.Name
            local Min         = Properties.Min
            local Max         = Properties.Max
            local Increment   = Properties.Increment or 1
            local Decimals    = Properties.DecimalPrecision or 0
            local Value       = tonumber(Properties.CurrentValue) or Min
            local Callback    = Properties.Callback or function() end

            local Slider = Create("Frame", {
                Parent = MiscellaneousContainer,
                Size = UDim2.new(1, 0, 0, 34),
                BackgroundTransparency = 1,
            })

            Create("UICorner", { Parent = Slider, CornerRadius = UDim.new(0, 6) })

            local Label = Create("TextLabel", {
                Parent = Slider,
                Size = UDim2.new(1, -120, 1, 0),
                BackgroundTransparency = 1,
                Text = Name,
                TextColor3 = ColorPalette.White,
                TextSize = 13,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local Track = Create("Frame", {
                Parent = Slider,
                Position = UDim2.new(1, -120, 0, 6),
                Size     = UDim2.new(0, 120, 0, 22),
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.6,
            })

            Create("UICorner", { Parent = Track, CornerRadius = UDim.new(0, 6) })

            local Fill = Create("Frame", {
                Parent = Track,
                Size = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = ColorPalette.Primary
            })

            Create("UICorner", { Parent = Fill, CornerRadius = UDim.new(0, 6) })

            local ValueText = Create("TextLabel", {
                Parent = Track,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = tostring(Value),
                TextColor3 = ColorPalette.White,
                TextSize = 13,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                TextXAlignment = Enum.TextXAlignment.Center,
            })

            local Interact = Create("TextButton", {
                Parent = Slider,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                BackgroundTransparency = 1
            })

            local dragging = false

            local function SetValueFromPercent(pct)
                pct = math.clamp(pct, 0, 1)

                -- convert pct → value
                local range = Max - Min
                local raw = Min + pct * range

                local rounded = math.floor(raw / Increment + 0.5) * Increment
                rounded = math.clamp(rounded, Min, Max)

                Value = rounded

                local pctRounded = (Value - Min) / (Max - Min)
                Fill.Size = UDim2.new(pctRounded, 0, 1, 0)

                ValueText.Text = string.format("%." .. Decimals .. "f", Value)
                Callback(Value)
            end

            local function UpdateFromMouse()
                local mouse = UserInputService:GetMouseLocation().X
                local pos = Track.AbsolutePosition.X
                local width = Track.AbsoluteSize.X

                if width <= 0 then return end

                local pct = (mouse - pos) / width
                SetValueFromPercent(pct)
            end

            Interact.MouseButton1Down:Connect(function()
                dragging = true

                CreateTween(Label, 0.4, Enum.EasingStyle.Exponential, { Position = UDim2.new(-1, 0, 0, 0) })
                CreateTween(Track, 0.4, Enum.EasingStyle.Exponential, { Position = UDim2.new(0, 0, 0, 6), Size = UDim2.new(1, 0, 0, 22) })

                UpdateFromMouse()
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false

                    CreateTween(Label, 0.4, Enum.EasingStyle.Exponential, { Position = UDim2.new(0, 0, 0, 0) })
                    CreateTween(Track, 0.4, Enum.EasingStyle.Exponential, { Position = UDim2.new(1, -120, 0, 6), Size = UDim2.new(0, 120, 0, 22) })
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    UpdateFromMouse()
                end
            end)

            SetValueFromPercent((Value - Min) / (Max - Min))
        end


        function Miscellaneous:CreateInput(InputProperties)
            -- Input Properties
            local Input_Name = InputProperties.Name
            local Input_PlaceholderText = InputProperties.PlaceholderText

            -- Input
            local Input =
                Create(
                "Frame",
                {
                    Parent = MiscellaneousContainer,
                    Name = "Input",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.Black,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 0, 34),
                    Visible = true,
                    ClipsDescendants = false
                }
            )

            -- Input UICorner
            local Input_UICorner =
                Create(
                "UICorner",
                {
                    Parent = Input,
                    CornerRadius = UDim.new(0, 6)
                }
            )

            -- Input Interact
            local InputInteract =
                Create(
                "TextButton",
                {
                    Parent = Input,
                    Name = "Interact",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    Text = "",
                    TextColor3 = ColorPalette.Black,
                    TextSize = 0,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.None,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )

            -- Input Text
            local InputText =
                Create(
                "TextLabel",
                {
                    Parent = Input,
                    Name = "Text",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, -120, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    Text = Input_Name,
                    TextColor3 = ColorPalette.White,
                    TextSize = 13,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )

            -- Input Box
            local InputBox =
                Create(
                "TextBox",
                {
                    Parent = Input,
                    Name = "InputBox",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.Black,
                    BackgroundTransparency = 0.60,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -120, 0, 6),
                    Rotation = 0,
                    Size = UDim2.new(0, 120, 0, 22),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    PlaceholderText = Input_PlaceholderText,
                    PlaceholderColor3 = ColorPalette.Gray,
                    Text = "",
                    TextColor3 = ColorPalette.White,
                    TextSize = 13,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )

            -- Input Box UICorner
            local InputBox_UICorner =
                Create(
                "UICorner",
                {
                    Parent = InputBox,
                    CornerRadius = UDim.new(0, 6)
                }
            )

            -- Input Box Focused
            InputBox.Focused:Connect(
                function()
                    CreateTween(
                        InputText,
                        0.5,
                        Enum.EasingStyle.Exponential,
                        {
                            Position = UDim2.new(-1, 0, 0, 0)
                        }
                    )
                    CreateTween(
                        InputBox,
                        0.5,
                        Enum.EasingStyle.Exponential,
                        {
                            Position = UDim2.new(0, 0, 0, 6),
                            Size = UDim2.new(1, 0, 0, 22)
                        }
                    )
                end
            )

            -- Input Box Focus Lost
            InputBox.FocusLost:Connect(
                function()
                    CreateTween(
                        InputText,
                        0.5,
                        Enum.EasingStyle.Exponential,
                        {
                            Position = UDim2.new(0, 0, 0, 0)
                        }
                    )
                    CreateTween(
                        InputBox,
                        0.5,
                        Enum.EasingStyle.Exponential,
                        {
                            Position = UDim2.new(1, -120, 0, 6),
                            Size = UDim2.new(0, 120, 0, 22)
                        }
                    )
                    local Success, Error =
                        pcall(
                        function()
                            InputProperties.Callback(InputBox.Text)
                        end
                    )
                    if not Success then
                        print("[Horizon Bar Error]: " .. Error)
                    end
                end
            )
        end

        return Miscellaneous
    end

    -- Create User Tab Function
    function Window:CreateUserTab(UserTabProperties)
        -- User Tab Properties
        local UserTab_Name = UserTabProperties.Name
        local UserTab_Icon = UserTabProperties.Icon
        local FirstWindow = UserTabProperties.FirstWindow

        -- User Button Wrapper
        local UserTabButtonWrapper =
            Create(
            "Frame",
            {
                Parent = TabButtonContainer,
                Name = "Wrapper",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(0, 35, 0, 35),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- User Tab Button Wrapper
        local UserTabButtonWrapper_UIListLayout =
            Create(
            "UIListLayout",
            {
                Parent = UserTabButtonWrapper,
                Padding = UDim.new(0, 0),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        -- User Button
        local UserTabButton =
            Create(
            "Frame",
            {
                Parent = UserTabButtonWrapper,
                Name = "Button",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.80,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- User Tab Button UICorner
        local UserTabButton_UICorner =
            Create(
            "UICorner",
            {
                Parent = UserTabButton,
                CornerRadius = UDim.new(0, 6)
            }
        )

        -- User Tab Button Interact
        local UserTabButtonInteract =
            Create(
            "TextButton",
            {
                Parent = UserTabButton,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            }
        )

        -- User Tab Button Icon
        local UserTabButtonIcon =
            Create(
            "ImageLabel",
            {
                Parent = UserTabButton,
                Name = "Icon",
                AnchorPoint = Vector2.new(0.5, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Rotation = 0,
                Size = UDim2.new(1, -5, 1, -5),
                Visible = true,
                ClipsDescendants = false,
                Image = UserTab_Icon,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            }
        )

        -- User Tab
        local UserTab =
            Create(
            "Frame",
            {
                Parent = TabsFolder,
                Name = "Tab",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, -1, -25),
                Rotation = 0,
                Size = UDim2.new(1, -20, 1, -80),
                Visible = true,
                ClipsDescendants = true
            }
        )

        -- First Window
        if FirstWindow then
            UserTab.Position = UDim2.new(0, 10, 0, 10)
        end

        -- User Tab UICorner
        local UserTab_UICorner =
            Create(
            "UICorner",
            {
                Parent = UserTab,
                CornerRadius = UDim.new(0, 6)
            }
        )

        --  User Container (scaled)
        local UserContainer =
            Create(
            "ScrollingFrame",
            {
                Parent = UserTab,
                Name = "UserContainer",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 10),
                Rotation = 0,
                Size = UDim2.new(1, -20, 0.28, 0), -- use a proportional height
                Visible = true,
                ClipsDescendants = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasPosition = Vector2.new(0, 0),
                ScrollBarImageColor3 = ColorPalette.Black,
                ScrollBarThickness = 4,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ScrollingEnabled = true
            }
        )

        -- User Container UIListLayout
        local UserContainer_UIListLayout =
            Create(
            "UIListLayout",
            {
                Parent = UserContainer,
                Padding = UDim.new(0, 6),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        -- User Tab Button Mouse Enter Interaction
        UserTabButtonInteract.MouseEnter:Connect(
            function()
                CreateTween(
                    UserTabButton,
                    0.35,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundTransparency = 0.72
                    }
                )
            end
        )

        -- User Tab Button Mouse Leave Interaction
        UserTabButtonInteract.MouseLeave:Connect(
            function()
                CreateTween(
                    UserTabButton,
                    0.35,
                    Enum.EasingStyle.Exponential,
                    {
                        BackgroundTransparency = 0.80
                    }
                )
            end
        )

        -- User Tab Button Interact
        UserTabButtonInteract.MouseButton1Down:Connect(
            function()
                local Tabs = TabsFolder:GetChildren()
                for Index, Tab in next, Tabs do
                    if Tab:IsA("Frame") and Tab ~= UserTab then
                        CreateTween(
                            Tab,
                            0.4,
                            Enum.EasingStyle.Exponential,
                            {
                                Position = UDim2.new(0, 10, -1, -25)
                            }
                        )
                    end
                end
                UserTab.Position = UDim2.new(0, 10, -1, -25)
                CreateTween(
                    UserTab,
                    0.4,
                    Enum.EasingStyle.Exponential,
                    {
                        Position = UDim2.new(0, 10, 0, 10)
                    }
                )
            end
        )

        -- User Profile (responsive)
        local UserProfile =
            Create(
            "Frame",
            {
                Parent = UserTab,
                Name = "UserProfile",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 10),
                Rotation = 0,
                Size = UDim2.new(1, -20, 0.28, 0), -- proportional to tab
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- User Profile UICorner
        local UserProfile_UICorner =
            Create(
            "UICorner",
            {
                Parent = UserProfile,
                CornerRadius = UDim.new(0, 6)
            }
        )

        -- User PFP (scaled)
        local UserPFP =
            Create(
            "ImageLabel",
            {
                Parent = UserProfile,
                Name = "PFP",
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Black,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 15, 0.5, 0),
                Rotation = 0,
                Size = UDim2.new(0.22, 0, 0.8, 0), -- percentage of profile height
                Visible = true,
                ClipsDescendants = false,
                Image = Players:GetUserThumbnailAsync(
                    Players.LocalPlayer.UserId,
                    Enum.ThumbnailType.HeadShot,
                    Enum.ThumbnailSize.Size420x420
                ),
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Crop
            }
        )

        -- User PFP UICorner
        local UserPFP_UICorner =
            Create(
            "UICorner",
            {
                Parent = UserPFP,
                CornerRadius = UDim.new(1, 0)
            }
        )

        -- Username (responsive position/size)
        local Username =
            Create(
            "TextLabel",
            {
                Parent = UserProfile,
                Name = "Username",
                AnchorPoint = Vector2.new(0, 0.2),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0.28, 10, 0.18, 0),
                Rotation = 0,
                Size = UDim2.new(0.68, -25, 0.25, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                Text = Players.LocalPlayer.Name,
                TextColor3 = ColorPalette.White,
                TextSize = 20,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            }
        )

        -- Display Name
        local DisplayName =
            Create(
            "TextLabel",
            {
                Parent = UserProfile,
                Name = "DisplayName",
                AnchorPoint = Vector2.new(0, 0.2),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0.28, 10, 0.43, 0),
                Rotation = 0,
                Size = UDim2.new(0.68, -25, 0.2, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                Text = "@" .. Players.LocalPlayer.DisplayName,
                TextColor3 = ColorPalette.Gray,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            }
        )

        -- User Whitelist Status (responsive)
        local UserWhitelistStatus =
            Create(
            "Frame",
            {
                Parent = UserProfile,
                Name = "UserWhitelistStatus",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0.28, 10, 0.7, 0),
                Rotation = 0,
                Size = UDim2.new(0.35, 0, 0.18, 0),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- User Whitelist Status UICorner
        local UserWhitelistStatus_UICorner =
            Create(
            "UICorner",
            {
                Parent = UserWhitelistStatus,
                CornerRadius = UDim.new(0, 6)
            }
        )

        -- User Whitelist Status UIGradient
        local UserWhitelistStatus_UIGradient =
            Create(
            "UIGradient",
            {
                Parent = UserWhitelistStatus,
                Rotation = 0,
                Color = ColorSequence.new {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 189, 0)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 135, 0))
                }
            }
        )

        -- User Whitelist Status Icon
        local UserWhitelistStatusIcon =
            Create(
            "ImageLabel",
            {
                Parent = UserWhitelistStatus,
                Name = "Icon",
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 8, 0.5, 0),
                Rotation = 0,
                Size = UDim2.new(0, 18, 0, 18),
                Visible = true,
                ClipsDescendants = false,
                Image = Storage.Icons.WhitelistStatus,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            }
        )

        -- User Whitelist Status Text
        local UserWhitelistStatusText =
            Create(
            "TextLabel",
            {
                Parent = UserWhitelistStatus,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 34, 0.5, -8),
                Rotation = 0,
                Size = UDim2.new(1, -34, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                Text = "PREMIUM",
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            }
        )

        -- Robbery Stats Container (responsive placement)
        local RobberyStatsContainer =
            Create(
            "Frame",
            {
                Parent = UserTab,
                Name = "RobberyStatsContainer",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, UserProfile.AbsoluteSize.Y + 20),
                Rotation = 0,
                Size = UDim2.new(1, -20, 0.08, 0), -- fixed small height proportion
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- Robbery Stats Container UIListLayout
        local RobberyStatsContainer_UIListLayout =
            Create(
            "UIListLayout",
            {
                Parent = RobberyStatsContainer,
                Padding = UDim.new(0, 8),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        -- Execution Stats
        local ExecutionStats =
            Create(
            "Frame",
            {
                Parent = RobberyStatsContainer,
                Name = "ExecutionStats",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(0.32, 0, 1, 0), -- use portion of width
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- Execution Stats UICorner
        local ExecutionStats_UICorner =
            Create(
            "UICorner",
            {
                Parent = ExecutionStats,
                CornerRadius = UDim.new(0, 6)
            }
        )

        -- Execution Stats Icon
        local ExecutionStatsIcon =
            Create(
            "ImageLabel",
            {
                Parent = ExecutionStats,
                Name = "Icon",
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 8, 0.5, 0),
                Rotation = 0,
                Size = UDim2.new(0, 20, 0, 20),
                Visible = true,
                ClipsDescendants = false,
                Image = Storage.Icons.Execution,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            }
        )

        -- Execution Stats Text
        local ExecutionStatsText =
            Create(
            "TextLabel",
            {
                Parent = ExecutionStats,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 36, 0.5, -10),
                Rotation = 0,
                Size = UDim2.new(1, -40, 0.9, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                Text = "0000",
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            }
        )

        -- Money Stats
        local MoneyStats =
            Create(
            "Frame",
            {
                Parent = RobberyStatsContainer,
                Name = "MoneyStats",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(0.32, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- Money Stats UICorner
        local MoneyStats_UICorner =
            Create(
            "UICorner",
            {
                Parent = MoneyStats,
                CornerRadius = UDim.new(0, 6)
            }
        )

        -- Money Stats Icon
        local MoneyStatsIcon =
            Create(
            "ImageLabel",
            {
                Parent = MoneyStats,
                Name = "Icon",
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 8, 0.5, 0),
                Rotation = 0,
                Size = UDim2.new(0, 20, 0, 20),
                Visible = true,
                ClipsDescendants = false,
                Image = Storage.Icons.Money,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            }
        )

        -- Money Stats Text
        local MoneyStatsText =
            Create(
            "TextLabel",
            {
                Parent = MoneyStats,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 36, 0.5, -10),
                Rotation = 0,
                Size = UDim2.new(1, -40, 0.9, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                Text = "0000",
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            }
        )

        -- Time Stats
        local TimeStats =
            Create(
            "Frame",
            {
                Parent = RobberyStatsContainer,
                Name = "TimeStats",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(0.32, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false
            }
        )

        -- Time Stats UICorner
        local TimeStats_UICorner =
            Create(
            "UICorner",
            {
                Parent = TimeStats,
                CornerRadius = UDim.new(0, 6)
            }
        )

        local TimeStatsIcon =
            Create(
            "ImageLabel",
            {
                Parent = TimeStats,
                Name = "Icon",
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 8, 0.5, 0),
                Rotation = 0,
                Size = UDim2.new(0, 20, 0, 20),
                Visible = true,
                ClipsDescendants = false,
                Image = Storage.Icons.Time,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            }
        )

        local TimeStatsText =
            Create(
            "TextLabel",
            {
                Parent = TimeStats,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 36, 0.5, -10),
                Rotation = 0,
                Size = UDim2.new(1, -40, 0.9, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                Text = "0000",
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            }
        )

        local Credits =
            Create(
            "Frame",
            {
                Parent = UserTab,
                Name = "Credits",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, UserProfile.AbsoluteSize.Y + RobberyStatsContainer.AbsoluteSize.Y + 30),
                Rotation = 0,
                Size = UDim2.new(1, -20, 0.45, 0),
                Visible = true,
                ClipsDescendants = false
            }
        )

        local Credits_UICorner =
            Create(
            "UICorner",
            {
                Parent = Credits,
                CornerRadius = UDim.new(0, 6)
            }
        )

        local CreditsContainer =
            Create(
            "ScrollingFrame",
            {
                Parent = Credits,
                Name = "CreditsContainer",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasPosition = Vector2.new(0, 0),
                ScrollBarImageColor3 = ColorPalette.Black,
                ScrollBarThickness = 6,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ScrollingEnabled = true
            }
        )

        local CreditsContainer_UIListLayout =
            Create(
            "UIListLayout",
            {
                Parent = CreditsContainer,
                Padding = UDim.new(0, 8),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )

        local CreditsContainer_UIPadding =
            Create(
            "UIPadding",
            {
                Parent = CreditsContainer,
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 8)
            }
        )

        local User = {}

        function User:CreateCredit(CreditProperties)
            local CreditText = CreditProperties.Text

            local UserCredits =
                Create(
                "Frame",
                {
                    Parent = CreditsContainer,
                    Name = "UserCredits",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 0.9,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 0, 38),
                    Visible = true,
                    ClipsDescendants = false
                }
            )

            local UserCredits_UICorner =
                Create(
                "UICorner",
                {
                    Parent = UserCredits,
                    CornerRadius = UDim.new(0, 6)
                }
            )

            local userCreditsText =
                Create(
                "TextLabel",
                {
                    Parent = UserCredits,
                    Name = "Text",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold),
                    Text = CreditText,
                    TextColor3 = ColorPalette.White,
                    TextSize = 16,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.None,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center
                }
            )
        end

        function User:SetExecutionText(ExecutionTextProperties)
            local Text = ExecutionTextProperties.Text
            ExecutionStatsText.Text = Text
        end

        function User:SetMoneyText(MoneyTextProperties)
            local Text = MoneyTextProperties.Text
            MoneyStatsText.Text = Text
        end

        function User:SetTimeText(TimeTextProperties)
            local Text = TimeTextProperties.Text
            TimeStatsText.Text = Text
        end

        return User
    end

	_G.NotificationUI = "HorizonNotifications"

local HorizonNotificationUI = Instance.new("ScreenGui")
local uiparent = (gethui and gethui()) or Players.LocalPlayer.PlayerGui
HorizonNotificationUI.Name = _G.NotificationUI
if uiparent:FindFirstChild(_G.NotificationUI) then
    uiparent:FindFirstChild(_G.NotificationUI).Parent = nil
end

HorizonNotificationUI.Parent = uiparent

local ColorPalette = {
    Black = Color3.fromRGB(0, 0, 0),
    Dark = Color3.fromRGB(25, 25, 25),
    Gray = Color3.fromRGB(185, 185, 185),
    DarkGray = Color3.fromRGB(50, 50, 50),
    White = Color3.fromRGB(255, 255, 255),
    Primary = Color3.fromRGB(87, 166, 199),
    Success = Color3.fromRGB(87, 166, 199),
    Warning = Color3.fromRGB(199, 166, 87),
    Error = Color3.fromRGB(199, 87, 87),
    Info = Color3.fromRGB(87, 166, 199)
}

local Storage = {
    Icons = {
        Success = "rbxassetid://11293982222",
        Warning = "rbxassetid://11293983062",
        Error = "rbxassetid://11293981855",
        Info = "rbxassetid://11293981644",
        Notification = "rbxassetid://11293981392"
    }
}

local NotificationConfig = {
    MaxNotifications = 5,
    DefaultDuration = 5,
    AnimationDuration = 0.3,
    NotificationWidth = 300,
    NotificationHeight = 80,
    Padding = 10,
    Position = "TopRight" 
}

local ActiveNotifications = {}
local IsUpdatingPositions = false

local function Create(Object_Type, Object_Properties)
    local Object = Instance.new(Object_Type)
    for Property, Value in next, Object_Properties do
        Object[Property] = Value
    end
    return Object
end

local function CreateTween(Object, Tween_Duration, Tween_Easing_Style, Tween_Properties)
    local TweenInfo = TweenInfo.new(Tween_Duration, Tween_Easing_Style)
    local Tween = TweenService:Create(Object, TweenInfo, Tween_Properties)
    Tween:Play()
    return Tween
end

local function Shadow(ShadowProperties)
    local ShadowFrame =
        Create(
        "Frame",
        {
            Parent = ShadowProperties.Parent,
            Name = "ShadowFrame",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = false
        }
    )

    local ShadowFrame_UICorner =
        Create(
        "UICorner",
        {
            Parent = ShadowFrame,
            CornerRadius = UDim.new(0, ShadowProperties.CornerRadius)
        }
    )

    local ShadowFrame_UIStroke =
        Create(
        "UIStroke",
        {
            Parent = ShadowFrame,
            Color = ColorPalette.Black,
            Thickness = ShadowProperties.Thickness,
            Transparency = ShadowProperties.Transparency
        }
    )
end

local function Gradient(GradientProperties)
    local GradientFrame =
        Create(
        "Frame",
        {
            Parent = GradientProperties.Parent,
            Name = "GradientFrame",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = false
        }
    )

    local GradientFrame_UICorner =
        Create(
        "UICorner",
        {
            Parent = GradientFrame,
            CornerRadius = UDim.new(0, GradientProperties.CornerRadius)
        }
    )

    local GradientFrame_UIGradient =
        Create(
        "UIGradient",
        {
            Parent = GradientFrame,
            Color = GradientProperties.Color,
            Rotation = GradientProperties.Rotation,
            Transparency = GradientProperties.Transparency
        }
    )
end

local NotificationContainer =
    Create(
    "Frame",
    {
        Parent = HorizonNotificationUI,
        Name = "NotificationContainer",
        AnchorPoint = Vector2.new(1, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.White,
        BackgroundTransparency = 1,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -10, 0, 10),
        Rotation = 0,
        Size = UDim2.new(0, NotificationConfig.NotificationWidth, 1, -20),
        Visible = true,
        ClipsDescendants = false
    }
)

local function GetTypeColor(NotificationType)
    if NotificationType == "Success" then
        return ColorPalette.Success
    elseif NotificationType == "Warning" then
        return ColorPalette.Warning
    elseif NotificationType == "Error" then
        return ColorPalette.Error
    elseif NotificationType == "Info" then
        return ColorPalette.Info
    else
        return ColorPalette.Primary
    end
end

local function GetTypeIcon(NotificationType)
    if NotificationType == "Success" then
        return Storage.Icons.Success
    elseif NotificationType == "Warning" then
        return Storage.Icons.Warning
    elseif NotificationType == "Error" then
        return Storage.Icons.Error
    elseif NotificationType == "Info" then
        return Storage.Icons.Info
    else
        return Storage.Icons.Notification
    end
end

local function UpdateNotificationPositions(animate)
    if IsUpdatingPositions then return end
    IsUpdatingPositions = true
    
    local yOffset = 0
    for i, notification in ipairs(ActiveNotifications) do
        if notification and notification.Parent then
            local targetPos = UDim2.new(0, 0, 0, yOffset)
            if animate ~= false then
                CreateTween(notification, 0.2, Enum.EasingStyle.Quint, {Position = targetPos})
            else
                notification.Position = targetPos
            end
            yOffset = yOffset + notification.AbsoluteSize.Y + 10
        end
    end
    
    IsUpdatingPositions = false
end

local function RemoveNotification(NotificationFrame)
    for i, notification in ipairs(ActiveNotifications) do
        if notification == NotificationFrame then
            table.remove(ActiveNotifications, i)
            break
        end
    end

    local FadeOutTween = CreateTween(
        NotificationFrame,
        NotificationConfig.AnimationDuration,
        Enum.EasingStyle.Quint,
        {
            Size = UDim2.new(0, NotificationConfig.NotificationWidth, 0, 0),
            BackgroundTransparency = 1
        }
    )

    FadeOutTween.Completed:Connect(function()
        NotificationFrame:Destroy()
        UpdateNotificationPositions()
    end)
end

local HorizonNotificationLibrary = {}

function HorizonNotificationLibrary:Notify(NotificationProperties)
    local Notification_Title = NotificationProperties.Title or "Notification"
    local Notification_Message = NotificationProperties.Message or ""
    local Notification_Type = NotificationProperties.Type or "Info" -- Success, Warning, Error, Info
    local Notification_Duration = NotificationProperties.Duration or NotificationConfig.DefaultDuration
    local Notification_Callback = NotificationProperties.Callback

    if #ActiveNotifications >= NotificationConfig.MaxNotifications then
        RemoveNotification(ActiveNotifications[1])
    end

    local TypeColor = GetTypeColor(Notification_Type)
    local TypeIcon = GetTypeIcon(Notification_Type)

    local NotificationFrame =
        Create(
        "Frame",
        {
            Parent = NotificationContainer,
            Name = "NotificationFrame",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = ColorPalette.Dark,
            BackgroundTransparency = 0,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(1, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, NotificationConfig.NotificationWidth, 0, 0),
            Visible = true,
            ClipsDescendants = true
        }
    )

    table.insert(ActiveNotifications, NotificationFrame)

    local lastHeight = 0
    local sizeConnection
    sizeConnection = NotificationFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        local newHeight = NotificationFrame.AbsoluteSize.Y
        if math.abs(newHeight - lastHeight) > 1 then
            lastHeight = newHeight
            UpdateNotificationPositions()
        end
    end)

    local NotificationFrame_UICorner =
        Create(
        "UICorner",
        {
            Parent = NotificationFrame,
            CornerRadius = UDim.new(0, 8)
        }
    )

    local NotificationFrame_UIStroke =
        Create(
        "UIStroke",
        {
            Parent = NotificationFrame,
            Color = ColorPalette.White,
            Thickness = 1,
            Transparency = 0.85
        }
    )

    local NotificationShadowFolder =
        Create(
        "Folder",
        {
            Parent = NotificationFrame,
            Name = "Shadow"
        }
    )

    Shadow(
        {
            Parent = NotificationShadowFolder,
            Thickness = 1,
            Transparency = 0.95,
            CornerRadius = 8
        }
    )

    Shadow(
        {
            Parent = NotificationShadowFolder,
            Thickness = 3,
            Transparency = 0.95,
            CornerRadius = 8
        }
    )

    local NotificationGradientFolder =
        Create(
        "Folder",
        {
            Parent = NotificationFrame,
            Name = "Gradient"
        }
    )

    Gradient(
        {
            Parent = NotificationGradientFolder,
            Color = ColorSequence.new {
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(25, 24, 24)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(87, 166, 199))
            },
            Rotation = 0,
            Transparency = NumberSequence.new {
                NumberSequenceKeypoint.new(0.00, 0.98),
                NumberSequenceKeypoint.new(0.56, 1.00),
                NumberSequenceKeypoint.new(1.00, 0.27)
            },
            CornerRadius = 8
        }
    )

    local ContentFrame =
        Create(
        "Frame",
        {
            Parent = NotificationFrame,
            Name = "ContentFrame",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 0, 0),
            Visible = true,
            ClipsDescendants = false
        }
    )

    local ContentFrame_UIPadding =
        Create(
        "UIPadding",
        {
            Parent = ContentFrame,
            PaddingTop = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15),
            PaddingLeft = UDim.new(0, 25),
            PaddingRight = UDim.new(0, 25)
        }
    )

    local ContentFrame_UIListLayout =
        Create(
        "UIListLayout",
        {
            Parent = ContentFrame,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 2)
        }
    )

    local TitleRowFrame =
        Create(
        "Frame",
        {
            Parent = ContentFrame,
            Name = "TitleRowFrame",
            LayoutOrder = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 16),
            ClipsDescendants = false
        }
    )

    local TitleRow_UIListLayout =
        Create(
        "UIListLayout",
        {
            Parent = TitleRowFrame,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6)
        }
    )

    local CircularProgressBar =
        Create(
        "Frame",
        {
            Parent = TitleRowFrame,
            Name = "CircularProgressBar",
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 15, 0, 15)
        }
    )

    local Half2 =
        Create(
        "Frame",
        {
            Parent = CircularProgressBar,
            Name = "Half2",
            Size = UDim2.new(0.5, 0, 1, 0),
            ClipsDescendants = true,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }
    )

    local ImageLabel_Half2 =
        Create(
        "ImageLabel",
        {
            Parent = Half2,
            Size = UDim2.new(2, 0, 1, 0),
            BackgroundTransparency = 1,
            ImageColor3 = ColorPalette.White,
            Image = "rbxassetid://2763450503"
        }
    )

    local UIGradient_Half2 =
        Create(
        "UIGradient",
        {
            Parent = ImageLabel_Half2,
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0.499, 0),
                NumberSequenceKeypoint.new(0.5, 1),
                NumberSequenceKeypoint.new(0.501, 1),
                NumberSequenceKeypoint.new(1, 1)
            }),
            Rotation = -180
        }
    )

    local Half1 =
        Create(
        "Frame",
        {
            Parent = CircularProgressBar,
            Name = "Half1",
            Size = UDim2.new(0.5, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            ClipsDescendants = true,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }
    )

    local ImageLabel_Half1 =
        Create(
        "ImageLabel",
        {
            Parent = Half1,
            Size = UDim2.new(2, 0, 1, 0),
            Position = UDim2.new(-1, 0, 0, 0),
            BackgroundTransparency = 1,
            ImageColor3 = ColorPalette.White,
            Image = "rbxassetid://2763450503"
        }
    )

    local UIGradient_Half1 =
        Create(
        "UIGradient",
        {
            Parent = ImageLabel_Half1,
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0.499, 0),
                NumberSequenceKeypoint.new(0.5, 1),
                NumberSequenceKeypoint.new(0.501, 1),
                NumberSequenceKeypoint.new(1, 1)
            }),
            Rotation = 0
        }
    )

    local TitleLabel =
        Create(
        "TextLabel",
        {
            Parent = TitleRowFrame,
            Name = "TitleLabel",
            LayoutOrder = 2,
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 0, 0, 0),
            Visible = true,
            FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold),
            Text = Notification_Title,
            TextColor3 = ColorPalette.White,
            TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextTruncate = Enum.TextTruncate.AtEnd
        }
    )

    local MessageLabel =
        Create(
        "TextLabel",
        {
            Parent = ContentFrame,
            Name = "MessageLabel",
            LayoutOrder = 2,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 0),
            Visible = true,
            FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Medium),
            Text = Notification_Message,
            TextColor3 = ColorPalette.Gray,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            TextTruncate = Enum.TextTruncate.AtEnd
        }
    )

    local CloseButton =
        Create(
        "TextButton",
        {
            Parent = NotificationFrame,
            Name = "CloseButton",
            AnchorPoint = Vector2.new(1, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(1, -5, 0, 5),
            Rotation = 0,
            Size = UDim2.new(0, 20, 0, 20),
            Visible = true,
            FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold),
            Text = "×",
            TextColor3 = ColorPalette.Gray,
            TextSize = 18
        }
    )

    CloseButton.MouseEnter:Connect(function()
        CreateTween(
            CloseButton,
            0.2,
            Enum.EasingStyle.Quint,
            {
                TextColor3 = ColorPalette.White
            }
        )
    end)

    CloseButton.MouseLeave:Connect(function()
        CreateTween(
            CloseButton,
            0.2,
            Enum.EasingStyle.Quint,
            {
                TextColor3 = ColorPalette.Gray
            }
        )
    end)

    CloseButton.MouseButton1Click:Connect(function()
        RemoveNotification(NotificationFrame)
        if Notification_Callback then
            Notification_Callback("Closed")
        end
    end)

    task.defer(function()
        task.wait()
        UpdateNotificationPositions(false)
        NotificationFrame.Position = UDim2.new(1, 50, 0, NotificationFrame.Position.Y.Offset)
        CreateTween(NotificationFrame, NotificationConfig.AnimationDuration, Enum.EasingStyle.Quint, {
            Position = UDim2.new(0, 0, 0, NotificationFrame.Position.Y.Offset)
        })
    end)

    task.spawn(function()
        local Phase1Tween = CreateTween(
            UIGradient_Half1,
            Notification_Duration / 2,
            Enum.EasingStyle.Linear,
            {
                Rotation = 180
            }
        )
        Phase1Tween.Completed:Wait()
        
        local Phase2Tween = CreateTween(
            UIGradient_Half2,
            Notification_Duration / 2,
            Enum.EasingStyle.Linear,
            {
                Rotation = 0
            }
        )
    end)

    task.delay(Notification_Duration, function()
        if NotificationFrame and NotificationFrame.Parent then
            RemoveNotification(NotificationFrame)
            if Notification_Callback then
                Notification_Callback("Expired")
            end
        end
    end)

    return {
        Frame = NotificationFrame,
        Close = function()
            RemoveNotification(NotificationFrame)
        end,
        UpdateMessage = function(NewMessage)
            MessageLabel.Text = NewMessage
        end,
        UpdateTitle = function(NewTitle)
            TitleLabel.Text = NewTitle
        end
    }
end

function HorizonNotificationLibrary:Success(Title, Message, Duration)
    return self:Notify({
        Title = Title,
        Message = Message,
        Type = "Success",
        Duration = Duration
    })
end

function HorizonNotificationLibrary:Warning(Title, Message, Duration)
    return self:Notify({
        Title = Title,
        Message = Message,
        Type = "Warning",
        Duration = Duration
    })
end

function HorizonNotificationLibrary:Error(Title, Message, Duration)
    return self:Notify({
        Title = Title,
        Message = Message,
        Type = "Error",
        Duration = Duration
    })
end

function HorizonNotificationLibrary:Info(Title, Message, Duration)
    return self:Notify({
        Title = Title,
        Message = Message,
        Type = "Info",
        Duration = Duration
    })
end

function HorizonNotificationLibrary:ClearAll()
    for i = #ActiveNotifications, 1, -1 do
        RemoveNotification(ActiveNotifications[i])
    end
end

-- Set Position Function
function HorizonNotificationLibrary:SetPosition(Position)
    NotificationConfig.Position = Position

    if Position == "TopRight" then
        NotificationContainer.AnchorPoint = Vector2.new(1, 0)
        NotificationContainer.Position = UDim2.new(1, -10, 0, 10)
    elseif Position == "TopLeft" then
        NotificationContainer.AnchorPoint = Vector2.new(0, 0)
        NotificationContainer.Position = UDim2.new(0, 10, 0, 10)
    elseif Position == "BottomRight" then
        NotificationContainer.AnchorPoint = Vector2.new(1, 1)
        NotificationContainer.Position = UDim2.new(1, -10, 1, -10)
    elseif Position == "BottomLeft" then
        NotificationContainer.AnchorPoint = Vector2.new(0, 1)
        NotificationContainer.Position = UDim2.new(0, 10, 1, -10)
    end
    
    UpdateNotificationPositions()
end

function HorizonNotificationLibrary:SetMaxNotifications(Max)
    NotificationConfig.MaxNotifications = Max
end

function HorizonNotificationLibrary:SetDefaultDuration(Duration)
    NotificationConfig.DefaultDuration = Duration
end

function HorizonNotificationLibrary:Destroy()
    HorizonNotificationUI:Destroy()
end

	Window.Notifications = HorizonNotificationLibrary

    return Window
end
return HorizonBarLibrary
