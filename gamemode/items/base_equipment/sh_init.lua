ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 			= "base_equipment"

ITEM.Generic 		= false

ITEM.UseCondition 	= true

ITEM.Blacklist 		= table.AddToCopy(BaseClass.Blacklist, {Slots = true})

ITEM.EquipDelay 	= 0.5
ITEM.EquipName 		= "Equipping..."

ITEM.UnequipDelay 	= 0.5
ITEM.UnequipName 	= "Unequipping..."

ITEM.Slots 			= {EQUIPMENT_MISC}
ITEM.Equipped 		= false

AddCSLuaFile("sh_events.lua")
include("sh_events.lua")

AddCSLuaFile("sh_get.lua")
include("sh_get.lua")

AddCSLuaFile("sh_permissions.lua")
include("sh_permissions.lua")

function ITEM:UnsetItemLocation(unloading)
	if SERVER then
		local slot = self:IsWorn()
		local ply = self.Player

		if slot and IsValid(ply) then
			self:Unwear(ply, unloading)
		end
	end

	BaseClass.UnsetItemLocation(self, unloading)
end

function ITEM:IsWorn()
	return self:GetProperty("Equipped")
end

if SERVER then
	function ITEM:Wear(ply, slot, loaded)
		local item = ply:GetEquipment(slot)

		if item then
			item:Unwear(ply)
		end

		ply.Equipment[slot] = self

		if not loaded then
			self:SetProperty("Equipped", slot)
		end

		self:OnWorn(ply)
	end

	function ITEM:Unwear(ply, unloaded)
		local slot = self:IsWorn()

		if not slot then
			return
		end

		ply.Equipment[slot] = nil

		if not unloaded then
			self:SetProperty("Equipped", nil)
		end

		self:OnUnworn(ply)
	end
end

if CLIENT then
	function ITEM:GetUIHighlight()
		local val = BaseClass.GetUIHighlight(self)

		if val then
			return val
		end

		if self:IsWorn() then
			return Color(100, 160, 210, 25)
		end
	end
end
