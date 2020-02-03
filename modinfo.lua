name = "Wolfgang util"
author = "Boas"
version = "22.0"

forumthread = ""
description = "Wolfgang warns you when you're about to change form."

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
    { description = "5", data = 5 },
    { description = "10", data = 10 },
    { description = "15", data = 15 },
    { description = "20", data = 20 },
    { description = "25", data = 25 },
}

local function AddConfig(label, name, options, default, hover)
    return { label = label, name = name, options = options, default = default, hover = hover or "" }
end

configuration_options = 
{
	AddConfig("Warning Time", "warning", warning, 5, "The amount of hunger before the warning starts"),
}