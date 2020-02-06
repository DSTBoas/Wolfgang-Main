local DST = GLOBAL.TheSim:GetGameID() == "DST"
if not DST then return end
if DST and GLOBAL.TheNet:IsDedicated() then return end

local Warning = GetModConfigData("WARNING")
local Deform = {[2] = 100,[3] = 220}
local Talker = {"WIMPY","NORMAL","MIGHTY"}
local CurrentForm

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
	CurrentForm = GetFormFromHunger(hunger, CurrentForm)
	if CurrentForm == 1 then return end
	if (hunger - Warning) <= Deform[CurrentForm] then
		GLOBAL.ThePlayer.components.talker:Say(string.format("Wolfgang becomes %s in %d hunger.", Talker[CurrentForm-1], (hunger - Deform[CurrentForm])))
	end
end

local function ModSetup(inst)
	if inst.prefab == "wolfgang" then
		inst:DoTaskInTime(0, function()
			inst:ListenForEvent("hungerdelta", OnHungerDelta)
		end)
	end
end
AddPlayerPostInit(ModSetup)
