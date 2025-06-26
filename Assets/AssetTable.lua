local genv = (getgenv and getgenv()) or shared

genv.AssetTable = genv.AssetTable or {}
local AssetTable = genv.AssetTable

AssetTable.Buttons = {
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

AssetTable.AutoLoadedEffects = {
	"vignette.png"
}

AssetTable.PsychopathicFlash = {
	"Charts.png",
	"Letter.png",
	"Ogscule.png",
	"Omniscience.png",
	"Positioner.png",
	"Sky.png",
	"Verboten.png"
}

AssetTable.Sounds = {}
