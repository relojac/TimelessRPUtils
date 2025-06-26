--[[
	Hii, reverse engineer! I'm Ms. Solyn A. Placeholder!! („>ヮ🌟„)! :3

	I started off as a placeholder (duh) in the early stages,
	but Ms. relojac asked if I wanted to stay here or be shoved into the Monochrox universe.
	Of course, I told her to split me into two, and my half would stay here and the other would be reincarnated as a character in Monochrox.
	That's why I'm here! Hehe!

	If you see a comment, that's me!!
	I hope you'll find a way to understand this spaghetti. :3
]]

local genv = (getgenv and getgenv()) or shared -- genv stands for Global Environment! I'm assuming you know what Global Environment means, especially if you're reverse engineering this of all things.
local Settings = genv.Settings -- This was defined in EXECUTEME.lua!

genv.Values = {
	["Gui"] = {
		["JumpButton"] = {
			["Position"] = UDim2.new(0, 0, 0, 0),
			["Size"] = UDim2.new(0, 0, 0, 0),

			["Reference"] = nil
		}
	}
}
genv.Module = {} -- All scripts in /Core/Module will shove their functions into this. Basically.
local Values = genv.Values
local Module = genv.Module

local JB = Values.Gui.JumpButton

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer -- See that heart, Anon? That's your SOUL! The culmination of your being!
local PlayerGui = Player.PlayerGui -- The stuff on your screen. :P

local TouchGui = PlayerGui:WaitForChild("TouchGui")
local TouchControlFrame = TouchGui:WaitForChild("TouchControlFrame")
local JumpButton = TouchControlFrame:WaitForChild("JumpButton") -- The JumpButton! You'll see how it's used later in this script.

local JumpRef = Instance.new("Frame", TouchControlFrame) -- This will make a reference of the JumpButton. This is where all the buttons will show up if you have any.
	JumpRef.Name = "JumpButtonReference"
	JumpRef.BackgroundTransparency = 1
	JB.Reference = JumpRef

local dirty = false -- This becomes true IF a property doesn't match. I-it's not what you think it means, I swear! Stop looking at me like that!

local function updateGui()
	JB.Position = JumpButton.Position
	JB.Size = JumpButton.Size

	dirty = true 
end

JumpButton:GetPropertyChangedSignal("Position"):Connect(updateGui)
JumpButton:GetPropertyChangedSignal("Size"):Connect(updateGui)

RunService.RenderStepped:Connect(function() -- This runs every frame.
	if dirty then 
		JumpRef.Position = JB.Position
		JumpRef.Size = JB.Size

		dirty = false
	end
end)

--|| MODULES ||--

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Module/Asset.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Module/Button.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Module/Positioner.lua"))()

--|| ASSETS ||--

loadstring(game:HttpGet("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Core/AssetLoader.lua"))()

--|| BUTTONS ||--

if Settings.Sit.Enabled then loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Buttons/Sit.lua"))() end

--|| ADDONS ||--
