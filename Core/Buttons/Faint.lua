--[[
	Did you know that my middle name stands for "Abandoned?"
	Oh, um, right... the script, sorry. (⁠╥⁠﹏⁠💫⁠)

	This is my favorite button?
	Er, not because it's useful, but...
	It has cute kaomoji as the button Icons.
	I know, please, shame me...

	Huh? Oh, right.
]]

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

local btn = "FaintButton" -- Mhm!

local off = Asset.get("Timeless/" .. btn .. "_off.png")
local on = Asset.get("Timeless/" .. btn .. "_on.png")

local button = Button.new(btn, true)
	button.Image = off
	button.PressedImage = on
	button.Position = Positioner.get(Settings.Buttons.Faint.Position)

button.MouseButton1Click:Connect(function()
	Humanoid.PlatformStand = not Humanoid.PlatformStand -- I'm honestly surprised it isn't called Stun or PhysicsDisabled...
end)

RunService.Stepped:Connect(function()
	if not Humanoid.PlatformStand then
		button.Image = off
		button.PressedImage = on
	else
		button.Image = on
		button.PressedImage = off
	end
end)

--[[
	Wait, it's already over?
	Well, I'm sure you understood it anyway... T-💫

	Even, if it looks like spaghetti, don't eat it.
	Trust me.
]]

-- what do you even mean when you say that? do you actually have a point or are you just saying things?

--[[
	Oh, uhm, Ms. relojac... I. I didn't see you there.
	I, umm...
]]
