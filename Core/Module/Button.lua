local genv = (getgenv and getgenv()) or shared

genv.Module = genv.Module or {}
local Module = genv.Module

Module.Button = Module.Button or {}
local Button = genv.Button

local Values = genv.Values

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local JB = Values.Gui.JumpButton
local Reference = JB.Reference


function Button.new(name, active)
	if typeof(name) ~= "string" then
		warn("name arg is not a string")
	elseif typeof(active) ~= "bool" then
		warn("active arg is not a bool")
	end
	local filePref = name.."Button" or "Button"
	
	local b = Instance.new("ImageButton", Reference)
		b.Name = filePref
		b.Image = getsynasset(filePref.."_off.png")
		b.PressedImage = getsyn_asset(filePref.."_on.png")
		b.Active = active or true
		b.BackgroundTransparency = 1
		b.Size = UDim2.fromScale(1, 1)

	return b
end

function Button.del(name)
	if typeof(name) ~= "string" then
		warn("name arg is not a string")
		return
	end
	
	local b = Reference:FindFirstChild(name)

	if b then
		b:Destroy()
	else
		warn(name, "is not a valid Button object")
	end
	return
end
