local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Drooms Scripting Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Drooms Scripting Hub",
   LoadingSubtitle = "by Droom_2",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Drooms Scripting Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Drooms Scripting Hub | Key",
      Subtitle = "You can only get a link via Drooms DMs",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "DroomsScriptinghubkey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/gHAbLkUs"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("🏠 Home", nil)-- Title, Image
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
   Title = "Notification",
   Content = "Do you like this and wish more to come? Go to Droom_2 his Dm's",
   Duration = 5,
   Image = nil,
})

local Button = MainTab:CreateButton({
   Name = "Infinate Jump",
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
   Name = "Fly (F)",
   Callback = function()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 50 -- Speed at which the player flies


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
    if input.KeyCode == Enum.KeyCode.F then
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
   Name = "Teleport (E)",
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

                if input.KeyCode == Enum.KeyCode.E then
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
   Name = "No Clip (J)",
   Callback = function()
   		local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local noclip = false

-- Toggle noclip when the player presses the "J" key
local function toggleNoclip()
    noclip = not noclip
end

-- Detect when the "J" key is pressed
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.J then
        toggleNoclip()
    end
end)

-- Update the player's movement based on noclip status
game:GetService("RunService").Heartbeat:Connect(function()
    if noclip then
        humanoid.PlatformStand = true
        character.HumanoidRootPart.CanCollide = false
        character:SetPrimaryPartCFrame(character.HumanoidRootPart.CFrame + character.HumanoidRootPart.Velocity)
    else
        humanoid.PlatformStand = false
        character.HumanoidRootPart.CanCollide = true
    end
end)

   end,
})

local GamecopyTab = Window:CreateTab("🌏Game Copy", nil)
local Section = GamecopyTab:CreateSection("Game ")

local Button = GamecopyTab:CreateButton({
   Name = "Copy Game",
   Callback = function()
  		local Params = {
    RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
    SSI = "saveinstance",
}

local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()

local CustomOptions = { SafeMode = true, timeout = 15, SaveBytecode = true, noscripts = false }

synsaveinstance(CustomOptions)
   end,
Rayfield:Notify({
   Title = "Game Copy",
   Content = "The Game is currently copying. When its done look in your executor workspace folder.",
   Duration = 5,
   Image = nil,
})
