--[[
	Hii!! It's me again! You remember me, right? Ms. Solyn A. Placeholder? From Main.lua?
	No? Awhh... it's fine, I'm used to being forgotten, don't worry.

	Anyway, what do we have here...
	Oh, the Sprint button! I like this one!

	It's the second most useful button.
	I'll explain along the way~!!⭐
]]

local genv = (getgenv and getgenv()) or shared

local Settings = genv.Settings -- This should get your Settings! If you executed it with them.
local Module = genv.Module -- Module will just keep appearing! Of course, these aren't actually ModuleScripts, but they're genv emulations of them.

local Button = Module.Button
local Positioner = Module.Positioner
local Asset = Module.Asset

local Toggled = Settings.Buttons.Sprint.Toggled or false -- This will determine whether or not the button will be Held or Toggled. Default is Held/false, if you didn't know already!
local IsTweened = Settings.Buttons.Sprint.IsTweened or true -- Of course, this is mostly visual. But it looks smooth!

local m = Settings.Buttons.Sprint.Multipliers or {} -- Yes, your Base WalkSpeed/Field of View will be multiplied by these values.
local WSm = m.WalkSpeed or 1.5
local FOVm = m.FieldOfView or 1.15

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local info = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Exponential, -- If you're familiar with mathematics, you would naturally understand this.
	Enum.EasingDirection.Out -- It's like.. Think of an Expo In. It gradually gets faster until you reach the end. Now this one is backwards! Instead of getting faster, it starts really fast, then gets slower and slower. Sorry, I'm talking too much. Sorry...
)

local Player = Players.LocalPlayer -- Hi You!! („>ᵕ🌟„)
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Camera = workspace.CurrentCamera

local BaseWS = Humanoid.WalkSpeed or 16
local BaseFOV = Camera.FieldOfView or 70

local sprinting = Instance.new("BoolValue", Character) -- This'll indicate whether you're sprinting or not!
	sprinting.Name = "Sprinting"
	sprinting.Value = false

Player.CharacterAdded:Connect(function(new)
	Character = new
	Humanoid = Character:WaitForChild("Humanoid")
	Camera = workspace.CurrentCamera
	
	sprinting = Instance.new("BoolValue", Character)
		sprinting.Name = "Sprinting"
		sprinting.Value = false

	BaseWS = Humanoid.WalkSpeed
	BaseFOV = Camera.FieldOfView
end)

local btn = "SprintButton"

local off = Asset.get("Timeless/" .. btn .. "_off.png")
local on = Asset.get("Timeless/" .. btn .. "_on.png")

local button = Button.new(btn, true)
	button.Image = off
	button.PressedImage = on
	button.Position = Positioner.get(Settings.Buttons.Sprint.Position)


local function sprintStart(hum, cam)
	local Tween_1 = TweenService:Create(hum, info, { WalkSpeed = BaseWS * WSm })
	local Tween_2 = TweenService:Create(cam, info, { FieldOfView = BaseFOV * FOVm })

	if IsTweened then
		Tween_1:Play()
		Tween_2:Play()
	else
		hum.WalkSpeed = BaseWS * WSm
		cam.FieldOfView = BaseFOV * FOVm
	end
end

local function sprintStop(hum, cam)
	local Tween_1 = TweenService:Create(hum, info, { WalkSpeed = BaseWS })
	local Tween_2 = TweenService:Create(cam, info, { FieldOfView = BaseFOV })
	
	if IsTweened then
		Tween_1:Play()
		Tween_2:Play()
	else
		hum.WalkSpeed = BaseWS
		cam.FieldOfView = BaseFOV
	end
end


if Toggled then
	button.MouseButton1Click:Connect(function()
		sprinting.Value = not sprinting.Value
		if sprinting.Value then
			sprintStart(Humanoid, Camera)
		else
			sprintStop(Humanoid, Camera)
		end
	end)
else
	button.MouseButton1Down:Connect(function()
		sprinting.Value = true
		sprintStart(Humanoid, Camera)
	end)

	button.MouseButton1Up:Connect(function() -- MouseButton1Up is kind of... er, terrible, sometimes. Unfortunately, Ms. relojac can't really do much about it.
		sprinting.Value = false
		sprintStop(Humanoid, Camera)
	end) 
end

RunService.RenderStepped:Connect(function()
	if not sprinting.Value and Toggled then
		button.Image = off
		button.PressedImage = on
	elseif sprinting.Value and Toggled then
		button.Image = on
		button.PressedImage = off
	end

	if Humanoid.MoveDirection.Magnitude > 0 then
		button.Visible = true
	else
		button.Visible = false
		sprinting.Value = false
		sprintStop(Humanoid, Camera) -- Because Roblox is wack, if a Button becomes invisible before you can MouseButton1Up it, it'll never fire until you do it once it's visible again. Of course, we'll have to work with just calling sprintStop again... (⁠╥⁠﹏⁠💫⁠)
	end
end) 
