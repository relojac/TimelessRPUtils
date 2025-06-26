local genv = (getgenv and getgenv()) or shared
local Settings = genv.Settings

local ButtonSpacing = Settings.ButtonSpacing or 0.1

genv.Module = genv.Module or {}
local Module = genv.Module

genv.Positioner = genv.Positioner or {}
local Positioner = genv.Positioner

local butSp = 1 + ButtonSpacing

function Positioner.do(xM, yM)
	local X = (xM or -1) * butSp
	local Y = (yM or 0) * (butSp*-1)

	return UDim2.fromScale(X, Y)
end

function Positioner.reset(button)
	button.Position = UDim2.fromScale(0, 0)
end
