local meta = FindMetaTable("Entity")
local pmeta = FindMetaTable("Player")
local nmeta = FindMetaTable("NPC")

local sharedtasks_e = {} -- Todo - remove when this is fixed in gmod (if)
sharedtasks_e["TASK_INVALID"] = 0
sharedtasks_e["TASK_RESET_ACTIVITY"] = 1
sharedtasks_e["TASK_WAIT"] = 2
sharedtasks_e["TASK_ANNOUNCE_ATTACK"] = 3
sharedtasks_e["TASK_WAIT_FACE_ENEMY"] = 4
sharedtasks_e["TASK_WAIT_FACE_ENEMY_RANDOM"] = 5
sharedtasks_e["TASK_WAIT_PVS"] = 6
sharedtasks_e["TASK_SUGGEST_STATE"] = 7
sharedtasks_e["TASK_TARGET_PLAYER"] = 8
sharedtasks_e["TASK_SCRIPT_WALK_TO_TARGET"] = 9
sharedtasks_e["TASK_SCRIPT_RUN_TO_TARGET"] = 10
sharedtasks_e["TASK_SCRIPT_CUSTOM_MOVE_TO_TARGET"] = 11
sharedtasks_e["TASK_MOVE_TO_TARGET_RANGE"] = 12
sharedtasks_e["TASK_MOVE_TO_GOAL_RANGE"] = 13
sharedtasks_e["TASK_MOVE_AWAY_PATH"] = 14
sharedtasks_e["TASK_GET_PATH_AWAY_FROM_BEST_SOUND"] = 15
sharedtasks_e["TASK_SET_GOAL"] = 16
sharedtasks_e["TASK_GET_PATH_TO_GOAL"] = 17
sharedtasks_e["TASK_GET_PATH_TO_ENEMY"] = 18
sharedtasks_e["TASK_GET_PATH_TO_ENEMY_LKP"] = 19
sharedtasks_e["TASK_GET_CHASE_PATH_TO_ENEMY"] = 20
sharedtasks_e["TASK_GET_PATH_TO_ENEMY_LKP_LOS"] = 21
sharedtasks_e["TASK_GET_PATH_TO_ENEMY_CORPSE"] = 22
sharedtasks_e["TASK_GET_PATH_TO_PLAYER"] = 23
sharedtasks_e["TASK_GET_PATH_TO_ENEMY_LOS"] = 24
sharedtasks_e["TASK_GET_FLANK_RADIUS_PATH_TO_ENEMY_LOS"] = 25
sharedtasks_e["TASK_GET_FLANK_ARC_PATH_TO_ENEMY_LOS"] = 26
sharedtasks_e["TASK_GET_PATH_TO_RANGE_ENEMY_LKP_LOS"] = 27
sharedtasks_e["TASK_GET_PATH_TO_TARGET"] = 28
sharedtasks_e["TASK_GET_PATH_TO_TARGET_WEAPON"] = 29
sharedtasks_e["TASK_CREATE_PENDING_WEAPON"] = 30
sharedtasks_e["TASK_GET_PATH_TO_HINTNODE"] = 31
sharedtasks_e["TASK_STORE_LASTPOSITION"] = 32
sharedtasks_e["TASK_CLEAR_LASTPOSITION"] = 33
sharedtasks_e["TASK_STORE_POSITION_IN_SAVEPOSITION"] = 34
sharedtasks_e["TASK_STORE_BESTSOUND_IN_SAVEPOSITION"] = 35
sharedtasks_e["TASK_STORE_BESTSOUND_REACTORIGIN_IN_SAVEPOSITION"] = 36
sharedtasks_e["TASK_REACT_TO_COMBAT_SOUND"] = 37
sharedtasks_e["TASK_STORE_ENEMY_POSITION_IN_SAVEPOSITION"] = 38
sharedtasks_e["TASK_GET_PATH_TO_COMMAND_GOAL"] = 39
sharedtasks_e["TASK_MARK_COMMAND_GOAL_POS"] = 40
sharedtasks_e["TASK_CLEAR_COMMAND_GOAL"] = 41
sharedtasks_e["TASK_GET_PATH_TO_LASTPOSITION"] = 42
sharedtasks_e["TASK_GET_PATH_TO_SAVEPOSITION"] = 43
sharedtasks_e["TASK_GET_PATH_TO_SAVEPOSITION_LOS"] = 44
sharedtasks_e["TASK_GET_PATH_TO_RANDOM_NODE"] = 45
sharedtasks_e["TASK_GET_PATH_TO_BESTSOUND"] = 46
sharedtasks_e["TASK_GET_PATH_TO_BESTSCENT"] = 47
sharedtasks_e["TASK_RUN_PATH"] = 48
sharedtasks_e["TASK_WALK_PATH"] = 49
sharedtasks_e["TASK_WALK_PATH_TIMED"] = 50
sharedtasks_e["TASK_WALK_PATH_WITHIN_DIST"] = 51
sharedtasks_e["TASK_WALK_PATH_FOR_UNITS"] = 52
sharedtasks_e["TASK_RUN_PATH_FLEE"] = 53
sharedtasks_e["TASK_RUN_PATH_TIMED"] = 54
sharedtasks_e["TASK_RUN_PATH_FOR_UNITS"] = 55
sharedtasks_e["TASK_RUN_PATH_WITHIN_DIST"] = 56
sharedtasks_e["TASK_STRAFE_PATH"] = 57
sharedtasks_e["TASK_CLEAR_MOVE_WAIT"] = 58
sharedtasks_e["TASK_SMALL_FLINCH"] = 59
sharedtasks_e["TASK_BIG_FLINCH"] = 60
sharedtasks_e["TASK_DEFER_DODGE"] = 61
sharedtasks_e["TASK_FACE_IDEAL"] = 62
sharedtasks_e["TASK_FACE_REASONABLE"] = 63
sharedtasks_e["TASK_FACE_PATH"] = 64
sharedtasks_e["TASK_FACE_PLAYER"] = 65
sharedtasks_e["TASK_FACE_ENEMY"] = 66
sharedtasks_e["TASK_FACE_HINTNODE"] = 67
sharedtasks_e["TASK_PLAY_HINT_ACTIVITY"] = 68
sharedtasks_e["TASK_FACE_TARGET"] = 69
sharedtasks_e["TASK_FACE_LASTPOSITION"] = 70
sharedtasks_e["TASK_FACE_SAVEPOSITION"] = 71
sharedtasks_e["TASK_FACE_AWAY_FROM_SAVEPOSITION"] = 72
sharedtasks_e["TASK_SET_IDEAL_YAW_TO_CURRENT"] = 73
sharedtasks_e["TASK_RANGE_ATTACK1"] = 74
sharedtasks_e["TASK_RANGE_ATTACK2"] = 75
sharedtasks_e["TASK_MELEE_ATTACK1"] = 76
sharedtasks_e["TASK_MELEE_ATTACK2"] = 77
sharedtasks_e["TASK_RELOAD"] = 78
sharedtasks_e["TASK_SPECIAL_ATTACK1"] = 79
sharedtasks_e["TASK_SPECIAL_ATTACK2"] = 80
sharedtasks_e["TASK_FIND_HINTNODE"] = 81
sharedtasks_e["TASK_FIND_LOCK_HINTNODE"] = 82
sharedtasks_e["TASK_CLEAR_HINTNODE"] = 83
sharedtasks_e["TASK_LOCK_HINTNODE"] = 84
sharedtasks_e["TASK_SOUND_ANGRY"] = 85
sharedtasks_e["TASK_SOUND_DEATH"] = 86
sharedtasks_e["TASK_SOUND_IDLE"] = 87
sharedtasks_e["TASK_SOUND_WAKE"] = 88
sharedtasks_e["TASK_SOUND_PAIN"] = 89
sharedtasks_e["TASK_SOUND_DIE"] = 90
sharedtasks_e["TASK_SPEAK_SENTENCE"] = 91
sharedtasks_e["TASK_WAIT_FOR_SPEAK_FINISH"] = 92
sharedtasks_e["TASK_SET_ACTIVITY"] = 93
sharedtasks_e["TASK_RANDOMIZE_FRAMERATE"] = 94
sharedtasks_e["TASK_SET_SCHEDULE"] = 95
sharedtasks_e["TASK_SET_FAIL_SCHEDULE"] = 96
sharedtasks_e["TASK_SET_TOLERANCE_DISTANCE"] = 97
sharedtasks_e["TASK_SET_ROUTE_SEARCH_TIME"] = 98
sharedtasks_e["TASK_CLEAR_FAIL_SCHEDULE"] = 99
sharedtasks_e["TASK_PLAY_SEQUENCE"] = 100
sharedtasks_e["TASK_PLAY_PRIVATE_SEQUENCE"] = 101
sharedtasks_e["TASK_PLAY_PRIVATE_SEQUENCE_FACE_ENEMY"] = 102
sharedtasks_e["TASK_PLAY_SEQUENCE_FACE_ENEMY"] = 103
sharedtasks_e["TASK_PLAY_SEQUENCE_FACE_TARGET"] = 104
sharedtasks_e["TASK_FIND_COVER_FROM_BEST_SOUND"] = 105
sharedtasks_e["TASK_FIND_COVER_FROM_ENEMY"] = 106
sharedtasks_e["TASK_FIND_LATERAL_COVER_FROM_ENEMY"] = 107
sharedtasks_e["TASK_FIND_BACKAWAY_FROM_SAVEPOSITION"] = 108
sharedtasks_e["TASK_FIND_NODE_COVER_FROM_ENEMY"] = 109
sharedtasks_e["TASK_FIND_NEAR_NODE_COVER_FROM_ENEMY"] = 110
sharedtasks_e["TASK_FIND_FAR_NODE_COVER_FROM_ENEMY"] = 111
sharedtasks_e["TASK_FIND_COVER_FROM_ORIGIN"] = 112
sharedtasks_e["TASK_DIE"] = 113
sharedtasks_e["TASK_WAIT_FOR_SCRIPT"] = 114
sharedtasks_e["TASK_PUSH_SCRIPT_ARRIVAL_ACTIVITY"] = 115
sharedtasks_e["TASK_PLAY_SCRIPT"] = 116
sharedtasks_e["TASK_PLAY_SCRIPT_POST_IDLE"] = 117
sharedtasks_e["TASK_ENABLE_SCRIPT"] = 118
sharedtasks_e["TASK_PLANT_ON_SCRIPT"] = 119
sharedtasks_e["TASK_FACE_SCRIPT"] = 120
sharedtasks_e["TASK_PLAY_SCENE"] = 121
sharedtasks_e["TASK_WAIT_RANDOM"] = 122
sharedtasks_e["TASK_WAIT_INDEFINITE"] = 123
sharedtasks_e["TASK_STOP_MOVING"] = 124
sharedtasks_e["TASK_TURN_LEFT"] = 125
sharedtasks_e["TASK_TURN_RIGHT"] = 126
sharedtasks_e["TASK_REMEMBER"] = 127
sharedtasks_e["TASK_FORGET"] = 128
sharedtasks_e["TASK_WAIT_FOR_MOVEMENT"] = 129
sharedtasks_e["TASK_WAIT_FOR_MOVEMENT_STEP"] = 130
sharedtasks_e["TASK_WAIT_UNTIL_NO_DANGER_SOUND"] = 131
sharedtasks_e["TASK_WEAPON_FIND"] = 132
sharedtasks_e["TASK_WEAPON_PICKUP"] = 133
sharedtasks_e["TASK_WEAPON_RUN_PATH"] = 134
sharedtasks_e["TASK_WEAPON_CREATE"] = 135
sharedtasks_e["TASK_ITEM_PICKUP"] = 136
sharedtasks_e["TASK_ITEM_RUN_PATH"] = 137
sharedtasks_e["TASK_USE_SMALL_HULL"] = 138
sharedtasks_e["TASK_FALL_TO_GROUND"] = 139
sharedtasks_e["TASK_WANDER"] = 140
sharedtasks_e["TASK_FREEZE"] = 141
sharedtasks_e["TASK_GATHER_CONDITIONS"] = 142
sharedtasks_e["TASK_IGNORE_OLD_ENEMIES"] = 143
sharedtasks_e["TASK_DEBUG_BREAK"] = 144
sharedtasks_e["TASK_ADD_HEALTH"] = 145
sharedtasks_e["TASK_ADD_GESTURE_WAIT"] = 146
sharedtasks_e["TASK_ADD_GESTURE"] = 147
sharedtasks_e["TASK_GET_PATH_TO_INTERACTION_PARTNER"] = 148
sharedtasks_e["TASK_PRE_SCRIPT"] = 149

