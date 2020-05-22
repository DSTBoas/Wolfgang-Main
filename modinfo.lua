name = "Wolfgang Main"
description = "Wolfgang warns you when you are about to change form\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tMade with 󰀍"

icon_atlas = "modicon.xml"
icon = "modicon.tex"

author = "Boas"
version = "2.2"
forumthread = ""

dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true

all_clients_require_mod = false
client_only_mod = true

api_version = 10

folder_name = folder_name or "Wolfgang-Main"
if not folder_name:find("workshop-") then
    name = name .. " (dev)"
end

local function AddConfigOption(desc, data, hover)
    return {description = desc, data = data, hover = hover}
end

local function AddConfig(label, name, options, default, hover)
    return {
                label = label,
                name = name,
                options = options,
                default = default,
                hover = hover
           }
end

local function AddSectionTitle(title)
    return AddConfig(title, "", {{description = "", data = 0}}, 0)
end

local SettingOptions =
{
    AddConfigOption("Disabled", false),
    AddConfigOption("Enabled", true, "Warning messages have a color gradient"),
}

local HungerOptions = {}

for i = 0, 11 do
    local hunger = 3 + i * 2
    hunger = (hunger + 1) % 10 == 0 and hunger + 1 or hunger
    if (hunger - 1) % 10 ~= 0 then
        local hover = "Warning starts at " .. (100 + hunger) .. " and " .. (220 + hunger) .. " hunger"
        HungerOptions[#HungerOptions + 1] = AddConfigOption(
                                                hunger.."", 
                                                hunger,
                                                hover
                                            )
    end
end

local SettingMessage = "Set to your liking"

configuration_options =
{
    AddSectionTitle("Settings"),
    AddConfig("Hunger", "WARNING", HungerOptions, 5, SettingMessage),
    AddConfig("Color", "COLORED", SettingOptions, false, SettingMessage)
}
