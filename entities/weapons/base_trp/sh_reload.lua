AddCSLuaFile()

function SWEP:GetAmmoType()
	return self:GetAltMode() and self:GetAltWeapon().AmmoType or self.AmmoType
end

function SWEP:UseAmmo()
	local ply = self:GetOwner()

	if not IsValid(ply) or not self:GetItem() then -- Spawned/loadout = infinite ammo
		return false
	end

	if ply:HasInfiniteAmmo(self:GetAmmoType()) then
		return false
	end

	return tobool(self:GetAmmoType())
end

function SWEP:HasReserveAmmo()
	if not self:UseAmmo() then
		return true
	end

	local ammo = self:GetAmmoType()

	if not ammo then
		return false
	end

	if not self:GetOwner():HasItem(ammo) then
		return false
	end

	return true
end

function SWEP:CanReload()
	if self:IsLowered() then
		return false
	end

	if self:IsBusy() then
		return false
	end

	if self:Clip1() >= self:GetMaxAmmo() then
		return false
	end

	if not self:HasReserveAmmo() then
		return false
	end

	return true
end

function SWEP:StartReload()
	local ply = self:GetOwner()

	ply:SetAnimation(PLAYER_RELOAD)

	local duration

	if self.ShotgunReload then
		duration = self:DoWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		self:SetFirstReload(true)
	else
		duration = self:DoWeaponAnim(ACT_VM_RELOAD)
	end

	local speed = 1
	local reloadTime = self:GetReloadTime()

	if reloadTime != 0 then
		speed = duration / reloadTime
		duration = reloadTime
	end

	ply:GetViewModel():SetPlaybackRate(speed) -- Automatically resets itself on the next animation... neat

	self:SetFinishReload(CurTime() + duration)
	self:SetNextIdle(CurTime() + duration)
end

function SWEP:FinishReload()
	self:SetMalfunction(false)
	self:SetFinishReload(0)

	local amt = self:GetMaxAmmo() - self:Clip1()

	if self.ShotgunReload then
		amt = 1
	end

	local abort = false
	local last = false

	if self:UseAmmo() and not self:GetFirstReload() then
		local item = self:GetOwner():GetFirstItem(self:GetAmmoType())

		if not item then
			abort = true
		else
			if class.IsTypeOf(item, "base_stacking") then
				amt = math.Min(item:GetAmount(), amt)

				if item:GetAmount() == 1 and self.ShotgunReload then
					last = true
				end

				if SERVER then
					item:TakeAmount(amt)
				end
			elseif SERVER then
				GAMEMODE:DeleteItem(item)
			end
		end
	end

	if not self:GetFirstReload() and not abort then
		self:SetClip1(self:Clip1() + amt)
	end

	self:SetFirstReload(false)

	if self.ShotgunReload then
		if self:Clip1() >= self:GetMaxAmmo() or self:GetAbortReload() or last then
			self:SetAbortReload(false)

			local duration = self:DoWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

			self:SetNextIdle(CurTime() + duration)
			self:SetNextPrimaryFire(CurTime() + duration)
		else
			local duration = self:DoWeaponAnim(ACT_VM_RELOAD)

			self:SetNextIdle(CurTime() + duration)
			self:SetFinishReload(CurTime() + duration)
			self:SetNextPrimaryFire(CurTime() + duration)
		end
	end
end
