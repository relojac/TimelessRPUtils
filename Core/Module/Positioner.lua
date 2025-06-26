local genv = (getgenv and getgenv()) or shared
local Settings = genv.Settings

local ButtonSpacing = Settings.ButtonSpacing or 0.1

genv.Module = genv.Module or {}
local Module = genv.Module

Module.Positioner = Module.Positioner or {}
local Positioner = Module.Positioner

local butSp = 1 + ButtonSpacing

function Positioner.get(pos)
	local X, Y = pos[1], pos[2]
	
	local xF = (X or -1) * butSp
	local yF = (Y or 0) * (butSp*-1)

	return UDim2.fromScale(xF, yF)
end

function Positioner.reset(button)
	button.Position = UDim2.fromScale(0, 0)
end
