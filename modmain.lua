local WARNING = GetModConfigData("WARNING")
local COLORED = GetModConfigData("COLORED")
local WolfgangStartMighty = TUNING.WOLFGANG_START_MIGHTY_THRESH
local WolfgangEndMighty = TUNING.WOLFGANG_END_MIGHTY_THRESH
local WolfgangStartWimpy = TUNING.WOLFGANG_START_WIMPY_THRESH
local WolfgangEndWimpy = TUNING.WOLFGANG_END_WIMPY_THRESH
local Deform = {[2] = WolfgangStartWimpy,[3] = WolfgangEndMighty}
local Talker = {"WIMPY","NORMAL"}
local GLOBAL, Cache, Player, CurrentForm = GLOBAL, {}

local function GetCached(value)
    if not Cache[value] then
        Cache[value] = (value / WARNING) - 1 / WARNING
    end
    return Cache[value]
end

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
    if CurrentForm ~= 1 and (hunger - WARNING) <= Deform[CurrentForm] then
        local color = {1, 1, 1, 1}
        if COLORED then
            color = {1, GetCached(hunger - Deform[CurrentForm]), 0, 1}
        end
        Player.components.talker:Say(string.format("Wolfgang becomes %s in %d hunger.", Talker[CurrentForm - 1], (hunger - Deform[CurrentForm])), 0, 0, false, false, color)
    end
end

local function ModInit(inst)
    inst:DoTaskInTime(0, function()
    	if inst == GLOBAL.ThePlayer and inst.prefab == "wolfgang" then
            Player = inst
            Player:ListenForEvent("hungerdelta", OnHungerDelta)
        end
    end)
end
AddPlayerPostInit(ModInit)