ai.GetTaskID = function(taskName)
	return sharedtasks_e[taskName]
end

function GM:RefreshNPCRelationships()
	for _, v in pairs(ents.GetNPCs()) do
		self:RefreshNPCRelationship(v)
	end
end

function GM:RefreshNPCRelationship(ent)
	if ent:GetClass() == "prop_vehicle_apc" then
		ent = ent:NPCDriver()
	end

	for _, v in pairs(player.GetAll()) do
		local hated = false

		if hated then
			ent:AddEntityRelationship(v, D_HT, 99)
		else
			ent:AddEntityRelationship(v, D_LI, 99)
		end
	end

	for _, v in pairs(ents.GetNPCs()) do
		-- Hate people who hate us
		if v:Disposition(ent) == D_HT then
			ent:AddEntityRelationship(v, D_HT, 99)

			continue
		end

		-- Like our clones
		if v:GetClass() == ent:GetClass() then
			ent:AddEntityRelationship(v, D_LI, 99)

			continue
		end

		local hated = false

		if ent:NPCHatesWeapons() == 1 then
			local wep = v:GetActiveWeapon()

			if IsValid(wep) and v:Visible(ent) then
				hated = true
			end
		end

		if hated then
			ent:AddEntityRelationship(v, D_HT, 99)
		else
			ent:AddEntityRelationship(v, D_LI, 99)
		end
	end
