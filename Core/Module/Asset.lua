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

local works = getsynasset and request and writefile and isfile and delfile
	
function Asset.video(url, videoName)
	if not videoName:match(".webm") then
		videoName = videoName..".webm"
	end
	
	if works then
		if not isfile(videoName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(videoName, Response.Body)
			end
		end

		return getsynasset(videoName) or nil
	end
end

function Asset.image(url, imageName)
	if works then
		if not isfile(imageName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(imageName, Response.Body)
			end
		end

		return getsynasset(imageName) or "rbxasset://textures/ui/GuiImagePlaceholder.png"
	end
end

function Asset.audio(url, audioName)
	if works then
		if not isfile(audioName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(audioName, Response.Body)
			end
		end

		return getsynasset(audioName) or "rbxasset://sounds/uuhhh.mp3"
	end
end


function Asset.write(url, assetName)
	if works then
		if not isfile(assetName) then
			print("attempt to download", assetName)
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(assetName, Response.Body)
				print("successful:", assetName, "-", getsynasset(assetName))
			end
		else
			warn(assetName, "already exists!")
		end
	end
end

function Asset.del(assetName)
	if works then
		if isfile(assetName) then
			delfile(assetName)
		else
			warn(assetName, "is not a valid member of workspace!")
		end
	end
end

function Asset.get(asset)
	if works then
		if isfile(asset) then
			return getsynasset(asset)
		else
			warn(asset, "is not a valid member of workspace!")
			return
		end
	end
end
