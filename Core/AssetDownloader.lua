local genv = (getgenv and getgenv()) or shared

genv.Module = genv.Module or {}
local Module = genv.Module
local Settings = genv.Settings

local AlwaysRedownload = Settings.AlwaysRedownloadAssets

local Asset = Module.Asset

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/AssetTable.lua"))()
local AllAssets = genv.AllAssets

for name, entry in pairs(AllAssets) do
	print("access", entry, "of AllAssets")
	for _, v in ipairs(entry) do
		if AlwaysRedownloadAssets then Asset.del(v) end
		
		print("attempt to download", v)
		Asset.write("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Assets/"..name.."/"..v.."/", v)
		print("downloaded", v, "-", getsynasset(v))
	end
end
