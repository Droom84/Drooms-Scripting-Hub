local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 100
local flyingEnabled = false
local bodyVelocity = nil

-- Load the flying script content
local function loadFlyScript()
    -- Check if script is already loaded
    if not bodyVelocity then
        print("Loading flying script")
        local success, result = pcall(function()
            return loadstring(game:HttpGet('https://raw.githubusercontent.com/Droom84/Drooms-Scripting-Hub/refs/heads/main/fly.lua'))()
        end)
        if not success then
            warn("Failed to load fly script:", result)
        end
    end
end

-- Function to start flying
local function startFlying()
    if flying then
        print("Already flying!")
        return
    end
    print("Starting to fly...")

    flying = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart
end

-- Function to stop flying
local function stopFlying()
    if not flying then
        print("Not flying!")
        return
    end
    print("Stopping flying...")
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
end

-- Toggle fly on and off with the "Y" key
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Y then
        if flying then
            stopFlying()
        else
            startFlying()
        end
    end
end)

-- To ensure the script is loaded only once at the beginning
loadFlyScript()
