local genv = (getgenv and getgenv()) or shared

local Module = genv.Module
local Asset = Module.Asset

genv.AllAssets = genv.AllAssets or {}
local AllAssets = genv.AllAssets
local AlwaysRedownload = genv.AlwaysRedownload or false

local getsynasset = getsynasset or getcustomasset or function() end

AllAssets.Buttons = {
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
AllAssets.AutoLoadedEffects = {
	"vignette.png"
}

for _, v in ipairs(AllAssets.Buttons) do
	if AlwaysRedownload then Asset.del(v) end
	Asset.write("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Assets/Buttons/"..v, v)
	print(getsynasset(v))
end

for _, v in ipairs(AllAssets.AutoLoadedEffects) do
	if AlwaysRedownload then Asset.del(v) end
	Asset.write("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Assets/AutoLoadedEffects/"..v, v)
	print(getsynasset(v))
end
