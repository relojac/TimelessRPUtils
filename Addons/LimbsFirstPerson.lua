local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local function transparencyFix(char)
	for _, v in char:GetChildren() do
		if not v:IsA("BasePart") or v.Name == "Torso" or v.Name == "UpperTorso" or v.Name == "LowerTorso" then
			continue
		end

		v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
			v.LocalTransparencyModifier = 0
		end)

		v.LocalTransparencyModifier = 0
	end

	char.ChildAdded:Connect(function(v)
		if not v:IsA("BasePart") or v.Name == "Torso" or v.Name == "UpperTorso" or v.Name == "LowerTorso" then
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
