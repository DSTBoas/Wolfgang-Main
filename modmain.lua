local DST = GLOBAL.TheSim:GetGameID() == "DST"
if not DST then return end
if DST and GLOBAL.TheNet:IsDedicated() then return end
local require = GLOBAL.require

local warning = GetModConfigData("warning")
local currentForm
local util = 
{
    deform = 
    {
        [2] = 100,
        [3] = 220
    },
    strings =
    {
        [1] = "WIMPY",
        [2] = "NORMAL",
        [3] = "MIGHTY" 
    }
}

local function GetFormFromHunger(hunger, lastform)
	local mighty = lastform == 3 and 220 or GLOBAL.TUNING.WOLFGANG_START_MIGHTY_THRESH
	local wimpy = lastform == 1 and 105 or GLOBAL.TUNING.WOLFGANG_START_WIMPY_THRESH
	if hunger > mighty then
		return 3
	elseif hunger <= wimpy then
		return 1
	else
		return 2
	end
end

local function OnHungerDelta(inst, data)
	local hunger = inst.replica.hunger:GetCurrent()
	currentForm = GetFormFromHunger(hunger, currentForm)
    	if currentForm == 1 then return end
    	if (hunger - warning) <= util.deform[currentForm] then
		GLOBAL.ThePlayer.components.talker:Say(string.format("Wolfgang becomes %s in %d hunger.", util.strings[currentForm-1], (hunger - util.deform[currentForm])))
    	end
end

local function Init(inst)
	if inst.prefab ~= "wolfgang" then return end
	inst:DoTaskInTime(0, function()
	   currentForm = GetFormFromHunger(inst.replica.hunger:GetCurrent())
	   inst:ListenForEvent("hungerdelta", OnHungerDelta)
	 end)
end

AddPlayerPostInit(Init)
