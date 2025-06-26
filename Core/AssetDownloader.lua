local genv = (getgenv and getgenv()) or shared

local getsynasset = getsynasset or getcustomasset or function() end

genv.Module = genv.Module or {}
local Module = genv.Module
local Settings = genv.Settings

local AlwaysRedownload = Settings.AlwaysRedownloadAssets

local Asset = Module.Asset

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Assets/AssetTable.lua"))()
local AssetTable = genv.AssetTable

for name, entry in pairs(AssetTable) do
	print("access", entry, "of AssetTable")
	for _, v in ipairs(entry) do
		if AlwaysRedownloadAssets then Asset.del(v) end
		
		Asset.write("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Assets/"..name.."/"..v.."/", v)
	end
end
