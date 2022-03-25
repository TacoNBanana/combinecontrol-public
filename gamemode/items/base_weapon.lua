ITEM = class.Create("base_equipment")
DEFINE_BASECLASS("base_equipment")

ITEM.Name 			= "base_weapon"
ITEM.UseCondition 	= true

ITEM.AllowBroken 	= true
ITEM.LootCondition 	= {5, 25}

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

function ITEM:GetCondition(force)
	if force or not IsValid(self.Player) then
		return BaseClass.GetCondition(self)
	end

	local weapon = NULL

	for _, v in pairs(self.Player:GetWeapons()) do
		if v.TRP and v:GetItem() == self then
			weapon = v
			break
		end
	end

	if IsValid(weapon) and weapon.GetCondition then
		return weapon:GetCondition()
	end

	return BaseClass.GetCondition(self)
end

if SERVER then
	function ITEM:Give(ply)
		self.WeaponEnt = ply:Give(self:GetProperty("Weapon"))

		if self.WeaponEnt.LoadFromItem then
			self.WeaponEnt:LoadFromItem(self)
		else
			self.WeaponEnt.Item = self
		end
	end

	function ITEM:Take(ply)
		if not IsValid(self.WeaponEnt) then
			self.WeaponEnt = nil

			return
		end

		if self.WeaponEnt.SaveItem then
			self.WeaponEnt:SaveItem()
		end

		self.WeaponEnt = nil

		ply:StripWeapon(self:GetProperty("Weapon"))
	end

	function ITEM:OnPlayerSpawn(ply)
		if self:IsWorn() then
			self:Give(ply)
		end
	end

	function ITEM:OnPlayerDeath(ply)
		if IsValid(self.WeaponEnt) and self.WeaponEnt.SaveItem then
			self.WeaponEnt:SaveItem()
		end
	end

	function ITEM:OnRepaired(condition)
		if IsValid(self.WeaponEnt) and self.WeaponEnt.SetCondition then
			self.WeaponEnt:SetCondition(condition)
		end
	end

	function ITEM:OnCustomSetup(condition)
		condition = tonumber(condition)

		if condition then
			self:SetCondition(math.Clamp(condition, 0, 100))
		end
	end

	function ITEM:OnBreak()
	end
end
