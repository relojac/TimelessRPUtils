local TestService = game:GetService("TestService")

local TS = {}

function TS.info(text)
	TestService:Message(text)
end
