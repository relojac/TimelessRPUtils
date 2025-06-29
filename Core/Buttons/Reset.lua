local genv = (getgenv and getgenv()) or shared

local Settings = genv.Settings
local Module = genv.Module

local Button = Module.Button
local Positioner = Module.Positioner
local Asset = Module.Asset


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

Player.CharacterAdded:Connect(function(new)
	Character = new
	Humanoid = Character:WaitForChild("Humanoid")
end)

local btn = "ResetButton"

local off = Asset.get("Timeless/" .. btn .. "_off.png")
local on = Asset.get("Timeless/" .. btn .. "_on.png")

local button = Button.new(btn, true)
	button.Image = off
	button.PressedImage = on
	button.Position = Positioner.get(Settings.Buttons.Reset.Position)

button.MouseButton1Click:Connect(function()
	if Humanoid and Humanoid.Health > 0 then
		Humanoid.Health = 0
	end
end)

RunService.Stepped:Connect(function()
	if Humanoid.Health <= 0 then
		button.Image = on
	else
		button.Image = off
	end
end) 
