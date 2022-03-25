local meta = FindMetaTable("Player")

GM.PlayerAccessors = {
	{"ToolTrust", 			false, 	"Float", 	0},
	{"PhysTrust", 			false, 	"Float", 	1},
	{"PropTrust", 			false, 	"Float", 	1},
	{"NewbieStatus", 		false, 	"Float", 	NEWBIE_STATUS_NEW},
	{"CharID", 				false, 	"Float", 	-1},
	{"RPName", 				false, 	"String", 	"Unconnected"},
	{"VisibleRPName", 		false, 	"String", 	"Unconnected"},
	{"RPModel", 			false, 	"String", 	"models/error.mdl"},
	{"Description",			false, 	"String", 	""},
	{"Holstered", 			false, 	"Bit", 		true},
	{"Money", 				true, 	"Float", 	0},
	{"Trait", 				false, 	"Float", 	TRAIT_NONE},
	{"Lang", 				false, 	"Float", 	LANG_ENGLISH},
	{"CombineFlag", 		false, 	"String", 	""},
	{"CombineSquad",		false,	"String",	""},
	{"CombineSquadID",		false,	"Float",	4},
	{"ActiveFlag", 			false, 	"String", 	""},
	{"CharFlags", 			false, 	"String", 	""},
	{"Consciousness", 		true, 	"Float", 	100},
	{"PassedOut", 			false, 	"Bit", 		false},
	{"TiedUp",				false,	"Bit",		false},
	{"CharCreationDate",	true,	"String",	""},
	{"InAttack2",			false,	"Bit",		false},
	{"BusinessLicenses",	false,	"Float",	0},
	{"Typing",				false,	"Float",	0},
	{"MountedGun",			false,	"Entity",	NULL},
	{"ScoreboardTitle",		false,	"String",	""},
	{"ScoreboardTitleC",	false,	"Vector",	Vector(200, 200, 200)},
	{"ScoreboardBadges",	false,	"Float",	0},
	{"PropProtection",		true,	"Table",	{}},
	{"Bottify",				false,	"Bit",		false},
	{"RagdollIndex",		false,	"Float",	-1},
	{"HideAdmin",			false,	"Bit",		false},
	{"Hidden",				false, 	"Bit",		false},
	{"LastPMSender",		true,	"String",	""},
	{"PlayerFlags", 		false, 	"String", 	""},
	{"LastNotesUpdate", 	false, 	"Float", 	0},
	{"IsOOCMuted", 			false, 	"Bit", 		false},
	{"IsTravelBanned", 		false, 	"Bit", 		false},
	{"CombineCamera", 		true, 	"Entity", 	NULL},
	{"AdminRadio", 			true, 	"Bit", 		false},
	{"PlayerScale",			false,	"Float",	1},
	{"CharacterScale", 		true, 	"Float", 	1},
	{"HullData", 			false, 	"Table", 	{}},
	{"InfiniteAmmo", 		false, 	"Bit", 		false},
	{"OverlayMode", 		true, 	"Float", 	OVERLAY_NONE},
	{"Donations", 			true, 	"Table", 	{}},
	{"PhysgunMode", 		false, 	"Bit", 		false},
	{"ThermalHidden", 		false, 	"Bit", 		false},
	{"JumpPackActive", 		false, 	"Bit", 		false},
	{"DroneFlags", 			false, 	"Table", 	{}},
	{"ActiveDroneFlag", 	false, 	"String", 	""},
	{"DonatorActive", 		false, 	"Bit", 		false},
	{"CustomModelAuths", 	false, 	"Bit", 		false},
	{"Hunger", 				true, 	"Float", 	0},
	{"ZoneMins", 			true, 	"Vector", 	Vector()},
	{"ZoneMaxs", 			true, 	"Vector", 	Vector()},
	{"ArmoryAccess", 		true, 	"String", 	""},
}

