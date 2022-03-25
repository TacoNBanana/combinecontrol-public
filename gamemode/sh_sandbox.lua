local meta = FindMetaTable("Entity")
local pmeta = FindMetaTable("Player")

GM.PropAccessors = {
	{"Creator", 	"String",	""},
	{"SteamID", 	"String",	""},
	{"FakePlayer", "Entity",	NULL},
	{"Saved", 		"Float",	0},
	{"Description",	"String", ""}
}

for k, v in pairs(GM.PropAccessors) do

	meta["SetProp" .. v[1]] = function(self, val)
		if CLIENT then return end

		if self["Prop" .. v[1] .. "Val"] == val then return end

		self["Prop" .. v[1] .. "Val"] = val

		net.Start("nSetProp" .. v[1])
			net.WriteEntity(self)
			net["Write" .. v[2]](val)
		net.Broadcast()

	end

	meta["Prop" .. v[1]] = function(self)

		if self["Prop" .. v[1] .. "Val"] == false then

			return false

		end

		return self["Prop" .. v[1] .. "Val"] or v[3]

	end

	if SERVER then

		util.AddNetworkString("nSetProp" .. v[1])

	else

		local function nRecvData(len)

			local prop = net.ReadEntity()
			local val = net["Read" .. v[2]]()

			if prop and prop:IsValid() then

				prop["Prop" .. v[1] .. "Val"] = val

			end

		end
		net.Receive("nSetProp" .. v[1], nRecvData)

	end
end

function meta:InitializePropAccessors()
	for _, v in pairs(GAMEMODE.PropAccessors) do

		self[v[1] .. "Val"] = v[3]

	end
end

function meta:SyncPropData(ply)
	for _, n in pairs(GAMEMODE.PropAccessors) do

		net.Start("nSetProp" .. n[1])
			net.WriteEntity(self)
			net["Write" .. n[2]](self["Prop" .. n[1]](self))
		net.Send(ply)

	end
end

if SERVER then
	net.Receive("nSetPropDesc", function(len, ply)
		local MAX_CHARS = 140

		local ent = net.ReadEntity()
		local description = string.Trim(net.ReadString())

		if #description > MAX_CHARS then
			net.Start("nPropDescTooLong")
				net.WriteFloat(MAX_CHARS)
			net.Send(ply)
		else
			if IsValid(ent) then
				GAMEMODE:WriteLog("sandbox_propdesc", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Ent = tostring(ent), Before = ent:PropDescription(), After = description})
				ent:SetPropDescription(description)
			end
		end
	end)
end

net.Receive("nPropDescTooLong", function (len)
	if SERVER then return end

	local maxChars = net.ReadFloat()
	GAMEMODE:AddChat("Prop descriptions are limited to " .. maxChars, Color(200, 0, 0, 255))
end)

net.Receive("nRequestPropData", function(len, ply)
	if CLIENT then return end

	local ent = net.ReadEntity()

	ent:SyncPropData(ply)
end)

GM.PropBlacklist = {
	"*models/maxofs2d/",
	"*models/balloons/",
	"*models/perftest/",
	"*models/props_explosive/",
	"*models/props_phx/[^/]+%.mdl",
	"*models/props_phx/huge/",
	"*models/props_phx/misc/",
	"*models/props_phx/trains/",
	"*models/shadertest/",
	"models/combine_room/combine_monitor002.mdl",
	"models/combine_room/combine_monitor003a.mdl",
	"models/cranes/crane_frame.mdl",
	"models/props_c17/oildrum001_explosive.mdl",
	"models/props_c17/metalladder003.mdl",
	"models/props_c17/furniturechair001a.mdl",
	"models/props_combine/breen_tube.mdl",
	"models/props_combine/combine_bunker01.mdl",
	"models/props_combine/combine_tptimer.mdl",
	"models/props_combine/prison01.mdl",
	"models/props_combine/prison01c.mdl",
	"models/props_combine/prison01b.mdl",
	"models/props_junk/gascan001a.mdl",
	"models/props_junk/propane_tank001a.mdl",
	"models/props_canal/canal_bridge01.mdl",
	"models/props_canal/canal_bridge02.mdl",
	"models/props_canal/canal_bridge03a.mdl",
	"models/vehicles/car001b_hatchback.mdl",
	"models/props_phx/amraam.mdl",
	"models/props_phx/ball.mdl",
	"models/props_phx/mk-82.mdl",
	"models/props_phx/oildrum001_explosive.mdl",
	"models/props_phx/torpedo.mdl",
	"models/props_phx/ww2bomb.mdl"
}

GM.PropWhitelist = {
	"models/props_c17/furniturestove001a.mdl",
}

GM.ToolTrustBasic = {
	"weld",
	"nocollide",
	"remover",
	"camera",
	"colour",
	"material",
	"rope",
	"winch",
	"ballsocket",
	"nocollideworld",
	"door",
	"button"
}

GM.ToolTrustEventManager = {
	"particlecontrol",
	"particlecontrol_tracer"
}

GM.ToolTrustBlacklist = {
	"duplicator",
	"balloon",
	"dynamite",
	"eyeposer",
	"faceposer",
	"finger",
	"inflator",
	"trails",
	"creator",
	"rb655_easy_inspector",
	"rb655_easy_bodygroup",
	"particlecontrol_proj",
	"streamradio_gui_color_global",
	"streamradio_gui_color_individual",
	"streamradio_gui_skin"
}

GM.SandboxBlacklist = {
	"prop_door_rotating",
	"func_door_rotating",
	"func_door",
	"func_monitor",
	"func_brush",
	"func_detail",
	"func_lod",
	"prop_dynamic",
	"prop_dynamic_override",
	"func_breakable",
	"func_movelinear",
	"func_button",
	"func_breakable_surf",
	"env_headcrabcanister",
}

