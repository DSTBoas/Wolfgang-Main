local Warning = GetModConfigData("WARNING")
local WolfgangStartMighty = TUNING.WOLFGANG_START_MIGHTY_THRESH
local WolfgangEndMighty = TUNING.WOLFGANG_END_MIGHTY_THRESH
local WolfgangStartWimpy = TUNING.WOLFGANG_START_WIMPY_THRESH
local WolfgangEndWimpy = TUNING.WOLFGANG_END_WIMPY_THRESH
local Deform = {[2] = WolfgangStartWimpy,[3] = WolfgangEndMighty}
local Talker = {"WIMPY","NORMAL"}
local Player, CurrentForm

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

local function OnHungerDelta(inst, data)
    local hunger = Player.replica.hunger:GetCurrent()
    CurrentForm = GetFormFromHunger(hunger, CurrentForm)
    if CurrentForm ~= 1 and (hunger - Warning) <= Deform[CurrentForm] then
        Player.components.talker:Say(string.format("Wolfgang becomes %s in %d hunger.", Talker[CurrentForm - 1], (hunger - Deform[CurrentForm])))
    end
end

local function ModInit(inst)
    if inst.name == "Wolfgang" then
        inst:DoTaskInTime(0, function()
        	if inst == GLOBAL.ThePlayer then
	            Player = inst
	            Player:ListenForEvent("hungerdelta", OnHungerDelta)
	        end
        end)
    end
end
AddPlayerPostInit(ModInit)