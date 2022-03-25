local meta = FindMetaTable("Player")

GM.PlayerFlags = {}
GM.CharFlags = {}
GM.DroneFlags = {}

function GM:LookupPlayerFlag(f)
	for _, v in pairs(self.PlayerFlags) do
		if v.Flag == f then
			return v
		end
	end
end

function GM:LookupCharFlag(f)
	for _, v in pairs(self.CharFlags) do
		if string.find(f, v.Flag) then
			return v
		end
	end
end

function GM:FlagPrintName(flag)
	for _, v in pairs(self.CharFlags) do
		if v.Flag == flag then
			return v.PrintName
		end
	end
	return flag
end

function GM:PlayerFlagPrintName(flag)
	for _, v in pairs(self.PlayerFlags) do
		if v.Flag == flag then
			return v.PrintName
		end
	end
	return "unknown"
end

function GM:CharFlagPrintName(flag)
	for _, v in pairs(self.CharFlags) do
		if v.Flag == flag then
			return v.PrintName
		end
	end
	return flag
end

function meta:GetCharFlag()
	return GAMEMODE:LookupCharFlag(self:CharFlags())
end

function meta:HasPlayerFlag(f)
	if string.find(self:PlayerFlags(), f) then return true end
	return false
end

function meta:HasCharFlag(f)
	if string.find(self:CharFlags(), f) then return true end
	return false
end

function meta:GetCharFlagAttribute(var)
	local flag = self:GetCharFlag()

	if not flag then
		return false
	end

	if flag[var] then
		return flag[var]
	end

	return false
end

function meta:GetCharFlagValue(var, fallback)
	local flag = self:GetCharFlag()

	if not flag or flag[var] == nil then
		return fallback
	end

	if isfunction(flag[var]) then
		return flag[var](self)
	end

	return flag[var]
end

local files = file.Find(GM.FolderName .. "/gamemode/playerflags/*.lua", "LUA", "namedesc")

if #files > 0 then
	for _, v in pairs(files) do
		FLAG = {}
		FLAG.PrintName					= ""
		FLAG.Flag						= ""

		FLAG.EventAllowed				= false
		FLAG.VehicleAllowed				= false
		FLAG.SENTAllowed				= false
		FLAG.NPCAllowed					= false

		AddCSLuaFile("playerflags/" .. v)
		include("playerflags/" .. v)

		table.insert(GM.PlayerFlags, FLAG)

		MsgC(Color(200, 200, 200, 255), "Player flag " .. v .. " loaded.\n")
	end
end

files = file.Find(GM.FolderName .. "/gamemode/charflags/*.lua", "LUA", "namedesc")

if #files > 0 then
	for _, v in pairs(files) do
		FLAG = {}
		FLAG.PrintName 					= ""
		FLAG.Flag 						= ""
		FLAG.Color						= Color(255, 255, 255, 255)
		FLAG.Loadout 					= {}
		FLAG.ItemLoadout 				= {}
		FLAG.ModelFunc 					= nil
		FLAG.OnSpawn 					= function(ply) end
		FLAG.IgnoreTravelRestriction	= false
		FLAG.Scale 						= 1
		FLAG.EventAllowed				= false

		AddCSLuaFile("charflags/" .. v)
		include("charflags/" .. v)

		table.insert(GM.CharFlags, FLAG)

		MsgC(Color(200, 200, 200, 255), "Character flag " .. v .. " loaded.\n")
	end
end

-- Drone flags

function GM:GetDroneFlag(flag)
	return self.DroneFlags[flag]
end

files = file.Find(GM.FolderName .. "/gamemode/droneflags/*.lua", "LUA", "namedesc")

if #files > 0 then
	for _, v in pairs(files) do
		FLAG = {}
		FLAG.PrintName = ""

		AddCSLuaFile("droneflags/" .. v)
		include("droneflags/" .. v)

		GM.DroneFlags[string.FileName(v)] = FLAG

		MsgC(Color(200, 200, 200, 255), "Drone flag " .. v .. " loaded.\n")
	end
end
