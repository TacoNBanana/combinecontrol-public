local meta = FindMetaTable("Player")

GM.CombineRadioFreq = 1000 -- dick weed

function GM:PlayerInitialSpawn(ply)
	if not self.FullyLoaded then
		self:LogBug("ERROR: PlayerInitialSpawn on player " .. ply:Nick() .. " before gamemode fully loaded.")

		return
	end

	self.BaseClass:PlayerInitialSpawn(ply)

	ply:SetCustomCollisionCheck(true)
	ply:SetCanZoom(false)
	ply:Freeze(true)

	ply.AFKTime = CurTime()

	if ply:IsBot() then
		return
	end

	ply.SQLPlayerData = {}
	ply.SQLCharData = {}

	ply:SetHolstered(true)
end

hook.Add("CC.SV.InitialSpawn", "SV.Player.InitialSpawn", function(ply)
	ply:SetModel(table.Random({"models/crow.mdl", "models/pigeon.mdl", "models/seagull.mdl"}))

	ply:LoadPlayerInfo()
	ply:LoadPlayerNotes()

	ply:SyncAllGlobalData()

	ply:SetNotSolid(true)
	ply:SetMoveType(MOVETYPE_NOCLIP)

	ply.SpawnPos = ply:GetPos()
end)

hook.Add("CC.SV.PlayerThink", "SV.Player.SpeedThink", function(ply)
	local walk, run, jump, crouch = ply:GetSpeeds()

	if ply:GetRunSpeed() != run then
		ply:SetRunSpeed(run)
	end

	if ply:GetWalkSpeed() != walk then
		ply:SetWalkSpeed(walk)
	end

	if ply:GetJumpPower() != jump then
		ply:SetJumpPower(jump)
	end

	local cwalk = math.floor(crouch / walk)

	if ply:GetCrouchedWalkSpeed() != cwalk then
		ply:SetCrouchedWalkSpeed(cwalk)
	end

	hook.Run("CC.SV.SpeedThink", ply)
end)

hook.Add("CC.SV.PlayerThink", "SV.Player.HealthThink", function(ply)
	ply.NextHealthRegen = ply.NextHealthRegen or 0

	if ply.NextHealthRegen <= CurTime() and ply:Health() < ply:GetMaxHealth() and ply:Alive() then
		local rate = ply:RemapStatEndurance(3, 1.8)

		ply.NextHealthRegen = CurTime() + rate
		ply:SetHealth(ply:Health() + 1)
	end
end)

function meta:GetSpeeds()
	local w = 95
	local r = self:RemapStatSpeed(150, 220)
	local j = self:RemapStatAgility(160, 210)
	local c = 95

	r = r * self:DrugSpeedMod()

	local override = self:GetCharFlagAttribute("SpeedOverride")

	if override then
		return override.w, override.r, override.j, override.c
	end

	if self:InventoryWeight() > self:InventoryMaxWeight() then
		w = 40
		r = 40
		c = 40
	end

	if IsValid(self:GetActiveWeapon()) and self:GetActiveWeapon().GetSpeeds then
		w, r, c, j = self:GetActiveWeapon():GetSpeeds(w, r, c, j)
	end

	return w, r, j, c
end

local fixes = {
	["models/tnb/skynet/t70.mdl"] = "models/headcrabblack.mdl"
}

hook.Add("OnPlayerScaleChanged", "SV.Player.PlayerScale", function(ply, scale)
	local min, max = ply:GetModelBounds()

	if min:Length() == 0 or max:Length() == 0 then
		local mdl = ply:GetModel()

		if fixes[mdl] then
			ply:SetModel(fixes[mdl])

			min, max = ply:GetModelBounds()

			ply:SetModel(mdl)
		else
			min, max = ply:GetHitBoxBounds(0, 0)
		end
	end

	local diff = max - min

	diff.x = math.max(diff.x, diff.y)
	diff.y = math.max(diff.x, diff.y)

	min = -Vector(diff.x * 0.25, diff.y * 0.25, 0)
	max = Vector(diff.x * 0.25, diff.y * 0.25, diff.z)

	min = min * 0.9
	max = max * 0.9

	ply:SetPlayerScaleData({scale, min, max})
end)

hook.Add("OnPlayerScaleDataChanged", "SV.Player.PlayerScaleData", function(ply, data)
	local scale = data[1]
	local min = data[2]
	local max = data[3]

	ply:SetViewOffset(Vector(0, 0, max.z * GAMEMODE.ViewOffset) * scale)
	ply:SetViewOffsetDucked(Vector(0, 0, max.z * GAMEMODE.ViewOffsetCrouched) * scale)

	ply:SetStepSize(18 * scale)

	ply:SetHull(min * scale, max * scale)
	ply:SetHullDuck(min * scale, Vector(max.x, max.y, max.z * GAMEMODE.HullOffsetDucked) * scale)
end)

