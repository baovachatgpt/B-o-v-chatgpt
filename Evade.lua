--[[
    Giữa hành trình
    SJAD © 2025
]]

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Trung tâm giữa hành trình (discord.gg/6UaRDjBY42)",
    LoadingTitle = "Evade v2 được viết lại",
    LoadingSubtitle = "Credits: (SJAD) - Phát triển nâng cao Sea Journeys",
    Theme = "Light",
    ShowText = "Giao diện người dùng MidWare",
    Icon = 105495960707973,
    Config = {
        SaveConfig = true,
        FolderName = "SJAD_Evade",
        FileName = "EvadeConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "6UaRDjBY42",
        RememberJoins = true
    },
    KeySystem = false
})

-- ======== Variables ========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character
local Humanoid
local OriginalWalkSpeed = 16
local infiniteSlideEnabled = false
local Speed = 55.5
local debounce = false
local ToggleKey = Enum.KeyCode.LeftControl

-- ======== Functions ========
local function setHumanoidReferences(char)
    if not char then return end
    local ok, h = pcall(function() return char:WaitForChild("Humanoid", 5) end)
    if ok and h then
        Humanoid = h
        OriginalWalkSpeed = (Humanoid and Humanoid.WalkSpeed) or 16
    else
        Humanoid = nil
    end
end

if Character then
    setHumanoidReferences(Character)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    setHumanoidReferences(char)

    -- Nếu slide đang bật, áp dụng humanoid mới
    if infiniteSlideEnabled and Humanoid then
        task.defer(function()
            pcall(function()
                Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                Humanoid.WalkSpeed = Speed
            end)
        end)
    end
end)

local function updateUIButton()
    if SlideButton then
        if infiniteSlideEnabled then
            SlideButton.Text = "TRƯỢT VÔ HẠN: BẬT"
            SlideButton.BackgroundColor3 = Color3.fromRGB(0,200,0)
        else
            SlideButton.Text = "TRƯỢT VÔ HẠN: TẮT"
            SlideButton.BackgroundColor3 = Color3.fromRGB(200,0,0)
        end
    end
end

local function EnableSlide()
    infiniteSlideEnabled = true
    updateUIButton()
    if Humanoid then
        Humanoid.WalkSpeed = Speed
    end
end

local function DisableSlide()
    infiniteSlideEnabled = false
    if Humanoid and OriginalWalkSpeed then
        Humanoid.WalkSpeed = OriginalWalkSpeed
    end
    updateUIButton()
end

local function setSpeed(s)
    Speed = math.clamp(s, 1, 500)
    if SpeedLabel then
        SpeedLabel.Text = "Tốc độ: " .. string.format("%.1f", Speed)
    end
    if infiniteSlideEnabled and Humanoid then
        Humanoid.WalkSpeed = Speed
    end
end

-- ======== GUI ========
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BaoChatGPTHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = playerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 270, 0, 140)
Frame.Position = UDim2.new(0.5, -135, 0.72, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -10, 0, 34)
Title.Position = UDim2.new(0, 5, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Bảo & ChatGPT Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextScaled = true
Title.Font = Enum.Font.FredokaOne
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Frame

local SlideButton = Instance.new("TextButton")
SlideButton.Size = UDim2.new(0, 220, 0, 48)
SlideButton.Position = UDim2.new(0.5, -110, 0.35, 0)
SlideButton.Text = "TRƯỢT VÔ HẠN: TẮT"
SlideButton.TextScaled = true
SlideButton.Font = Enum.Font.FredokaOne
SlideButton.BackgroundColor3 = Color3.fromRGB(200,0,0)
SlideButton.TextColor3 = Color3.fromRGB(255,255,255)
SlideButton.Parent = Frame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 120, 0, 20)
SpeedLabel.Position = UDim2.new(0.5, -60, 0.75, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Tốc độ: " .. tostring(Speed)
SpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.Parent = Frame

local DecreaseBtn = Instance.new("TextButton")
DecreaseBtn.Size = UDim2.new(0, 40, 0, 28)
DecreaseBtn.Position = UDim2.new(0.5, -64, 0.82, 0)
DecreaseBtn.Text = "-"
DecreaseBtn.Font = Enum.Font.FredokaOne
DecreaseBtn.TextScaled = true
DecreaseBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
DecreaseBtn.TextColor3 = Color3.fromRGB(255,255,255)
DecreaseBtn.Parent = Frame

local IncreaseBtn = Instance.new("TextButton")
IncreaseBtn.Size = UDim2.new(0, 40, 0, 28)
IncreaseBtn.Position = UDim2.new(0.5, 24, 0.82, 0)
IncreaseBtn.Text = "+"
IncreaseBtn.Font = Enum.Font.FredokaOne
IncreaseBtn.TextScaled = true
IncreaseBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
IncreaseBtn.TextColor3 = Color3.fromRGB(255,255,255)
IncreaseBtn.Parent = Frame

-- Button click
SlideButton.MouseButton1Click:Connect(function()
    if debounce then return end
    debounce = true
    if infiniteSlideEnabled then
        DisableSlide()
    else
        EnableSlide()
    end
    task.wait(0.15)
    debounce = false
end)

DecreaseBtn.MouseButton1Click:Connect(function()
    setSpeed(Speed - 5)
end)
IncreaseBtn.MouseButton1Click:Connect(function()
    setSpeed(Speed + 5)
end)

-- Toggle phím
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if UIS:GetFocusedTextBox() then return end
    if input.KeyCode == ToggleKey then
        if debounce then return end
        debounce = true
        if infiniteSlideEnabled then
            DisableSlide()
        else
            EnableSlide()
        end
        task.wait(0.12)
        debounce = false
    end
end)

-- ======== Heartbeat Loop ========
RunService.Heartbeat:Connect(function()
    if not Humanoid then return end
    if infiniteSlideEnabled then
        if Humanoid.MoveDirection.Magnitude > 0.01 then
            pcall(function()
                Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                Humanoid.WalkSpeed = Speed
            end)
        end
    else
        if Humanoid and OriginalWalkSpeed then
            Humanoid.WalkSpeed = OriginalWalkSpeed
        end
    end
end)