function GM:LimitReachedProcess(ply, str)
	if game.SinglePlayer() then return true end

	if not IsValid(ply) then
		return true
	end

	local c = cvars.Number("sbox_max" .. str, 0)

	if str == "props" then
		if ply:ToolTrust() == 1 then c = c * 2 end
		if ply:ToolTrust() == 2 then c = c * 5 end
	end

	if ply:GetCount(str) < c or c < 0 then return true end

	ply:LimitHit(str)

	return false
end

function GM:CanDrive(ply, ent)
	return false
end

function GM:ContextMenuOpen()
	return LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():GetClass() == "gmod_tool" and not CCP.ContextMenu
end

function GM:PlayerGiveSWEP(ply, weapon, info)
	return ply:IsSuperAdmin()
end

function GM:PlayerSpawnedRagdoll(ply, model, ent)
	ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function GM:PlayerSpawnedProp(ply, model, ent)
	if not table.HasValue(self.PropWhitelist, string.lower(model)) then
		if not ply:IsAdmin() and ent:BoundingRadius() > 800 and ply:ToolTrust() == 2 then
			self:LogSandbox("[S] " .. ply:VisibleRPName() .. " tried to spawn prop " .. model .. ", but it was too big (" .. math.Round(ent:BoundingRadius()) .. " > 800).", ply)

			ent:Remove()

			net.Start("nAddNotification")
				net.WriteString("That prop is too big.")
			net.Send(ply)

			return false
		end

		if not ply:IsAdmin() and ent:BoundingRadius() > 200 and ply:ToolTrust() == 1 then
			self:LogSandbox("[S] " .. ply:VisibleRPName() .. " tried to spawn prop " .. model .. ", but it was too big (" .. math.Round(ent:BoundingRadius()) .. " > 200).", ply)

			ent:Remove()

			net.Start("nAddNotification")
				net.WriteString("That prop is too big.")
			net.Send(ply)

			return false
		end

		if not ply:IsAdmin() and ent:BoundingRadius() > 100 and ply:ToolTrust() == 0 then
			self:LogSandbox("[S] " .. ply:VisibleRPName() .. " tried to spawn prop " .. model .. ", but it was too big (" .. math.Round(ent:BoundingRadius()) .. " > 100).", ply)

			ent:Remove()

			net.Start("nAddNotification")
				net.WriteString("That prop is too big.")
			net.Send(ply)

			return false
		end
	end

	if ply:ToolTrust() < 1 and not ply:IsAdmin() then
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end

	ent:SetPropCreator(ply:VisibleRPName())
	ent:SetPropSteamID(ply:SteamID())

	return self.BaseClass:PlayerSpawnedProp(ply, model, ent)
end

function GM:PlayerSpawnEffect(ply, model)
	if ply:IsAdmin() then
		if SERVER then
			self:WriteLog("sandbox_spawn_generic", {Char = self:LogCharacter(ply), Ply = self:LogPlayer(ply), Mdl = model})
			self:LogSandbox("[E] " .. ply:VisibleRPName() .. " spawned effect " .. model .. ".", ply)
		end

		return true
	end

	if ply:PassedOut() then return false end
	if ply:TiedUp() then return false end
	if ply:MountedGun() and ply:MountedGun():IsValid() then return false end

	if ply:PropTrust() == 0 then return false end

	if ply:ToolTrust() < 2 then
		if not ply.NextPropSpawn then ply.NextPropSpawn = 0 end
		if CurTime() < ply.NextPropSpawn then return false end
		ply.NextPropSpawn = CurTime() + 1
	end

	if not ply:Alive() then return false end

	if ply:DonatorActive() or self:LimitReachedProcess(ply, "effects") then
		if SERVER then
			self:WriteLog("sandbox_spawn_generic", {Char = self:LogCharacter(ply), Ply = self:LogPlayer(ply), Mdl = model})
			self:LogSandbox("[E] " .. ply:VisibleRPName() .. " spawned effect " .. model .. ".", ply)
		end

		return true
	end

	return false
end

function GM:PlayerSpawnNPC(ply, npctype, weapon)
	if ply:IsAdmin() then
		if SERVER then
			self:WriteLog("sandbox_spawn_npc", {Char = self:LogCharacter(ply), Ply = self:LogPlayer(ply), Class = npctype})
			self:LogSandbox("[N] " .. ply:VisibleRPName() .. " spawned NPC " .. npctype .. ".", ply)
		end

		return true
	end

	return false
end

function GM:PlayerSpawnObject(ply, model, skin)
	return self.BaseClass:PlayerSpawnObject(ply, model, skin)
end

function GM:PlayerSpawnProp(ply, model)
	model = model:lower():gsub("\\", "/")

	if ply:IsAdmin() then
		if SERVER then
			self:WriteLog("sandbox_spawn_generic", {Char = self:LogCharacter(ply), Ply = self:LogPlayer(ply), Mdl = model})
			self:LogSandbox("[S] " .. ply:VisibleRPName() .. " spawned prop " .. model .. ".", ply)
		end

		return true
	end

	if ply:PassedOut() then return false end
	if ply:TiedUp() then return false end
	if ply:MountedGun() and ply:MountedGun():IsValid() then return false end

	if ply:PropTrust() == 0 then return false end

	if ply:ToolTrust() < 2 then
		if not ply.NextPropSpawn then ply.NextPropSpawn = 0 end
		if CurTime() < ply.NextPropSpawn then return false end
		ply.NextPropSpawn = CurTime() + 1
	end

	if table.HasValue(self.PropBlacklist, string.lower(model)) then
		if CLIENT then
			GAMEMODE:AddNotification("That prop is banned.")
		end

		return false
	end

	for _, v in pairs(self.PropBlacklist) do
		if string.find(v, "*") == 1 and string.find(string.lower(model), string.sub(v, 2), nil, true) then
			if CLIENT then
				GAMEMODE:AddNotification("That prop is banned.")
			end

			return false
		end
	end

	if not ply:Alive() then return false end

	if ply:DonatorActive() or self:LimitReachedProcess(ply, "props") then
		if SERVER then
			self:WriteLog("sandbox_spawn_generic", {Char = self:LogCharacter(ply), Ply = self:LogPlayer(ply), Mdl = model})
			self:LogSandbox("[S] " .. ply:VisibleRPName() .. " spawned prop " .. model .. ".", ply)
		end

		return true
	end

	return false
