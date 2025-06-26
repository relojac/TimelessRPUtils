local genv = (getgenv and getgenv()) or shared

genv.Module = genv.Module or {}
local Module = genv.Module

Module.Asset = Module.Asset or {}
local Asset = Module.Asset

local getsynasset = getsynasset or getcustomasset or function() end 
local request = syn and syn.request or http and http.request or request or function() end
local isfile = isfile or readfile and function(filename) local succ,a = pcall(function() local b = readfile(filename) end) return succ end or function() end
local writefile = writefile or function() end
	
Asset.video = function(url, videoName)
	if not videoName:match(".webm") then
		videoName = videoName..".webm"
	end
	
	if getsynasset and request and writefile and isfile then
		if not isfile(videoName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(videoName, Response.Body)
			end
		end

		return getsynasset(videoName) or nil
	end
end

Asset.image = function(url, imageName)
	if not imageName:match(".png") then
		imageName = imageName..".png"
	end
	
	if getsynasset and request and writefile and isfile then
		if not isfile(imageName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(imageName, Response.Body)
			end
		end

		return getsynasset(imageName) or "rbxasset://textures/ui/GuiImagePlaceholder.png"
	end
end

Asset.audio = function(url, audioName)
	if getsynasset and request and writefile and isfile then
		if not isfile(audioName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(audioName, Response.Body)
			end
		end

		return getsynasset(audioName) or "rbxasset://sounds/uuhhh.mp3"
	end
end

Asset.write = function(url, assetName)
	if getsynasset and request and writefile and isfile then
		if not isfile(assetName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(audioname, Response.Body)
			end
		end
	end
end
