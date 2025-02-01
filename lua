local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DarkXploits",
   Icon = 103644919467149, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "DarkXploits",
   LoadingSubtitle = "by Droom_2&Burger",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "DarkXploits"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "https://discord.gg/EtsPBjn6s6", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "DarkXploits | Key",
      Subtitle = "Get the key in our discord.",
      Note = "Join https://discord.gg/EtsPBjn6s6 for the key.", -- Use this to tell the user how to get a key
      FileName = "DarkXploitskey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"G2SHDA6G2D262"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("🏠 Home", nil)-- Title, Image
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
   Title = "Notification",
   Content = "Thank you for using DarkXploits.",
   Duration = 5,
   Image = nil,
})

local Button = MainTab:CreateButton({
   Name = "Infinite Jump",
   Callback = function()
local InfiniteJumpEnabled = true
game:GetService("UserInputService").JumpRequest:connect(function()
	if InfiniteJumpEnabled then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end) -- The function that takes place when the button is pressed
   end,
})

local Button = MainTab:CreateButton({
   Name = "Fly (Y)",
   Callback = function()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 100 -- Speed at which the player flies


local function startFlying()
    flying = true
    
 
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart

 
    local userInputService = game:GetService("UserInputService")
    

    while flying do
        local moveDirection = Vector3.new(0, 0, 0)
        
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        bodyVelocity.Velocity = moveDirection * flySpeed
        wait(0.1)
    end
end


local function stopFlying()
    flying = false
    rootPart:FindFirstChild("BodyVelocity"):Destroy()
end

-- Toggle fly on and off with the "F" key
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Y then
        if flying then
            stopFlying()
        else
            startFlying()
        end
    end
end)-- The function that takes place when the button is pressed
   end,
})

local Toggle = MainTab:CreateToggle({
   Name = "Teleport (J)",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
        local UserInputService = game:GetService("UserInputService")
        local player = game.Players.LocalPlayer
        local mouse = player:GetMouse()

        local connection -- Store input connection

        -- Function to handle teleportation
        local function teleportToMouse()
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local targetPosition = mouse.Hit.Position  -- Get cursor's world position
                    humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0)) -- Adjust height slightly
                end
            end
        end

        -- Enable teleportation when toggle is turned on
        if Value then
            connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end  -- Ignore inputs processed by UI

                if input.KeyCode == Enum.KeyCode.J then
                    teleportToMouse()
                end
            end)
        else
            -- Disable teleportation when toggle is turned off
            if connection then
                connection:Disconnect()
                connection = nil -- Clear the stored connection
            end
        end
   end
})

local Button = MainTab:CreateButton({
   Name = "No Clip (E)",
   Callback = function()
   		local player = game.Players.LocalPlayer
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local runservice = game:GetService("RunService")
local noclip = false

 
runservice.Stepped:Connect(function()
    if noclip then
        player.Character.Humanoid:ChangeState(11)
    end
end)
 
mouse.KeyDown:Connect(function(key)
    if key == "m" then
        noclip = true
        player.Character.Humanoid:ChangeState(11)
    end
end)

mouse.KeyDown:Connect(function(key)
    if key == "z" then
        noclip = false
        player.Character.Humanoid:ChangeState(11)
    end
end)
   end,
})

local Button = MainTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
   		loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() 
   end,
})

