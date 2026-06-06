local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/7YBot/RbxUi/main/Ui.lua"))()
local Window = Library:CreateWindow("Fly Menü", "Uçma Hilesi", 10123000000)
local Tab = Window:CreateTab("Genel")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Torso = Character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 50
local bv, bg

-- Uçma Fonksiyonu
local function startFlying()
    if bv or bg then return end
    bv = Instance.new("BodyVelocity", Torso)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.velocity = Vector3.new(0, 0, 0)

    bg = Instance.new("BodyGyro", Torso)
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = Torso.CFrame

    task.spawn(function()
        while flying and task.wait() do
            Character.Humanoid.PlatformStand = true
            local Mouse = LocalPlayer:GetMouse()
            bv.velocity = Mouse.Hit.lookVector * speed
            bg.cframe = CFrame.new(Torso.Position, Torso.Position + Mouse.Hit.lookVector)
        end
        if bv then bv:Destroy() bv = nil end
        if bg then bg:Destroy() bg = nil end
        Character.Humanoid.PlatformStand = false
    end)
end

-- Menü Butonları
Tab:CreateToggle("Uçmayı Aç/Kapat", function(state)
    flying = state
    if flying then
        startFlying()
    end
end)

Tab:CreateSlider("Uçma Hızı", 10, 250, 50, function(value)
    speed = value
end)