function GM:PlayerCheckFlag(ply, respawn)
	local flag = self:LookupCharFlag(ply:CharFlags())

	ply:RecalculatePlayerModel()

	if flag then
		if flag.Team then
			ply:SetTeam(flag.Team)
		end

		flag.OnSpawn(ply)

		ply:SetPlayerScale(flag.Scale or 1, true)

		ply:SetMaxHealth(flag.Health or 100)
		ply:SetBodyArmor(flag.BodyArmor or 0)
		ply:SetMaxBodyArmor(flag.BodyArmor or 0)
	else
		ply:SetTeam(TEAM_CITIZEN)

		ply:SetPlayerScale(1, true)

		ply:SetMaxHealth(100)
		ply:SetBodyArmor(0)
		ply:SetMaxBodyArmor(0)
	end

	ply:SetHealth(ply:GetMaxHealth())

	self:RefreshNPCRelationships()

	if ply:GetCharFlagAttribute("UseCombineSpawns") then
		if self.CombineSpawnpoints and respawn then
			ply:SetPos(table.Random(self.CombineSpawnpoints))
		end
	elseif ply.EntryPort and self.EntryPortSpawns[ply.EntryPort] then
		ply:SetPos(table.Random(self.EntryPortSpawns[ply.EntryPort]))
	end

	local offset = ply:GetCharFlagAttribute("SpawnOffset")

	if offset then
		ply:SetPos(ply:GetPos() + offset)
	end

	ply.SpawnPos = ply:GetPos()

	net.Start("nSetNightvision")
		net.WriteBit(0)
	net.Send(ply)
end

function GM:PlayerCheckInventory(ply)
	for _, v in pairs(ply.Inventory) do
		v:OnPlayerSpawn(ply)
	end
end

function GM:OnCharFlagsChanged(ply, flags)
end

function GM:IsSpawnpointSuitable(ply, spawn, force)
	if ply:Team() == TEAM_SPECTATOR then return true end

	local pos = spawn:GetPos()
	local blockers = ents.FindInBox(pos + Vector(-16, -16, 0), pos + Vector(16, 16, 64))

	for _, blocker in pairs(blockers) do
		if IsValid(blocker) and blocker:IsPlayer() and blocker:Alive() and blocker != ply then
			return force
		end
	end

	return true
end

function GM:PlayerSpawn(ply)
	self.BaseClass:PlayerSpawn(ply)

	player_manager.SetPlayerClass(ply, "player_cc")

	ply:SetNoCollideWithTeammates(false)
	ply:SetAvoidPlayers(false)

	ply:SetDuckSpeed(0.3)
	ply:SetUnDuckSpeed(0.3)

	ply:SetHolstered(true)

	ply:AllowFlashlight(true)

	ply:SetConsciousness(100)
	ply:WakeUp(true)

	ply.DrownDamage = 0

	ply:SetNotSolid(false)
	ply:SetMoveType(MOVETYPE_WALK)

	ply:SetViewOffset(Vector(0,0,64)) -- default player height
	ply:SetViewOffsetDucked(Vector(0,0,28)) -- default player height when ducked
	ply:StopSound("scanner_loop")
	ply:StopSound("shieldscanner_loop")
	ply:ResetHull()

	if IsValid(ply:Ragdoll()) then
		ply:Ragdoll():Remove()
	end

	if ply:IsBot() then
		if not ply.CharCreateCompleted then
			ply:LoadCharacter(player.GetAll()[1].SQLCharData[1])
		end

		self:PlayerCheckFlag(ply)
		self:PlayerCheckInventory(ply)

		return
	end

	if not ply.InitialSafeSpawn then
		ply.InitialSafeSpawn = true

		hook.Run("CC.SV.InitialSpawn", ply)
	end

	if not ply.CharCreateCompleted then return end

	hook.Run("CC.SV.PlayerSpawn", ply)

	self:PlayerCheckFlag(ply, true)
	self:PlayerCheckInventory(ply)
end

function GM:PlayerFlagLoadout(ply)
	local flag = self:LookupCharFlag(ply:CharFlags())

	if flag then
		for _, swep in pairs(flag.Loadout) do
			ply:Give(swep)
		end
	end
end