end

function GM:PlayerSpawnRagdoll(ply, model)
	if ply:IsAdmin() then
		if SERVER then
			self:WriteLog("sandbox_spawn_generic", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Mdl = model})
			self:LogSandbox("[R] " .. ply:VisibleRPName() .. " spawned ragdoll " .. model .. ".", ply)
		end

		return true
	end

	if ply:PassedOut() then return false end
	if ply:TiedUp() then return false end
	if ply:MountedGun() and ply:MountedGun():IsValid() then return false end

	if ply:DonatorActive() or self:LimitReachedProcess(ply, "ragdolls") then
		if SERVER then
			self:WriteLog("sandbox_spawn_generic", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Mdl = model})
			self:LogSandbox("[R] " .. ply:VisibleRPName() .. " spawned ragdoll " .. model .. ".", ply)
		end

		return true
	end

	return false
end

local whitelist = {
	["lunasflightschool_ah6"] = "2",
	["merydianlfs_uh1h"] = "2"
}

function GM:PlayerSpawnSENT(ply, class)
	local whitelisted = false

	if whitelist[class] then
		whitelisted = ply:HasPlayerFlag(whitelist[class])
	end

	if ply:IsAdmin() or whitelisted then
		if SERVER then
			self:WriteLog("sandbox_spawn_entity", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Class = class})
			self:LogSandbox("[E] " .. ply:VisibleRPName() .. " spawned entity " .. class .. ".", ply)
		end

		return true
	end

	return false
end

function GM:PlayerSpawnSWEP(ply, class, info)
	if not ply:IsAdmin() then
		return false
	end

	if SERVER then
		self:WriteLog("sandbox_spawn_weapon", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Class = class})
		self:LogSandbox("[W] " .. ply:VisibleRPName() .. " spawned SWEP " .. class .. ".", ply)
	end

	return true
end

function GM:PlayerSpawnVehicle(ply, model, name, tab)
	if ply:IsAdmin() or ply:HasPlayerFlag("1") then
		if SERVER then
			self:WriteLog("sandbox_spawn_vehicle", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Type = name})
			self:LogSandbox("[V] " .. ply:VisibleRPName() .. " spawned vehicle " .. name .. ".", ply)

		end

		return true
	end

	return false
end

function GM:NoToolLog(ply, tr, tool)
	if tool == "paint" then return true end
	if tool == "duplicator" then return true end
	if tool == "creator" then return true end

	if tool == "remover" and tr.Entity == game.GetWorld() then
		return true
	end

	if IsValid(tr.Entity) then
		local c = tr.Entity:GetClass()

		if c == "gmod_" .. tool then
			return true
		end
	end

	return false
end

function GM:CanTool(ply, tr, tool)
	local ent = tr.Entity

	if (ply:IsDeveloper() and IsValid(ent) and ent:IsPlayer()) and tool == "remover" then
		local ed = EffectData()
			ed:SetEntity(ent)
		util.Effect("entity_remove", ed, true, true)

		ply:GetActiveWeapon():EmitSound(Sound("Airboat.FireGunRevDown"))
		ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		ply:SetAnimation(PLAYER_ATTACK1)

		local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetNormal(tr.HitNormal)
			effectdata:SetEntity(ent)
			effectdata:SetAttachment(tr.PhysicsBone)
		util.Effect("selection_indicator", effectdata)

		effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetStart(ply:GetShootPos())
			effectdata:SetAttachment(1)
			effectdata:SetEntity(ply:GetActiveWeapon())
		util.Effect("ToolTracer", effectdata)

		if SERVER then
			local nick = ent:VisibleRPName()

			ent:Kick("Kicked by " .. ply:Nick())

			GAMEMODE:LogAdmin("[K] " .. ply:Nick() .. " removed player " .. nick .. ".", ply)

			net.Start("nARemove")
				net.WriteString(nick)
				net.WriteEntity(ply)
			net.Broadcast()
		end

		return true
	end

	if ent.CanTool and not ent:CanTool(ply) then
		return false
	end

	if ent:PropSaved() == 1 then return false end
	if table.HasValue(self.SandboxBlacklist, ent:GetClass()) and not ent.BlacklistException then return false end
	if ent:IsVehicle() and ent.Static then return false end

	if ply:IsAdmin() then
		if SERVER then
			if tool == "remover" and IsValid(ent) and ent:GetClass() == "cc_item" and ent.Item then
				GAMEMODE:WriteLog("item_destroy", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Item = GAMEMODE:LogItem(ent.Item)})
			end

			if self:NoToolLog(ply, tr, tool) then return true end

			GAMEMODE:WriteLog("sandbox_tool", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Tool = tool, Ent = tostring(tr.Entity)})
			self:LogSandbox("[T] " .. ply:VisibleRPName() .. " used tool " .. tool .. " on " .. ent:GetClass() .. ".", ply)
		end

		return true
	end

	if ent:IsPlayer() then return false end
	if ent:IsNPC() then return false end
	if ent:GetClass() == "prop_vehicle_apc" then return false end
	if string.find(ent:GetClass(), "wac_*") then return ply:IsAdmin() end

	if ply:PassedOut() then return false end
	if ply:TiedUp() then return false end
	if IsValid(ply:MountedGun()) then return false end

	if ply:ToolTrust() == 0 then return false end

	if table.HasValue(self.ToolTrustBlacklist, tool) then return false end
	if table.HasValue(self.ToolTrustEventManager, tool) and not ply:HasPlayerFlag("0") then return false end

	if ply:ToolTrust() == 1 and not table.HasValue(self.ToolTrustBasic, tool) then return false end

	if ply:ToolTrust() < 2 and ent:PropSteamID() and ent:PropSteamID() != ply:SteamID() then
		local tab = {}

		for _, v in pairs(player.GetAll()) do
			if v:SteamID() == ent:PropSteamID() then
				tab = v:PropProtection()
			end
		end

		if not table.HasValue(tab, ply) then return false end
	end

	if tool == "remover" and IsValid(ent) and ent:GetClass() == "prop_ragdoll" and IsValid(ent:PropFakePlayer()) then return false end

	if self.BaseClass:CanTool(ply, tr, tool) then
		if SERVER then
			if tool == "remover" and IsValid(ent) and ent:GetClass() == "cc_item" and ent.Item then
				GAMEMODE:WriteLog("item_destroy", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Item = GAMEMODE:LogItem(ent.Item)})
			end

			if self:NoToolLog(ply, tr, tool) then return true end

			GAMEMODE:WriteLog("sandbox_tool", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Tool = tool, Ent = tostring(tr.Entity)})
			self:LogSandbox("[T] " .. ply:VisibleRPName() .. " used tool " .. tool .. " on " .. tr.Entity:GetClass() .. ".", ply)
		end

		return true
	end

	return false
