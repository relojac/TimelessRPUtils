local genv = (getgenv and getgenv()) or shared

local Settings = genv.Settings
local Module = genv.Module

local Button = Module.Button
local Positioner = Module.Positioner


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

Player.CharacterAdded:Connect(function(new)
	Character = new
	Humanoid = Character:WaitForChild("Humanoid")
end)

local button = Button.new("SitButton", true)
	button.PressedImage = ""
	button.Position = Positioner.get(Settings.Buttons.Sit.Position)

button.MouseButton1Click:Connect(function()
	if not Humanoid.Sit then
		Humanoid.Sit = true
	else
		Humanoid.Sit = false
	end
end)

RunService.Stepped:Connect(function()
	if not Humanoid.Sit then
		button.Image = getsynasset("SitButton_off.png")
	else
		button.Image = getsynasset("SitButton_on.png")
	end
end)
