local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 100
local flyingEnabled = false
local bodyVelocity = nil

-- Function to start flying using external script
local function startFlying()
    if flying then
        print("Already flying!")
        return
    end
    print("Starting to fly...")

    -- Load the external fly script
    local flyScript = loadstring(game:HttpGet('https://raw.githubusercontent.com/Droom84/Drooms-Scripting-Hub/refs/heads/main/fly.lua'))
    flyScript()  -- Execute the external script

    flying = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart

    local userInputService = game:GetService("UserInputService")

    -- Fly loop
    while flying do
        local moveDirection = Vector3.new(0, 0, 0)

        -- Checking WASD and space/shift for flying controls
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
    if not flying then
        print("Already stopped flying!")
        return
    end
    print("Stopping flying...")
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
end

-- Listen for key press to toggle flying
local function onInputBegan(input, gameProcessedEvent)
    -- Ensure the key is not being processed by the game (such as opening inventory, etc.)
    if gameProcessedEvent then return end
    
    if flyingEnabled then
        print("Key press detected: " .. input.KeyCode)
        if input.KeyCode == Enum.KeyCode.Y then
            if flying then
                stopFlying()
            else
                startFlying()
            end
        end
    end
end

game:GetService("UserInputService").InputBegan:Connect(onInputBegan)

-- Toggle function: Turn flying on or off
local function toggleFlying(Value)
    if flyingEnabled == Value then
        print("Flying is already in the desired state: " .. tostring(flyingEnabled))
        return
    end

    flyingEnabled = Value
    print("Flying enabled: " .. tostring(flyingEnabled))  -- Debugging the toggle state

    if not flyingEnabled then
        stopFlying()  -- Ensure we stop flying when toggled off
    end
end

-- Example toggle call based on a UI toggle (you need to call this when your toggle is clicked)
-- You can call this toggleFlying(true) to enable flying or toggleFlying(false) to disable flying

-- Example usage:
toggleFlying(true)  -- Turn on flying
-- toggleFlying(false) -- Turn off flying (use false to disable the toggle)

