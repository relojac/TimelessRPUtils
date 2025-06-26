local genv = (getgenv and getgenv()) or shared

genv.Module = genv.Module or {}
local Module = genv.Module

local getsynasset = getsynasset or getcustomasset or function() end 
local request = syn and syn.request or http and http.request or request or function() end
local isfile = isfile or readfile and function(filename) local succ,a = pcall(function() local b = readfile(filename) end) return succ end or function() end

function Module.loadVideo(url, videoName)
	if videoName 
	if getsynasset and request and writefile and isfile then
		if not isfile(videoName) then
			local Response, TempFile = request({Url = url, Method = 'GET'})
			if Response.StatusCode == 200 then
				writefile(videoName, Response.Body)
			end
		end
	end
end
