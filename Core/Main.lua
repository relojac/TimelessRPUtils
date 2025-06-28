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

genv.Module = genv.Module or {} -- All scripts in /Core/Module will shove their functions into this. Basically.
local Module = genv.Module

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer -- See that heart, Anon? That's your SOUL! The culmination of your being!
local PlayerGui = Player.PlayerGui -- The stuff on your screen. :P

local TouchGui = PlayerGui:WaitForChild("TouchGui")
local TouchControlFrame = TouchGui:WaitForChild("TouchControlFrame")
local JumpButton = TouchControlFrame:WaitForChild("JumpButton") -- The JumpButton! You'll see how it's used later in this script.

if TouchControlFrame:FindFirstChild("JumpButtonReference") then TouchControlFrame.JumpButtonReference:Destroy() end
local JumpRef = Instance.new("Frame", TouchControlFrame) -- This will make a reference of the JumpButton. This is where all the buttons will show up if you have any.
	JumpRef.Name = "JumpButtonReference"
	JumpRef.BackgroundTransparency = 1
	JumpRef.Position = JumpButton.Position
	JumpRef.Size = JumpButton.Size

local function updateGui()
	JumpRef.Position = JumpButton.Position
	JumpRef.Size = JumpButton.Size
end

JumpButton:GetPropertyChangedSignal("Position"):Connect(updateGui)
JumpButton:GetPropertyChangedSignal("Size"):Connect(updateGui)

--|| MODULES ||--

loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Module/Asset.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Module/Button.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Module/Positioner.lua"))()

--|| ASSETS ||--

loadstring(game:HttpGet("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Core/AssetDownloader.lua"))()

--|| BUTTONS ||--

if Settings.Buttons.Faint.Enabled then loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Buttons/Faint.lua"))() end
if Settings.Buttons.Reset.Enabled then loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Buttons/Reset.lua"))() end
if Settings.Buttons.Sit.Enabled then loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Buttons/Sit.lua"))() end
if Settings.Buttons.Sit.Enabled then loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Core/Buttons/Sprint.lua"))() end

--|| ADDONS ||--

if Settings.Addons.nothingiswatching.Enabled then loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Addons/nothingiswatching.lua"))() end
if Settings.Addons.LimbsFirstPerson then loadstring(game:HttpGet("https://raw.githubusercontent.com/relojac/TimelessRPUtils/refs/heads/main/Addons/LimbsFirstPerson.lua"))() end
