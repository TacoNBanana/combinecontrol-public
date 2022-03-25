local meta = FindMetaTable("Player")

if CLIENT then

	function nWakeUp(len)

		local ply = net.ReadEntity()

		if LocalPlayer() == ply then

			ply.DrawWakeUp = CurTime()

		end

	end
	net.Receive("nWakeUp", nWakeUp)
end

function meta:MakeRagdollClone()
	if IsValid(self:Ragdoll()) then
		self:Ragdoll():Remove()
	end

	local rag = ents.Create("prop_ragdoll")
	rag = ents.Create("prop_ragdoll")
	rag:SetPos(self:GetPos())
	rag:SetAngles(self:GetAngles())
	rag:SetModel(self:GetModel())
	rag:SetSkin(self:GetSkin())
	rag:SetMaterial(self:GetMaterial())
	rag:CopyBodygroups(self)
	rag:Spawn()
	rag:Activate()

	rag:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	function rag:GetPlayerColor()
		if not IsValid(self:PropFakePlayer()) then return Vector(1, 1, 1) end

		return self:PropFakePlayer():GetPlayerColor()
	end

	compound.CopyCompoundModel(self, rag)

	rag:SetPropFakePlayer(self)
	self:SetRagdoll(rag)

	return rag
end

function meta:SnapFromRagdollClone()
	if self:Ragdoll() and self:Ragdoll():IsValid() then

		self:SetPos(self:Ragdoll():GetPos())

		self:Ragdoll():Remove()

	end
end

function meta:PassOut()
	if self:FlashlightIsOn() then
		self:Flashlight(false)
	end

	self:AllowFlashlight(false)

	self:SetPassedOut(true)

	self:ExitVehicle()
	self:SetNoTarget(true)
	self:SetNoDraw(true)

	for _, v in pairs(GAMEMODE.HandsWeapons) do
		if self:HasWeapon(v) then
			self:SelectWeapon(v)
			break
		end
	end

	self:SetHolstered(true)
	self:SetNotSolid(true)

	if self:GetActiveWeapon() != NULL then
		self:GetActiveWeapon():SetNoDraw(true)
	end

	return self:MakeRagdollClone()
end

function meta:WakeUp(spawn)
	self:SetPassedOut(false)

	self:AllowFlashlight(true)

	self:SetNoTarget(false)
	self:SetNoDraw(false)
	self:SetNotSolid(false)

	if self:GetActiveWeapon() != NULL then

		self:GetActiveWeapon():SetNoDraw(false)

	end

	if not spawn then

		self:SnapFromRagdollClone()

		net.Start("nWakeUp")
			net.WriteEntity(self)
		net.Broadcast()

	end
end

function meta:TakeCDamage(amt)
	local wep = self:GetActiveWeapon()

	if IsValid(wep) and wep:GetClass() == "weapon_cc_riotshield" then
		return
	end

	self:SetConsciousness(math.Clamp(self:Consciousness() - amt, 0, 100))

	if self:Consciousness() <= 0 and not self:PassedOut() then

		self:PassOut()

	end

	if self:Consciousness() == 100 and self:PassedOut() then

		self:WakeUp()

	end
end

hook.Add("CC.SV.PlayerThink", "SH.Consciousness.PlayerThink", function(ply)
	if not ply.ConsciousUpdate then
		ply.ConsciousUpdate = CurTime()
	end

	if CurTime() >= ply.ConsciousUpdate then

		if IsValid(ply:Ragdoll()) then
			ply:SetPos(ply:Ragdoll():GetPos())

			if ply:Ragdoll():GetVelocity():Length() > 15 then
				return
			end
		end

		ply.ConsciousUpdate = CurTime() + GAMEMODE.ConsciousnessRate

		ply:TakeCDamage(-1)
	end
end)