for k, v in pairs(GM.PlayerAccessors) do
	local name, private, vartype, default = v[1], v[2], v[3], v[4]

	meta["Set" .. name] = function(ply, val, force)
		if val == nil then
			return
		end

		if SERVER then
			if ply[name .. "Val"] == val and vartype != "Table" and not force then
				return
			end

			ply[name .. "Val"] = val

			hook.Run("On" .. name .. "Changed", ply, val)

			if private then
				if ply:IsBot() then
					return
				end

				net.Start("nSet" .. name)
					net["Write" .. vartype](val)
				net.Send(ply)
			else
				net.Start("nSet" .. name)
					net.WriteEntity(ply)
					net["Write" .. vartype](val)
				net.Broadcast()
			end
		end

		if CLIENT then
			if vartype == "Bit" then
				val = tobool(val)
			end

			ply[name .. "Val"] = val
		end

		return val
	end

	meta[name] = function(ply)
		if ply[name .. "Val"] == nil then
			return default
		end

		if ply[name .. "Val"] == false then
			return false
		end

		return ply[name .. "Val"]
	end

	if SERVER then
		util.AddNetworkString("nSet" .. name)
	end

	if CLIENT then
		net.Receive("nSet" .. name, function()
			local ply
			local val

			if private then
				ply = LocalPlayer()
				val = net["Read" .. vartype]()

				if vartype == "Bit" then
					val = tobool(val)
				end

				LocalPlayer()[name .. "Val"] = val
			else
				ply = net.ReadEntity()
				val = net["Read" .. vartype]()

				if vartype == "Bit" then
					val = tobool(val)
				end

				ply[name .. "Val"] = val
			end

			if IsValid(ply) then
				hook.Run("On" .. name .. "Changed", ply, val)
			end
		end)
	end
end

hook.Add("OnEntityCreated", "SH.Player.OnEntityCreated", function(ent)
	if ent:IsPlayer() then
		ent.Augments = {}
		ent.Equipment = {}
		ent.Inventory = {}
	end
end)

function meta:SyncAllData(ply)
	for _, v in pairs(GAMEMODE.PlayerAccessors) do
		local name, private, vartype = v[1], v[2], v[3]

		if not private then

			net.Start("nSet" .. name)
				net.WriteEntity(self)
				net["Write" .. vartype](self[name](self))
			if ply then
				net.Send(ply)
			else
				net.Broadcast()
			end
		end
	end
end

function meta:SyncAllOtherData()
	for _, v in pairs(player.GetAll()) do

		if v != self then

			for _, n in pairs(GAMEMODE.PlayerAccessors) do

				if not n[2] then

					net.Start("nSet" .. n[1])
						net.WriteEntity(v)
						net["Write" .. n[3]](v[n[1]](v))
					net.Send(self)

				end

			end

		end

	end
end

net.Receive("nRequestPlayerData", function(len, ply)
	if CLIENT then return end

	local ent = net.ReadEntity()
	if not ent or not ent:IsValid() then return end

	ent:SyncAllData(ply)
end)

net.Receive("nRequestAllPlayerData", function(len, ply)
	if CLIENT then return end

	if not ply.NextSyncPlayerData then ply.NextSyncPlayerData = 0 end

	if CurTime() < ply.NextSyncPlayerData then return end

	ply.NextSyncPlayerData = CurTime() + 1

	ply:SyncAllOtherData()
end)

function meta:AddMoney(money)
	if CLIENT then return end

	self:SetMoney(math.max(math.floor(self:Money() + money), 0))
end

function GM:FreezePlayer(ply, time)
	ply.FreezeTime = math.max(ply.FreezeTime or 0, CurTime() + time)
end

function GM:Move(ply, move)
	if ply.FreezeTime and CurTime() < ply.FreezeTime then

		move:SetMaxSpeed(0)
		move:SetMaxClientSpeed(0)
		move:SetVelocity(Vector())

	end

	if ply:PassedOut() then

		move:SetMaxSpeed(0)
		move:SetMaxClientSpeed(0)
		move:SetVelocity(Vector())

	end

	if IsValid(ply:MountedGun()) then

		move:SetMaxSpeed(0)
		move:SetMaxClientSpeed(0)
		move:SetVelocity(Vector())

	end

	local func = ply:GetCharFlagAttribute("Move")

	if func then
		func(ply, move)
	end

	return self.BaseClass:Move(ply, move)