local Button = MainTab:CreateButton({
   Name = "All in 1 Menu",
   Callback = function()
   		loadstring(game:HttpGet('https://raw.githubusercontent.com/4zuren0name/ZeroGGG/refs/heads/main/ZeroG'))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Fling User",
   Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Auto%20Fling%20Player"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Chat Logger",
   Callback = function()
		local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")


local ChatLogger = Instance.new("ScreenGui")
ChatLogger.Name = "ChatLogger"
ChatLogger.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.8, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ChatLogger


local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame


local DropShadow = Instance.new("ImageLabel")
DropShadow.Name = "DropShadow"
DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.BackgroundTransparency = 1
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
DropShadow.Size = UDim2.new(1, 30, 1, 30)
DropShadow.ZIndex = -1
DropShadow.Image = "rbxassetid://6014261993"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.5
DropShadow.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -30, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Chat Logger"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame


local ButtonsContainer = Instance.new("Frame")
ButtonsContainer.Name = "ButtonsContainer"
ButtonsContainer.Size = UDim2.new(0, 60, 0, 30)
ButtonsContainer.Position = UDim2.new(1, -65, 0, 0)
ButtonsContainer.BackgroundTransparency = 1
ButtonsContainer.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = ButtonsContainer

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(0, 0, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = ButtonsContainer


local function addButtonStyles(button)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 2)
    padding.Parent = button
end

addButtonStyles(CloseButton)
addButtonStyles(MinimizeButton)

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -20, 1, -45)
ScrollFrame.Position = UDim2.new(0, 10, 0, 35)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)
ScrollFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ScrollFrame
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 4)


local messageCache = {}
local function addMessage(player, message, messageType)
    local timeStamp = os.date("%H:%M:%S")
    local messageKey = player.Name .. message .. timeStamp
    

    if messageCache[messageKey] then return end
    messageCache[messageKey] = true
    

    task.delay(1, function()
        messageCache[messageKey] = nil
    end)
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, 0, 0, 20)
    messageLabel.BackgroundTransparency = 1
    messageLabel.TextSize = 14
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextWrapped = true
    
    if messageType == "private" then
        messageLabel.Text = string.format("[%s] [Private] %s: %s", timeStamp, player.Name, message)
        messageLabel.TextColor3 = Color3.fromRGB(255, 180, 180)
    else
        messageLabel.Text = string.format("[%s] %s: %s", timeStamp, player.Name, message)
        messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    messageLabel.Parent = ScrollFrame
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
    ScrollFrame.CanvasPosition = Vector2.new(0, ListLayout.AbsoluteContentSize.Y)
end


local dragging
local dragInput
local dragStart
local startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)


CloseButton.MouseButton1Click:Connect(function()
    ChatLogger:Destroy()
end)


local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize
    if minimized then
        targetSize = UDim2.new(0, 300, 0, 30)
        MinimizeButton.Text = "+"
    else
        targetSize = UDim2.new(0, 300, 0, 400)
        MinimizeButton.Text = "-"
    end
    
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = targetSize})
    tween:Play()
end)


Players.PlayerChatted:Connect(function(chatType, player, message, targetPlayer)
    if chatType == Enum.PlayerChatType.Whisper then
        addMessage(player, message, "private")
    else
        addMessage(player, message, "normal")
    end
end)


for _, player in ipairs(Players:GetPlayers()) do
    player.Chatted:Connect(function(message)
        addMessage(player, message, "normal")
    end)
end


Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        addMessage(player, message, "normal")
    end)
end)
   end,
})

