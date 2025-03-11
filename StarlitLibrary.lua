-- Starlit ModuleScript

local Starlit = {}
Starlit.__index = Starlit

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("User  InputService")

-- Variable to hold the window
local window
local isOpen = false -- Track whether the window is open or closed

-- Function to create a new window
function Starlit:CreateWindow(options)
    -- Check if the window is already open
    if isOpen then
        return -- If it's already open, do nothing
    end

    window = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local titleLabel = Instance.new("TextLabel")
    local subtitleLabel = Instance.new("TextLabel")
    local closeButton = Instance.new("ImageButton") -- Close button

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

    -- Close Button
    closeButton.Size = UDim2.new(0, 30, 0, 30) -- Size of the close button
    closeButton.Position = UDim2.new(1, -40, 0, 5) -- Position it in the top right corner
    closeButton.Image = "rbxassetid://106498149854720" -- Set the image ID for the close button
    closeButton.BackgroundTransparency = 1 -- Make the background transparent
    closeButton.Parent = frame

    -- Close button functionality
    closeButton.MouseButton1Click:Connect(function()
        self:CloseWindow()
    end)

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

    -- Set the window state to open
    isOpen = true

    -- Listen for key input to toggle the window
    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if not gameProcessedEvent and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.B then
            self:ToggleWindow()
        end
    end)

    return window, frame
end

-- Function to animate the window
function Starlit:AnimateWindow(frame)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Tween for the frame's background transparency
    local fadeInTween = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 0})
    fadeInTween:Play()
end

-- Function to close the window
