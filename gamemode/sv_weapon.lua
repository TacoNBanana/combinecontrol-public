hook.Add("OnNPCKilled", "SV.Weapons.OnNPCKilled", function(npc)
	local mins, maxs = npc:WorldSpaceAABB()

	timer.Simple(0.1, function()
		for _, v in pairs(ents.FindInBox(mins, maxs)) do
			if not v:IsWeapon() and not string.find(v:GetClass(), "item_*") then
				continue
			end

			v:Remove()
		end
	end)
end)

hook.Add("CreateEntityRagdoll", "SV.Weapons.CreateEntityRagdoll", function(owner, ragdoll)
	if owner:GetClass() == "npc_cscanner" or owner:GetClass() == "npc_clawscanner" then
		ragdoll:Remove()

		return
	end

	ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	ragdoll:Fire("FadeAndRemove", "", 30)
end)

hook.Add("PostPlayerDeath", "SV.Weapons.PostPlayerDeath", function(ply)
	if not ply:GetRagdollEntity() then
		ply:CreateRagdoll()
	end

	local ragdoll = ply:GetRagdollEntity()

	if ply:PlayerScale() != 1 then
		ragdoll:Remove()

		return
	end
end)