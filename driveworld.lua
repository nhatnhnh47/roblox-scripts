local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local toggle = Instance.new("TextButton")
local status = Instance.new("TextLabel")

gui.Name = "DriveFarmGui"
gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = gui

toggle.Size = UDim2.new(0, 180, 0, 40)
toggle.Position = UDim2.new(0, 10, 0, 10)
toggle.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.Text = "Start Auto Farm"
toggle.TextSize = 16
toggle.Parent = frame

status.Size = UDim2.new(0, 180, 0, 30)
status.Position = UDim2.new(0, 10, 0, 60)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.Font = Enum.Font.Gotham
status.Text = "Status: Idle"
status.TextSize = 14
status.Parent = frame

--== Logic farm ==--
local rep = game:GetService("ReplicatedStorage")
local remotes = rep:WaitForChild("Remotes")
local running = false

local function startFarm()
    running = true
    status.Text = "Status: Farming..."
    while running do
        pcall(function()
            remotes.StartJob:FireServer()
            task.wait(1.5) -- Delay để tránh spam nhanh quá
            remotes.CompleteJob:FireServer()
        end)
        task.wait(2.5)
    end
end

local function stopFarm()
    running = false
    status.Text = "Status: Idle"
end

toggle.MouseButton1Click:Connect(function()
    if running then
        stopFarm()
        toggle.Text = "Start Auto Farm"
    else
        startFarm()
        toggle.Text = "Stop Auto Farm"
    end
end)