function GM:PlayerLoadout(ply)
	if not ply.CharCreateCompleted then return end

	ply:Give("weapon_cc_hands")

	GAMEMODE:PlayerFlagLoadout(ply)

	if ply:PhysTrust() == 1 or ply:IsAdmin() then
		ply:Give("weapon_physgun")
	end

	if ply:IsDeveloper() then
		ply:Give("weapon_physcannon")
	end

	if ply:ToolTrust() > 0 or ply:IsAdmin() then
		ply:Give("gmod_tool")
	end

	if ply:IsAdmin() then
		ply:Give("weapon_zombiemarker")
	end
end

function meta:LoadPlayer(data)
	self:SetToolTrust(tonumber(data.ToolTrust), true)
	self:SetPhysTrust(tonumber(data.PhysTrust), true)
	self:SetPropTrust(tonumber(data.PropTrust), true)
	self:SetNewbieStatus(tonumber(data.NewbieStatus), true)
	self:SetCustomMaxProps(tonumber(data.CustomMaxProps), true)
	self:SetCustomMaxRagdolls(tonumber(data.CustomMaxRagdolls), true)
	self:SetPlayerFlags(data.PlayerFlags, true)

	self:SetScoreboardTitle(data.ScoreboardTitle, true)
	self:SetScoreboardTitleC(Vector(data.ScoreboardTitleC), true)
	self:SetScoreboardBadges(tonumber(data.ScoreboardBadges), true)

	self:SetDonationAmount(tonumber(data.DonationAmount), true)

	self:SetLastNotesUpdate(tonumber(data.LastNotesUpdate), true)
	self:SetIsOOCMuted(tobool(data.IsOOCMuted), true)
	self:SetIsTravelBanned(tobool(data.IsTravelBanned), true)
end

net.Receive("nRequestPData", function(len, ply)
	if not ply.RequestedPData then

		ply:LoadPlayer(ply.SQLPlayerData)
		ply.RequestedPData = true

	end
end)

net.Receive("nSetCombineCamera", function(len, ply)
	local ent = net.ReadEntity()

	if IsValid(ent) then
		ply:SetCombineCamera(ent)
	end
end)

net.Receive("nResetCombineCamera", function(len, ply)
	ply:SetCombineCamera(NULL)
end)

net.Receive("nSetCharCreate", function(len, ply)
	local bool = net.ReadBool()

	ply.CharCreate = bool
end)

function meta:LoadCharacter(data)
	if self:CharID() != -1 then
		hook.Run("CC.SV.UnloadCharacter", self)
	end

	self.CharCreateCompleted = true
	self:Freeze(false)

	self:StripWeapons()
	self:ClearDrug()

	self:SetTeam(TEAM_CITIZEN)
	self:SetActiveFlag("")

	self:SetCharCreationDate(data.Date)

	self:SetCharID(tonumber(data.id))

	self:SetRPName(data.RPName)
	self:SetRPModel(data.Model)
	self:SetDescription(data.Title)

	self.CharModel = data.Model
	self.CharSkin = tonumber(data.Skin)

	self:SetTrait(tonumber(data.Trait))
	self:SetLang(tonumber(data.Lang))

	self:SetCID(data.CID)
	self:SetMoney(tonumber(data.Money))

	self:SetCharFlags(data.CharFlags)

	self:SetSpeed(tonumber(data.StatSpeed))
	self:SetStrength(tonumber(data.StatStrength))
	self:SetEndurance(tonumber(data.StatEndurance))
	self:SetAgility(tonumber(data.StatAgility))
	self:SetDexterity(tonumber(data.StatDexterity))

	self:SetLoan(tonumber(data.Loan))

	self:SetBusinessLicenses(tonumber(data.BusinessLicenses))

	self:SetCriminalRecord(data.CriminalRecord)

	-- FIXME: this is kind of a hack, the map should have a hook for this!
	-- if he's been in the city for long enough, he spawns normally
	-- print(util.TimeSinceDate(data.EntryTime))
	if GAMEMODE.CurrentLocation == LOCATION_CITY and util.TimeSinceDate(data.EntryTime) > 86400 then
		data.EntryPort = 1
		self:UpdateCharacterField("EntryPort", 1)
	end

	hook.Run("CC.SV.LoadCharacterData", self, data)

	self.EntryPort = tonumber(data.EntryPort)

	self:UpdateCharacterField("LastOnline", os.date("!%m/%d/%y %H:%M:%S"))

	hook.Run("CC.SH.LoadCharacter", self)

	net.Start("nLoadCharacter")
	net.Send(self)

	if self:IsBot() then return end

	self:SyncAllOtherData()

	self:PostLoadCharacter()

	self:Spawn()
end