end

function GM:OnPhysgunFreeze(wep, phys, ent, ply)
	if table.HasValue(self.SandboxBlacklist, ent:GetClass()) and not ent.BlacklistException then return false end
	if ent:IsVehicle() and ent.Static then return false end
	if ent.CanPhysgun and not ent:CanPhysgun(ply) then return false end

	if ent:PropSaved() == 1 then return false end

	if ent.Chairs then
		for _, v in pairs(ent.Chairs) do
			if v:GetPassenger(0) != NULL then
				return false
			end
		end
	end

	if ply:IsAdmin() then return self.BaseClass:OnPhysgunFreeze(wep, phys, ent, ply) end

	if ent:IsNPC() then return false end
	if ent:GetClass() == "prop_vehicle_apc" then return false end
	if ent:IsPlayer() then return false end

	if ply:PhysTrust() == 0 then return false end

	if ply:ToolTrust() < 2 and ent:PropSteamID() and ent:PropSteamID() != ply:SteamID() then
		local tab = {}

		for _, v in pairs(player.GetAll()) do
			if v:SteamID() == ent:PropSteamID() then
				tab = v:PropProtection()
			end
		end

		if not table.HasValue(tab, ply) then return false end
	end

	return self.BaseClass:OnPhysgunFreeze(wep, phys, ent, ply)
end

function GM:OnPhysgunReload(physgun, ply)
	local trace = {}
	trace.start = ply:GetShootPos()
	trace.endpos = ply:GetEyeTrace().HitPos
	trace.filter = {physgun, ply}
	local tr = util.TraceLine(trace)

	local ent = tr.Entity

	if ent and ent:IsValid() then
		if table.HasValue(self.SandboxBlacklist, ent:GetClass()) and not ent.BlacklistException then return false end
		if ent:IsVehicle() and ent.Static then return false end
		if ent.CanPhysgun and not ent:CanPhysgun(ply) then return false end

		if ent:PropSaved() == 1 then return false end

		if ent.Chairs then
			for _, v in pairs(ent.Chairs) do
				if v:GetPassenger(0) != NULL then
					return false
				end
			end
		end

		if ply:IsAdmin() then return self.BaseClass:OnPhysgunReload(physgun, ply) end

		if ply:PhysTrust() == 0 then return false end

		if ply:ToolTrust() < 2 and ent:PropSteamID() != ply:SteamID() and (not ent:PropFakePlayer() or ent:PropFakePlayer() == NULL) then
			local tab = {}

			for _, v in pairs(player.GetAll()) do
				if v:SteamID() == ent:PropSteamID() then
					tab = v:PropProtection()
				end
			end

			if not table.HasValue(tab, ply) then return false end
		end
	end

	local ret = self.BaseClass:OnPhysgunReload(physgun, ply)

	if ret then
		ent.PhysgunActive = false

		return true
	end

	return false
end

function GM:PhysgunPickup(ply, ent)
	if ent:PropSaved() == 1 then return false end
	if ent:IsVehicle() and ent.Static then return false end
	if table.HasValue(self.SandboxBlacklist, ent:GetClass()) and not ent.BlacklistException then return false end
	if ent.CanPhysgun and not ent:CanPhysgun(ply) then return false end

	if ent.Chairs then
		for _, v in pairs(ent.Chairs) do
			if v:GetPassenger(0) != NULL then
				return false
			end
		end
	end

	if ply:IsAdmin() and self.BaseClass:PhysgunPickup(ply, ent) then
		ent.PhysgunActive = true

		return true
	end

	if ent:IsPlayer() then
		if ply:IsAdmin() then
			if ent:IsAdmin() and not ply:IsSuperAdmin() then
				return false
			else
				ent:SetMoveType(MOVETYPE_NOCLIP)

				return true
			end
		else
			return false
		end

	end

	if ent:IsNPC() then return false end
	if ent:GetClass() == "prop_vehicle_apc" then return false end

	if ply:PhysTrust() == 0 then return false end

	if ply:ToolTrust() < 2 and ent:PropSteamID() != ply:SteamID() and (not ent:PropFakePlayer() or ent:PropFakePlayer() == NULL) then
		local tab = {}

		for _, v in pairs(player.GetAll()) do
			if v:SteamID() == ent:PropSteamID() then
				tab = v:PropProtection()
			end
		end

		if not table.HasValue(tab, ply) then return false end
	end

	if ply:ToolTrust() == 0 and ent:GetPos():Distance(ply:GetPos()) > 300 then return false end

	local ret = self.BaseClass:PhysgunPickup(ply, ent)

	if ret then
		ent.PhysgunActive = true

		return true
	end
end

