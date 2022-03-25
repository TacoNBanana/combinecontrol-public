AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "cc_base_ent"

ENT.Category		= "CombineControl"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.AllowPhys 		= true

ENT.Whitelist 		= {
	ammo_lmg = true,
	ammo_pistol = true,
	ammo_plasma = true,
	ammo_plasma_lmg = true,
	ammo_rifle = true,
	ammo_shotgun = true,
	ammo_sniper = true
}

function ENT:Initialize()
	self:SetModel(Model("models/Items/BoxMRounds.mdl"))

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)
	end
end

if SERVER then
	function ENT:Use(ply)
		local wep = ply:GetActiveWeapon()

		if not IsValid(wep) or not wep.Tekka then
			ply:SendChat(nil, "ERROR", "You can't find anything useful in here.")

			return
		end

		local ammo

		if wep.GetFiremode then
			local item = wep:GetFiremode().GetAmmoItem(wep)

			if item then
				ammo = item
			end
		elseif wep.AmmoItem then
			ammo = wep.AmmoItem
		end

		if not ammo or not self.Whitelist[ammo] then
			ply:SendChat(nil, "ERROR", "You can't find anything useful in here.")

			return
		end

		local amt = 0
		local stack = ply:GetFirstItem(ammo)
		local max = GAMEMODE:GetDefaultItemKey(ammo, "MaxStack")

		if stack then
			amt = max - stack:GetAmount()
		else
			amt = max
		end

		local weight = GAMEMODE:GetDefaultItemKey(ammo, "Weight")

		if weight > 0 then
			local space = ply:InventoryMaxWeight() - ply:InventoryWeight()

			amt = math.min(amt, math.floor(space / weight), 0)
		end

		if amt < 1 then
			ply:SendChat(nil, "ERROR", "You can't find anything useful in here.")

			return
		end

		if stack then
			stack:AddAmount(amt)
		else
			GAMEMODE:DBCreateItem(ammo, ITEM_NONE, nil, function(item)
				item:SetAmount(amt)
				item:SetItemLocation(ITEM_PLAYER, ply:CharID())
			end)
		end

		ply:SendChat(nil, "INFO", "You refill your ammo.")

		self:EmitSound("BaseCombatCharacter.AmmoPickup")
	end
end