function meta:PostLoadCharacter()
	GAMEMODE:WriteLog("character_loaded", {Ply = GAMEMODE:LogPlayer(self), Char = GAMEMODE:LogCharacter(self)})

	if not self:HasBadge(BADGE_BIRTHDAY) and os.date("!%m-%d") == "02-09" then

		self:SetScoreboardBadges(self:ScoreboardBadges() + BADGE_BIRTHDAY)
		self:UpdatePlayerField("ScoreboardBadges", self:ScoreboardBadges())

		self:AddMoney(400)
		self:UpdateCharacterField("Money", tostring(self:Money()))

		self:SendChat(nil, "INFO", "It's Gangleider's birthday today! You've been awarded 400 dollars and a badge!")

	end

	if self:HasBadge(BADGE_BIRTHDAY) and os.date("!%m-%d") != "02-09" then

		self:SetScoreboardBadges(self:ScoreboardBadges() - BADGE_BIRTHDAY)
		self:UpdatePlayerField("ScoreboardBadges", self:ScoreboardBadges())

	end

end

function GM:FindUseEntity(ply, ent)
	if ply:PassedOut() then return end
	if ply:TiedUp() and not (ent and ent:IsValid() and ent:IsVehicle()) then return end
	if ply:MountedGun() and ply:MountedGun():IsValid() then return ply:MountedGun() end

	return self.BaseClass:FindUseEntity(ply, ent)
end

function GM:PlayerUse(ply, ent)
	return self.BaseClass:PlayerUse(ply, ent)
end

function GM:KeyPress(ply, key)
	if key == IN_USE then
		local tr = self:GetHandTrace(ply, 100)

		if IsValid(tr.Entity) and tr.Entity:IsDoor() and tr.Entity:DoorType() == DOOR_COMBINEOPEN then
			tr.Entity:Fire("Open")
		end
	end
end

function GM:PlayerSay(ply, text, t)
	return ""
end

function ccCSay(ply, cmd, args, text)
	if ply:EntIndex() ~= 0 then return end

	text = string.Trim(text)

	GAMEMODE:SendChat(nil, player.GetAll(), "WARNING", text)
end
concommand.Add("csay", ccCSay)

function ccASay(ply, cmd, args, text)
	if ply:EntIndex() ~= 0 then return end

	text = string.Trim(text)

	if #text == 0 then return end

	local rf = {}

	for k, v in pairs(player.GetAll()) do

		if v:IsAdmin() then

			table.insert(rf, v)

		end

	end

	GAMEMODE:SendChat(nil, rf, "ADMIN", text)
end
concommand.Add("asay", ccASay)

function GM:PlayerDeathSound()
	return true
end

GM.BannedWeaponPickups = {
	"weapon_crowbar",
	"weapon_stunstick",
	"weapon_pistol",
	"weapon_smg1",
	"weapon_ar2",
	"weapon_shotgun",
	"weapon_crossbow",
	"weapon_357",
	"weapon_rpg",
	"weapon_annabelle",
}

function GM:PlayerCanPickupWeapon(ply, wep)
	if table.HasValue(self.BannedWeaponPickups, wep:GetClass()) then

		return false

	end

	return true
end

