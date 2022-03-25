AddCSLuaFile()

function SWEP:UpdateFiremode(firemode)
	self.Primary.Automatic = firemode == -1

	self:SetFiremode(firemode)
	self:SetBurstAmount(0)
end

function SWEP:CycleFiremode()
	if self:GetSwitchedModes() or not istable(self.Firemodes) then
		return
	end

	if self:GetAltMode() then
		return
	end

	self:SetSwitchedModes(true)

	local index = table.KeyFromValue(self.Firemodes, self:GetFiremode()) + 1

	if index > #self.Firemodes then
		index = 1
	end

	self:UpdateFiremode(self.Firemodes[index])
	self:HandleAutomatic()

	if CLIENT then
		self:EmitSound("weapons/smg1/switch_single.wav", 75, 100, 1, CHAN_ITEM)
	end
end