function GM:PhysgunDrop(ply, ent)
	self.BaseClass:PhysgunDrop(ply, ent)

	if not ply:IsAdmin() then
		ent:SetVelocity(Vector())
	end

	if ent:IsPlayer() then
		ent:SetMoveType(MOVETYPE_WALK)
	end

	ent.PhysgunActive = false

	return true
end

function GM:CanPlayerUnfreeze(ply, ent, phys)
	if table.HasValue(self.SandboxBlacklist, ent:GetClass()) and not ent.BlacklistException then return false end
	if ent.CanPhysgun and not ent:CanPhysgun(ply) then return false end

	if ent:PropSaved() == 1 then return false end

	if ent.Chairs then
		for _, v in pairs(ent.Chairs) do
			if v:GetPassenger(0) != NULL then
				return false
			end
		end
	end

	if ply:IsAdmin() then return self.BaseClass:CanPlayerUnfreeze(ply, ent, phys) end

	if ply:PhysTrust() == 0 then return false end

	if ply:ToolTrust() < 2 and ent:PropSteamID() != ply:SteamID() and (not ent:PropFakePlayer() or ent:PropFakePlayer() == NULL) then
		local tab = {}

		for _, v in pairs(player.GetAll()) do
			if v:SteamID() == ent:PropSteamID() then
				tab = v:PropProtection()
			end
		end

		if not table.HasValue(tab, ply) then return false end
	end

	return self.BaseClass:CanPlayerUnfreeze(ply, ent, phys)
end

function GM:GravGunPunt(ply, ent)
	return ply:IsDeveloper()
end

local blacklist = {
	["persist"] = true,
	["drive"] = true,
	["bonemanipulate"] = true,
	["remove"] = true,
	["npc_bigger"] = true,
	["npc_smaller"] = true
}

function GM:CanProperty(ply, prop, ent)
	if not ply:IsAdmin() then
		return false
	end

	if ent:PropSaved() == 1 then
		return false
	end

	if blacklist[prop] then
		return false
	end

	return true
end

function GM:SaveLootPoints()
	local text = ""

	for _, v in pairs(ents.FindByClass("cc_loot")) do
		text = text .. util.TableToJSON({
			Pos = v:GetPos(),
			Ang = v:GetAngles(),
			Mdl = v:GetModel(),
			Pool = v:GetLootPool()
		}) .. "\n"
	end

	file.Write("combinecontrol/loot/" .. self:GetMapRedirect() .. ".txt", text)
end

function GM:SpawnLootPoints()
	local str = file.Read("combinecontrol/loot/" .. self:GetMapRedirect() .. ".txt")

	if not str then
		return
	end

	local tab = string.Explode("\n", str)

	for _, v in pairs(tab) do
		local data = util.JSONToTable(v)

		if not data then
			continue
		end

		local ent = ents.Create("cc_loot")

		ent:SetModel(data.Mdl)
		ent:SetPos(data.Pos)
		ent:SetAngles(data.Ang)

		ent:Spawn()
		ent:Activate()

		ent:RegisterWithLootPool(data.Pool)
	end
end

local classes = {
	["prop_physics"] = true,
	["prop_effect"] = true
}

local function save(tab, ent)
	local data = {}
	local mdl = ent

	data.Class = ent:GetClass()

	if data.Class == "prop_effect" then
		mdl = ent.AttachedEntity
	end

	data.Model = mdl:GetModel()
	data.Skin = mdl:GetSkin()

	data.Pos = ent:GetPos()
	data.Ang = ent:GetAngles()

	data.CollisionGroup = ent:GetCollisionGroup()

	data.RenderMode = mdl:GetRenderMode()
	data.RenderFX = mdl:GetRenderFX()

	data.Color = mdl:GetColor()

	local mat = mdl:GetMaterial()

	if mdl.MaterialData then
		data.AdvancedMaterialData = mdl.MaterialData
	else
		if #mat > 0 then
			data.Material = mat
		else
			local tab = {}
			local found = false

			for i = 0, 31 do
				local submat = mdl:GetSubMaterial(i)

				if #submat > 0 then
					tab[i] = submat
					found = true
				end
			end

			if found then
				data.SubMaterials = tab
			end
		end
	end

	data.SteamID = ent:PropSteamID()
	data.PlayerName = ent:PropCreator()
	data.Description = ent:PropDescription()

	table.insert(tab, data)
end

function GM:GetPermaPropFile()
	return string.format("combinecontrol/savedprops/v3/%s.txt", self:GetMapRedirect())
end

function GM:SaveSavedProps()
	local data = {}

	for _, ent in ipairs(ents.GetAll()) do
		if ent:PropSaved() == 0 or not classes[ent:GetClass()] then continue end

		save(data, ent)
	end

	file.Write(self:GetPermaPropFile(), pon.encode(data))
end

function GM:SpawnSavedProps()
	local contents = file.Read(self:GetPermaPropFile(), "DATA")

	if not contents or #contents == 0 then
		return
	end

	local entities = pon.decode(contents)

	if not entities then
		return
	end

	for _, data in next, entities do
		if not classes[data.Class] then continue end

		local ent = ents.Create(data.Class)

		if string.StartWith(data.Class, "prop") then
			ent:SetModel(data.Model)
			ent:SetSkin(data.Skin)
		end

		ent:SetPos(data.Pos)
		ent:SetAngles(data.Ang)

		ent:Spawn()
		ent:Activate()

		local phys = ent:GetPhysicsObject()

		if IsValid(phys) then
			phys:EnableMotion(false)
			phys:Sleep()
		end

		local mdl = data.Class == "prop_effect" and ent.AttachedEntity or ent

		ent:SetCollisionGroup(data.CollisionGroup)

		mdl:SetRenderMode(data.RenderMode)
		mdl:SetRenderFX(data.RenderFX)

		mdl:SetColor(data.Color)

		if data.AdvancedMaterialData and materials then
			local texture = data.AdvancedMaterialData.texture
			data.AdvancedMaterialData.texture = nil

			materials:Set(mdl, string.Trim(texture):lower(), data.AdvancedMaterialData)
		else
			if data.Material then
				mdl:SetMaterial(data.Material)
			elseif data.SubMaterials then
				for index, mat in pairs(data.SubMaterials) do
					mdl:SetSubMaterial(index, mat)
				end
			end
		end

		ent:SetPropSteamID(data.SteamID)
		ent:SetPropCreator(data.PlayerName)
		ent:SetPropDescription(data.Description)
		ent:SetPropSaved(1)
	end
