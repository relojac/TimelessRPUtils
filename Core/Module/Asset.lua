local genv = (getgenv and getgenv()) or shared

genv.Module = genv.Module or {}
local Module = genv.Module

Module.Asset = Module.Asset or {}
local Asset = Module.Asset

local getsynasset = getsynasset or getcustomasset or function() end 
local request = syn and syn.request or http and http.request or request or function() end
local isfile = isfile or readfile and function(filename) local succ,a = pcall(function() local b = readfile(filename) end) return succ end or function() end
local writefile = writefile or function() end
local delfile = delfile or function() end
local makefolder = makefolder or function() end
local isfolder = isfolder or function() end
local delfolder = delfolder or function() end

local works = getsynasset and request and writefile and isfile and defile and makefolder and isfolder and delfolder

if works then
	makefolder("Timeless")
end
	
function Asset.video(url, videoName)
	if works then
		if not isfile("Timeless/"..videoName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile("Timeless/"..videoName, Response.Body)
			end
		end

		return getsynasset("Timeless/"..videoName) or nil
	end
end

function Asset.image(url, imageName)
	if works then
		if not isfile("Timeless/"..imageName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile("Timeless"..imageName, Response.Body)
			end
		end

		return getsynasset("Timeless/"..imageName) or "rbxasset://textures/ui/GuiImagePlaceholder.png"
	end
end

function Asset.audio(url, audioName)
	if works then
		if not isfile("Timeless/"..audioName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile("Timeless/"..audioName, Response.Body)
			end
		end

		return getsynasset("Timeless/"..audioName) or "rbxasset://sounds/uuhhh.mp3"
	end
end


function Asset.write(url, assetName)
	if works then
		if not isfile("Timeless/"..assetName) then
			print("attempt to download", assetName)
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile("Timeless/"..assetName, Response.Body)
				print("successful:", assetName, "-", getsynasset(assetName))
			end
		else
			warn(assetName, "already exists!")
		end
	end
end

function Asset.del(assetName)
	if works then
		if isfile("Timeless/"..assetName) then
			delfile("Timeless/"..assetName)
		else
			warn(assetName, "is not a valid member of workspace!")
		end
	end
end

function Asset.get(asset)
	if works then
		if isfile("Timeless/"..asset) then
			return getsynasset("Timeless/"..asset)
		else
			warn(asset, "is not a valid member of workspace!")
			return
		end
	end
end
