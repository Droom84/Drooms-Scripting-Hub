-- Starlit ModuleScript

local Starlit = {}
Starlit.__index = Starlit

local TweenService = game:GetService("TweenService")

-- Function to create a new window
function Starlit:CreateWindow(options)
    local window = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local titleLabel = Instance.new("TextLabel")
    local subtitleLabel = Instance.new("TextLabel")

    -- Set up the window properties
    window.Name = options.Name or "StarlitWindow"
    frame.Size = UDim2.new(0.5, 0, 0.5, 0)
    frame.Position = UDim2.new(0.25, 0, 0.25, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 1 -- Start transparent for fade-in effect
    frame.Parent = window

    -- Title Label
    titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleLabel.Text = options.LoadingTitle or "Loading..."
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Parent = frame

    -- Subtitle Label
    subtitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
    subtitleLabel.Position = UDim2.new(0, 0, 0.1, 0)
    subtitleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    subtitleLabel.Text = options.LoadingSubtitle or "by YourName"
    subtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    subtitleLabel.Parent = frame

    -- Optional properties
    if options.Icon then
        -- Set icon if provided (you can implement this based on your design)
    end

    -- Configuration saving
    if options.ConfigurationSaving and options.ConfigurationSaving.Enabled then
        -- Implement configuration saving logic here
    end

    -- Discord integration
    if options.Discord and options.Discord.Enabled then
        -- Implement Discord integration logic here
    end

    -- Key system
    if options.KeySystem then
        -- Implement key system logic here
    end

    window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Smooth animation for the window
    self:AnimateWindow(frame)

    return window, frame
end

-- Function to animate the window
function Starlit:AnimateWindow(frame)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Tween for the frame's background transparency
    local fadeInTween = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 0})
    fadeInTween:Play()
end

return Starlit
