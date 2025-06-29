local genv = (getgenv and getgenv()) or shared

local Settings = genv.Settings.Addons.nothingiswatching
local Module = genv.Module

local Asset = Module.Asset


local CRTEffect = Settings.CRTEffect
local Shoving = Settings.Shoving
local null = Settings.null
local LockFirstPerson = Settings.LockFirstPerson

local AssetTable = genv.AssetTable

local Shove = game:HttpGet("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Core/RandomShit/Shove.lua")


local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera
local Character = Player.Character or Player.CharacterAdded:Wait()

local castParams = RaycastParams.new()

Player.CharacterAdded:Connect(function(char)
	Character = char or Player.Character
	Camera = workspace.CurrentCamera
	castParams.FilterDescendantsInstances = { Character }
end) 

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

--|| ScaryFlash UI ||--

local ScaryFlash = {
	Asset.get("Timeless/Charts.png"),
	Asset.get("Timeless/Letter.png"),
	Asset.get("Timeless/Omniscience.png"),
	Asset.get("Timeless/Positioner.png"),
	Asset.get("Timeless/Sky.png"),
	Asset.get("Timeless/Verboten.png")
}

local SFGui = Instance.new("ScreenGui", PlayerGui); do
	SFGui.Name = "ScaryFlash"
	SFGui.ResetOnSpawn = false
	SFGui.IgnoreGuiInset = false
	SFGui.Enabled = false
end

local SFf = Instance.new("ImageLabel", SFGui); do
	SFf.Name = "SFImage"
	SFf.Position = UDim2.new(0, 0, 0, 0)
	SFf.Size = UDim2.fromScale(1, 1)
	SFf.BackgroundTransparency = 1
	SFf.Image = ScaryFlash[math.random(1, #ScaryFlash)]
end

--|| null ||--

local Jumpscare1 = Asset.get("Timeless/Jumpscare1.ogg")
local NullKill = Instance.new("Sound", SoundService); do
	NullKill.Name = "NullKill"
	NullKill.Volume = 1.25
	NullKill.SoundId = Jumpscare1
end

local OneOfUs = Asset.get("Timeless/ONE_OF_US.ogg")
local YouWill = Instance.new("Sound", SoundService); do
	YouWill.Name = "YOU WILL BECOME ONE OF US"
	YouWill.Volume = 2
	YouWill.SoundId = OneOfUs
end

local function Null(plr)
	local Radius = 100
	
	local cast
	local loop = RunService.RenderStepped:Connect(function()
		cast = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 1500, castParams)
	end)

	plr.Character.Archivable = true
	local nullPlr = plr.Character:Clone(); do
		nullPlr.Name = "PlayerIsmissingUserID"
		nullPlr.Parent = workspace
		nullPlr.PrimaryPart = nullPlr.HumanoidRootPart
	end -- Here I am.

	for _, obj in ipairs(nullPlr:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Anchored = true
			obj.CanCollide = false
		end
	end

	local hl = Instance.new("Highlight"); do
		hl.OutlineTransparency = 1
		hl.FillTransparency = 0
		hl.FillColor = Color3.new(0, 0, 0)
		hl.DepthMode = Enum.HighlightDepthMode.Occluded
		hl.Parent = nullPlr
	end

	Debris:AddItem(nullPlr, 120)

	local Character = plr.Character
	local HRP = Character:WaitForChild("HumanoidRootPart")

	local angle = math.random() * 2 * math.pi
	local X = HRP.Position.X + math.cos(angle) * Radius
	local Y = HRP.Position.Y + 50
	local Z = HRP.Position.Z + math.sin(angle) * Radius
	
	nullPlr:SetPrimaryPartCFrame(CFrame.new(Vector3.new(X, Y, Z)))
	if cast and cast.Instance and cast.Instance == nullPlr.PrimaryPart then
		loop:Disconnect()
		if math.random() >= 0.05 then
			nullPlr:Destroy()
			Glitch:Play()

			warn("            =)")
		else
			SFGui.Enabled = true

			nullPlr:Destroy()
			
			Glitch:Play()

			task.wait(0.75)
			SFGui.Enabled = false

			Character.Humanoid.Health = 0
			NullKill:Play() 
			YouWill:Play()

			for _, v in ipairs(Character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
					v.AssemblyLinearVelocity = Vector3.new( math.random(-100, 100), 200, math.random(-100, 100) )
				end
			end
		end
	end
end

if null then 
	task.spawn(function()
		while true do
			task.wait(5)
			Null(Player)
		end
	end)
end

--|| RENDER DISTANCE ||--

