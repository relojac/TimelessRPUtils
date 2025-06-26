local genv = (getgenv and getgenv()) or shared

genv.Module = genv.Module or {}
local Module = genv.Module

Module.Button = Module.Button or {}
local Button = Module.Button

local Values = genv.Values

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local JB = Values.Gui.JumpButton
local Reference = JB.Reference

local getsynasset = getsynasset or getcustomasset or function() end


function Button.new(name, active)
	local off = name .. "_off.png"
	local on = name .. "_on.png"
	
	local b = Instance.new("ImageButton", Reference)
		b.Name = name
		b.Image = getsynasset(off)
		b.PressedImage = getsynasset(on)
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
