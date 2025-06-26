local genv = (getgenv and getgenv()) or shared
local Settings = genv.Settings

local ButtonSpacing = Settings.ButtonSpacing or 0.1

genv.Module = genv.Module or {}
local Module = genv.Module

genv.Positioner = genv.Positioner or {
	["get"] = nil,
	["reset"] = nil
}
local Positioner = genv.Positioner

local butSp = 1 + ButtonSpacing

Positioner.get = function(pos)
	local X, Y = pos[1], pos[2]
	
	local xF = (X or -1) * butSp
	local yF = (Y or 0) * (butSp*-1)

	return UDim2.fromScale(xF, yF)
end

Positioner.reset = function(button)
	button.Position = UDim2.fromScale(0, 0)
end
