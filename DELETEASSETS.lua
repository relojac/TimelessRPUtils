-- Execute this to delete all the Timeless assets from your workspace folder!

local genv = (getgenv and getgenv()) or shared

local Module = genv.Module
local Asset = Module.Asset

loadstring(game:HttpGet("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/AssetTable.lua"))()
local AllAssets = genv.AllAssets

for _, entry in ipairs(AllAssets) do
	for _, v in ipairs(entry) do
		Asset.del(v)
	end
end
