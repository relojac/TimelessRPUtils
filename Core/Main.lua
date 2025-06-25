local genv = (getgenv and getgenv()) or shared
local Settings = genv.Settings

require(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Modules/Info.lua"))

genv.Values = {
	["Gui"] = {
		["JumpButton"] = {
			["Position"] = UDim2.new(0, 0, 0, 0),
			["Size"] = UDim2.new(0, 0, 0, 0)
		}
	}
}
genv.Functions = {}
local Values = genv.Values

local JBPosition = Values.Gui.JumpButton.Position
local JBSize = Values.Gui.JumpButton.Size

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local TouchGui = PlayerGui:WaitForChild("TouchGui")
local TouchControlFrame = TouchGui:WaitForChild("TouchControlFrame")
local JumpButton = TouchControlFrame:WaitForChild("JumpButton")

local JumpRef = Instance.new("Frame", TouchControlFrame)
	JumpRef.Name = "JumpButtonReference"
	JumpRef.BackgroundTransparency = 1

local function updateGui()
	JBPosition = JumpButton.Position
	JBSize = JumpButton.Size
end

JumpButton:GetPropertyChangedSignal("Position"):Connect(updateGui)
JumpButton:GetPropertyChangedSignal("Size"):Connect(updateGui)

RunService.RenderStepped:Connect(function()
	if JumpRef.Position ~= JBPosition then JumpRef.Position = JBPosition end
	if JumpRef.Size ~= JBSize then JumpRef.Size = JBSize end
end)

--

loadstring(game:HttpGet(""))()
