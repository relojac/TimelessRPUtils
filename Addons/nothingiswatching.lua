local genv = (getgenv and getgenv()) or shared

local Settings = genv.Settings.Addons.nothingiswatching
local Module = genv.Module

local Asset = Module.Asset


local CRTEffect = Settings.CRTEffect
local Shoving = Settings.Shoving
local null = Settings.null
local LockFirstPerson = Settings.LockFirstPerson

local Shove = game:HttpGet("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Core/RandomShit/Shove.lua")


local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--|| SOUNDS ||--

local MoonglitchSource = Asset.get("Timeless/Moonglitch.ogg")
local GlitchSource = Asset.get("Timeless/Glitch.ogg")

local Moonglitch = Instance.new("Sound", SoundService); do
	Moonglitch.Name = "Moonglitch"
	Moonglitch.Volume = 1.5
	Moonglitch.SoundId = MoonglitchSource
end

local Glitch = Instance.new("Sound", SoundService); do
	Glitch.Name = "Glitch"
	Glitch.Volume = 2
	Glitch.SoundId = GlitchSource
end

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

--|| FIRST PERSON ||--

if LockFirstPerson then
	while Player.CameraMode ~= Enum.CameraMode.LockFirstPerson do
		Player.CameraMode = Enum.CameraMode.LockFirstPerson
	end
end

--|| SHOVING ||--

local function shove()
	loadstring(Shove)()
	task.wait(math.random(0.5, 0.8))

	loadstring(Shove)()
	task.wait(math.random(0.5, 0.8))

	loadstring(Shove)()
	task.wait(math.random(0.5, 0.8))

	loadstring(Shove)()
	task.wait(math.random(0.5, 0.8))
end

if Shoving then
	task.spawn(function()
		while true do
			task.wait(math.random(30, 120))
			shove()
		end
	end)
end

--|| null ||--

local function phantom(plr)
	local Radius = 30
	
	local Ghost = plr.Character:Clone(workspace); do
		Ghost.Name = string.reverse(Player.DisplayName)
	end

	for _, obj in ipairs(Ghost:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Anchored = true
			obj.CanCollide = false
		end
	end

	local hl = Instance.new("Highlight"); do
		hl.OutlineTransparency = 1
		hl.FillColor = Color3.new(0, 0, 0)
		hl.DepthMode = Enum.HighlightDepthMode.Occluded
		hl.Parent = Ghost
	end

	Debris:AddItem(Ghost, 120)

	local Character = plr.Character
	local HRP = Character:WaitForChild("HumanoidRootPart")

	local X = HRP.Position.X + Radius*(2*math.random()-1)
	local Y = HRP.Position.Y + 1.5
	local Z = HRP.Position.Z + Radius*(2*math.random()-1)
	
	Ghost:SetPrimaryPartCFrame(CFrame.new(Vector3.new(X, Y, Z)))
	Ghost.PrimaryPart.Touched:Connect(function(hit)
		local ch = hit:FindFirstAncestorOfClass("Model")
		if ch then
			local Pl = Players:GetPlayerFromCharacter(ch)
			if Pl and Pl.Name == plr.Name then
				warn("=)")

				Glitch:Play()
				Null:Destroy()
			end
		end
	end)
end

if null then 
	task.spawn(function()
		while true do
			task.wait(5)
			phantom(Player)
		end
	end)
end

--|| RENDER DISTANCE ||--

