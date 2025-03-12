-- StarlitLibrary.lua

local Starlit = {}
Starlit.__index = Starlit

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("User InputService") -- Correct service name

-- Variable to hold the window
local window
local isOpen = false -- Track whether the window is open or closed

-- Function to create a new window
function Starlit:CreateWindow(options)
    if isOpen then return end -- Prevent multiple windows

    window = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local titleLabel = Instance.new("TextLabel")
    local subtitleLabel = Instance.new("TextLabel")
    local closeButton = Instance.new("ImageButton")

    -- Set up the window properties
    window.Name = options.Name or "StarlitWindow"
    frame.Size = UDim2.new(0.5, 0, 0.5, 0)
    frame.Position = UDim2.new(0.25, 0, 0.25, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 1
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
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0, 5)
    closeButton.Image = "rbxassetid://106498149854720"
    closeButton.BackgroundTransparency = 1
    closeButton.Parent = frame

    -- Close button functionality
    closeButton.MouseButton1Click:Connect(function()
        self:CloseWindow()
    end)

    window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    self:AnimateWindow(frame)
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
    local fadeInTween = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 0})
    fadeInTween:Play()
end

-- Function to close the window
function Starlit:CloseWindow()
    if window then
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local swipeOutTween = TweenService:Create(window.Frame, tweenInfo, {Position = UDim2.new(1, 0, 0.25, 0)})
        swipeOutTween:Play()
        swipeOutTween.Completed:Wait()
        self:ShowNotification("To open the panel again please press 'B' on your keyboard.")
        window:Destroy()
        isOpen = false
    end
end

-- Function to toggle the window
function Starlit:ToggleWindow()
    if isOpen then
        self:CloseWindow()
    else
        self:CreateWindow({
            Name = "Starlit Example Window",
            LoadingTitle = "Starlit Interface Suite",
            LoadingSubtitle = "by YourName",
        })
    end
end

-- Function to show a notification
function Starlit:ShowNotification(message)
    local notification = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local textLabel = Instance.new("TextLabel")

    notification.Name = "Notification"
    frame.Size = UDim2.new(0.3, 0, 0.1, 0)
    frame.Position = UDim2.new(0.7, 0, 0.9, 0)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BackgroundTransparency = 0.5
    frame.Parent = notification

    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = message
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = frame

    notification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Animate the notification
    self:AnimateNotification(frame)

    -- Automatically destroy the notification after a few seconds
    wait(5)
    notification:Destroy()
end

-- Function to animate the notification
function Starlit:AnimateNotification(frame)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    frame.Position = UDim2.new(0.7, 0, 1, 0) -- Start off-screen
    local swipeInTween = TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.7, 0, 0.9, 0)}) -- Move to visible position
    swipeInTween:Play()
end

return Starlit
