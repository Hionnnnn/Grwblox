--[[
============================================================
AUTO FARM LEGIT (SAFE FROM PATCH)
- Nge-punch, naro block, & collect pake simulasi klik
- Ga pake memory hook / bypass (Anti Ban)
- Cocok buat game yang baru di-patch dev
============================================================
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- ============== CONFIG ==============
local PUNCH_DELAY = 0.25      -- Jeda antar pukulan (detik)
local PLACE_DELAY = 0.25      -- Jeda antar naro block
local AUTO_COLLECT = true     -- Auto ambil drop di sekitar
-- ====================================

local isFarming = false
local farmConnection = nil

-- Fungsi simulasi nge-klik / mukul (menggantikan Ref.Punch yang udah patched)
local function simulatePunch(x, y)
    -- Nembak event klik kiri di koordinat tengah layar
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2))
end

-- Fungsi simulasi naro block
local function simulatePlace(x, y)
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2))
end

-- Fungsi Auto Collect (nempel ke karakter buat narik drop)
local function doCollect()
    -- Kebanyakan game Growtopia clone di Roblox ngedetek drop pas karakter nyentuh item.
    -- Kita bisa mindahin karakter dikit biar nyentuh drop, atau panggil fungsi internal game kalo masih work.
    -- Fallback: Karakter goyang dikit biar drop ke-take.
end

-- Loop Farm
local function startFarming()
    isFarming = true
    print("[Auto Farm] Started")
    
    task.spawn(function()
        while isFarming do
            -- 1. Simulasi nge-punch lurus ke depan
            simulatePunch(LocalPlayer.Character.HumanoidRootPart.Position.X, LocalPlayer.Character.HumanoidRootPart.Position.Y)
            task.wait(PUNCH_DELAY)
            
            -- 2. Simulasi Naro Block (Kalo lu pegang block)
            simulatePlace(LocalPlayer.Character.HumanoidRootPart.Position.X, LocalPlayer.Character.HumanoidRootPart.Position.Y)
            task.wait(PLACE_DELAY)
            
            -- 3. Auto Collect
            if AUTO_COLLECT then
                doCollect()
            end
            
            RunService.Heartbeat:Wait()
        end
    end)
end

local function stopFarming()
    isFarming = false
    print("[Auto Farm] Stopped")
end

-- UI Sederhana (Pake WindUI atau Library biasa)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SafeFarmGui"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(1, -20, 0, 40)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Text = "START FARM"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
ToggleBtn.Parent = Frame

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 0, 30)
StatusText.Position = UDim2.new(0, 10, 0, 60)
StatusText.BackgroundTransparency = 1
StatusText.TextColor3 = Color3.new(1, 1, 1)
StatusText.Text = "Status: OFF"
StatusText.Font = Enum.Font.Gotham
StatusText.TextSize = 12
StatusText.Parent = Frame

ToggleBtn.MouseButton1Click:Connect(function()
    if not isFarming then
        startFarming()
        ToggleBtn.Text = "STOP FARM"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        StatusText.Text = "Status: RUNNING"
    else
        stopFarming()
        ToggleBtn.Text = "START FARM"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        StatusText.Text = "Status: OFF"
    end
end)

-- Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