hook.Add("EntityTakeDamage", "SV.Player.EntityTakeDamage", function(ent, dmginfo)
	if ent:GetClass() == "prop_ragdoll" and IsValid(ent:PropFakePlayer()) then
		if ent:PropFakePlayer():IsEFlagSet(EFL_NOCLIP_ACTIVE) then
			return
		end

		if dmginfo:GetDamageType() == DMG_CRUSH then
			return
		end

		local pdmg = DamageInfo()
		pdmg:SetAttacker(dmginfo:GetAttacker())
		pdmg:SetDamage(dmginfo:GetDamage())
		pdmg:SetDamageForce(dmginfo:GetDamageForce())
		pdmg:SetDamagePosition(ent:GetPos())
		pdmg:SetInflictor(dmginfo:GetInflictor())

		ent:PropFakePlayer():TakeDamageInfo(pdmg)
	end

	if ent:IsVehicle() and IsValid(ent:GetDriver()) then
		if dmginfo:GetDamageType() == DMG_CRUSH then
			return
		end

		-- HACK! source appears to do some very strange fuckery with vehicle bullet damage
		if dmginfo:IsBulletDamage() and dmginfo:GetDamage() < 1 then
			dmginfo:ScaleDamage(10000)
		end

		local pdmg = DamageInfo()
		pdmg:SetAttacker(dmginfo:GetAttacker())
		pdmg:SetDamage(dmginfo:GetDamage())
		pdmg:SetDamageForce(dmginfo:GetDamageForce())
		pdmg:SetDamagePosition(ent:GetPos())
		pdmg:SetInflictor(dmginfo:GetInflictor())

		ent:GetDriver():TakeDamageInfo(pdmg)
	end

	local blacklist =
		DMG_BURN +
		DMG_FALL +
		DMG_SHOCK +
		DMG_DROWN +
		DMG_PARALYZE +
		DMG_NERVEGAS +
		DMG_POISON +
		DMG_ACID

	if ent:IsPlayer() and (ent:Team() == TEAM_SKYNET or bit.band(blacklist, dmginfo:GetDamageType()) ~= dmginfo:GetDamageType()) then
		if ent:IsEFlagSet(EFL_NOCLIP_ACTIVE) or ent:Team() == TEAM_UNASSIGNED then
			dmginfo:ScaleDamage(0)

			return
		end

		local armor = ent:BodyArmor()

		if armor > 0 then
			local dmg = dmginfo:GetDamage()
			local reduction = ent:GetCharFlagAttribute("DamageReduction") or 0
			local hitgroup = ent:LastHitGroup()

			if hitgroup == HITGROUP_HEAD then
				local item = ent:GetEquipment(EQUIPMENT_HEAD)

				if item then
					reduction = reduction + item:GetProperty("DamageReduction")
				end
			else
				for _, v in pairs({EQUIPMENT_CHEST, EQUIPMENT_EXO}) do
					local item = ent:GetEquipment(v)

					if item then
						reduction = reduction + item:GetProperty("DamageReduction")
					end
				end
			end

			if reduction > 0 then
				local weapon = dmginfo:GetAttacker().GetActiveWeapon and dmginfo:GetAttacker():GetActiveWeapon()

				if IsValid(weapon) and weapon.Plasma then
					reduction = reduction / 2
				end

				dmg = dmg * (1 - (reduction / 100))

				if dmg > armor then
					dmg = dmg - armor
					armor = 0
				else
					armor = armor - dmg
					dmg = 0
				end

				dmginfo:SetDamage(dmg)
				ent:SetBodyArmor(armor)
			end
		else
			ent.NextHealthRegen = CurTime() + 30
		end
	end

	if ent:IsNPC() and not dmginfo:GetAttacker():IsNPC() then
		ent:AddEntityRelationship(dmginfo:GetAttacker(), D_HT, 99)
	end

	if ent.NoDamage then
		dmginfo:ScaleDamage(0)

		return true
	end
end)

function GM:DoPlayerDeath(ply, attacker, dmg)
	if ply.Inventory then
		for _, v in pairs(ply.Inventory) do
			v:OnPlayerDeath(ply)
		end
	end

	if self.UntieOnDeath then
		ply:SetTiedUp(false)
	end

	if not ply:PassedOut() then
		ply:CreateRagdoll()
	end

	local func = ply:GetCharFlagAttribute("OnDeath")

	if func then
		func(ply)
	end

	if attacker and attacker:IsPlayer() and attacker ~= ply then
		local weapon = dmg:GetInflictor()

		if not IsValid(weapon) then
			return
		end

		if weapon:IsPlayer() then
			weapon = weapon:GetActiveWeapon():GetClass()
		else
			weapon = weapon:GetClass()
		end

		self:LogSQL(string.format("Player %s (%s) killed player %s (%s) with %s.", attacker:Nick(), attacker:SteamID(), ply:Nick(), ply:SteamID(), weapon))

		self:WriteLog("sandbox_kill", {
			Ply = GAMEMODE:LogPlayer(attacker),
			Char = GAMEMODE:LogCharacter(attacker),
			VictimPly = GAMEMODE:LogPlayer(ply),
			VictimChar = GAMEMODE:LogCharacter(ply),
			Weapon = weapon
		})
	end

	net.Start("nSetNightvision")
		net.WriteBit(0)
	net.Send(ply)

	hook.Run("CC.SV.PlayerDeath", ply)
end

function GM:PlayerSilentDeath(ply)
	if self.UntieOnDeath then

		ply:SetTiedUp(false)

	end
end

function GM:ScalePlayerDamage(ply, hitgroup, dmginfo)
	if ply:IsEFlagSet(EFL_NOCLIP_ACTIVE) or ply:Team() == TEAM_UNASSIGNED then

		dmginfo:ScaleDamage(0)
		return

	end

	if hitgroup == HITGROUP_HEAD then

		dmginfo:ScaleDamage(2)

	end

	if hitgroup == HITGROUP_LEFTARM or
		hitgroup == HITGROUP_RIGHTARM or
		hitgroup == HITGROUP_LEFTLEG or
		hitgroup == HITGROUP_RIGHTLEG or
		hitgroup == HITGROUP_GEAR then

		dmginfo:ScaleDamage(0.25)

	end


	if dmginfo:GetAttacker():IsNPC() then

		dmginfo:ScaleDamage(5) -- npcs do 5x dmg

	end
