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


function Button.new(name, active)
	if typeof(name) ~= "string" then
		warn("expected string for name, got", typeof(name)..". defaulting to nil.")
		name = "Button"
	elseif typeof(active) ~= "bool" then
		warn("expected bool for active, got", typeof(name)..". defaulting to true.")
		active = true
	end

	local filePref
	if not name:match("Button") then
		filePref = name.."Button" or "Button"
	else
		filePref = name or "Button"
	end
	
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
