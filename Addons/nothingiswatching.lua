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

local CoreGui = game.CoreGui

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera
local Character = Player.Character or Player.CharacterAdded:Wait()

Player.CharacterAdded:Connect(function(char)
	Character = char or Player.Character
	Camera = workspace.CurrentCamera
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
	Player.CameraMode = Enum.CameraMode.LockFirstPerson
end

--|| SHOVING ||--

if Shoving then
	task.spawn(function()
		while true do
			task.wait(math.random(30, 120))
			loadstring(Shove)() 
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

local SFGui = Instance.new("ScreenGui", CoreGui); do
	SFGui.Name = "ScaryFlash"
	SFGui.ResetOnSpawn = false
	SFGui.IgnoreGuiInset = true
	SFGui.Enabled = false
	SFGui.DisplayOrder = 2147483648
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
	local Radius = 200

	plr.Character.Archivable = true
	local nullPlr = plr.Character:Clone(); do
		nullPlr.Name = "PlayerIsmissingUserId"
		nullPlr.Humanoid.DisplayName = "PlayerIsmissingUserId"
		nullPlr.Parent = workspace
		nullPlr.PrimaryPart = nullPlr.HumanoidRootPart

		nullPlr:FindFirstChild("Animate"):Destroy()
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

	local Center = workspace.CurrentCamera.ViewportSize / 2

	Debris:AddItem(nullPlr, 180)

	local Character = plr.Character
	local HRP = Character:FindFirstChild("HumanoidRootPart")

	local function getSafeSpawnPosition()
		local attempts = 0
		while attempts < 10 do
			attempts += 1

			local angle = math.random() * 2 * math.pi
			local distance = Radius
			local offset = Vector3.new(math.cos(angle) * distance, 50, math.sin(angle) * distance)
			local spawnPos = HRP.Position + offset

			local screenPoint, onScreen = Camera:WorldToViewportPoint(spawnPos)
			if not onScreen then
				return spawnPos
			end

			local screenCenter = workspace.CurrentCamera.ViewportSize / 2
			local dist = (Vector2.new(screenPoint.X, screenPoint.Y) - screenCenter).Magnitude

			if dist > 250 then
				return spawnPos
			end
		end

		-- fallback: just spawn far behind the player atp
		local backVec = -Camera.CFrame.LookVector * Radius
		return HRP.Position + backVec + Vector3.new(0, 50, 0)
	end

	-- Set safe position
	nullPlr:PivotTo(CFrame.new(getSafeSpawnPosition()))

	local stareLoop
	local loop
	
	stareLoop = RunService.RenderStepped:Connect(function()
		local nPos = nullPlr.PrimaryPart.Position
		local tPos = HRP.Position

		local modTPos = Vector3.new(tPos.X, nPos.Y, tPos.Z)
		local newCF = CFrame.new(nPos, modTPos)

		nullPlr:PivotTo(newCF)
	end) 
	loop = RunService.RenderStepped:Connect(function()
		local Point, onScreen = workspace.CurrentCamera:WorldToViewportPoint(nullPlr.PrimaryPart.Position)

		if onScreen then
			local d = (Vector2.new(Point.X, Point.Y) - Center).Magnitude
			local r = 20

			if d <= r then
				-- || RAYCAST CHECK FIRST
				local origin = Camera.CFrame.Position
				local direction = (nullPlr.PrimaryPart.Position - origin).Unit * 999
				local rayParams = RaycastParams.new(); do
					rayParams.FilterDescendantsInstances = {nullPlr, Player.Character}
					rayParams.FilterType = Enum.RaycastFilterType.Blacklist
				end

				local result = workspace:Raycast(origin, direction, rayParams)

				if result and not nullPlr:IsAncestorOf(result.Instance) then
					-- Something else is in the way of the Player's view.
					return
				end

				-- There's no obstruction, so continue. 
				stareLoop:Disconnect()
				loop:Disconnect()
			
				if math.random() >= 0.25 then
					nullPlr:Destroy()
					Glitch:Play()

					warn("            =)")
				else
					SFf.Image = ScaryFlash[math.random(1, #ScaryFlash)]
					warn("You will become one of us.")

					nullPlr:Destroy()

					task.spawn(function()
						SFGui.Enabled = true
						task.wait(0.5)
						SFGui.Enabled = false
					end) 

					local minzoom = plr.CameraMinZoomDistance
					local maxzoom = plr.CameraMaxZoomDistance
				
					task.spawn(function()
						plr.CameraMode = Enum.CameraMode.Classic
						plr.CameraMinZoomDistance = 10
						plr.CameraMaxZoomDistance = 10
						task.wait()
						Character.Humanoid.Health = 0

						task.wait(Players.RespawnTime)
						plr.CameraMode = Enum.CameraMode.LockFirstPerson
						plr.CameraMinZoomDistance = minzoom
						plr.CameraMaxZoomDistance = maxzoom
					end)

					Glitch:Play()
					NullKill:Play()

					for _, v in ipairs(Character:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CanCollide = false
							v.AssemblyLinearVelocity = Vector3.new(math.random(100, 200), 200, math.random(100, 200))
						end
					end
				end
			end
		end
	end)
end

if null then 
	task.spawn(function()
		while true do
			task.wait(5) -- Hello this cooldown is a placeholder it'll be random later I think maybe if I don't forget or something idk Don't Forget deltarune reference okay
			if Player.Character and Player.Character:WaitForChild("Humanoid").Health > 0 then
				Null(Player)
			end
		end
	end)
end

--|| RENDER DISTANCE ||--

