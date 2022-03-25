GM.HandsWeapons = {
	"weapon_cc_hands",
}

function GM:PlayerSwitchWeapon(ply, old, new)
	if SERVER and new.Holsterable then

		ply:SetHolstered(true)

	end

	if not new.Holsterable then

		ply:SetHolstered(false)

	end

	if ply:PassedOut() and not table.HasValue(self.HandsWeapons, new:GetClass()) then return true end
	if ply:TiedUp() and not table.HasValue(self.HandsWeapons, new:GetClass()) then return true end
	if ply:MountedGun() and ply:MountedGun():IsValid() and not table.HasValue(self.HandsWeapons, new:GetClass()) then return true end

	for _, v in pairs(ents.GetNPCs()) do

		if not v:IsValid() then return end
		if v:NPCHatesWeapons() == 1 then

			local class = new:GetClass()

			if class ~= "weapon_cc_hands" and class ~= "weapon_physgun" and class ~= "gmod_tool" and class ~= "weapon_physcannon" then

				v:AddEntityRelationship(ply, D_HT, 99)

			else

				if not ply:Visible(v) then

					self:RefreshNPCRelationship(v)

				end

			end

		end

	end

	self.BaseClass:PlayerSwitchWeapon(ply, old, new)
end

function GM:PlayerSwitchFlashlight(ply, enable)
	if not enable then
		return true
	end

	local item = ply:GetEquipment(EQUIPMENT_LIGHT)

	if not ply.NextFlashlight then
		ply.NextFlashlight = CurTime()
	end

	if item and CurTime() >= ply.NextFlashlight then
		ply.NextFlashlight = CurTime() + 0.2

		return item:Toggle(ply)
	end

	return false
end

if SERVER then
	function nToggleHolster(len, ply)
		if ply:PassedOut() then return end
		if ply:TiedUp() then return end
		if ply:MountedGun() and ply:MountedGun():IsValid() then return end

		local weapon = ply:GetActiveWeapon()

		if IsValid(weapon) then
			if weapon.Holsterable then
				ply:SetHolstered(not ply:Holstered())
			else
				ply:SetHolstered(false)
			end

			if weapon.Tekka then
				weapon:ToggleHolster()
			end
		end
	end
	net.Receive("nToggleHolster", nToggleHolster)

	function nSelectWeapon(len, ply)

		local class = net.ReadString()

		if ply:PassedOut() then return end
		if ply:TiedUp() then return end
		if ply:MountedGun() and ply:MountedGun():IsValid() then return end

		ply:SelectWeapon(class)

	end
	net.Receive("nSelectWeapon", nSelectWeapon)

	function nUseWeapon(len, ply)
		local wep = net.ReadEntity()
		local action = net.ReadInt(8)

		if not IsValid(wep) or ply:GetActiveWeapon() ~= wep then
			return
		end

		local actions = wep:GetContextOptions()

		if actions[action] then
			actions[action].Func(wep, ply)
		end
	end
	net.Receive("nUseWeapon", nUseWeapon)
end

function GM:IronsightsMul()
	return FrameTime() / 1.5
end

function GM:GetTraceDecal(tr)
	if tr.MatType == MAT_ALIENFLESH then return "Impact.AlientFlesh" end
	if tr.MatType == MAT_ANTLION then return "Impact.Antlion" end
	if tr.MatType == MAT_CONCRETE then return "Impact.Concrete" end
	if tr.MatType == MAT_METAL then return "Impact.Metal" end
	if tr.MatType == MAT_WOOD then return "Impact.Wood" end
	if tr.MatType == MAT_GLASS then return "Impact.Glass" end
	if tr.MatType == MAT_FLESH then return "Impact.Flesh" end
	if tr.MatType == MAT_BLOODYFLESH then return "Impact.BloodyFlesh" end

	return "Impact.Concrete"
end

function GM:GetImpactSound(tr)
	if tr.MatType == MAT_ALIENFLESH then return "Flesh.BulletImpact" end
	if tr.MatType == MAT_ANTLION then return "Flesh.BulletImpact" end
	if tr.MatType == MAT_CONCRETE then return "Concrete.BulletImpact" end
	if tr.MatType == MAT_METAL then return "SolidMetal.BulletImpact" end
	if tr.MatType == MAT_WOOD then return "Wood.BulletImpact" end
	if tr.MatType == MAT_GLASS then return "Glass.BulletImpact" end
	if tr.MatType == MAT_FLESH then return "Flesh.BulletImpact" end
	if tr.MatType == MAT_BLOODYFLESH then return "Flesh.BulletImpact" end
	if tr.MatType == MAT_DIRT then return "Dirt.BulletImpact" end
	if tr.MatType == MAT_GRATE then return "MetalGrate.BulletImpact" end
	if tr.MatType == MAT_TILE then return "Tile.BulletImpact" end
	if tr.MatType == MAT_COMPUTER then return "Computer.BulletImpact" end
	if tr.MatType == MAT_SAND then return "Sand.BulletImpact" end
	if tr.MatType == MAT_PLASTIC then return "Plastic_Box.BulletImpact" end

	return "Default.BulletImpact"
end