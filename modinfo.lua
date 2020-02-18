name = "Wolfgang Main"
author = "Boas"
version = "1.0"

forumthread = ""
description = "Wolfgang warns you when you're about to change form"

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

local warning = {
	{description = "3", data = 3},
    {description = "5", data = 5},
    {description = "7", data = 7},
    {description = "10", data = 10},
    {description = "12", data = 12},
    {description = "15", data = 15},
    {description = "20", data = 20},
    {description = "25", data = 25},
}

local bool = {
	{description = "Enabled", data = true},
	{description = "Disabled", data = false},
}

local function AddConfig(label, name, options, default, hover)
    return {label = label, name = name, options = options, default = default, hover = hover or ""}
end

configuration_options = 
{
	AddConfig("Amount of Hunger", "WARNING", warning, 5, "The amount of Hunger before the warning starts"),
	AddConfig("Color", "COLORED", bool, false, "Adds color to the warning messages"),
}