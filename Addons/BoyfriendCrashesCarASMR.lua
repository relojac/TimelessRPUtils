local getsynasset = getsynasset or getcustomasset or function() end 
local request = syn and syn.request or http and http.request or request or function() end
local isfile = isfile or readfile and function(filename) local succ,a = pcall(function() local b = readfile(filename) end) return succ end or function() end

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Gui = Instance.new("ScreenGui", PlayerGui); do
	Gui.IgnoreGuiInset = false
	Gui.ResetOnSpawn = false
end

local Video = Instance.new("VideoFrame"); do
	Video.Size = UDim2.new(1, 0, 1, 0)
	Video.Looped = true
	Video.Parent = Gui
end

if getsynasset and request and writefile and isfile then
	if not isfile("ASMR.mp4") then
		local Response, TempFile = request({Url = "https://cdn.discordapp.com/attachments/971520525736218766/1008731543298117692/cat.webm",Method = 'GET'})
		if Response.StatusCode == 200 then
			writefile("ASMR.mp4",Response.Body)
		end
	end
	Video.Video = getsynasset("ASMR.mp4")
	Video:Play()
else
	Video.Visible = false
end
