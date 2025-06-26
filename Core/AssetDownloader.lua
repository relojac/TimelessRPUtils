local genv = (getgenv and getgenv()) or shared

local Module = genv.Module
local Asset = Module.Asset

local getsynasset = getsynasset or getcustomasset or function() end

local buttons = {
	"Button_off.png",
	"Button_on.png", 

	"DropButton_off.png",
	"DropButton_on.png", 

	"JumpButton_off.png",
	"JumpButton_on.png", 

	"NVButton_off.png",
	"NVButton_on.png", 

	"ResetButton_off.png",
	"ResetButton_on.png", 

	"SitButton_off.png",
	"SitButton_on.png"
}
local effects = {
	"vignette.png"
}

for _, v in ipairs(buttons) do
	Asset.write("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Assets/Buttons/"..v, v)
	print(getsynasset(v))
end

for _, v in ipairs(effects) do
	Asset.write("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Assets/AutoLoadedEffects/"..v, v)
	print(getsynasset(v))
end
