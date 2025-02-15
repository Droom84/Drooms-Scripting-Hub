local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 100 -- Speed at which the player flies
local flyingEnabled = false  -- Add a new variable to track whether flying is enabled

local bodyVelocity = nil  -- This will be created once flying starts

-- Start flying function
local function startFlying()
    flying = true
    bodyVelocity = Instance.new("BodyVelocity")
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

-- Stop flying function
local function stopFlying()
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
    end
end

-- The input handler now checks if flying is enabled and only listens to the "Y" key if it is
local function onInputBegan(input)
    if flyingEnabled and input.KeyCode == Enum.KeyCode.Y then
        if flying then
            stopFlying()
        else
            startFlying()
        end
    end
end

game:GetService("UserInputService").InputBegan:Connect(onInputBegan)

-- Function to enable or disable flying based on the toggle state
local function toggleFlying(Value)
    if Value then
        flyingEnabled = true  -- Enable the keybind for flying
    else
        flyingEnabled = false -- Disable the keybind for flying
        stopFlying()           -- Stop flying if it's currently on
    end
end

-- Example of calling the toggleFlying function
-- Replace this with your actual toggle call
toggleFlying(true)  -- This would enable flying, change it based on the toggle