end

function GM:ScaleNPCDamage(ply, hitgroup, dmginfo)

	dmginfo:ScaleDamage(0.6) -- take less damage

	return self.BaseClass:ScaleNPCDamage(npc, hitgroup, dmginfo)
end

function GM:GetFallDamage(ply, speed)
	if ply:GetCharFlagAttribute("NoFallDamage") then
		return 0
	end

	return self.BaseClass:GetFallDamage(ply, speed)
end

function GM:CanPlayerSuicide(ply)
	if ply:CharID() == -1 then return false end
	if ply:TiedUp() then return false end
	if ply:PassedOut() then return false end
	if ply:MountedGun() and ply:MountedGun():IsValid() then return false end

	return true
end

function GM:PlayerShouldTakeDamage(ply, attacker)
	if attacker:GetClass() == "prop_physics" or attacker:GetClass() == "prop_ragdoll" or attacker:GetClass() == "cc_item" then return false end

	return true
end

function GM:EntityRemoved(ent)
	if ent:GetClass() == "prop_ragdoll" then

		for _, v in pairs(player.GetAll()) do

			if v:RagdollIndex() == ent:EntIndex() then

				v:SetRagdollIndex(-1)

			end

		end

		if ent:PropFakePlayer() and ent:PropFakePlayer():IsValid() and ent:PropFakePlayer():PassedOut() then

			ent:PropFakePlayer():Kill()

		end

	end
end

function GM:PlayerDisconnected(ply)
	for _, v in pairs(game.GetDoors()) do

		if table.HasValue(v:DoorOwners(), ply:CharID()) then

			if table.Count(v:DoorOwners()) == 1 then

				ply:SellDoor(v)

			else

				ply:RemoveDoorOwner(v)

			end

		end
	end

	if ply:Ragdoll() and ply:Ragdoll():IsValid() then

		ply:Ragdoll():Remove()

	end

	if ply:ToolTrust() == 0 and not ply:IsAdmin() then

		for _, v in pairs(ents.FindByClass("prop_physics")) do

			if ply:SteamID() == v:PropSteamID() and v:PropSaved() == 0 then

				v:Remove()

			end

		end

	end
end

function GM:ShutDown()
	GAMEMODE.IsShuttingDown = true

	for _, ply in pairs(player.GetAll()) do
		for _, v in pairs(game.GetDoors()) do
			if table.HasValue(v:DoorOwners(), ply:CharID()) then
				if table.Count(v:DoorOwners()) == 1 then
					ply:SellDoor(v)
				else
					ply:RemoveDoorOwner(v)
				end
			end
		end
	end

	hook.Run("CC.SV.ShutDown")
end

function GM:PlayerSpray(ply)
	return game.IsDedicated()
end

function GM:PlayerCanHearPlayersVoice(targ, ply)
	return not game.IsDedicated()
end

function GM:PlayerShouldTaunt(ply, act)
	return false
end

function GM:CanPlayerEnterVehicle(ply, vehicle, role)
	if self.BaseClass:CanPlayerEnterVehicle(ply, vehicle, role) then

		if vehicle.Static then

			vehicle.PlayerPos = ply:GetPos()
			vehicle.PlayerAngles = ply:EyeAngles()

		end

		if IsValid(vehicle:GetParent()) and vehicle:GetParent():GetClass() == "prop_physics" then

			if vehicle:GetParent():GetVelocity():Length2D() > 1 then return false end

			local trace = {}
			trace.start = vehicle:GetPos()
			trace.endpos = trace.start + Vector(0, 0, 64)
			trace.filter = {vehicle, vehicle:GetParent()}

			local tr = util.TraceLine(trace)

			if tr.Hit then return false end

			if vehicle.PhysgunActive or vehicle:GetParent().PhysgunActive then return false end

			vehicle:GetParent():GetPhysicsObject():EnableMotion(false)

		end

		return true

	end

	return false
end

function GM:CanExitVehicle(vehicle, ply)
	if vehicle.Static then

		vehicle.PlayerAngles = ply:EyeAngles()
		vehicle.PlayerAngles.r = 0

	end

	return self.BaseClass:CanExitVehicle(vehicle, ply)
end

function GM:PlayerLeaveVehicle(ply, vehicle)
	if vehicle.PlayerPos then

		ply:SetPos(vehicle.PlayerPos)

	end

	if vehicle.PlayerAngles then

		ply:SetEyeAngles(vehicle.PlayerAngles)

	end

	vehicle.PlayerPos = nil
