local genv = (getgenv and getgenv()) or shared

local Settings = genv.Settings.Addons.nothingiswatching
local Module = genv.Module

local Asset = Module.Asset


local CRTEffect = Settings.CRTEffect
local Shoving = Settings.Shoving
local null = Settings.null
local FPSCap = Settings.FPSCap
local LockFirstPerson = Settings.LockFirstPerson

local Shove = game:HttpGet("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Core/RandomShit/Shove.lua")


local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--|| CRT EFFECT ||--

local CRTimg = Asset.get("Timeless/crt.png")

local CRTGui = Instance.new("ScreenGui", PlayerGui); do
	CRTGui.Name = "CRTGui"
	CRTGui.ResetOnSpawn = false
	CRTGui.IgnoreGuiInset = true
	CRTGui.Enabled = CRTEffect
	CRTGui.DisplayOrder = -2147483648
end

local Reference = Instance.new("ImageLabel", CRTGui); do
	Reference.Name = "Reference"
	Reference.Active = false
	Reference.AnchorPoint = Vector2.new(0.5, 0)
	Reference.Position = UDim2.fromScale(0.5, 0)
	Reference.Size = UDim2.fromScale(1, 1)
	Reference.BackgroundTransparency = 1
	Reference.Image = CRTimg
end

local UIARC = Instance.new("UIAspectRatioConstraint", Reference); do
	UIARC.AspectRatio = 4/3
	UIARC.DominantAxis = Enum.DominantAxis.Width
end

local border = Instance.new("Frame"); do
	border.Name = "Border"
	border.Active = false
	border.Size = UDim2.fromScale(1, 2)
	border.BorderSizePixel = 0
	border.BackgroundColor3 = Color3.new(0, 0, 0)
end

local left = border:Clone(); do
	left.Parent = Reference
	left.Position = UDim2.fromScale(-1, 0)
end
local right = border:Clone(); do
	right.Parent = Reference
	right.Position = UDim2.fromScale(1, 0)
end

--|| FPS ||--

if FPSCap then
	RunService.RenderStepped:Connect(function()
		setfpscap(12)
	end)
end

--|| FIRST PERSON ||--

if LockFirstPerson then
	while Player.CameraMode ~= Enum.CameraMode.LockFirstPerson do
		Player.CameraMode = Enum.CameraMode.LockFirstPerson
	end
end

--|| SHOVING ||--

task.spawn(function()
	while true do
		task.wait(math.random(60, 180))
		loadstring(Shove)()
	end
end)
