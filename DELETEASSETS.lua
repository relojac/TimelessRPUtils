local genv = (getgenv and getgenv()) or shared

genv.Module = genv.Module or {}
local Module = genv.Module

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Module/Asset.lua"))()
local Asset = Module.Asset

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Assets/AssetTable.lua"))()
local AssetTable = genv.AssetTable

for name, entry in pairs(AssetTable) do
	print("access", name, "of AssetTable")
	for _, v in ipairs(entry) do
		Asset.del("Timeless/" .. v)
	end
end
