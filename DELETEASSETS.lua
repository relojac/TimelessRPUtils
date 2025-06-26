-- Execute this to delete all the Timeless assets from your workspace folder!

local genv = (getgenv and getgenv()) or shared

genv.Module = genv.Module or {}
local Module = genv.Module

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Module/Asset.lua"))()

local Asset = Module.Asset

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/AssetTable.lua"))()
local AllAssets = genv.AllAssets

for name, entry in pairs(AllAssets) do
	print("access", entry, "of AllAssets")
	for _, v in ipairs(entry) do
		print("attempt to delete", v)
		Asset.del(v)
	end
end