end

function GM:PostCleanupMap()
	if SERVER then
		self:InitPostEntity()

		for _, v in pairs(player.GetAll()) do
			self:PlayerLoadout(v)
			self:PlayerCheckInventory(v)
		end
	end
end

local V = {
				-- Required information
				Name = "Jeep (+Gun)",
				Class = "prop_vehicle_jeep_old",
				Category = "Half-Life 2",

				-- Optional information
				Author = "VALVe",
				Information = "The regular old jeep",
				Model = "models/buggy.mdl",

				KeyValues = {
								vehiclescript	=	"scripts/vehicles/jeep_test.txt",
								EnableGun 		=	"1"
							}
			}

list.Set("Vehicles", "Jeep (+Gun)", V)

local V = {
				-- Required information
				Name = "Airboat (+Gun)",
				Class = "prop_vehicle_airboat",
				Category = "Half-Life 2",

				-- Optional information
				Author = "VALVe",
				Information = "Airboat from Half-Life 2",
				Model = "models/airboat.mdl",

				KeyValues = {
								vehiclescript	=	"scripts/vehicles/airboat.txt",
								EnableGun 		=	"1"
							}
			}

list.Set("Vehicles", "Airboat (+Gun)", V)

if CLIENT then

	language.Add("Prop_Protection", "Prop Protection")
	language.Add("Prop_Protection_Edit", "Edit Prop Protection")
	language.Add("Prop_Protection.EditHeader", "Edit your prop protection whitelist.")

	function GM:AddToolMenuTabs()
		self.BaseClass:AddToolMenuTabs()

		spawnmenu.AddToolTab("Prop Protection", "#Prop_Protection", "icon16/user.png")
	end

	function GM:AddToolMenuCategories()
		self.BaseClass:AddToolMenuCategories()

		spawnmenu.AddToolCategory("Prop Protection", "Prop Protection", "#Prop_Protection")
	end

	local function Prop_Protection_Edit(CPanel)
		CPanel:AddControl("Header", {Description = "#Prop_Protection.EditHeader"})
		CPanel:AddControl("Button", {Label = "Open", Command = "cc_editpropprotection"})
	end

	local function EditPropProtection(ply, cmd, args)
		CCP.PropProtectionEdit = vgui.Create("DFrame")
		CCP.PropProtectionEdit:SetSize(400, 504)
		CCP.PropProtectionEdit:Center()
		CCP.PropProtectionEdit:SetTitle("Edit Prop Protection")
		CCP.PropProtectionEdit.lblTitle:SetFont("CombineControl.Window")
		CCP.PropProtectionEdit:MakePopup()
		CCP.PropProtectionEdit.PerformLayout = CCFramePerformLayout
		CCP.PropProtectionEdit:PerformLayout()

		CCP.PropProtectionEdit.Think = UIAutoClose

		CCP.PropProtectionEdit.AllPlayers = vgui.Create("DListView", CCP.PropProtectionEdit)
		CCP.PropProtectionEdit.AllPlayers:SetPos(10, 34)
		CCP.PropProtectionEdit.AllPlayers:SetSize(185, 430)
		CCP.PropProtectionEdit.AllPlayers:AddColumn("Players")

		function CCP.PropProtectionEdit.AllPlayers:DoDoubleClick(id, line)
			local ply = CCP.PropProtectionEdit.AllPlayers:GetLine(id).Player

			net.Start("nAddPropProtection")
				net.WriteEntity(ply)
			net.SendToServer()

			CCP.PropProtectionEdit.AllPlayers:RemoveLine(id)
			CCP.PropProtectionEdit.Allowed:AddLine(ply:VisibleRPName()).Player = ply
		end

		for k, v in pairs(player.GetAll()) do
			if not table.HasValue(LocalPlayer():PropProtection(), v) and v != LocalPlayer() then
				CCP.PropProtectionEdit.AllPlayers:AddLine(v:VisibleRPName()).Player = v
			end
		end

		CCP.PropProtectionEdit.Allowed = vgui.Create("DListView", CCP.PropProtectionEdit)
		CCP.PropProtectionEdit.Allowed:SetPos(205, 34)
		CCP.PropProtectionEdit.Allowed:SetSize(185, 430)
		CCP.PropProtectionEdit.Allowed:AddColumn("Allowed")
		function CCP.PropProtectionEdit.Allowed:DoDoubleClick(id, line)
			local ply = CCP.PropProtectionEdit.Allowed:GetLine(id).Player

			net.Start("nRemovePropProtection")
				net.WriteEntity(ply)
			net.SendToServer()

			CCP.PropProtectionEdit.Allowed:RemoveLine(id)
			CCP.PropProtectionEdit.AllPlayers:AddLine(ply:VisibleRPName()).Player = ply
		end

		for k, v in pairs(LocalPlayer():PropProtection()) do
			CCP.PropProtectionEdit.Allowed:AddLine(v:VisibleRPName()).Player = v
		end

		CCP.PropProtectionEdit.MakeAllowed = vgui.Create("DButton", CCP.PropProtectionEdit)
		CCP.PropProtectionEdit.MakeAllowed:SetFont("CombineControl.LabelSmall")
		CCP.PropProtectionEdit.MakeAllowed:SetText(">")
		CCP.PropProtectionEdit.MakeAllowed:SetPos(10, 474)
		CCP.PropProtectionEdit.MakeAllowed:SetSize(185, 20)

		function CCP.PropProtectionEdit.MakeAllowed:DoClick()
			if not CCP.PropProtectionEdit.AllPlayers:GetSelected()[1] then return end

			local ply = CCP.PropProtectionEdit.AllPlayers:GetSelected()[1].Player

			net.Start("nAddPropProtection")
				net.WriteEntity(ply)
			net.SendToServer()

			CCP.PropProtectionEdit.AllPlayers:RemoveLine(CCP.PropProtectionEdit.AllPlayers:GetSelected()[1]:GetID())
			CCP.PropProtectionEdit.Allowed:AddLine(ply:VisibleRPName()).Player = ply
		end

		CCP.PropProtectionEdit.MakeAllowed:PerformLayout()

		CCP.PropProtectionEdit.RemoveAllowed = vgui.Create("DButton", CCP.PropProtectionEdit)
		CCP.PropProtectionEdit.RemoveAllowed:SetFont("CombineControl.LabelSmall")
		CCP.PropProtectionEdit.RemoveAllowed:SetText("<")
		CCP.PropProtectionEdit.RemoveAllowed:SetPos(205, 474)
		CCP.PropProtectionEdit.RemoveAllowed:SetSize(185, 20)

		function CCP.PropProtectionEdit.RemoveAllowed:DoClick()
			if not CCP.PropProtectionEdit.Allowed:GetSelected()[1] then return end

			local ply = CCP.PropProtectionEdit.Allowed:GetSelected()[1].Player

			net.Start("nRemovePropProtection")
				net.WriteEntity(ply)
			net.SendToServer()

			CCP.PropProtectionEdit.Allowed:RemoveLine(CCP.PropProtectionEdit.Allowed:GetSelected()[1]:GetID())
			CCP.PropProtectionEdit.AllPlayers:AddLine(ply:VisibleRPName()).Player = ply
		end

		CCP.PropProtectionEdit.RemoveAllowed:PerformLayout()
	end
	concommand.Add("cc_editpropprotection", EditPropProtection)

	function GM:PopulateToolMenu()
		self.BaseClass:PopulateToolMenu()

		spawnmenu.AddToolMenuOption("Prop Protection", "Prop Protection", "Prop_Protection_Edit", "#Prop_Protection_Edit", "", "", Prop_Protection_Edit)
	end
