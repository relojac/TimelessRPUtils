local genv = (getgenv and getgenv()) or shared

genv.Module = genv.Module or {}
local Module = genv.Module

Module.Button = Module.Button or {}
local Button = Module.Button

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local TouchGui = PlayerGui:WaitForChild("TouchGui")
local TCF = TouchGui:WaitForChild("TouchControlFrame")
local JumpButton = TCF:WaitForChild("JumpButton")

local Reference = TCF:WaitForChild("JumpButtonReference")

local getsynasset = getsynasset or getcustomasset or function() end


function Button.new(name, active)
	local b = Instance.new("ImageButton", Reference)
		b.Name = name
		b.Image = getsynasset(name.."_off")
		b.PressedImage = getsynasset(name.."_on")
		b.Active = active
		b.BackgroundTransparency = 1
		b.Size = UDim2.fromScale(1, 1)

	return b
end

function Button.del(name)
	local b = Reference:FindFirstChild(name)

	if b then
		b:Destroy()
	else
		warn(name, "is not a valid Button object")
	end
	return
end
