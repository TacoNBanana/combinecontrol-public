ITEM = class.Create("base_equipment")
DEFINE_BASECLASS("base_equipment")

ITEM.Name 			= "base_weapon"
ITEM.UseCondition 	= true

ITEM.Blacklist 		= table.AddToCopy(BaseClass.Blacklist, {WeaponEnt = true})

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= ""
ITEM.WeaponEnt 		= nil

function ITEM:OnWorn(ply)
	if SERVER then
		self:Give(ply)
	end
end

function ITEM:OnUnworn(ply)
	if SERVER then
		self:Take(ply)
	end
end

if SERVER then
	function ITEM:Give(ply)
		self.WeaponEnt = ply:Give(self:GetProperty("Weapon"))
		self.WeaponEnt.Item = self
	end

	function ITEM:Take(ply)
		self.WeaponEnt = nil

		ply:StripWeapon(self:GetProperty("Weapon"))
	end

	function ITEM:OnPlayerSpawn(ply)
		if self:IsWorn() then
			self:Give(ply)
		end
	end

	function ITEM:OnPlayerDeath(ply)
		if self:IsWorn() and not ply:GetCharFlagAttribute("NoWeaponDrop") then
			if math.random(1, 3) == 1 then
				self:TakeDamage()
			end

			self:OnDrop(ply)
		end
	end
end