end

function GM:PlayerSpawnedNPC(ply, npc)
	local class = npc:GetClass()

	if class == "npc_helicopter" or class == "npc_combinegunship" then
		npc:Fire("GunOff")
	elseif class == "npc_strider" then
		npc:Fire("DisableAggressiveBehavior")
	elseif class == "npc_cscanner" then
		npc:SetKeyValue("spawnflags", SF_NPC_NO_WEAPON_DROP)
	elseif class == "npc_kleiner" then
		npc:SetName("Kleiner")
	elseif class == "npc_alyx" then
		npc:SetName("Alyx")
	elseif class == "npc_barney" then
		npc:SetName("Barney")
	elseif class == "npc_eli" then
		npc:SetName("Eli")
	elseif class == "npc_mossman" then
		npc:SetName("Mossman")
	end

	npc:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)

	if self.MapSpawnNPC then
		self:MapSpawnNPC(ply, npc)
	end
end

function meta:GoTo(pos, style)
	local ent = self

	if self:GetClass() == "prop_vehicle_apc" then
		ent = self:NPCDriver()
	end

	if ent:GetClass() == "npc_apcdriver" then
		ent:GetParent():SetNPCTargetPos(pos)

		local targ = ent:GetParent().Path

		if not targ or not targ:IsValid() then
			targ = ents.Create("path_corner")
			targ:SetPos(pos)
			targ:SetName("cc_apc_path_" .. ent:GetParent():EntIndex())
			targ:Spawn()
			targ:Activate()
			ent:GetParent():DeleteOnRemove(targ)

			ent:GetParent().Path = targ
		end

		targ:SetPos(pos)
		ent:Fire("GotoPathCorner", targ:GetName())

		return
	end

	if ent:GetClass() == "npc_helicopter" or ent:GetClass() == "npc_combinegunship" or ent:GetClass() == "npc_combinedropship" then
		ent:SetNPCTargetPos(pos)

		local targ1 = ent.Path1
		local targ2 = ent.Path2

		if IsValid(targ1) then
			targ1 = ents.Create("path_track")
			targ1:SetPos(pos)
			targ1:SetName("cc_heli_path_" .. ent:EntIndex() .. "_1")
			targ1:Spawn()
			targ1:Activate()
			ent:DeleteOnRemove(targ1)

			ent.Path1 = targ1
		end

		if IsValid(targ2) then
			targ2 = ents.Create("path_track")
			targ2:SetPos(pos)
			targ2:SetName("cc_heli_path_" .. ent:EntIndex() .. "_2")
			targ2:Spawn()
			targ2:Activate()
			ent:DeleteOnRemove(targ2)

			ent.Path2 = targ2
		end

		targ1:SetPos(pos)
		targ2:SetPos(pos)

		if not ent.ActivePath then
			ent.ActivePath = 1
		end

		ent.ActivePath = 1 - ent.ActivePath

		ent:Fire("FlyToPathTrack", "cc_heli_path_" .. ent:EntIndex() .. "_" .. (1 + ent.ActivePath))

		return
	end

	ent:SetNPCTargetPos(pos)
	ent:SetLastPosition(pos)
	ent:SetSchedule(style)
