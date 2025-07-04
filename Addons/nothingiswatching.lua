local genv = (getgenv and getgenv()) or shared

local Settings = genv.Settings.Addons.nothingiswatching
local Module = genv.Module

local Asset = Module.Asset


local CRTEffect = Settings.CRTEffect
local Shoving = Settings.Shoving
local null = Settings.null
local LockFirstPerson = Settings.LockFirstPerson
local Nostalgia = Settings.Nostalgia

local AssetTable = genv.AssetTable


local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui") 

local Terrain = workspace.Terrain

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera or workspace:FindFirstChildWhichIsA("Camera")
local Character = Player.Character or Player.CharacterAdded:Wait()

Player.CharacterAdded:Connect(function(char)
	Character = char
	Camera = workspace.CurrentCamera

	if LockFirstPerson then
		Player.CameraMode = Enum.CameraMode.LockFirstPerson
	end
end)


local function badgeNotif(badgeName, badgeImg, creator)
	StarterGui:SetCore("SendNotification", {
		Title = "Badge Awarded";
		Text = Player.Name .. " won " .. creator .. [['s "]] .. badgeName .. [[" award!]];
		Icon = badgeImg;
		Duration = 5;
	})
end

--|| NOSTALGIA ||--

local amb = Color3.fromRGB(128, 128, 128)
if Nostalgia then
	for _, v in ipairs(Lighting:GetChildren()) do
		v:Destroy()
	end
	for _, v in ipairs(workspace.Terrain:GetDescendants()) do
		if v:IsA("Clouds") then v:Destroy() end
	end
	
	Lighting.GlobalShadows = false

	Lighting.Ambient = amb
	Lighting.OutdoorAmbient = amb
	Lighting.ColorShift_Top = amb
	Lighting.ColorShift_Bottom = amb

	Lighting.Technology = Enum.Technology.Compatibility

	Lighting.EnvironmentSpecularScale = 0
	Lighting.EnvironmentDiffuseScale = 1

	Lighting.ShadowSoftness = 0
	Lighting.ExposureCompensation = 0
	Lighting.Brightness = 1

	local sky_bk = Asset.get("Timeless/null_plainsky512_bk.jpg")
	local sky_dn = Asset.get("Timeless/null_plainsky512_dn.jpg")
	local sky_up = Asset.get("Timeless/null_plainsky512_up.jpg")
	local sky_rt = Asset.get("Timeless/null_plainsky512_rt.jpg")
	local sky_lf = Asset.get("Timeless/null_plainsky512_lf.jpg")
	local sky_ft = Asset.get("Timeless/null_plainsky512_ft.jpg")
	local Sun = Asset.get("Timeless/Sun.jpg")
	local Moon = Asset.get("Timeless/Moon.png")
	local Sky = Instance.new("Sky", Lighting); do
		Sky.Name = "Classic"
		
		Sky.SkyboxBk = sky_bk
		Sky.SkyboxDn = sky_dn
		Sky.SkyboxFt = sky_ft
		Sky.SkyboxLf = sky_lf
		Sky.SkyboxRt = sky_rt
		Sky.SkyboxUp = sky_up

		Sky.MoonTextureId = Moon
		Sky.SunTextureId = Sun
	end
end

--|| SOUNDS ||--

local Moonglitch = Instance.new("Sound", SoundService); do
	Moonglitch.Name = "Moonglitch"
	Moonglitch.Volume = 1.5
	Moonglitch.SoundId = Asset.get("Timeless/Moonglitch.ogg")
end

local Glitch = Instance.new("Sound", SoundService); do
	Glitch.Name = "Glitch"
	Glitch.Volume = 2
	Glitch.SoundId = Asset.get("Timeless/Glitch.ogg")
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

local function shove(plr)
	local X = math.random(-30, 30)
	local Y = math.random(5, 20)
	local Z = math.random(-30, 30)

	local ch = plr.Character
	local HRP = ch:FindFirstChild("HumanoidRootPart")
	local Att = HRP:WaitForChild("RootAttachment")
	local LV = Instance.new("LinearVelocity"); do
		LV.Name = "FlingForce"
		LV.MaxForce = math.huge
		LV.VectorVelocity = Vector3.new(X, Y, Z)
		LV.Attachment0 = Att
		LV.Parent = HRP
	end

	Debris:AddItem(LV, 0.1)
end

local shoveDel = math.random(30, 120)
if Shoving then
	task.spawn(function()
		while true do
			print(shoveDel.."s before shove()")
			task.wait(shoveDel)
			
			if Player.Character and Player.Character.Humanoid.Health > 0 then
				shove(Player)
			end
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
	SFGui.DisplayOrder = 2147483647
end

local SFf = Instance.new("ImageLabel", SFGui); do
	SFf.Name = "SFImage"
	SFf.Position = UDim2.new(0, 0, 0, 0)
	SFf.Size = UDim2.fromScale(1, 1)
	SFf.BackgroundTransparency = 1
	SFf.Image = ScaryFlash[math.random(1, #ScaryFlash)]
end

--|| null ||--

local NullKill = Instance.new("Sound", SoundService); do
	NullKill.Name = "NullKill"
	NullKill.Volume = 1.25
	NullKill.SoundId = Asset.get("Timeless/Jumpscare1.ogg")
end

local YouWill = Instance.new("Sound", SoundService); do
	YouWill.Name = "YOU WILL BECOME ONE OF US"
	YouWill.Volume = 2
	YouWill.SoundId = Asset.get("Timeless/ONE_OF_US.ogg")
end

local function Null(plr)
	local ch = plr.Character or plr.CharacterAdded:Wait()
	local HRP = ch:WaitForChild("HumanoidRootPart")
	local cam = workspace.CurrentCamera
	
	local Radius = math.random(100, 150)

	ch.Archivable = true
	local nullPlr = ch:Clone(); do
		nullPlr.Name = "PlayerIsmissingUserId"
		nullPlr.Humanoid.DisplayName = "PlayerIsmissingUserId"
		nullPlr.Parent = workspace
		nullPlr.PrimaryPart = nullPlr.HumanoidRootPart

		nullPlr:FindFirstChild("Animate"):Destroy()
	end -- Here I am.
	local LookAtMe = nullPlr.HumanoidRootPart:Clone(); do
		LookAtMe.Name = "LookAtMe"
		LookAtMe.Size = Vector3.new(10, 10, 10) -- The end is nigh
		LookAtMe.Parent = nullPlr
	end

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

			if dist > 150 then
				return spawnPos
			end
		end

		-- fallback: just spawn far behind the player atp
		local backVec = -Camera.CFrame.LookVector * Radius
		return HRP.Position + backVec + Vector3.new(0, 50, 0)
	end

	-- Set safe position
	nullPlr:PivotTo(CFrame.new(getSafeSpawnPosition()))
	
	local loop
	loop = RunService.RenderStepped:Connect(function()
		local nPos = nullPlr.PrimaryPart.Position
		local tPos = HRP.Position

		local modTPos = Vector3.new(tPos.X, nPos.Y, tPos.Z)
		local newCF = CFrame.new(nPos, modTPos)

		nullPlr:PivotTo(newCF)

		--

		local l = 300
		local cfg = RaycastParams.new(); do
			cfg.FilterDescendantsInstances = {ch}
		end

		local cast = workspace:Raycast(cam.CFrame.Position, cam.CFrame.LookVector * l, cfg) 

		if cast and cast.Instance and cast.Instance == LookAtMe then
			loop:Disconnect()

			if math.random() >= 0.3 then
				nullPlr:Destroy()
				Glitch:Play()

				warn("                     =)")
			else
				SFf.Image = ScaryFlash[math.random(1, #ScaryFlash)]
				warn("YOU      WILL    B   e  COME          ONE OF         US      S      S  s     s    s    /")

				nullPlr:Destroy()

				task.spawn(function()
					SFGui.Enabled = true
					task.wait(0.25)
					SFGui.Enabled = false
				end) 

				local minzoom = plr.CameraMinZoomDistance
				local maxzoom = plr.CameraMaxZoomDistance

				if LockFirstPerson then
					task.spawn(function()
						plr.CameraMode = Enum.CameraMode.Classic
						plr.CameraMinZoomDistance = 10
						plr.CameraMaxZoomDistance = 10
						task.wait()
						Player.Character:WaitForChild("Humanoid").Health = 0
						
						task.wait(Players.RespawnTime)
						plr.CameraMode = Enum.CameraMode.LockFirstPerson
						plr.CameraMinZoomDistance = minzoom
						plr.CameraMaxZoomDistance = maxzoom
					end)
				end

				task.spawn(function()
					for _, v in ipairs(ch:GetDescendants()) do
						task.spawn(function()
							if v:IsA("BasePart") then
								v.CanCollide = false
								v.AssemblyLinearVelocity = Vector3.new(math.random(-150, 150), 250, math.random(-150, 150))
							end
						end) 
					end

					task.wait(0.05)

					Player.Character:WaitForChild("Humanoid").Health = 0
				end) 

				NullKill:Play()

				for _, v in ipairs(workspace:GetChildren()) do
					if v:IsA("Model") and v.Name == nullPlr.Name then
						v:Destroy()
					end
				end
			end
		end
	end)
	local died
	died = plr.Character.Humanoid.Died:Connect(function()
		loop:Disconnect() 
		died:Disconnect()
	end)

	task.spawn(function()
		local destr
		destr = nullPlr.Destroying:Connect(function()
			loop:Disconnect()
			died:Disconnect() 
			destr:Disconnect()
		end)
	end) 
end

if null then 
	task.spawn(function()
		while true do
			task.wait(math.random(3, 7)) -- Hello this cooldown is a placeholder it'll be random later I think maybe if I don't forget or something idk Don't Forget deltarune reference okay
			if Character and Character:WaitForChild("Humanoid").Health > 0 then
				Null(Player)
			end
		end
	end)
end

--|| RENDER DISTANCE ||--

local function FogEvent()
	local fcol = Lighting.FogColor
	local fstart, fend = Lighting.FogStart, Lighting.FogEnd
	
	Moonglitch:Play() 
	
	Lighting.FogColor = Color3.new(0.5, 0.5, 0.5)
	Lighting.FogStart = 15
	Lighting.FogEnd = 20

	task.wait(20)

	Lighting.FogColor = fcol
	Lighting.FogStart = fstart
	Lighting.FogEnd = fend
end

local rFog
task.spawn(function()
	while true do
		rFog = math.random(60, 120)
		print(rFog.."s until FogEvent RNG")
			
		task.wait(rFog)
		
		if math.random() < 0.5 then
			FogEvent()
			warn("Do you see me?")
		else
			print("Random event: FogEvent() not initiated; math.random > 0.5")
		end
	end
end)

--|| FAKE BADGE ||--

local badge = false
local badgeWait
while not badge do
	badgeWait = math.random(15, 30)
	
	print(badgeWait .. "s until badge RNG")
	task.wait(badgeWait)
	
	if math.random() < 0.075 then
		badge = true
		badgeNotif("", Asset.get("Timeless/badge.png"), "null")
	end
end
