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
	local filePref
	if not name:match("Button") then
		filePref = name.."Button"
	else
		filePref = name
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
	local b = Reference:FindFirstChild(name)

	if b then
		b:Destroy()
	else
		warn(name, "is not a valid Button object")
	end
	return
end
