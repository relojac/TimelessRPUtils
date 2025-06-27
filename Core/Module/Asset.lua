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

local works = getsynasset and request and writefile and isfile and delfile and makefolder and isfolder and delfolder

if works then
	if not isfolder("Timeless") then
		makefolder("Timeless")
	end
end
	
function Asset.video(url, path)
	if works then
		if not isfile(path) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(path, Response.Body)
			end
		end

		return getsynasset(path) or ""
	end
end

function Asset.image(url, path)
	if works then
		if not isfile(path) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(path, Response.Body)
			end
		end

		return getsynasset(path) or "rbxasset://textures/ui/GuiImagePlaceholder.png"
	end
end

function Asset.audio(url, path)
	if works then
		if not isfile(path) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(path, Response.Body)
			end
		end

		return getsynasset(path) or "rbxasset://sounds/uuhhh.mp3"
	end
end


function Asset.fromURL(url, path)
	if works then
		if not isfile(path) then
			print("attempt to download", path)
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(path, Response.Body)
				print("successful:", path, "-", getsynasset(path))
			end
		else
			warn(path, "already exists!")
		end
	end
end

function Asset.del(path)
	if works then
		if isfile(path) then
			delfile(path)
		else
			warn(path, "is not a valid member of workspace!")
		end
	end
end

function Asset.get(path)
	if works then
		if isfile(path) then
			return getsynasset(path)
		else
			warn(path, "is not a valid member of workspace!")
			return
		end
	end
end
