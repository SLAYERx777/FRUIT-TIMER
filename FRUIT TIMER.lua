-- Initialize GUI
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local TextLabel = Instance.new("TextLabel", ScreenGui)
TextLabel.Size = UDim2.new(0, 400, 0, 50)
TextLabel.Position = UDim2.new(0.5, -200, 0, 50)
TextLabel.BackgroundTransparency = 0.5
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.Text = "Initializing Fruit Tracker..."

-- Fruit Data
local fruitLocations = {
    { Name = "LightFruit", Position = Vector3.new(100, 50, 200), spawnTime = math.random(180, 300) },
    { Name = "DarkFruit", Position = Vector3.new(-300, 75, 400), spawnTime = math.random(180, 300) }
}

-- Teleport player to fruit location
local function teleportToFruit(fruit)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(fruit.Position)
        print("Teleported to " .. fruit.Name)
    end
end

-- Update GUI to show remaining time
local function updateGui(fruit)
    TextLabel.Text = fruit.Name .. " - Time Left: " .. fruit.spawnTime .. "s"
end

-- Main loop to check for fruit spawns
local function checkForFruits()
    while true do
        for _, fruit in pairs(fruitLocations) do
            -- Reduce the spawn time countdown
            fruit.spawnTime = fruit.spawnTime - 5
            updateGui(fruit)

            -- If fruit is found in the game workspace, teleport to it
            local fruitPart = game.Workspace:FindFirstChild(fruit.Name)
            if fruitPart and fruitPart:IsA("Model") and fruitPart.Parent == game.Workspace then
                print(fruit.Name .. " spawned at " .. tostring(fruit.Position))
                teleportToFruit(fruit)

                -- Reset spawn time for next spawn
                fruit.spawnTime = math.random(180, 300)  -- Random next spawn time between 3 to 5 minutes
            end

            -- If spawn time reaches 0, reset the timer and check again
            if fruit.spawnTime <= 0 then
                fruit.spawnTime = math.random(180, 300)
            end
        end
        wait(5)  -- Check every 5 seconds
    end
end

-- Start checking for fruit spawns
checkForFruits()
