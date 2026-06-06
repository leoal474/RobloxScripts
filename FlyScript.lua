local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local flying = false
local speed = 50
local connection

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        flying = not flying
        if flying then
            connection = RunService.RenderStepped:Connect(function()
                local camera = workspace.CurrentCamera
                local direction = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    direction += camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    direction -= camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    direction -= camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    direction += camera.CFrame.RightVector
                end
                if direction.Magnitude > 0 then
                    humanoidRootPart.Velocity = direction.Unit * speed
                else
                    humanoidRootPart.Velocity = Vector3.new(0,0,0)
                end
            end)
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end
end)
