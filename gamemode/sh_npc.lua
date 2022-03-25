local meta = FindMetaTable("Entity")

GM.NPCAccessors = {
	{"Driver", 			"Entity",	NULL},
	{"GunOn",				"Float",	0},
	{"MastermindColor",	"Vector",	Vector(255, 255, 255)},
	{"TargetPos",			"Vector",	Vector()},
	{"HatesUnflaggedCPs",	"Float",	0},
	{"HatesFlaggedCPs",	"Float",	0},
	{"HatesCitizens",		"Float",	0},
	{"HatesRebels",		"Float",	0},
	{"HatesWeapons",		"Float",	0},
}

for _, v in pairs(GM.NPCAccessors) do
	local name, vartype, default = v[1], v[2], v[3]

	meta["SetNPC" .. name] = function(self, val)
		if CLIENT then
			return
		end

		if self["NPC" .. name .. "Val"] == val then
			return
		end

		self["NPC" .. name .. "Val"] = val

		net.Start("nSetNPC" .. name)
			net.WriteEntity(self)
			net["Write" .. vartype](val)
		net.Broadcast()
	end

	meta["NPC" .. name] = function(self)
		if self["NPC" .. name .. "Val"] == false then
			return false
		end

		return self["NPC" .. name .. "Val"] or default
	end

	if SERVER then
		util.AddNetworkString("nSetNPC" .. name)
	else
		local function nRecvData(len)
			local npc = net.ReadEntity()
			local val = net["Read" .. vartype]()

			if IsValid(npc) then
				npc["NPC" .. name .. "Val"] = val
			end
		end

		net.Receive("nSetNPC" .. name, nRecvData)
	end
end

function meta:InitializeNPCAccessors()
	for _, v in pairs(GAMEMODE.NPCAccessors) do
		local name, default = v[1], v[3]

		self[name .. "Val"] = default
	end
end

function meta:SyncNPCData(ply)
	for _, v in pairs(GAMEMODE.NPCAccessors) do
		local name, vartype = v[1], v[2]

		net.Start("nSetNPC" .. name)
			net.WriteEntity(self)
			net["Write" .. vartype](self["NPC" .. name](self))
		net.Send(ply)
	end
end

function ents.GetNPCs()
	local tab = {}

	local blacklist = {
		["bullseye_strider_focus"] = true,
		["npc_bullseye"] = true,
		["monster_generic"] = true
	}

	for _, v in pairs(ents.GetAll()) do
		if not v.GetClass or not IsValid(v) then
			continue
		end

		if not v:IsNPC() then
			continue
		end

		if blacklist[v:GetClass()] then
			continue
		end

		if v:Health() > 0 then
			table.insert(tab, v)
		end
	end

	return tab
end