else

	function nAddPropProtection(len, ply)
		local targ = net.ReadEntity()

		if not table.HasValue(ply:PropProtection(), targ) and targ != ply then
			local tab = ply:PropProtection()

			table.insert(tab, targ)

			ply:SetPropProtection(tab)
		end
	end

	net.Receive("nAddPropProtection", nAddPropProtection)

	function nRemovePropProtection(len, ply)
		local targ = net.ReadEntity()

		if table.HasValue(ply:PropProtection(), targ) and targ != ply then
			local tab = {}

			for _, v in pairs(ply:PropProtection()) do
				if v:IsValid() and v != targ then
					table.insert(tab, v)
				end
			end

			ply:SetPropProtection(tab)
		end
	end

	net.Receive("nRemovePropProtection", nRemovePropProtection)
end

function GM:DrawPhysgunBeam(ply, weapon, bOn, target, boneid, pos)
	return true
end

list.Add("OverrideMaterials", "models/props_c17/metalladder001")
list.Add("OverrideMaterials", "models/props_c17/metalladder002")
list.Add("OverrideMaterials", "models/props_c17/metalladder003")
list.Add("OverrideMaterials", "models/props_debris/metalwall001a")
list.Add("OverrideMaterials", "models/props_canal/metalwall005b")
list.Add("OverrideMaterials", "models/props_combine/metal_combinebridge001")
list.Add("OverrideMaterials", "models/props_interiors/metalfence007a")
list.Add("OverrideMaterials", "models/props_pipes/pipeset_metal02")
list.Add("OverrideMaterials", "models/props_pipes/pipeset_metal")
list.Add("OverrideMaterials", "models/props_wasteland/metal_tram001a")
list.Add("OverrideMaterials", "models/props_canal/metalcrate001d")
list.Add("OverrideMaterials", "models/weapons/v_stunbaton/w_shaft01a")
list.Add("OverrideMaterials", "models/props_wasteland/lighthouse_stairs")
list.Add("OverrideMaterials", "models/props_debris/plasterwall021a")
list.Add("OverrideMaterials", "models/props_debris/plasterwall009d")
list.Add("OverrideMaterials", "models/props_debris/plasterwall034a")
list.Add("OverrideMaterials", "models/props_debris/plasterwall039c")
list.Add("OverrideMaterials", "models/props_debris/plasterwall040c")
list.Add("OverrideMaterials", "models/props_debris/concretefloor013a")
list.Add("OverrideMaterials", "models/props_wasteland/concretefloor010a")
list.Add("OverrideMaterials", "models/props_debris/concretewall019a")
list.Add("OverrideMaterials", "models/props_wasteland/concretewall064b")
list.Add("OverrideMaterials", "models/props_wasteland/concretewall066a")
list.Add("OverrideMaterials", "models/props_debris/building_template012d")
list.Add("OverrideMaterials", "models/props_wasteland/dirtwall001a")
list.Add("OverrideMaterials", "models/props_combine/masterinterface01c")
list.Add("OverrideMaterials", "effects/breenscreen_static01_")
list.Add("OverrideMaterials", "models/props_lab/security_screens")
list.Add("OverrideMaterials", "models/props_lab/security_screens2")
list.Add("OverrideMaterials", "effects/minescreen_static01_")
list.Add("OverrideMaterials", "console/background01_widescreen")
list.Add("OverrideMaterials", "effects/c17_07camera")
list.Add("OverrideMaterials", "effects/com_shield002a")
list.Add("OverrideMaterials", "effects/c17_07camera")
list.Add("OverrideMaterials", "effects/combinedisplay_core_")
list.Add("OverrideMaterials", "effects/combinedisplay_dump")
list.Add("OverrideMaterials", "effects/combinedisplay001a")
list.Add("OverrideMaterials", "effects/combinedisplay001b")
list.Add("OverrideMaterials", "models/props_lab/eyescanner_disp")
list.Add("OverrideMaterials", "effects/combine_binocoverlay")
list.Add("OverrideMaterials", "models/props_lab/generatorconsole_disp")
list.Add("OverrideMaterials", "models/props_lab/computer_disp")
list.Add("OverrideMaterials", "models/combine_helicopter/helicopter_bomb01")
list.Add("OverrideMaterials", "models/props_combine/introomarea_disp")
list.Add("OverrideMaterials", "models/props_combine/tpballglow")
list.Add("OverrideMaterials", "models/props_combine/combine_door01_glass")
list.Add("OverrideMaterials", "models/props_combine/Combine_Citadel001")
list.Add("OverrideMaterials", "models/props_combine/combine_fenceglow")
list.Add("OverrideMaterials", "models/props_combine/combine_intmonitor001_disp")
list.Add("OverrideMaterials", "models/props_combine/combine_monitorbay_disp")
list.Add("OverrideMaterials", "models/props_combine/masterinterface_alert")
list.Add("OverrideMaterials", "models/props_combine/weaponstripper_sheet")
list.Add("OverrideMaterials", "models/Combine_Helicopter/helicopter_bomb01")
list.Add("OverrideMaterials", "models/props_combine/combine_interface_disp")
list.Add("OverrideMaterials", "models/props_combine/tprings_sheet")
list.Add("OverrideMaterials", "models/props_combine/combinethumper002")
list.Add("OverrideMaterials", "models/props_combine/tprotato1_sheet")
list.Add("OverrideMaterials", "models/props_combine/pipes01")
list.Add("OverrideMaterials", "models/combine_mine/combine_mine_citizen")
list.Add("OverrideMaterials", "models/combine_mine/combine_mine_citizen2")
list.Add("OverrideMaterials", "models/combine_mine/combine_mine_citizen3")
list.Add("OverrideMaterials", "models/combine_turrets/floor_turret/floor_turret_citizen")
list.Add("OverrideMaterials", "models/combine_turrets/floor_turret/floor_turret_citizen2")
list.Add("OverrideMaterials", "models/combine_turrets/floor_turret/floor_turret_citizen4")
list.Add("OverrideMaterials", "effects/prisonmap_disp")
list.Add("OverrideMaterials", "models/effects/vortshield")
list.Add("OverrideMaterials", "effects/tvscreen_noise001a")
list.Add("OverrideMaterials", "effects/combinedisplay002a")
list.Add("OverrideMaterials", "effects/combinedisplay002b")
list.Add("OverrideMaterials", "models/props_foliage/oak_tree01")
list.Add("OverrideMaterials", "models/props_wasteland/rockcliff02b")
list.Add("OverrideMaterials", "models/props_wasteland/rockcliff02c")
list.Add("OverrideMaterials", "models/props_wasteland/rockcliff04a")
list.Add("OverrideMaterials", "models/props_wasteland/rockcliff02a")
list.Add("OverrideMaterials", "models/dav0r/hoverball")
list.Add("OverrideMaterials", "models/props_junk/ravenholmsign_sheet")
list.Add("OverrideMaterials", "models/props_junk/TrafficCone001a")
list.Add("OverrideMaterials", "models/props_c17/frostedglass_01a_dx60")
list.Add("OverrideMaterials", "models/props_canal/rock_riverbed01a")
list.Add("OverrideMaterials", "models/props_canal/canalmap_sheet")
list.Add("OverrideMaterials", "models/props_canal/coastmap_sheet")
list.Add("OverrideMaterials", "models/effects/slimebubble_sheet")
list.Add("OverrideMaterials", "models/Items/boxart1")
list.Add("OverrideMaterials", "models//props/de_tides/clouds")
list.Add("OverrideMaterials", "models/props_c17/fisheyelens")
list.Add("OverrideMaterials", "models/Shadertest/predator")
list.Add("OverrideMaterials", "models/props_lab/warp_sheet")
list.Add("OverrideMaterials", "models/props_c17/furniturefabric001a")
list.Add("OverrideMaterials", "models/props_c17/furniturefabric002a")
list.Add("OverrideMaterials", "models/props_c17/furniturefabric003a")
list.Add("OverrideMaterials", "models/props_c17/oil_drum001h")
list.Add("OverrideMaterials", "models/props_junk/glassbottle01b")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin10")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin11")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin12")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin13")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin14")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin15")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin16")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin2")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin3")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin4")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin5")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin6")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin7")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin8")
list.Add("OverrideMaterials", "models/props_c17/door01a_skin9")
list.Add("OverrideMaterials", "models/props_c17/hospital_bed01_skin2")
list.Add("OverrideMaterials", "models/props_c17/hospital_surgerytable01_skin2")
list.Add("OverrideMaterials", "models/props_animated_breakable/smokestack/brickwall002a")
list.Add("OverrideMaterials", "models/props_animated_breakable/smokestack/brick_chimney01")
list.Add("OverrideMaterials", "models/props_building_details/courtyard_template001c_bars")
list.Add("OverrideMaterials", "models/props_c17/awning001a")
list.Add("OverrideMaterials", "models/props_c17/awning001b")
list.Add("OverrideMaterials", "models/props_c17/awning001c")
list.Add("OverrideMaterials", "models/props_c17/awning001d")
list.Add("OverrideMaterials", "models/props_c17/chairchrome01")
list.Add("OverrideMaterials", "models/props_c17/concretewall020a")
list.Add("OverrideMaterials", "models/props_c17/door03a_glass")
list.Add("OverrideMaterials", "models/props_c17/gate_door01a")
list.Add("OverrideMaterials", "models/props_combine/combine_cell_burned")
list.Add("OverrideMaterials", "models/props_combine/coredx70")
