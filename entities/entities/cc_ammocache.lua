AddCSLuaFile()
DEFINE_BASECLASS("cc_worldent")

ENT.Base 			= "cc_worldent"

ENT.PrintName 		= "Ammo box"
ENT.Category		= "CombineControl - World"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Whitelist 		= {
	ammo_lmg = true,
	ammo_pistol = true,
	ammo_rifle = true,
	ammo_shotgun = true,
	ammo_sniper = true
}

function ENT:Initialize()
	self:SetModel(Model("models/props_survival/crates/crate_ammobox.mdl"))

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)
	end
end

if SERVER then
	function ENT:Use(ply)
		if GAMEMODE:AprilFools() and math.Rand(0, 1) > 0.8 then
			self:EmitSound("vo/npc/male01/uhoh.wav")

			timer.Simple(1, function()
				if not self:IsValid() then return end

				local pos = self:LocalToWorld(Vector(0, 0, 15))

				self:EmitSound("vo/npc/male01/watchout.wav")
				for i = 0, math.random(2, 5) do

					timer.Simple(i * 0.3, function()

						local ent = ents.Create("npc_grenade_frag")
						ent:SetPos(pos)
						ent:SetAngles(AngleRand())
						ent:Spawn()
						ent:Activate()
						ent:Fire("SetTimer", 2.5)
						ent.NoDamage = true

						local phys = ent:GetPhysicsObject()

						local vec = Vector(math.Rand(-1, 1), math.Rand(-1, 1), 2)

						if IsValid(phys) then
							phys:SetVelocity(vec * 100)
						end
						self:EmitSound(Sound("Buttons.snd4"))
					end)
				end
			end)

			return
		end

		local wep = ply:GetActiveWeapon()

		if not IsValid(wep) or (not wep.Tekka and not wep.TRP) then
			ply:SendChat(nil, "ERROR", "You can't find anything useful in here.")

			return
		end

		local ammo

		if wep.AmmoType then
			ammo = wep.AmmoType
		elseif wep.GetFiremode then
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