end

net.Receive("nNMMGoTo", function(len, ply)
	if not ply:IsAdmin() then return end

	local ent = net.ReadEntity()
	local pos = net.ReadVector()

	ent:GoTo(pos, SCHED_FORCED_GO_RUN)
end)

net.Receive("nNMMWalkTo", function(len, ply)
	if not ply:IsAdmin() then return end

	local ent = net.ReadEntity()
	local pos = net.ReadVector()

	ent:GoTo(pos, SCHED_FORCED_GO)
end)

net.Receive("nNMMSetMastermindColor", function(len, ply)
	if not ply:IsAdmin() then return end

	local ent = net.ReadEntity()
	local col = net.ReadVector()

	ent:SetNPCMastermindColor(col)
end)

net.Receive("nNMMFireInput", function(len, ply)
	if not ply:IsAdmin() then return end

	local ent = net.ReadEntity()
	local input = net.ReadString()
	local arg = net.ReadString()
	local driver = tobool(net.ReadBit())

	if driver then
		ent = ent:NPCDriver()
	end

	ent:Fire(input, arg)
end)

net.Receive("nNMMGunOn", function(len, ply)
	if not ply:IsAdmin() then return end

	local ent = net.ReadEntity()
	local f = net.ReadFloat()

	ent:SetNPCGunOn(f)
end)

