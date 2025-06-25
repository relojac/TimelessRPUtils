local genv = (getgenv and getgenv()) or shared
local Settings = genv.Settings
local Module = genv.Module

local butSp = 1.1

function Module.Positioner(xM, yM, Button)
	local X = xM * 1.1
	local Y = yM * -1.1

	Button.Position = UDim2.fromScale(X, Y)
end