end

hook.Add("CC.SV.PlayerThink", "SV.Player.DrownThink", function(ply)
	if not ply:Alive() then return end

	local waterlevel = 3
	local targ = ply

	if ply:PassedOut() then
		waterlevel = 1
		targ = ply:Ragdoll()
	end

	if targ:WaterLevel() < waterlevel then
		ply.AirFinished = CurTime() + 7

		if ply.DrownDamage and ply.DrownDamage > 0 then
			if not ply.PainFinished then
				ply.PainFinished = 0
			end

			if ply.PainFinished < CurTime() then
				ply.PainFinished = CurTime() + 1

				local dmg = DamageInfo()
				dmg:SetAttacker(game.GetWorld())
				dmg:SetDamage(10)
				dmg:SetDamageForce(Vector())
				dmg:SetDamagePosition(ply:GetPos())
				dmg:SetInflictor(game.GetWorld())
				dmg:SetDamageType(DMG_DROWN)

				GAMEMODE:EntityTakeDamage(ply, dmg)

				ply:SetHealth(ply:Health() + dmg:GetDamage())
				ply.DrownDamage = ply.DrownDamage - 10
			end
		end
	else
		if not ply:IsEFlagSet(EFL_NOCLIP_ACTIVE) and ply.AirFinished < CurTime() then
			if not ply.PainFinished then
				ply.PainFinished = 0
			end

			if ply.PainFinished < CurTime() then
				ply.PainFinished = CurTime() + 1

				local dmg = DamageInfo()
				dmg:SetAttacker(game.GetWorld())
				dmg:SetDamage(10)
				dmg:SetDamageForce(Vector())
				dmg:SetDamagePosition(ply:GetPos())
				dmg:SetInflictor(game.GetWorld())
				dmg:SetDamageType(DMG_DROWN)

				if not ply.DrownDamage then
					ply.DrownDamage = 0
				end

				ply.DrownDamage = math.min(ply.DrownDamage + 10, 50)
				ply:TakeDamageInfo(dmg)
			end
		end
	end
end)

function meta:HealOverTime(amount, rate, interval)
	self.HealRemaining = amount
	self.HealRate = rate
	self.HealInterval = interval
	self.NextHeal = CurTime()
end

hook.Add("CC.SV.PlayerThink", "SV.Player.HealThink", function(ply)
	if not ply.HealRemaining or ply.HealRemaining <= 0 then
		return
	end

	if ply:Health() >= ply:GetMaxHealth() or not ply:Alive() then
		ply.HealRemaining = 0

		return
	end

	if not ply.NextHeal or ply.NextHeal > CurTime() then
		return
	end

	local rate = ply.HealRate or 10 -- Amount of heals applied per tick
	local interval = ply.HealInterval or 1 -- Amount of seconds between each tick
	local amt = math.min(ply.HealRemaining, rate)

	ply.HealRemaining = ply.HealRemaining - amt
	ply.NextHeal = CurTime() + interval

	ply:SetHealth(math.min(ply:Health() + amt, ply:GetMaxHealth()))
end)

net.Receive("nSetTyping", function(len, ply)
	local val = net.ReadFloat()
	ply:SetTyping(val)
end)

net.Receive("nUpdateRecord", function(len, ply)
	if not GAMEMODE:LookupCombineFlag(ply:ActiveFlag()) then return end

	local text = net.ReadString()
	local targ = net.ReadEntity()

	text = string.sub(string.Trim(text), 1, 1024)

	GAMEMODE:LogCombine("[C] " .. ply:VisibleRPName() .. " set " .. targ:VisibleRPName() .. "'s criminal record to \"" .. text .. "\".", ply)

	targ:SetCriminalRecord(text)
	targ:UpdateCharacterField("CriminalRecord", text)
end)

net.Receive("nAddPrison", function(len, ply)
	if not GAMEMODE:LookupCombineFlag(ply:ActiveFlag()) then return end

	local targ = net.ReadEntity()
	local duration = net.ReadFloat() * 60
	local reason = net.ReadString()

	if duration < 1 * 60 or duration > 10 * 60 or #reason > 100 then return end

	GAMEMODE:LogCombine("[P] " .. ply:VisibleRPName() .. " imprisoned " .. targ:VisibleRPName() .. " for " .. string.ToMinutesSeconds(duration) .. " (\"" .. reason .. "\").", ply)

	targ:SetPrisonReason(reason)
	targ:SetPrisonReleaseTime(CurTime() + duration)
	targ:SetPrisonNotified(2)
	targ:SetArrester(ply:VisibleRPName())
end)