net.Receive("nNMMPlayGesture", function(len, ply)
	if not ply:IsAdmin() then return end

	local ent = net.ReadEntity()
	local g = net.ReadFloat()

	ent:RestartGesture(g)
end)

net.Receive("nNMMHateWeapons", function(len, ply)
	if not ply:IsAdmin() then return end

	local ent = net.ReadEntity()
	local f = net.ReadFloat()

	ent:SetNPCHatesWeapons(f)
	GAMEMODE:RefreshNPCRelationships()
end)

net.Receive("nNMMKill", function(len, ply)
	if not ply:IsAdmin() then return end

	local ent = net.ReadEntity()

	if ent.SetHealth and ent.TakeDamage then
		ent:SetHealth(0)
		ent:TakeDamage(1)
	end
end)

net.Receive("nNCMShake", function(len, ply)
	if not ply:IsAdmin() then return end

	local pos = ply:GetEyeTrace().HitPos
	local freq = net.ReadFloat()
	local amp = net.ReadFloat()
	local dur = net.ReadFloat()

	util.ScreenShake(pos, amp, freq, dur, 1024)
end)

function GM:SpawnAntlion(pos)
	local ant = ents.Create("npc_antlion")
	ant:SetPos(pos)
	ant:SetAngles(Angle())
	ant:SetKeyValue("spawnflags", "2048")
	ant:SetKeyValue("startburrowed", "1")
	ant:SetSkin(math.random(1, 4))
	ant:Spawn()
	ant:Activate()
	ant:Fire("Unburrow")

	ant:NavSetWanderGoal(256, 4096)
	timer.Simple(1, function()
		if not ant or not ant:IsValid() then return end
		if ant:GetEnemy() then return end

		ant:SetSchedule(SCHED_PATROL_WALK)
	end)

	return ant
end

GM.AntlionSpawns = {}

function GM:AddAntlionSpawn(pos, num)
	table.insert(self.AntlionSpawns, {pos, num, 0, {}})
end

