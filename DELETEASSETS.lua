-- Execute this to delete all the Timeless assets from your workspace folder!

local genv = (getgenv and getgenv()) or shared

local Module = genv.Module
local Asset = Module.Asset

genv.AllAssets = genv.AllAssets or {}
local AllAssets = genv.AllAssets

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
	Asset.del(v)
end

for _, v in ipairs(AllAssets.AutoLoadedEffects) do
	Asset.del(v)
end
