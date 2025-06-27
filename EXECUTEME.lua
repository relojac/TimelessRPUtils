local genv = (getgenv and getgenv()) or shared
genv.Settings = {
	["ButtonSpacing"] = 0.1,
	["AlwaysRedownloadAssets"] = false,
	
	["Buttons"] = {
		["Drop"] = { -- Lets you drop an item if it is droppable.
			["Enabled"] = true,
			["Position"] = { -3, 1 },

			["DroppableRequired"] = true
		},
		
		["Faint"] = { -- Disables your own Humanoid physics when on.
			["Enabled"] = true,
			["Position"] = { -2, 0 }
		},
		
		["NightVision"] = { -- Lets you see in the dark and highlights Player Characters.
			["Enabled"] = true,
			["Position"] = { 0, 2 }
		}, 
		
		["Reset"] = { -- Kills your character on press.
			["Enabled"] = true,
			["Position"] = { -2, 1 }
		},
		
		["Sit"] = { -- Makes your Character sit.
			["Enabled"] = true,
			["Position"] = { -1, 0 }
		},
		
		["Sprint"] = { -- Multiplies your FOV and WalkSpeed.
			["Enabled"] = true,
			["Position"] = { -1, 1 },

			["Toggled"] = false,
			["IsTweened"] = true, 

			["Multipliers"] = {
				["WalkSpeed"] = 1.5,
				["FieldOfView"] = 1.15
			}
		},
	},

	["Effects"] = {
		["NightVision"] = {
			["ColorCorrection"] = true,
			["PlayerHighlights"] = true,
			["Vignette"] = true
		}
	},

	["Addons"] = {
		["Psychopathic"] = false
	}
}

loadstring(game:HttpGet("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Core/Main.lua"))()