local Button = MainTab:CreateButton({
   Name = "Give Tool",
   Callback = function()
		        local ScreenGui = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local ScrollingFrame = Instance.new("ScrollingFrame")
        local UIListLayout = Instance.new("UIListLayout")
        local TextButton = Instance.new("TextButton")
        local TextLabel = Instance.new("TextLabel")
        local UpdateButton = Instance.new("TextButton")
        local CloseButton = Instance.new("TextButton")

        -- Main GUI Setup
        ScreenGui.Parent = game:GetService("CoreGui")
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.ResetOnSpawn = false

        -- Main Frame
        Frame.Parent = ScreenGui
        Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Frame.Position = UDim2.new(0.061, 0, 0.094, 0)
        Frame.Size = UDim2.new(0, 300, 0, 400)
        Frame.ClipsDescendants = true

        -- Add smooth corners
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = Frame

        -- Title Label with gradient
        TextLabel.Parent = Frame
        TextLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TextLabel.Size = UDim2.new(1, 0, 0, 40)
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.Text = "🎮 Tool Grabber"
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 22

        local UICornerTitle = Instance.new("UICorner")
        UICornerTitle.CornerRadius = UDim.new(0, 8)
        UICornerTitle.Parent = TextLabel

        -- Scrolling Frame with modern styling
        ScrollingFrame.Parent = Frame
        ScrollingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ScrollingFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
        ScrollingFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 10, 0)
        ScrollingFrame.ScrollBarThickness = 6
        ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

        local UICornerScroll = Instance.new("UICorner")
        UICornerScroll.CornerRadius = UDim.new(0, 8)
        UICornerScroll.Parent = ScrollingFrame

        UIListLayout.Parent = ScrollingFrame
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)

        -- Tool Button Template
        TextButton.Parent = ScrollingFrame
        TextButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TextButton.Size = UDim2.new(0.95, 0, 0, 40)
        TextButton.Position = UDim2.new(0.025, 0, 0, 0)
        TextButton.Visible = false
        TextButton.Font = Enum.Font.GothamSemibold
        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.TextSize = 16
        TextButton.AutoButtonColor = false

        local UICornerButton = Instance.new("UICorner")
        UICornerButton.CornerRadius = UDim.new(0, 6)
        UICornerButton.Parent = TextButton

        -- Update Button with hover effect
        UpdateButton.Parent = Frame
        UpdateButton.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
        UpdateButton.Position = UDim2.new(0.1, 0, 0.88, 0)
        UpdateButton.Size = UDim2.new(0.8, 0, 0, 35)
        UpdateButton.Font = Enum.Font.GothamBold
        UpdateButton.Text = "🔄 Refresh Tools"
        UpdateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        UpdateButton.TextSize = 16
        UpdateButton.AutoButtonColor = false

        local UICornerUpdate = Instance.new("UICorner")
        UICornerUpdate.CornerRadius = UDim.new(0, 6)
        UICornerUpdate.Parent = UpdateButton

        -- Close Button
        CloseButton.Parent = Frame
        CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        CloseButton.Position = UDim2.new(0.9, 0, 0.02, 0)
        CloseButton.Size = UDim2.new(0, 25, 0, 25)
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.Text = "×"
        CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseButton.TextSize = 20
        CloseButton.AutoButtonColor = false

        local UICornerClose = Instance.new("UICorner")
        UICornerClose.CornerRadius = UDim.new(0, 6)
        UICornerClose.Parent = CloseButton

        -- Button Hover Effects
        local function createHoverEffect(button, defaultColor, hoverColor)
            button.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
                    BackgroundColor3 = hoverColor
                }):Play()
            end)
            
            button.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
                    BackgroundColor3 = defaultColor
                }):Play()
            end)
        end

        createHoverEffect(UpdateButton, Color3.fromRGB(0, 122, 255), Color3.fromRGB(0, 100, 200))
        createHoverEffect(CloseButton, Color3.fromRGB(200, 50, 50), Color3.fromRGB(170, 40, 40))

        -- Main Functionality
        local function FNDR_fake_script()
            local script = Instance.new('LocalScript', Frame)
            local button = TextButton:Clone()
            button.Parent = nil
            button.Name = "ToolButton"

            local function updateList()
                for _, v in ipairs(ScrollingFrame:GetChildren()) do
                    if v:IsA("TextButton") then v:Destroy() end
                end

                for _, v in pairs(game:GetDescendants()) do
                    if v:IsA("Tool") and not v:IsDescendantOf(game.Players.LocalPlayer) then
                        local cloneButton = button:Clone()
                        cloneButton.Parent = ScrollingFrame
                        cloneButton.Visible = true
                        cloneButton.Text = "🔧 " .. v.Name
                        createHoverEffect(cloneButton, Color3.fromRGB(45, 45, 45), Color3.fromRGB(60, 60, 60))
                        
                        cloneButton.MouseButton1Click:Connect(function()
                            local clone = v:Clone()
                            clone.Parent = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")
                        end)
                    end
                end
            end

            UpdateButton.MouseButton1Click:Connect(updateList)
            CloseButton.MouseButton1Click:Connect(function()
                ScreenGui:Destroy()
            end)
        end
        coroutine.wrap(FNDR_fake_script)()

        -- Drag Functionality
        local function enableDragging()
            local UserInputService = game:GetService("UserInputService")
            local dragging, dragInput, dragStart, startPos
            
            Frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    dragStart = input.Position
                    startPos = Frame.Position
                end
            end)
            
            Frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local delta = input.Position - dragStart
                    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                        startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)
        end
        coroutine.wrap(enableDragging)()
   end,
})

