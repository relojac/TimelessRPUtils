local genv = (getgenv and getgenv()) or shared

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Module/Asset.lua"))()

genv.Module = genv.Module or {}
local Module = genv.Module

local Asset = Module.Asset

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Assets/AssetTable.lua"))()
local AssetTable = genv.AssetTable

for name, entry in pairs(AssetTable) do
	print("access", entry, "of AssetTable")
	for _, v in ipairs(entry) do
		Asset.del(v, nil)
	end
end
