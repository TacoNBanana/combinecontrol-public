ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 				= "Customisable item"

ITEM.Generic 			= false
ITEM.Description 		= "Change me!"

ITEM.Locked 			= false

ITEM.EditableProperties	= {
	"Name",
	"Description",

	"Model",
	"Skin",
	"Scale",

	"Bodygroups",
	"Materials",
	"Color",

	"IconFOV",
	"CamOffset",
	"AngOffset",

	"Weight",
	"CarryAdd"
}

ITEM.Blacklist 			= table.AddToCopy(BaseClass.Blacklist, ITEM.EditableFields)

AddCSLuaFile("cl_ui.lua")

if CLIENT then
	include("cl_ui.lua")
end

AddCSLuaFile("sh_get.lua")
include("sh_get.lua")

AddCSLuaFile("sh_permissions.lua")
include("sh_permissions.lua")

if SERVER then
	include("sv_networking.lua")
end

function ITEM:__tostring()
	return string.format("Item [%s][%s (%s)]", self.ID, self:GetClass(), self:GetProperty("Name"))
end