net.Receive("nRemovePrison", function(len, ply)
	if not GAMEMODE:LookupCombineFlag(ply:ActiveFlag()) then return end

	local targ = net.ReadEntity()

	GAMEMODE:LogCombine("[P] " .. ply:VisibleRPName() .. " released " .. targ:VisibleRPName() .. ".", ply)

	targ:SetPrisonReason("")
	targ:SetPrisonReleaseTime(0)
	targ:SetArrester("")
end)

hook.Add("CC.SV.PlayerThink", "SV.Player.PrisonThink", function(ply)
	if ply:PrisonNotified() == 2 and ply:PrisonReleaseTime() > 0 and math.ceil(ply:PrisonReleaseTime() - CurTime()) <= 30 then
		ply:SetPrisonNotified(1)

		local rf = {}

		for _, v in pairs(player.GetAll()) do
			-- if v:HasAnyCombineFlag() then
				table.insert(rf, v)
			-- end
		end

		net.Start("nPrisonNotify30")
			net.WriteEntity(ply)
		net.Send(rf)
	end

	if ply:PrisonNotified() == 1 and ply:PrisonReleaseTime() > 0 and math.ceil(ply:PrisonReleaseTime() - CurTime()) <= 0 then
		ply:SetPrisonNotified(0)

		local rf = {}

		for _, v in pairs(player.GetAll()) do
			-- if v:HasAnyCombineFlag() then
				table.insert(rf, v)
			-- end
		end

		net.Start("nPrisonNotify")
			net.WriteEntity(ply)
		net.Send(rf)
	end
end)

function GM:PlayerButtonDown(ply, button)
	ply.AFKTime = CurTime()

	self.BaseClass:PlayerButtonDown(ply, button)
end

hook.Add("CC.SV.PlayerThink", "SV.Player.AFKThink", function(ply)
	if GAMEMODE.AFKKickerEnabled and CurTime() - (ply.AFKTime or 0) > GAMEMODE.AFKTime and (#player.GetAll() / game.MaxPlayers()) > GAMEMODE.AFKPercentage and ply:DonationAmount() == 0 and not ply:IsAdmin() and not ply:IsEventCoordinator() then

		ply:Kick("Auto-kicked for being AFK")
	end
end)

local function RollDice(ply, cmd, args)
	local errmessage = "rp_roll NdX+m -- N = # of dice, X = # of sides on dice, m = optional modifier\ne.g. rp_roll 2d20-4 will roll two d20's with a -4 modifier.\n"
	local num, sides, sign, mod

	if not args[1] then
		ply:PrintMessage(HUD_PRINTCONSOLE, errmessage)
		return
	end

	num, sides, sign, mod = string.match(args[1], "^ *(%d+)d(%d+) *([%+%-]?) *(%d*) *$")
	num, sides, mod = tonumber(num), tonumber(sides), tonumber(mod)

	if not (num and sides) then
		ply:PrintMessage(HUD_PRINTCONSOLE, errmessage)
		return
	end

	if num > 10 then
		ply:PrintMessage(HUD_PRINTCONSOLE, "Why would you need to roll more than 10 dice at once?\n")
		return
	end

	if sides > 1000 then
		ply:PrintMessage(HUD_PRINTCONSOLE, "How could you possibly roll a dice with that many sides?\n")
		return
	end

	local results, total = {}, 0
	for i = 1, num do
		local roll = math.random(sides)
		total = total + roll
		results[i] = roll
	end

	local mult, output
	local str = table.concat(results, " + ")

	if #sign > 0 and mode ~= 0 then
		mult = tonumber(sign .. mod)
		total = total + mult
		output = string.format("%s rolled %id%i%s%i: (%s) %s %i = %i", ply:VisibleRPName(), num, sides, sign, mod, str, sign, mod, total)
	else
		output = string.format("%s rolled %id%i: (%s) = %i", ply:VisibleRPName(), num, sides, str, total)
	end

	local rf = ply:GetRF(450, 450)
	GAMEMODE:SendChat(nil, rf, "WARNING", output)
end
concommand.Add("rp_roll", RollDice)

function meta:SetEquipment(slot, item)
	if item then
		self.Equipment[slot] = item

		net.Start("nSetEquipment")
			net.WriteEntity(self)
			net.WriteUInt(slot, 8)
			net.WriteUInt(item.ID, 32)
		net.Send(item:GetUpdateTargets())
	else
		self.Equipment[slot] = nil

		net.Start("nUnsetEquipment")
			net.WriteEntity(self)
			net.WriteUInt(slot, 8)
		net.Broadcast()
	end
end