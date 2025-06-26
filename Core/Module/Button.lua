local genv = (getgenv and getgenv()) or shared

genv.Module = genv.Module or {}
local Module = genv.Module

Module.Button = Module.Button or {}
local Button = genv.Button

local Values = genv.Values

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local JB = Values.Gui.JumpButton
local Reference = JB.Reference

local function createTextBtn()
	
end

local function createImgBtn()
	local b = Instance.new("ImageButton", Reference)
		b.Image = ""
		b.PressedImage = ""
end



function Button.new(toggleable, active, imgBtn)
	local button
	if imgBtn then
		button = createImgBtn()
	else
		button = createTextButton()
	end

	
end
