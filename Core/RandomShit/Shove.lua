local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Character = Player.Character
local HRP = Character:WaitForChild("HumanoidRootPart")

local X = math.random(-100, 100)
local Y = math.random(50, 100)
local Z = math.random(-100, 100)

local Att = HRP:WaitForChild("RootAttachment")
local LV = Instance.new("LinearVelocity"); do
	LV.Name = "FlingForce"
	LV.MaxForce = math.huge
	LV.VectorVelocity = Vector3.new(X, Y, Z)
	LV.Attachment0 = Att
	LV.Parent = HRP
end

Debris:AddItem(LV, 0.1)