function GM:SpawnerThink()
	for _, v in pairs(self.AntlionSpawns) do
		for k, n in pairs(v[4]) do
			if not n or not n:IsValid() then
				table.remove(v[4], k)
			end
		end

		if CurTime() > v[3] and #v[4] < v[2] then
			local trace = {}
			trace.start = v[1]
			trace.endpos = trace.start + Vector(0, 0, 20)
			trace.mins = Vector(-16, -16, 0)
			trace.maxs = Vector(16, 16, 1)
			trace.mask = MASK_NPCSOLID
			local tr = util.TraceLine(trace)

			if not tr.Hit then
				if GAMEMODE.CurrentLocation == LOCATION_COAST then
					v[3] = CurTime() + 1 + (0.05 * _)
					for o,p in pairs(ents.FindInSphere(v[1], 512)) do
						if (p:IsPlayer() and p:OnGround() and p:GetMoveType() != MOVETYPE_NOCLIP) or (p:IsNPC() and p:GetClass() != "npc_antlion" and p:GetClass() != "npc_antlionguard") then
							local ant = self:SpawnAntlion(v[1])
							table.insert(v[4], ant)
						end
					end
				else
					v[3] = CurTime() + math.random(60, 180)

					local ant = self:SpawnAntlion(v[1])
					table.insert(v[4], ant)
				end
			end
		end
	end
end

local function SendDispatch(v)
	local id = v:GetNWString("camname")

	if #id < 1 then
		id = "id-" .. v:EntIndex()
	end

	local rem = {}

	for _, ply in pairs(player.GetAll()) do
		if GAMEMODE:LookupCombineFlag(ply:ActiveFlag()) or ply:GetCharFlagAttribute("UseCombineRadio") then
			table.insert(rem, ply)
		end
	end

	PlayOverwatchRadio(v, {table.Random(GAMEMODE.RadioDispatchLines.CameraDestroyed)})
end

sound.Add({
	name = "camera_destroyed_loop",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 90,
	pitch = 110,
	sound = "ambient/alarms/combine_bank_alarm_loop4.wav"
})

local NextThink = 0

function GM:CombineCameraThink()
	if CurTime() < NextThink then return end
	NextThink = CurTime() + 2

	for _, v in pairs(ents.FindByClass("npc_combine_camera")) do
		if v.IsDead then continue end
		local id = v:GetNWString("camname")

		if #id < 1 then
			id = "id-" .. v:EntIndex()
		end

		if v:Health() < 1 then
			v.IsDead = true
			SendDispatch(v)

			local snd = CreateSound(v, "camera_destroyed_loop")
			snd:Play()

			timer.Simple(50, function()
				if not snd then return end

				snd:FadeOut(10)
			end)
		end

		local target = v:GetSaveTable().m_hEnemyTarget
		v.LastTarget = v.LastTarget or nil

		if not target or not target:IsPlayer() then
			v:Fire("SetIdle")
			v.IsAngry = false
			v.LastTarget = nil
			continue
		end

		target.LastCamSpotted = target.LastCamSpotted or 0

		if v.LastTarget != target and v.LastTarget != nil and v.IsAngry then
			v:Fire("SetIdle")
			v.IsAngry = false
			v.LastTarget = target
			continue
		end

		local function HandleResponse(message)
			v:Fire("SetAngry")
			v.IsAngry = true

			if target.LastCamSpotted < CurTime() + 10 or target.LastCamSpotted == 0 then
				local rem = {}

				for _, ply in pairs(player.GetAll()) do
					if GAMEMODE:LookupCombineFlag(ply:ActiveFlag()) or ply:GetCharFlagAttribute("UseCombineRadio") then
						table.insert(rem, ply)
					end
				end

				target.LastCamSpotted = CurTime()
			end

			v.LastTarget = target
		end

		if target:HasTerminatorTeam() then
			continue
		end

		if v.IsAngry and v.LastTarget == target then
			continue
		end

		local name = target:VisibleRPName()

		local crimes = {}

		if target:HasFaceCovered() then
			table.insert(crimes, "43_NO_ID")
			name = "[unknown]"
		end

		if target:IsArmed() then
			table.insert(crimes, "95_ILLEGAL_CARRY")
		end

		if target:Typing() == 2 and target:HasItem("radio") then
			table.insert(crimes, "122_UNREGISTERED_COMM_DEVICE")
		end

		if #crimes > 0 then
			local message = string.format("ALERT. [%s] reports %s: [%s]", id, name, table.concat(crimes, ", "))
			HandleResponse(message)
		end
	end
end