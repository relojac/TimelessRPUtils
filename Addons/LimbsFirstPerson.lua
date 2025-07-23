local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local RS, Died
local currentState, lastState
local function transparencyFix(char)
	RS = RunService.RenderStepped:Connect(function()
		local Humanoid = char:FindFirstChild("Humanoid")
		local Head = char:FindFirstChild("Head")

		currentState = Head.LocalTransparencyModifier <= 0 and "first" or "third"

		if currentState ~= lastState then
			if Head and Humanoid and currentState == "first" then
				Humanoid.CameraOffset += Vector3.new(0, 0, 0.5)
			else
				Humanoid.CameraOffset -= Vector3.new(0, 0, 0.5)
			end
			
			lastState = currentState
		end
	end

	Died = char:WaitForChild("Humanoid").Died:Connect(function()
		RS:Disconnect()
		Died:Disconnect()
	end)

	
	for _, v in char:GetChildren() do
		if not v:IsA("BasePart") then
			continue
		end

		v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
			v.LocalTransparencyModifier = 0
		end)

		v.LocalTransparencyModifier = 0
	end

	char.ChildAdded:Connect(function(v)
		if not v:IsA("BasePart") then
			return
		end

		v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
			v.LocalTransparencyModifier = 0
		end)

		v.LocalTransparencyModifier = 0
	end)
end

if Player.Character then
	transparencyFix(Player.Character)
end

Player.CharacterAdded:Connect(transparencyFix)
