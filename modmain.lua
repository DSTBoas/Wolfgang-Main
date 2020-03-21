local GLOBAL = GLOBAL

local function Init(inst)
	inst:DoTaskInTime(0, function()
		if inst == GLOBAL.ThePlayer then  
			local WARNING = GetModConfigData("WARNING")
			local COLORED = GetModConfigData("COLORED")
			local WolfgangStartMighty 	= TUNING.WOLFGANG_START_MIGHTY_THRESH
			local WolfgangEndMighty 	= TUNING.WOLFGANG_END_MIGHTY_THRESH
			local WolfgangStartWimpy 	= TUNING.WOLFGANG_START_WIMPY_THRESH
			local WolfgangEndWimpy 		= TUNING.WOLFGANG_END_WIMPY_THRESH
			local Deform = {[2] = WolfgangStartWimpy, [3] = WolfgangEndMighty}
			local Talker = {[2] = "WIMPY", [3] = "NORMAL"}
			local Color, Colorstep, CurrentForm = {1, 1, 1, 1}, 1 / WARNING

			local function GetFormFromHunger(hunger, lastform)
				local mighty = lastform == 3 and WolfgangEndMighty or WolfgangStartMighty
				local wimpy = lastform == 1 and WolfgangEndWimpy or WolfgangStartWimpy
				if hunger > mighty then
					return 3
				elseif hunger <= wimpy then
					return 1
				else
					return 2
				end
			end

			local function OnHungerDelta(inst)
				local hunger = inst.player_classified.currenthunger:value()
				CurrentForm = GetFormFromHunger(hunger, CurrentForm)
				if CurrentForm ~= 1 and (hunger - WARNING) <= Deform[CurrentForm] then
					local hungerRemaining = hunger - Deform[CurrentForm]
					Color = COLORED and {1, Colorstep * (hungerRemaining - 1), 0, 1} or Color
					inst.components.talker:Say(string.format("Wolfgang becomes %s in %d hunger.", Talker[CurrentForm], hungerRemaining), 0, 0, false, false, Color)
				end
			end

			inst:ListenForEvent("hungerdelta", OnHungerDelta)
		end
	end)
end

AddPrefabPostInit("wolfgang", Init)
