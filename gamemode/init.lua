MsgC(Color(200, 200, 200, 255), "Loading serverside...\n")

GM.FullyLoaded = GM.FullyLoaded or false

include("sh_enum.lua")
include("sh_fixes.lua")

include("config/sv_config.lua")
include("config/sh_config.lua")

include("sh_utils.lua")

include("config/sv_loot.lua")
include("config/motd.lua")
include("shared.lua")

include("sh_includes.lua")
include("sh_logging.lua")
include("sh_admin.lua")
include("sh_animation.lua")
include("sh_consciousness.lua")
include("sh_chat.lua")
include("sh_entity.lua")
include("sh_inventory.lua")
include("sh_file.lua")
include("sh_flags.lua")
include("sh_map.lua")
include("sh_mapevents.lua")
include("sh_npc.lua")
include("sh_player.lua")
include("sh_playerclass.lua")
include("sh_playsounds.lua")
include("sh_reload.lua")
include("sh_sandbox.lua")
include("sh_pon.lua")
include("sh_weapons.lua")
include("sh_items.lua")
include("sh_donations.lua")
include("sh_sound.lua")
include("sh_dev.lua")

include("sv_logging.lua")
include("sv_admin.lua")
include("sv_business.lua")
include("sv_charcreate.lua")
include("sv_chat.lua")
include("sv_context.lua")
include("sv_dev.lua")
include("sv_drugs.lua")
include("sv_logs.lua")
include("sv_net.lua")
include("sv_npc.lua")
include("sv_map.lua")
include("sv_paper.lua")
include("sv_player.lua")
include("sv_playsounds.lua")
include("sv_resource.lua")
include("sv_security.lua")
include("sv_sockets.lua")
include("sv_sql.lua")
include("sv_think.lua")
include("sv_items.lua")
include("sv_weapon.lua")
include("sv_prometheus.lua")
include("sv_donations.lua")
include("sv_worldents.lua")

AddCSLuaFile("cl_init.lua")

AddCSLuaFile("sh_enum.lua")
AddCSLuaFile("sh_fixes.lua")
AddCSLuaFile("sh_utils.lua")

AddCSLuaFile("config/sh_config.lua")
AddCSLuaFile("config/motd.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFile("sh_includes.lua")
AddCSLuaFile("sh_logging.lua")
AddCSLuaFile("sh_admin.lua")
AddCSLuaFile("sh_animation.lua")
AddCSLuaFile("sh_chat.lua")
AddCSLuaFile("sh_consciousness.lua")
AddCSLuaFile("sh_entity.lua")
AddCSLuaFile("sh_inventory.lua")
AddCSLuaFile("sh_file.lua")
AddCSLuaFile("sh_flags.lua")
AddCSLuaFile("sh_map.lua")
AddCSLuaFile("sh_mapevents.lua")
AddCSLuaFile("sh_npc.lua")
AddCSLuaFile("sh_player.lua")
AddCSLuaFile("sh_playerclass.lua")
AddCSLuaFile("sh_playsounds.lua")
AddCSLuaFile("sh_reload.lua")
AddCSLuaFile("sh_sandbox.lua")
AddCSLuaFile("sh_pon.lua")
AddCSLuaFile("sh_weapons.lua")
AddCSLuaFile("sh_items.lua")
AddCSLuaFile("sh_donations.lua")
AddCSLuaFile("sh_sound.lua")
AddCSLuaFile("sh_dev.lua")

AddCSLuaFile("cl_logging.lua")
AddCSLuaFile("cl_admin.lua")
AddCSLuaFile("cl_adminmenu.lua")
AddCSLuaFile("cl_binds.lua")
AddCSLuaFile("cl_charcreate.lua")
AddCSLuaFile("cl_chat.lua")
AddCSLuaFile("cl_context.lua")
AddCSLuaFile("cl_drugs.lua")
AddCSLuaFile("cl_help.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_map.lua")
AddCSLuaFile("cl_music.lua")
AddCSLuaFile("cl_names.lua")
AddCSLuaFile("cl_npc.lua")
AddCSLuaFile("cl_player.lua")
AddCSLuaFile("cl_playermenu.lua")
AddCSLuaFile("cl_playsounds.lua")
AddCSLuaFile("cl_playurl.lua")
AddCSLuaFile("cl_resource.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("cl_think.lua")
AddCSLuaFile("cl_weaponselect.lua")
AddCSLuaFile("cl_items.lua")
AddCSLuaFile("cl_fonts.lua")
AddCSLuaFile("cl_weapon.lua")
AddCSLuaFile("cl_donations.lua")

--ctp
include( "ctp/sv_ctp.lua");
AddCSLuaFile( "ctp/cl_ctp.lua" );

IncludeFolder(GM.FolderName .. "/gamemode/gui")
IncludeFolder(GM.FolderName .. "/gamemode/logtypes")

function GM:Initialize()
	game.ConsoleCommand("net_maxfilesize 64\n")
	game.ConsoleCommand("sv_kickerrornum 0\n")

	game.ConsoleCommand("sv_allowupload 0\n")
	game.ConsoleCommand("sv_allowdownload 0\n")

	game.ConsoleCommand("sk_antlion_worker_spit_grenade_dmg 100\n")

	if game.IsDedicated() and not self.PrivateMode then

		game.ConsoleCommand("sv_allowcslua 0\n")

		concommand.Remove("gm_save")
		concommand.Add("gm_save", function(ply)
			GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to run command gm_save!")
		end)

	else

		game.ConsoleCommand("sv_allowcslua 1\n")

	end

	self:InitSQL()

	if self.EnablePrometheus then
		self:InitPrometheus()
	end

	self:SetupDataDirectories()
	self:LoadBans()

	timer.Create("LoadBans", 60, 0, function()

		GAMEMODE:LoadBans()

	end)

	-- Auto map switch support for rpa_changelevel
	local port = game.GetPort()

	if not file.Exists("cc_maps", "DATA") then
		file.CreateDir("cc_maps")
	end

	if file.Exists("cc_maps/" .. port .. ".txt", "DATA") then
		local map = file.Read("cc_maps/" .. port .. ".txt", "DATA")

		if map and map != game.GetMap() and table.HasValue(GAMEMODE:GetMaps(), map) then
			self.AutoMapOverride = map
		end
	end

	self:LogAll("Server started on map: " .. game.GetMap())
end

GM.FullyLoaded = true

MsgC(Color(200, 200, 200, 255), "Serverside loaded.\n")
