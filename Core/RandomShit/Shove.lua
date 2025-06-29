local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Character = Player.Character
local HRP = Character:WaitForChild("HumanoidRootPart")

local function shove()
	local X = math.random(-30, 30)
	local Y = math.random(5, 20)
	local Z = math.random(-30, 30)

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

task.spawn(function()
	shove()
	task.wait(math.random(0.5, 0.75)

	shove()
	task.wait(math.random(0.5, 0.75)

	shove()
	task.wait(math.random(0.5, 0.75)

	shove()
end)
