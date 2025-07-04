local genv = (getgenv and getgenv()) or shared

local getsynasset = getsynasset or getcustomasset or function() end

genv.Module = genv.Module or {}
local Module = genv.Module
local Settings = genv.Settings

local AlwaysRedownloadAssets = Settings.AlwaysRedownloadAssets

local Asset = Module.Asset

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Assets/AssetTable.lua"))()
local AssetTable = genv.AssetTable

local activeTasks = 0

for name, entry in pairs(AssetTable) do
	print("access", name, "of AssetTable")
	for _, v in ipairs(entry) do
		task.spawn(function()
			activeTasks += 1
			if AlwaysRedownloadAssets then Asset.del("Timeless/" .. v) end
		
			Asset.write("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Assets/"..name.."/"..v.."/", "Timeless/" .. v)

			activeTasks -= 1
		end) 
	end
end

repeat task.wait() until activeTasks == 0