end

function GM:SetupMove(ply, move)
	if ply.FreezeTime and CurTime() < ply.FreezeTime then
		move:SetMaxSpeed(0)
		move:SetMaxClientSpeed(0)
		move:SetVelocity(Vector())
	end

	if ply:PassedOut() then
		move:SetMaxSpeed(0)
		move:SetMaxClientSpeed(0)
		move:SetVelocity(Vector())
	end

	if IsValid(ply:MountedGun()) then
		move:SetMaxSpeed(0)
		move:SetMaxClientSpeed(0)
		move:SetVelocity(Vector())
	end

	local item = ply:GetEquipment(EQUIPMENT_EXO)

	if item and item.SetupMove then
		item:SetupMove(ply, move)
	end

	return self.BaseClass:SetupMove(ply, move)
end

function meta:Ragdoll()
	if self:RagdollIndex() == -1 then return NULL end

	return ents.GetByIndex(self:RagdollIndex())
end

function meta:SetRagdoll(ent)
	self:SetRagdollIndex(ent:EntIndex())
end

GM.BotDeadRemarks = {
	"gordead_ques01",
	"gordead_ques02",
	"gordead_ques06",
	"gordead_ques07",
	"gordead_ques10",
	"gordead_ques11",
	"gordead_ques14",
	"gordead_ans01",
	"gordead_ans02",
	"gordead_ans03",
	"gordead_ans04",
	"gordead_ans05",
	"gordead_ans07",
	"gordead_ans10",
	"gordead_ans14",
	"gordead_ans19",
}

GM.BotTargetedSounds = {
	"excuseme01",
	"excuseme02",
	"pardonme01",
	"pardonme02",
}

GM.BotIdleSounds = {
	"doingsomething",
	"getgoingsoon",
	"question02",
	"question04",
	"question05",
	"question06",
	"question07",
	"question09",
	"question11",
	"question12",
	"question13",
	"question15",
	"question16",
	"question17",
	"question18",
	"question19",
	"question20",
	"question22",
	"question23",
	"question25",
	"question27",
	"question28",
	"question29",
	"question30",
}

function GM:StartCommand(bot, cmd)
	if not bot:IsBot() and not bot:Bottify() then
		return
	end

	if not bot.AI then
		bot.AI = {}
	end

	if not bot.AI.Next then
		bot.AI.Next = CurTime()
	end

	cmd:ClearButtons()
	cmd:ClearMovement()
	cmd:SetViewAngles(bot:EyeAngles())

	if not bot:Alive() then
		cmd:SetButtons(IN_JUMP)

		bot.AI.Next = CurTime() + 3
		bot.AI.Target = nil

		return
	end

	if bot:PassedOut() then
		bot.AI.Next = CurTime() + 3
		bot.AI.Target = nil

		return
	end

	if IsValid(bot.AI.Target) then
		if not bot.AI.Target:Alive() then
			bot.AI.Target = nil
			bot.AI.Next = CurTime() + 4

			local remark = table.Random(self.BotDeadRemarks)

			bot:EmitSound(Sound("*vo/npc/" .. bot:Gender() .. "01/" .. remark .. ".wav"), 80)

			return
		end

		if bot.AI.Target:InVehicle() or bot.AI.Target:GetNoDraw() then
			bot.AI.Target = nil

			return
		end
	end

	if not IsValid(bot.AI.Target) then
		local dist = 400
		local closest = nil

		for _, v in pairs(player.GetAll()) do
			if v != bot and v:Alive() and not v:InVehicle() and not v:GetNoDraw() and bot:CanSee(v) then
				local d = v:GetPos():Distance(bot:GetPos())

				if d < dist then
					dist = d
					closest = v
				end
			end
		end

		if IsValid(closest) then
			bot.AI.Target = closest

			local remark = table.Random(self.BotTargetedSounds)

			bot:EmitSound(Sound("*vo/npc/" .. bot:Gender() .. "01/" .. remark .. ".wav"), 80)

			return
		end
	end

	if not IsValid(bot.AI.Target) then
		return
	end

	local eyeang = (bot.AI.Target:EyePos() - bot:EyePos()):GetNormal():Angle()

	eyeang.p = math.NormalizeAngle(eyeang.p)
	eyeang.y = math.NormalizeAngle(eyeang.y)
	eyeang.r = math.NormalizeAngle(eyeang.r)

	local dist = bot:GetPos():Distance(bot.AI.Target:GetPos())

	if dist > 200 then
		cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_SPEED))
	end

	if not bot:IsFemale() and bot.AI.Target:IsFemale() then
		cmd:SetForwardMove(bot:GetMaxSpeed())
	elseif dist > 50 then
		cmd:SetForwardMove(bot:GetMaxSpeed())
	end

	if CurTime() >= bot.AI.Next then
		if dist <= 50 then
			if not bot:IsFemale() and bot.AI.Target:IsFemale() then
				bot:EmitSound(Sound("vo/npc/male01/hi0" .. math.random(1, 2) .. ".wav"), 80)
				bot.AI.Next = CurTime() + 0.2
			else
				if math.random(1, 3) == 1 then
					local remark = table.Random(self.BotIdleSounds)

					bot:EmitSound(Sound("*vo/npc/" .. bot:Gender() .. "01/" .. remark .. ".wav"), 80)
				end

				bot.AI.Next = CurTime() + math.random(20, 30)
			end

			return
		end

		bot.AI.Next = CurTime() + 0.1
	end

	cmd:SetViewAngles(eyeang)
	bot:SetEyeAngles(eyeang)
