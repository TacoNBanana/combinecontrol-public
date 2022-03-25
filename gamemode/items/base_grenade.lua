ITEM = class.Create("base_stacking")
DEFINE_BASECLASS("base_stacking")

ITEM.Name 		= "base_grenade"

ITEM.Blacklist 	= table.AddToCopy(BaseClass.Blacklist, {Weapon = true, WeaponEnt = true})

ITEM.Weapon 	= ""
ITEM.WeaponEnt 	= nil

function ITEM:OnPickup(ply, loaded)
	BaseClass.OnPickup(self, ply, loaded)

	if SERVER then
		self:Give(ply)
	end
end

function ITEM:OnRemove(ply)
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
		self:Give(ply)
	end
end