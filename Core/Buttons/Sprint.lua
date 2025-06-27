local genv = (getgenv and getgenv()) or shared

local Settings = genv.Settings
local Module = genv.Module

local Button = Module.Button
local Positioner = Module.Positioner
local Asset = Module.Asset

local Toggled = Settings.Sprint.Toggled or false
local IsTweened = Settings.Sprint.IsTweened or true

local m = Settings.Sprint.Multipliers or {}
local WSm = m.WalkSpeed or 1.5
local FOVm = m.FieldOfView or 1.3

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local info = {
	0.5,
	Enum.EasingStyle.Exponential,
	Enum.EasingDirection.Out
}

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Camera = workspace.CurrentCamera

local sprinting = Instance.new("BoolValue", Character)
	sprinting.Name = "Sprinting"
	sprinting.Value = false

Player.CharacterAdded:Connect(function(new)
	Character = new
	Humanoid = Character:WaitForChild("Humanoid")
	Camera = workspace.CurrentCamera
	
	sprinting = Instance.new("BoolValue", Character)
		sprinting.Name = "Sprinting"
		sprinting.Value = false
end)

local btn = "SprintButton"

local off = Asset.get("Timeless/" .. btn .. "_off.png")
local on = Asset.get("Timeless/" .. btn .. "_on.png")

local button = Button.new(btn, true)
	button.Image = off
	button.PressedImage = on
	button.Position = Positioner.get(Settings.Buttons.Sprint.Position)

if not Toggled then
	button.MouseButton1Click:Connect(function()
		sprinting.Value = not sprinting.Value
	end)
else
	button.MouseButton1Down:Connect(function()
		sprinting.Value = true
	end)

	button.MouseButton1Up:Connect(function()
		sprinting.Value = false
	end) 
end

local BaseWS, BaseFOV
local blockBase = false
RunService.RenderStepped:Connect(function()
	if not sprinting.Value and not blockBase then
		BaseWS = Humanoid.WalkSpeed
		BaseFOV = Camera.FieldOfView
	end
end)


local function sprintStart(hum, cam)
	local Tween_1 = TweenService:Create(hum, info, { WalkSpeed = BaseWS*WSm })
	local Tween_2 = TweenService:Create(cam, info, { FieldOfView = BaseFOV*FOVm })
	
	if IsTweened then
		blockBase = true
		
		Tween_1:Play()
		Tween_2:Play()
	else
		blockBase = true

		hum.WalkSpeed = BaseWS*WSm
		cam.FieldOfView = BaseFOV*FOVm
	end
end

local function sprintEnd(hum, cam)
	local Tween_1 = TweenService:Create(hum, info, { WalkSpeed = BaseWS })
	local Tween_2 = TweenService:Create(cam, info, { FieldOfView = BaseFOV })
	
	if IsTweened then
		Tween_1:Play()
		Tween_2:Play()

		Tween_1.Completed:Wait()

		blockBase = false
	else
		hum.WalkSpeed = BaseWS*WSm
		cam.FieldOfView = BaseFOV*FOVm

		blockBase = false
	end
end


Humanoid.StateChanged:Connect(function()
	if sprinting.Value then
		if Humanoid.MoveDirection.Magnitude > 0 then
			sprintStart(Humanoid, Camera)
		else
			sprintStop(Humanoid, Camera)
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if not sprinting.Value then
		button.Image = off
		button.PressedImage = on
	else
		button.Image = on
		button.PressedImage = off
	end
end) 
