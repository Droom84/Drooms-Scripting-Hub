-- StarlitLibrary.lua

local Starlit = {}
Starlit.__index = Starlit

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

-- Variable to hold the window
local window
local frame
local isOpen = false -- Track whether the window is open or closed

-- Function to create a new window
function Starlit:CreateWindow(options)
    -- Check if the window is already open
    if isOpen then
        return -- If it's already open, do nothing
    end

    -- Check for key system
    if options.KeySystem and options.KeySettings then
        local key = options.KeySettings.Key[1] -- Get the first key from the list
        local userKey = options.KeySettings.UserKey -- This should be provided by the user

        if userKey ~= key then
            warn("Invalid key! Access denied.")
            return
        end
    end

    window = Instance.new("ScreenGui")
    frame = Instance.new("Frame")
    local titleLabel = Instance.new("TextLabel")
    local subtitleLabel = Instance.new("TextLabel")
    local closeButton = Instance.new("ImageButton") -- Close button
    local corner = Instance.new("UICorner") -- UICorner for rounded corners

    -- Set up the window properties
    window.Name = options.Name or "StarlitWindow"
    frame.Size = UDim2.new(0.5, 0, 0.5, 0)
    frame.Position = UDim2.new(1, 0, 0.25, 0) -- Start off-screen to the right
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.5 -- Make it semi-transparent
    frame.Parent = window

    -- Add rounded corners
    corner.Parent = frame
    corner.CornerRadius = UDim.new(0, 15) -- Adjust the radius for smooth corners

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

    -- Add a blur effect
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Size = 10 -- Adjust the blur size as needed
    blurEffect.Parent = Lighting -- Add the blur effect to the Lighting service

    window.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Smooth animation for the window
    self:AnimateWindow(frame)

    -- Set the window state to open
    isOpen = true

    return window, frame
end

-- Function to animate the window
function Starlit:AnimateWindow(frame)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Tween for the frame's background transparency
    local fadeInTween = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 0})
    fadeInTween:Play()

    -- Tween for the frame's position to slide in from the right
    frame.Position = UDim2.new(1, 0, 0.25, 0) -- Start off-screen to the right
    local slideInTween = TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.25, 0, 0.25, 0)}) -- Move to visible position
    slideInTween:Play()
end

-- Function to close the window
function Starlit:CloseWindow()
    if window then
        -- Animate the frame to swipe out to the right
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local swipeOutTween = TweenService:Create(frame, tweenInfo, {Position = UDim2.new(1, 0, 0.25, 0)}) -- Move off-screen to the right
        swipeOutTween:Play()

        -- Show notification after the swipe-out animation
        swipeOutTween.Completed:Wait() -- Wait for the animation to complete
        self:ShowNotification("To open the panel again please press 'B' on your keyboard.")

        -- Hide the window instead of destroying it
        window.Enabled = false
        isOpen = false -- Update the state
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
            KeySystem = true,
            KeySettings = {
                Key = {"YourKeyHere"}, -- Replace with your key
                UserKey = "User  ProvidedKey" -- This should be provided by the user
            }
        })
    end
end

-- Function to show a notification
function Starlit:ShowNotification(message)
    local notification = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local textLabel = Instance.new("TextLabel")

    -- Set up the notification properties
    notification.Name = "Notification"
    frame.Size = UDim2.new(0.3, 0, 0.1, 0)
    frame.Position = UDim2.new(0.7, 0, 0.9, 0) -- Position it at the bottom right
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BackgroundTransparency = 0.5
    frame.Parent = notification

    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = message
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = frame

    notification.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Animate the notification
    self:AnimateNotification(frame)

    -- Automatically destroy the notification after a few seconds
    wait(5)
    notification:Destroy()
end

-- Function to animate the notification
function Starlit:AnimateNotification(frame)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Tween for the frame's position to swipe in
    frame.Position = UDim2.new(0.7, 0, 1, 0) -- Start off-screen
    local swipeInTween = TweenService:Create(frame, tweenInfo, {Position = UDim2.new(0.7, 0, 0.9, 0)}) -- Move to visible position
    swipeInTween:Play()
end

return Starlit --out ig
