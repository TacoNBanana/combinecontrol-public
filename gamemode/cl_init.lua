MsgC(Color(200, 200, 200, 255), "Loading clientside...\n")

GM.FullyLoaded = GM.FullyLoaded or false

if not CCP then
	CCP = {} -- CombineControl Panels.
end

include("sh_enum.lua")
include("sh_fixes.lua")
include("sh_utils.lua")

include("config/sh_config.lua")
include("config/motd.lua")
include("shared.lua")

include("sh_includes.lua")
include("sh_logging.lua")
include("sh_admin.lua")
include("sh_animation.lua")
include("sh_chat.lua")
include("sh_consciousness.lua")
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
include("sh_bullets.lua")
include("sh_firemodes.lua")

include("cl_logging.lua")
include("cl_admin.lua")
include("cl_adminmenu.lua")
include("cl_binds.lua")
include("cl_charcreate.lua")
include("cl_chat.lua")
include("cl_context.lua")
include("cl_dev.lua")
include("cl_drugs.lua")
include("cl_help.lua")
include("cl_hud.lua")
include("cl_map.lua")
include("cl_music.lua")
include("cl_names.lua")
include("cl_npc.lua")
include("cl_player.lua")
include("cl_playermenu.lua")
include("cl_playsounds.lua")
include("cl_playurl.lua")
include("cl_resource.lua")
include("cl_scoreboard.lua")
include("cl_think.lua")
include("cl_weaponselect.lua")
include("cl_items.lua")
include("cl_fonts.lua")
include("cl_weapon.lua")

include( "ctp/cl_ctp.lua");

IncludeFolder(GM.FolderName .. "/gamemode/gui")
IncludeFolder(GM.FolderName .. "/gamemode/logtypes")

function GM:Initialize()
	RunConsoleCommand("cl_showhints", "0")

	hook.Run("CC.SH.SetupAccessors")
end

function GM:OnGamemodeLoaded()
	self:CreateChat()
end

function GM:InitPostEntity()
	net.Start("nRequestPData")
	net.SendToServer()
end

hook.Add("OnEntityCreated", "CL.Init.OnEntityCreated", function(ent)
	if ent:IsPlayer() then
		if ent ~= LocalPlayer() then

			net.Start("nRequestPlayerData")
				net.WriteEntity(ent)
			net.SendToServer()
		end
	elseif ent:IsDoor() then
		GAMEMODE.EntityTable.door[table.Count(GAMEMODE.EntityTable.door)] = ent
	elseif ent:GetClass() == "prop_physics" then
		GAMEMODE.EntityTable.prop[table.Count(GAMEMODE.EntityTable.prop)] = ent
	elseif ent:GetClass() == "cc_item" then
		GAMEMODE.EntityTable.item[table.Count(GAMEMODE.EntityTable.item)] = ent
	elseif ent:GetClass() == "cc_paper" then
		GAMEMODE.EntityTable.paper[table.Count(GAMEMODE.EntityTable.paper)] = ent
	elseif string.StartWith(ent:GetClass(), "npc_") or string.find(ent:GetClass(), "inf_zombie*") then
		GAMEMODE.EntityTable.npc[table.Count(GAMEMODE.EntityTable.npc)] = ent
	end

	if cookie.GetNumber( "cc_thirdperson", 0 ) == 1 then
		ctp:Enable()
	end
end)

function UIAutoClose(panel)
	if cookie.GetNumber("cc_escapemenuclose", 1) == 1 and input.IsKeyDown(KEY_ESCAPE) and panel:IsActive() then
		panel:Close()
		gui.HideGameUI()

		GAMEMODE.CursorItem = nil
	end
end

GM.FullyLoaded = true

MsgC(Color(200, 200, 200, 255), "Clientside loaded.\n")