end

function meta:HasBadge(b)
	if bit.band(self:ScoreboardBadges(), b) == b then return true end
	return false
end

sound.Add({
	name = "T600.FootstepLeft",
	channel = CHAN_STATIC,
	volume = 0.4,
	level = 80,
	pitch = {95, 105},
	sound = {
		"npc/dog/dog_footstep_walk01.wav",
		"npc/dog/dog_footstep_walk02.wav",
		"npc/dog/dog_footstep_walk03.wav",
		"npc/dog/dog_footstep_walk04.wav",
		"npc/dog/dog_footstep_walk05.wav"
	}
})

sound.Add({
	name = "T600.FootstepRight",
	channel = CHAN_STATIC,
	volume = 0.4,
	level = 80,
	pitch = {95, 105},
	sound = {
		"npc/dog/dog_footstep_walk06.wav",
		"npc/dog/dog_footstep_walk07.wav",
		"npc/dog/dog_footstep_walk08.wav",
		"npc/dog/dog_footstep_walk09.wav",
		"npc/dog/dog_footstep_walk10.wav"
	}
})


sound.Add({
	name = "T100.FootstepLeft",
	channel = CHAN_STATIC,
	volume = 0.6,
	level = 80,
	pitch = {95, 105},
	sound = {
		"npc/dog/dog_footstep_run01.wav",
		"npc/dog/dog_footstep_run02.wav",
		"npc/dog/dog_footstep_run03.wav",
		"npc/dog/dog_footstep_run04.wav",
		"npc/dog/dog_footstep_run05.wav"
	}
})

sound.Add({
	name = "T100.FootstepRight",
	channel = CHAN_STATIC,
	volume = 0.6,
	level = 80,
	pitch = {95, 105},
	sound = {
		"npc/dog/dog_footstep_run06.wav",
		"npc/dog/dog_footstep_run07.wav",
		"npc/dog/dog_footstep_run08.wav",
		"npc/dog/dog_footstep_run09.wav",
		"npc/dog/dog_footstep_run10.wav"
	}
})

sound.Add({
	name = "T400.Step",
	channel = CHAN_STATIC,
	volume = 0.4,
	level = 80,
	pitch = {95, 105},
	sound = {
		"npc/dog/dog_footstep_run1.wav",
		"npc/dog/dog_footstep_run2.wav",
		"npc/dog/dog_footstep_run3.wav",
		"npc/dog/dog_footstep_run5.wav",
		"npc/dog/dog_footstep_run6.wav",
		"npc/dog/dog_footstep_run8.wav"
	}
})

