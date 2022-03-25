FIREMODE = class.Create()

FIREMODE.Name 			= "Semi"

FIREMODE.Automatic 		= false

FIREMODE.ClipSize 		= false

FIREMODE.AmmoCaliber 	= false

function FIREMODE:SwitchTo(weapon)
	weapon.Primary.ClipSize = self.ClipSize or weapon.ClipSize
	weapon.Primary.Automatic = self.Automatic

	local saved = weapon.SavedAmmo[self.AmmoCaliber]

	if saved then
		weapon:SetClip1(saved.Clip)
		weapon:SetAmmoType(saved.Bullet)

		weapon.SavedAmmo[self.AmmoCaliber] = nil
	else
		weapon:SetClip1(0)
		weapon:SetAmmoType("")
	end
end

function FIREMODE:SwitchFrom(weapon)
	weapon.SavedAmmo[self.AmmoCaliber] = {Clip = weapon:Clip1(), Bullet = weapon:GetAmmoType()}
end

function FIREMODE:CanReload(weapon)
	if weapon:ShouldLower() then
		return false
	end

	if weapon:IsReloading() then
		return false
	end

	if weapon:GetNextPrimaryFire() > CurTime() then
		return false
	end

	if weapon:Clip1() >= weapon.Primary.ClipSize then
		return false
	end

	local item = weapon:GetAmmoItem()

	return item and weapon.Owner:HasItem(item)
end

function FIREMODE:Reload(weapon)
	weapon.Owner:SetAnimation(PLAYER_RELOAD)

	if weapon.UseReloadAnimation then
		weapon:SendWeaponAnim(ACT_VM_RELOAD)
	end

	local duration = weapon:PlayAnimation("reload")

	weapon:SetFinishReload(CurTime() + duration)
	weapon:SetNextPrimaryFire(CurTime() + duration)
end

function FIREMODE:CanFire(weapon)
	if weapon:ShouldLower() then
		return false
	end

	if weapon:IsReloading() then
		return false
	end

	if weapon.Primary.ClipSize > 0 and weapon:Clip1() <= 0 then
		return false
	end

	return true
end

function FIREMODE:Fire(weapon)
	local ply = weapon.Owner
	local delay = weapon.FireDelay

	ply:SetAnimation(PLAYER_ATTACK1)
	weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	if weapon.FireDelay == -1 then
		delay = weapon:PlayAnimation("fire")
	elseif weapon:DoFireAnimation() then
		weapon:PlayAnimation("fire")
	else
		weapon:PlayAnimation("fire", 1, 1)
	end

	if weapon.PumpAction then
		weapon:EmitSound("Weapon_Shotgun.Special1")
	end

	if not weapon:GetIsFiring() then
		weapon:SetIsFiring(true)
		weapon:StartFiring()
	end

	local bullet = GAMEMODE:GetBullet(weapon:GetAmmoType())
	local cone = weapon.CurrentCone

	math.randomseed(ply:GetCurrentCommand():CommandNumber())

	bullet:OnFired(weapon.Owner, weapon, Angle(math.Rand(-cone, cone), math.Rand(-cone, cone), 0))

	weapon:TakePrimaryAmmo(1)

	weapon:SetNextPrimaryFire(CurTime() + delay)
end

function FIREMODE:Think(weapon)
	local ply = weapon.Owner

	if weapon:GetIsFiring() and (weapon:ShouldLower() or not ply:KeyDown(IN_ATTACK) or (weapon:Clip1() <= 0 and weapon.Primary.ClipSize != -1)) then
		weapon:SetIsFiring(false)
		weapon:StopFiring()
	end

	if weapon:IsReloading() and weapon:GetFinishReload() <= CurTime() then
		weapon:SetFinishReload(0)

		local itemclass = weapon:GetAmmoItem()
		local amt = weapon.Primary.ClipSize - weapon:Clip1()

		if weapon.ShotgunReload then
			amt = weapon.ReloadAmount
		end

		local abort = false

		if itemclass then
			local item = ply:GetFirstItem(itemclass)

			if not item then
				abort = true
			else
				if class.IsTypeOf(item, "base_stacking") then
					amt = math.Min(item:GetAmount(), amt)

					if SERVER then
						item:TakeAmount(amt)
					end
				elseif SERVER then
					GAMEMODE:DeleteItem(item)
				end
			end
		end

		if not abort then
			weapon:SetClip1(weapon:Clip1() + amt)

			if SERVER then
				if weapon.ShotgunReload then
					weapon.NextAmmoSave = CurTime() + 10
				else
					weapon:SaveAmmo()
				end
			end
		end

		if weapon.ShotgunReload then
			if weapon:Clip1() >= weapon.Primary.ClipSize or weapon:GetAbortReload() or abort then
				weapon:SetAbortReload(false)

				if weapon.UseReloadAnimation then
					weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
				end

				local duration = weapon:PlayAnimation("reloadfinish")

				weapon:SetNextPrimaryFire(CurTime() + duration)
			else
				if weapon.UseReloadAnimation then
					weapon:SendWeaponAnim(ACT_VM_RELOAD)
				end

				local duration = weapon:PlayAnimation("reloadinsert")

				weapon:SetFinishReload(CurTime() + duration)
			end
		end
	end
end

function FIREMODE:UseCrosshair(weapon)
	if weapon:ShouldLower() then
		return false
	end

	if weapon:IsReloading() then
		return false
	end

	if weapon:AimingDownSights() then
		return false
	end

	if weapon.Owner:TargetHUD() then
		return false
	end

	if weapon:GetAmmoType() == "" then
		return false
	end

	return true
end