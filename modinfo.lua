name = "Wolfgang Main"
author = "Boas"
version = "1.5"

forumthread = ""
description = "Wolfgang warns you when you are about to change form"

api_version = 10

icon_atlas = "modicon.xml"
icon = "modicon.tex"

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true

all_clients_require_mod = false
client_only_mod = true
server_filter_tags = {}

local warning = {}
local bool = {
	{description = "Enabled", data = true},
	{description = "Disabled", data = false}
}

for i = 0, 11 do
	local hunger = 3 + i * 2
	hunger = (hunger + 1) % 10 == 0 and hunger + 1 or hunger 
	if (hunger - 1) % 10 ~= 0 then 
		warning[#warning + 1] = {
			description = hunger.."", 
			data = hunger,
			hover = "Warning starts at "..(100 + hunger).." and "..(220 + hunger).." hunger"
		}
	end
end

local function AddConfig(label, name, options, default, hover)
	return {label = label, name = name, options = options, default = default, hover = hover or ""}
end

configuration_options = 
{
	AddConfig("Amount of hunger", "WARNING", warning, 5, "Amount of hunger"),
	AddConfig("Color", "COLORED", bool, true, "Adds color to the warning messages"),
}
