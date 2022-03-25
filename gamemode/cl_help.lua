function GM:RefreshHelpMenuContent()
	self.HelpContent = {
		{"Credits",
			[[CombineControl created by Disseminate.

			Casadis - for all the support and ideas.
			Kamern - ideas and support.

			Built upon for TnB by:
			Steve
			Hoplite
			Gangleider
			Thor
			Jeuz
			Jake
			TankNut]]},

		{"Commands",
			[=[Just entering something in the chatbox will make you say it in character.

			/y - Yell
			/w - Whisper
			/me - Action
			/lme - Longer range action
			/it - World action
			/lit - Longer range world action
			// - Global OOC
			[[ or .// - Local OOC
			/a - Talk to admins
			/pm [name] [text] - PM another player
			/reply [text] - Reply to the last person that messaged you
			/r - Talk on your radio if you have one
			/ry - Yell on your radio
			/rw - Whisper on your radio
			/rset [channel] - Sets your radio channel
			/help - Open this menu

			/highlight or /hl - Highlight someone's text in chat, customize the color by changing the console variable rp_highlight_color

			/eng [text] - Speak English (default).
			/rus [text] - Speak Russian.
			/chi [text] - Speak Chinese.
			/jap [text] - Speak Japanese.
			/spa [text] - Speak Spanish.
			/fre [text] - Speak French.
			/ger [text] - Speak German.
			/ita [text] - Speak Italian.

			You can use languages with chat commands with the following syntax:
			/[lang].<cmd> [text]
			/rus.y Hello world! - Yells in Russian.
			/fre.rw Hello world! - Whispers over the radio in French.

			There is a sticky language setting in F3 which when selected will remember a set language, and all following commands will automatically use that language.
			/[lang] - Sets a default language (/eng will set you back to default).

			Console commands:

			rp_thirdperson - Changes the perspective to third person view
			rp_stopmusic - Stops any youtube music that may be playing
			rp_roll - Allows you to roll a set of die with the format NdX+m
			prone - Go prone
			rp_uptime - Print out the server uptime
			]=]},
		{"Key Bindings", [[F1 - Open help menu.
		F2 - Open character menu.
		F3 - Open player menu.
		F4 - Open admin menu.
		C - Open context menu.
		B - Toggle weapon holster.]]},

		{"Flags", [[CombineControl uses a flag system for additional character/player functionality.

		Character Flags
		A - SkyNET Human Assets
		S - SkyNET Drone

		Player Flags
		0 - Event Manager
		1 - Ground Vehicles
		2 - Air Vehicles]]},
		{"Tooltrust", [[By default, you don't have tooltrust, you have phystrust, and you have proptrust. Phys- and proptrust give you a physgun and the ability to spawn props respectively. Tooltrust gives you a toolgun.

		Basic tooltrust gives you some common simple tools, a slightly increased prop limit, and slightly increased prop spawn permissions. To get this, ask an admin.

		Advanced tooltrust gives you most tools, an increased prop limit, and increased prop spawn permissions. Advanced tooltrust users' props are solid, whereas basic and non tooltrusted props are no-collided. To get this, check the forums.

		Admins can take away phys and proptrust if you abuse the privilege - you can get it back on the forums.]]}
	}

	if LocalPlayer():IsAdmin() then

		table.insert(self.HelpContent, {"Admin Commands", [[Press F4 to open the admin menu.

		If you want to enter commands manually, below is a list of all admin commands in CombineControl.

		Note: In CombineControl, there is no rpa_observe - observe mode is just noclip.

		If the command needs a player, you can specify "^" to target yourself and "-" to target the player you're looking at.

		rpa_kill [player] - Kill a player.
		rpa_slap [player] - Slap a player.
		rpa_kick [player] (reason) - Kick a player.
		rpa_goto [player] - Teleport to a player.
		rpa_bring [player] - Teleport a player to you.
		rpa_send [victim] [target] - Teleports the victim to the target.

		You can also use the above commands via the chat, e.g. /slap, /kick, /slay, /kill etc...

		rpa_restart - Restart the server.
		rpa_ko [player] - Knock out a player.
		rpa_wakeup [player] - Wake up a player.
		rpa_ban [player] [time] (reason) - Ban a player. A time of 0 is a permaban.
		rpa_unban [SteamID] - Unban a player.
		rpa_changebanlength [SteamID] [duration] - Change a ban's length for a player.
		rpa_namewarn [player] - Give a player a name warning.
		rpa_setcharname [player] [new name] - Change a player's name.
		rpa_setcharmodel [player] [model] (skin) - Change a player's model. You can use citizen IDs (male_01, for example) instead of the full path.
		rpa_setcharskin [player] [skin] - Change a player's skin without changing their model.
		rpa_seeall - Toggle admin ESP mode.

		rpa_editinventory [player] - Open a character's inventory for editing.

		rpa_setcharflags [player] [flag(s)] - Set a player's character flags.
		rpa_flagsroster - See all characters with player flags.

		rpa_settooltrust [tt] - Set a player's tooltrust. 0 is none, 1 is basic, 2 is advanced.
		rpa_setphystrust [0/1] - Set a player's phystrust. Default is 1, set to 0 to take away the physgun.
		rpa_setproptrust [0/1] - Set a player's proptrust. Default is 1, set to 0 to take away the ability to spawn props.

		rpa_togglesaved - Toggle the prop you're looking at's static property. If static, it will glow pink in SeeAll when you have a toolgun or physgun out and will save across restarts.

		rpa_playmusic [music/0/1/2] - Play music. 0 is calm, 1 is alert, 2 is action. Alternatively you can specify a song by filename.
		rpa_stopmusic - Stop any playing music.
		rpa_playoverwatch [id] - Play an overwatch line. If you don't enter an id, a list of valid ids and lines will display instead.

		rpa_createitem [item] - Spawn an item.
		rpa_givemoney [player] [amount] - Give a player money.

		rpa_charlist [steamid] - Look up a list of all characters owned by the given SteamID. This command gives character ID's, which is used by the various followup commands
		rpa_charlookup [name] - Look up a list of all characters with the given name. Use % as a wildcard, for performance reasons the search is limited to 500 results

		rpa_getchardata [charid] - Look up the character data for a certain character.
		rpa_getcharinv [charid] - Look up a character's normal and CP inventory.
		rpa_wipecharinv [charid] - Wipe a character's normal and CP inventory.
		rpa_wipecharflags [charid] - Wipe a character's normal and combine flags.

		rpa_spawncanister [number headcrabs] [regular/fast/poison] - Send a headcrab canister to wherever you're looking, from behind you.
		rpa_spawnmortar [number of shots] [inaccuracy range] - Send a barrage of combine mortars at your target.
		rpa_createexplosion - Create an explosion where you're looking at.
		rpa_createfire [duration] - Create a fire where you're looking at.

		rpa_stopsound - Stop all playing sounds for everyone.

		rpa_playernotes [player] - Open a list of the player's admin notes.

		rpa_mute [player] - Mutes or unmutes a player from OOC.

		rpa_givelang [player] [lang] - Give a player a language.
		rpa_takelang [player] [lang] - Take a language from a player.

		Available languages:
		english    japanese      italian
		chinese    russian       spanish
		german     french

		rpa_deleteitem [id] - Deletes an item based on it's ID (Use logs)
		rpa_restoreitem [id] - Undeletes an item and moves it into your inventory

		/ev - Broadcast an IC event.
		/lev - Localised version /ev (~yell range)]]})

		table.insert(self.HelpContent, {"Loot", [[New system for keeping players busy.

		Loot is distributed through loot points, these are placed down by admins and can be disguised as /any/ prop. These points will slowly fill themselves up and give their contents to players when they interact with them.

		Basic mechanics are as follows:
		- The system has several 'pools' defined, you can find those below.
		- Each pool runs on it's own separate timer.
		- Once a timer expires a new item is added to any point belonging to the same pool. If a point already contains an item then it'll be overwritten.
		- If the player count falls below a certain threshold for a pool, all points belonging to that pool empty out.

		Pools are placed down with rpa_createlootpoint <pool> and removed using the context menu.

		Currently we have 4 pools:
		- pool_domestic (Household items, basic clothing and basic weapons/ammo)
		- pool_tech (Electrical supplies and tools)
		- pool_military (Military weapons and ammo)
		- pool_scav (All kinds of junk, small chances for low-grade armor and weapons/ammo)]]})

		table.insert(self.HelpContent, {"Drone flags", [[The replacement for separate character flags for each drone.

		Players need to be given each drone flag separately, once they have them they can freely (and on the fly) switch between them by using /flag.

		Flags are given through rpa_givedroneflag and taken through rpa_takedroneflag, you can list a player's flags through rpa_listdroneflags.

		A list of all flags can be found in rpa_droneflags.]]})

		table.insert(self.HelpContent, {"New commands", [[Commands new to TRP 3, specifically ones not mentioned before.

		rpa_setlight [group] [style] - Used to set the light style of persistent light entities, the group of an entity can be found through seeall.

		rpa_radiostatic [severity] - Used to jam all common (non-skynet and non-longrange) frequencies, severity goes from 0 to 100 and determines how distorted radio messages are. A severity of 25 or higher removes the ability to see the sender.

		rpa_setarmoryaccess [player] [armory] - Used to assign people access to an armory, check F4 > Armory for a list of available ones.

		rpa_setarmorystock [armory] [item] [stock] [create] - Sets the stock level for a certain item inside of a certain armory, a stock of 0 removes the item, a stock of -1 makes it available in infinite amounts and anything else gives it a limited stock. The create option is for superadmins to create a new armory alltogether.

		rpa_deletearmory [armory] - Superadmin only, deletes an armory and wipes the access from every player.

		rpa_createloot [pool] - Lets you spawn random loot items based on any of the existing pools.

		rpa_setplayerflag [player] [flag] - Gives a player a player flag, multiple flags can be given by adding all of the flags at once (e.g. 012 for events, ground and air vehicles)]]})
	end
end

function GM:CreateHelpMenu()
	self:RefreshHelpMenuContent()

	CCP.HelpMenu = vgui.Create("DFrame")
	CCP.HelpMenu:SetSize(800, 600)
	CCP.HelpMenu:Center()
	CCP.HelpMenu:SetTitle("Help")
	CCP.HelpMenu.lblTitle:SetFont("CombineControl.Window")
	CCP.HelpMenu:MakePopup()
	CCP.HelpMenu.PerformLayout = CCFramePerformLayout
	CCP.HelpMenu:PerformLayout()

	CCP.HelpMenu.Think = UIAutoClose
	CCP.HelpMenu.OnKeyCodePressed = function(self, key)
		if input.LookupKeyBinding(key) and string.find(input.LookupKeyBinding(key), "showhelp") then
			self:Close()
		end
	end

	CCP.HelpMenu.ContentPane = vgui.Create("DScrollPanel", CCP.HelpMenu)
	CCP.HelpMenu.ContentPane:SetSize(650, 556)
	CCP.HelpMenu.ContentPane:SetPos(140, 34)
	function CCP.HelpMenu.ContentPane:Paint(w, h)

		surface.SetDrawColor(30, 30, 30, 255)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(20, 20, 20, 100)
		surface.DrawOutlinedRect(0, 0, w, h)

	end

	CCP.HelpMenu.Content = vgui.Create("CCLabel")
	CCP.HelpMenu.Content:SetPos(10, 10)
	CCP.HelpMenu.Content:SetSize(630, 14)
	CCP.HelpMenu.Content:SetFont("CombineControl.LabelMedium")
	CCP.HelpMenu.Content:SetText("Welcome to the help menu! Press a button on the left to select a topic.")
	CCP.HelpMenu.Content:PerformLayout()
	CCP.HelpMenu.ContentPane:AddItem(CCP.HelpMenu.Content)

	local y = 34

	for _, v in pairs(self.HelpContent) do

		local but = vgui.Create("DButton", CCP.HelpMenu)
		but:SetPos(10, y)
		but:SetSize(120, 20)
		but:SetText(v[1])
		but:PerformLayout()
		function but:DoClick()

			CCP.HelpMenu.Content:SetText(string.gsub(v[2], "\t", ""))

			CCP.HelpMenu.Content:InvalidateLayout(true)
			CCP.HelpMenu.ContentPane:PerformLayout()

		end

		y = y + 30

	end
end
