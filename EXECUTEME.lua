local genv = (getgenv and getgenv()) or shared
genv.Settings = {
	[""] = true
}

loadstring(game:HttpGet("https://github.com/relojac/TimelessRPUtils/raw/refs/heads/main/Core/Main.lua"))()
