local getsynasset = getsynasset or getcustomasset or function() end 
local request = syn and syn.request or http and http.request or request or function() end
local isfile = isfile or readfile and function(filename) local succ,a = pcall(function() local b = readfile(filename) end) return succ end or function() end

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Gui = Instance.new("ScreenGui", PlayerGui); do
	Gui.IgnoreGuiInset = true
	Gui.ResetOnSpawn = false
end

local Video = Instance.new("VideoFrame"); do
	Video.Size = UDim2.new(1, 0, 1, 0)
	Video.Looped = true
	Video.Parent = Gui
end

if getsynasset and request and writefile and isfile then
	if not isfile("ASMR.webm") then
		local Response, TempFile = request({Url = "https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Assets/ASMR.webm", Method = 'GET'})
		if Response.StatusCode == 200 then
			writefile("ASMR.webm", Response.Body)
		end
	end
	Video.Video = getsynasset("ASMR.webm")
	Video:Play()
else
	Video.Visible = false
end
