AddCSLuaFile()

function SWEP:GetItem()
	local id = self:GetItemID()

	if id == 0 then
		return
	end

	return GAMEMODE:GetItem(id)
end

if SERVER then
	function SWEP:SaveItem()
		local item = self:GetItem()

		if not item then
			return
		end

		local clip
		local alt

		if self:GetAltMode() then
			clip = self:GetAltAmmo()
			alt = self:Clip1()
		else
			clip = self:Clip1()
			alt = self:GetAltAmmo()
		end

		if self.AmmoType then
			item:SetProperty("Ammo", clip)
		end

		local altWeapon = self:GetAltWeapon()

		if altWeapon and altWeapon.AmmoType then
			item:SetProperty("AltAmmo", alt)
		end

		item:SetCondition(self:GetCondition())

		if istable(self.Firemodes) then
			item:SetProperty("Firemode", self:GetFiremode())
		end
	end

	function SWEP:LoadFromItem(item)
		self:SetItemID(item.ID)

		if self.AmmoType and self.ClipSize > 0 then
			self:SetClip1(item:GetProperty("Ammo") or 0)
		end

		local alt = self:GetAltWeapon()

		if alt and alt.AmmoType then
			self:SetAltAmmo(item:GetProperty("AltAmmo") or 0)
		end

		self:SetCondition(item:GetCondition(true))

		local firemode = item:GetProperty("Firemode")

		if firemode and istable(self.Firemodes) then
			firemode = self.Firemodes[table.KeyFromValue(self.Firemodes, firemode) or 1]

			self:UpdateFiremode(firemode)
		end
	end
end