local PillarTab = Window:CreateTab("⛩ Pillar Chase", nil)
local Section = PillarTab:CreateSection("Pillar")

local Button = PillarTab:CreateButton({
   Name = "Pillar Chase Menu",
   Callback = function()
   		 loadstring(game:HttpGet('https://raw.githubusercontent.com/dqvh/dqvh/main/pillar%20chase%202.lua'))() 
   end,
})

local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()

local CustomOptions = { SafeMode = true, timeout = 15, SaveBytecode = true, noscripts = false }

synsaveinstance(CustomOptions)
   end,
})

local ArsenalTab = Window:CreateTab("🔫 Arsenal", nil)
local Section = ArsenalTab:CreateSection("Arsenal")

local Button = ArsenalTab:CreateButton({
   Name = "Arsenal Cheat Menu",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/JackyPoopoo/cartel/main/0000000000000000000000000000000000000000000000000"))()
   end
}) -- Fixed the syntax error here by removing the extra closing parenthesis

local MM2Tab = Window:CreateTab("🔪 MM2", nil)
local Section = MM2Tab:CreateSection("MM2")

local Button = MM2Tab:CreateButton({
   Name = "MM2 Cheat Menu",
   Callback = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/vertex-peak/vertex/refs/heads/main/loadstring'))()
   end,
})

local CombatTab = Window:CreateTab("⚔ Combat Warriors", nil)
local Section = CombatTab:CreateSection("Combat")

local Button = CombatTab:CreateButton({
   Name = "Autoparry",
   Callback = function()
		local lp = game.Players.LocalPlayer
 
local animationInfo = {}
 
function getInfo(id)
  local success, info = pcall(function()
      return game:GetService("MarketplaceService"):GetProductInfo(id)
  end)
  if success then
      return info
  end
  return {Name=''}
end
function block(player)
  keypress(0x46)
  wait()
  keyrelease(0x46)
end
 
local AnimNames = {
  'Slash',
  'Swing',
  'Sword'
}
 
function playerAdded(v)
    local function charadded(char)
      local humanoid = char:WaitForChild("Humanoid", 5)
      if humanoid then
          humanoid.AnimationPlayed:Connect(function(track)
              local info = animationInfo[track.Animation.AnimationId]
              if not info then
                  info = getInfo(tonumber(track.Animation.AnimationId:match("%d+")))
                  animationInfo[track.Animation.AnimationId] = info
              end
 
              if (lp.Character and lp.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Head")) then
                  local mag = (v.Character.Head.Position - lp.Character.Head.Position).Magnitude
                  if mag < 15  then
 
                      for _, animName in pairs(AnimNames) do
                          if info.Name:match(animName) then
                              pcall(block, v)
                          end
                      end
 
                  end
              end
          end)
      end
  end
 
  if v.Character then
      charadded(v.Character)
  end
  v.CharacterAdded:Connect(charadded)
end
 
for i,v in pairs(game.Players:GetPlayers()) do
   if v ~= lp then
       playerAdded(v)
   end
end
 
game.Players.PlayerAdded:Connect(playerAdded)
   end,
})

local RivalsTab = Window:CreateTab("🧨 Rivals", nil)
local Section = RivalsTab:CreateSection("Rivals")

local Button = RivalsTab:CreateButton({
   Name = "Rivals Cheat Script",
   Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EzWinsV4/FlameForRobloxRivals/refs/heads/main/Main.lua", true))()
   end,
})

local TrollTab = Window:CreateTab("🧞‍♂️ Trolling", nil)
local Section = TrollTab:CreateSection("Animations")

local Button = AnimationsTab:CreateButton({
   Name = "Troll Animations V1",
   Callback = function()
		loadstring(game:HttpGet("https://pastebin.com/raw/093VxNLa"))()
   end,
})
