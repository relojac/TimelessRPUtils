local genv = (getgenv and getgenv()) or shared
local Settings = genv.Settings

local ButtonSpacing = Settings.ButtonSpacing or 0.1

genv.Module = genv.Module or {}
local Module = genv.Module

local butSp = 1 + ButtonSpacing

function Module.Positioner(xM, yM, Button)
	local X = xM * 1.1
	local Y = yM * -1.1

	Button.Position = UDim2.fromScale(X, Y)
end