GM.WalkSounds = {}

GM.WalkSounds["models/tnb/player/trp/t400.mdl"] 			= "T400.Step"
GM.WalkSounds["models/tnb/player/trp/t100.mdl"] 			= {"T100.FootstepLeft",  "T100.FootstepRight"}
GM.WalkSounds["models/tnb/player/trp/t200.mdl"] 			= {"T100.FootstepLeft",  "T100.FootstepRight"}
GM.WalkSounds["models/tnb/player/trp/t300_new.mdl"] 		= GM.WalkSounds["models/tnb/player/trp/t400.mdl"]
GM.WalkSounds["models/tnb/player/trp/t70_scorpion.mdl"] 	= {"T100.FootstepLeft",  "T100.FootstepRight"}
GM.WalkSounds["models/tnb/player/trp/t70_widow.mdl"] 		= GM.WalkSounds["models/tnb/player/trp/t400.mdl"]

GM.WalkSounds["models/tnb/player/trp/t600.mdl"] 			= {"T600.FootstepLeft",  "T600.FootstepRight"}
GM.WalkSounds["models/tnb/player/trp/t600_skinjob.mdl"] 	= GM.WalkSounds["models/tnb/player/trp/t600.mdl"]
GM.WalkSounds["models/tnb/player/trp/t600_skinjob2.mdl"] 	= GM.WalkSounds["models/tnb/player/trp/t600.mdl"]
GM.WalkSounds["models/tnb/player/trp/t700.mdl"] 			= GM.WalkSounds["models/tnb/player/trp/t600.mdl"]
GM.WalkSounds["models/tnb/player/trp/t800.mdl"] 			= GM.WalkSounds["models/tnb/player/trp/t600.mdl"]
GM.WalkSounds["models/tnb/player/trp/t831.mdl"] 			= GM.WalkSounds["models/tnb/player/trp/t600.mdl"]

GM.RunSounds = {}

GM.RunSounds["models/tnb/player/trp/t100.mdl"] 				= {"T100.FootstepLeft",  "T100.FootstepRight"}
GM.RunSounds["models/tnb/player/trp/t200.mdl"] 				= {"T100.FootstepLeft",  "T100.FootstepRight"}
GM.RunSounds["models/tnb/player/trp/t400.mdl"] 				= "T400.Step"

GM.RunSounds["models/tnb/player/trp/t600.mdl"] 				= {"T600.FootstepLeft",  "T600.FootstepRight"}
GM.RunSounds["models/tnb/player/trp/t600_skinjob.mdl"] 		= GM.RunSounds["models/tnb/skynet/t600.mdl"]
GM.RunSounds["models/tnb/player/trp/t600_skinjob2.mdl"] 	= GM.RunSounds["models/tnb/skynet/t600.mdl"]
GM.RunSounds["models/tnb/player/trp/t700.mdl"] 				= GM.RunSounds["models/tnb/skynet/t600.mdl"]
GM.RunSounds["models/tnb/player/trp/t800.mdl"] 				= GM.RunSounds["models/tnb/skynet/t600.mdl"]
GM.RunSounds["models/tnb/player/trp/t831.mdl"] 				= GM.RunSounds["models/tnb/skynet/t600.mdl"]

function GM:PlayerFootstep(ply, pos, foot, s, vol, rf)
	if SERVER or ply:GetCharFlagValue("QuietSteps", false) then return end

	local mdl = ply:GetModel()
	local snd = ""

	local data = self.WalkSounds[mdl]

	if data then
		if type(data) == "table" then
			snd = foot == 0 and data[1] or data[2]
		else
			snd = data
		end
	end

	data = self.RunSounds[mdl]

	if data and ply:GetVelocity():Length2D() > 150 then
		if type(data) == "table" then
			snd = foot == 0 and data[1] or data[2]
		else
			snd = data
		end
	end

	if #snd > 0 then
		ply:EmitSound(snd, 75, 100, vol, CHAN_BODY)

		return true
	end

	self.BaseClass:PlayerFootstep(ply, pos, foot, s, vol, rf)
