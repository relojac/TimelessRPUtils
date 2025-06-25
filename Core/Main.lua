local genv = (getgenv and getgenv()) or shared
local Settings = genv.Settings

genv.Values = {
	["Gui"] = {
		["JumpButton"] = {
			["Position"] = UDim2.new(0, 0, 0, 0),
			["Size"] = UDim2.new(0, 0, 0, 0)
		}
	}
}
local Values = genv.Values

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local TouchGui = PlayerGui:WaitForChild("TouchGui")
local TouchControlFrame = TouchGui:WaitForChild("TouchControlFrame")
local JumpButton = TouchControlFrame:WaitForChild("JumpButton")

local function updateGui()
	Values.Gui.JumpButton.Position = JumpButton.Position
	Values.Gui.JumpButton.Size = JumpButton.Size
end

RunService.RenderStepped:Connect(updateGui)

--
