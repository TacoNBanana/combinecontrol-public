local meta = FindMetaTable("Entity")
local pmeta = FindMetaTable("Player")

hook.Add("EntityTakeDamage", "SV.Door.EntityTakeDamage", function(ent, dmg)
	if ent:GetClass() == "prop_door_rotating" and (ent.NextBreach or 0) < CurTime() then
		local handle = ent:LookupBone("handle")

		if handle and dmg:IsBulletDamage() then
			local attacker = dmg:GetAttacker()
			local dmgPos = dmg:GetDamagePosition()

			if not IsValid(attacker) or not attacker:IsPlayer() then
				return
			end

			if attacker:GetEyeTrace().Entity != ent or attacker:GetPos():DistToSqr(dmgPos) > 180^2 then
				return
			end

			if dmgPos:DistToSqr(ent:GetBonePosition(handle)) > 6^2 then
				return
			end

			local effect = EffectData()
				effect:SetStart(dmgPos)
				effect:SetOrigin(dmgPos)
				effect:SetScale(2)
			util.Effect("GlassImpact", effect)

			local name = attacker:UniqueID() .. CurTime()
			attacker:SetName(name)

			ent.oldSpeed = ent.oldSpeed or ent:GetKeyValues().speed or 100

			ent:Fire("setspeed", ent.oldSpeed * 3.5)
			ent:Fire("unlock")
			ent:Fire("openawayfrom", name)
			ent:EmitSound("physics/wood/wood_plank_break" .. math.random(1, 4) .. ".wav", 100, 120)

			ent.NextBreach = CurTime() + 1

			timer.Simple(0.5, function()
				if (IsValid(ent)) then
					ent:Fire("setspeed", ent.oldSpeed)
				end
			end)
		end
	end
end)

net.Receive("nRequestDoorData", function(len, ply)
	local ent = net.ReadEntity()

	ent:SyncDoorData(ply)
end)

function GM:ExplodeDoor(door, force, explode)
	if door:GetNoDraw() then
		return
	end

	if explode then -- We'll blow up anyway, because it's the breaching charge
		local effect = EffectData()

		effect:SetOrigin(door:GetPos())
		util.Effect("Explosion", effect)
	end

	if door:DoorType() == DOOR_COMBINEOPEN then
		return
	end -- but we wont open for you, if you're a combine door!!!

	door:EmitSound("physics/wood/wood_crate_break" .. math.random(1, 5) .. ".wav")

	door:SetNotSolid(true)
	door:SetNoDraw(true)

	local newdoor = ents.Create("prop_physics")
	newdoor:SetPos(door:GetPos())
	newdoor:SetAngles(door:GetAngles())
	newdoor:SetModel(door:GetModel())
	newdoor:SetSkin(door:GetSkin() or 0)
	newdoor:Spawn()
	newdoor:GetPhysicsObject():ApplyForceOffset(force * 300, newdoor:WorldSpaceCenter())
	newdoor:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	timer.Simple(300, function()
		if IsValid(door) then
			door:Fire("Unlock")
			door:SetNotSolid(false)
			door:SetNoDraw(false)
		end

		if IsValid(newdoor) then
			newdoor:Remove()
		end
	end)
end

function pmeta:BuyDoor(ent)
	self:AddMoney(-ent:DoorPrice())
	self:UpdateCharacterField("Money", tostring(self:Money()))

	ent:SetDoorOwners({self:CharID()})

	if ent:DoorBuilding() != "" then
		for _, v in pairs(game.GetDoors()) do
			if ent:DoorBuilding() == v:DoorBuilding() then
				v:SetDoorOwners({self:CharID()})
			end
		end
	end
end

function pmeta:SellDoor(ent)
	self:AddMoney(math.floor(ent:DoorPrice() * 0.8))
	self:UpdateCharacterField("Money", tostring(self:Money()))

	ent:ResetDoor()
end

function meta:ResetDoor()
	self:SetDoorOwners({})
	self:SetDoorName(self:DoorOriginalName())
	self:Fire("Unlock")

	if self:DoorBuilding() != "" then
		for _, v in pairs(game.GetDoors()) do
			if self:DoorBuilding() == v:DoorBuilding() then
				v:SetDoorOwners({})
				v:SetDoorName(v:DoorOriginalName())
				v:Fire("Unlock")
			end
		end
	end
end