end

function GM:PlayerStepSoundTime(ply, stepType, walking)
	return self.BaseClass:PlayerStepSoundTime(ply, stepType, walking)
end

function player.GetByCharID(id)
	for _, v in pairs(player.GetAll()) do

		if v:CharID() == id then
			return v
		end
	end
end

function meta:HasTerminatorTeam()
	local team = self:Team()

	if team == TEAM_SKYNET or team == TEAM_REPROG then

		return true

	end

	return false
end

function meta:HasFaceCovered()
	for k, v in pairs(self.Equipment) do
		if v.CoversFace then
			return true
		end
	end

	return false
end

function meta:IsGasImmune()
	if self:GetMoveType() == MOVETYPE_NOCLIP or self:GetCharFlagValue("GasImmune", false) then
		return true
	end

	local val = 0

	for k, v in pairs(self.Equipment) do
		local immunity = v:GetGasImmunity()

		if immunity == true then
			return true
		end

		if isnumber(immunity) then
			val = math.max(val, immunity)
		end
	end

	return val != 0 and val or false
end

function meta:IsArmed()
	local wep = self:GetActiveWeapon()

	if IsValid(wep) then
		local class = wep:GetClass()

		if class != "weapon_cc_hands" and class != "weapon_physgun" and class != "gmod_tool" and class != "weapon_physcannon" then
			return true
		end
	end

	return false
end

function meta:IsDeveloper()
	if table.HasValue(GAMEMODE.Developers, self:SteamID()) then
		return true
	end

	return false
end

function meta:CanIgnoreTravelRestrictions(chardata)
	if self:IsAdmin() then return true end
	if not chardata then return false end

	if chardata.CharFlags and #chardata.CharFlags > 0 then
		local charFlags = GAMEMODE:LookupCharFlag(chardata.CharFlags)

		for _, v in pairs(charFlags) do
			if v and v.IgnoreTravelRestriction then
				return v.IgnoreTravelRestriction
			end
		end
	end

	return false
end

function GM:GetPlayerByCharID(id)
	for _, v in pairs(player.GetAll()) do
		if v:CharID() == id then
			return v
		end
	end
end

local blacklist = {
	ammo_40mm = true,
	ammo_rpg = true,
	ammo_20mm = true
}

function meta:HasInfiniteAmmo(ammo)
	if self:InfiniteAmmo() then
		return true
	end

	if self:DonatorActive() and not blacklist[ammo] then
		return true
	end

	return self:GetCharFlagValue("InfiniteAmmo", false)
end

local function update(ply, scale, data)
	ply:SetModelScale(scale, 0.0001)

	timer.Simple(0, function()
		if not IsValid(ply) then
			return
		end

		if data.Standing then
			ply:SetHull(data.Standing[1], data.Standing[2])
			ply:SetHullDuck(data.Crouching and data.Crouching[1] or data.Standing[1], data.Crouching and data.Crouching[2] or data.Standing[2])

			ply:SetViewOffset(data.ViewOffset * scale)
			ply:SetViewOffsetDucked((data.DuckedViewOffset or data.ViewOffset) * scale)
		else
			ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 72))
			ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 36))

			ply:SetViewOffset(Vector(0, 0, 64) * scale)
			ply:SetViewOffsetDucked(Vector(0, 0, 28) * scale)
		end
	end)
end

if CLIENT then
	hook.Add("NetworkEntityCreated", "hull", function(ent)
		if not ent:IsPlayer() then
			return
		end

		update(ent, ent:PlayerScale(), ent:HullData())
	end)
end

hook.Add("OnHullDataChanged", "hull", function(ply, data)
	update(ply, ply:PlayerScale(), data)
end)

hook.Add("OnPlayerScaleChanged", "hull", function(ply, scale)
	update(ply, scale, ply:HullData())
end)

function meta:GetPlayerColor()
	return Vector(0.2, 0.2, 0.2)
end
