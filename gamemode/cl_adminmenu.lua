function GM:CreateAdminMenu()
	if CCP.AdminMenu and CCP.AdminMenu:IsValid() then

		CCP.AdminMenu:Remove()
		return

	end

	CCP.AdminMenu = vgui.Create("DFrame")
	CCP.AdminMenu:SetSize(800, 500)
	CCP.AdminMenu:Center()
	CCP.AdminMenu:SetTitle("Admin Menu")
	CCP.AdminMenu.lblTitle:SetFont("CombineControl.Window")
	CCP.AdminMenu:MakePopup()
	CCP.AdminMenu.PerformLayout = CCFramePerformLayout
	CCP.AdminMenu:PerformLayout()

	CCP.AdminMenu.Think = UIAutoClose
	CCP.AdminMenu.OnKeyCodePressed = function(self, key)
		if input.LookupKeyBinding(key) and string.find(input.LookupKeyBinding(key), "showspare2") then
			self:Close()
		end
	end

	CCP.AdminMenu.TopBar = vgui.Create("DPanel", CCP.AdminMenu)
	CCP.AdminMenu.TopBar:SetPos(0, 24)
	CCP.AdminMenu.TopBar:SetSize(800, 50)
	function CCP.AdminMenu.TopBar:Paint(w, h)

		surface.SetDrawColor(0, 0, 0, 70)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawOutlinedRect(0, 0, w, h)

	end

	CCP.AdminMenu.TopBar.Buttons = {}

	CCP.AdminMenu.TopBar.Buttons[1] = vgui.Create("DButton", CCP.AdminMenu.TopBar)
	CCP.AdminMenu.TopBar.Buttons[1]:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TopBar.Buttons[1]:SetText("Tools")
	CCP.AdminMenu.TopBar.Buttons[1]:SetPos(11, 10)
	CCP.AdminMenu.TopBar.Buttons[1]:SetSize(100, 26)
	CCP.AdminMenu.TopBar.Buttons[1].DoClick = function(self)

		CCP.AdminMenu.ContentPane:Clear()
		GAMEMODE:AdminCreateToolsMenu()

	end
	CCP.AdminMenu.TopBar.Buttons[1]:PerformLayout()

	CCP.AdminMenu.TopBar.Buttons[2] = vgui.Create("DButton", CCP.AdminMenu.TopBar)
	CCP.AdminMenu.TopBar.Buttons[2]:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TopBar.Buttons[2]:SetText("Players")
	CCP.AdminMenu.TopBar.Buttons[2]:SetPos(124, 10)
	CCP.AdminMenu.TopBar.Buttons[2]:SetSize(100, 26)
	CCP.AdminMenu.TopBar.Buttons[2].DoClick = function(self)

		CCP.AdminMenu.ContentPane:Clear()
		GAMEMODE:AdminCreatePlayersMenu()

	end
	CCP.AdminMenu.TopBar.Buttons[2]:PerformLayout()

	CCP.AdminMenu.TopBar.Buttons[3] = vgui.Create("DButton", CCP.AdminMenu.TopBar)
	CCP.AdminMenu.TopBar.Buttons[3]:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TopBar.Buttons[3]:SetText("Bans")
	CCP.AdminMenu.TopBar.Buttons[3]:SetPos(237, 10)
	CCP.AdminMenu.TopBar.Buttons[3]:SetSize(100, 26)
	CCP.AdminMenu.TopBar.Buttons[3].DoClick = function(self)

		CCP.AdminMenu.ContentPane:Clear()
		GAMEMODE:AdminCreateBansMenu()

	end
	CCP.AdminMenu.TopBar.Buttons[3]:PerformLayout()

	CCP.AdminMenu.TopBar.Buttons[4] = vgui.Create("DButton", CCP.AdminMenu.TopBar)
	CCP.AdminMenu.TopBar.Buttons[4]:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TopBar.Buttons[4]:SetText("Logs")
	CCP.AdminMenu.TopBar.Buttons[4]:SetPos(350, 10)
	CCP.AdminMenu.TopBar.Buttons[4]:SetSize(100, 26)
	CCP.AdminMenu.TopBar.Buttons[4].DoClick = function(self)

		CCP.AdminMenu.ContentPane:Clear()
		GAMEMODE:AdminCreateLogsMenu()

	end
	CCP.AdminMenu.TopBar.Buttons[4]:PerformLayout()

	CCP.AdminMenu.TopBar.Buttons[5] = vgui.Create("DButton", CCP.AdminMenu.TopBar)
	CCP.AdminMenu.TopBar.Buttons[5]:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TopBar.Buttons[5]:SetText("Armory")
	CCP.AdminMenu.TopBar.Buttons[5]:SetPos(463, 10)
	CCP.AdminMenu.TopBar.Buttons[5]:SetSize(100, 26)
	CCP.AdminMenu.TopBar.Buttons[5].DoClick = function(self)

		CCP.AdminMenu.ContentPane:Clear()
		GAMEMODE:AdminCreateArmory()

	end
	CCP.AdminMenu.TopBar.Buttons[5]:PerformLayout()

	CCP.AdminMenu.TopBar.Buttons[6] = vgui.Create("DButton", CCP.AdminMenu.TopBar)
	CCP.AdminMenu.TopBar.Buttons[6]:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TopBar.Buttons[6]:SetText("Roleplay")
	CCP.AdminMenu.TopBar.Buttons[6]:SetPos(576, 10)
	CCP.AdminMenu.TopBar.Buttons[6]:SetSize(100, 26)
	CCP.AdminMenu.TopBar.Buttons[6].DoClick = function(self)

		CCP.AdminMenu.ContentPane:Clear()
		GAMEMODE:AdminCreateRoleplayMenu()

	end
	CCP.AdminMenu.TopBar.Buttons[6]:PerformLayout()

	CCP.AdminMenu.TopBar.Buttons[7] = vgui.Create("DButton", CCP.AdminMenu.TopBar)
	CCP.AdminMenu.TopBar.Buttons[7]:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TopBar.Buttons[7]:SetText("Mastermind")
	CCP.AdminMenu.TopBar.Buttons[7]:SetPos(689, 10)
	CCP.AdminMenu.TopBar.Buttons[7]:SetSize(100, 26)
	CCP.AdminMenu.TopBar.Buttons[7].DoClick = function(self)

		if not GAMEMODE.Mastermind then GAMEMODE.Mastermind = false end

		GAMEMODE.Mastermind = not GAMEMODE.Mastermind

	end
	CCP.AdminMenu.TopBar.Buttons[7]:PerformLayout()

	CCP.AdminMenu.ContentPane = vgui.Create("DPanel", CCP.AdminMenu)
	CCP.AdminMenu.ContentPane:SetPos(0, 74)
	CCP.AdminMenu.ContentPane:SetSize(800, 426)
	function CCP.AdminMenu.ContentPane:Paint(w, h) end

	self:AdminCreateToolsMenu()
end

function GM:AdminCreateToolsMenu()
	CCP.AdminMenu.RestartBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.RestartBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.RestartBut:SetText("Restart Server")
	CCP.AdminMenu.RestartBut:SetPos(10, 10)
	CCP.AdminMenu.RestartBut:SetSize(100, 20)
	function CCP.AdminMenu.RestartBut:DoClick()

		RunConsoleCommand("rpa_restart")
		CCP.AdminMenu.RestartBut:SetDisabled(true)

	end
	CCP.AdminMenu.RestartBut:PerformLayout()

	CCP.AdminMenu.StopSoundBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.StopSoundBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.StopSoundBut:SetText("Stop Sounds")
	CCP.AdminMenu.StopSoundBut:SetPos(120, 10)
	CCP.AdminMenu.StopSoundBut:SetSize(100, 20)
	function CCP.AdminMenu.StopSoundBut:DoClick()

		RunConsoleCommand("rpa_stopsound")

	end
	CCP.AdminMenu.StopSoundBut:PerformLayout()

	CCP.AdminMenu.SeeAllFilter = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.SeeAllFilter:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.SeeAllFilter:SetText("SeeAll Filter")
	CCP.AdminMenu.SeeAllFilter:SetPos(230, 10)
	CCP.AdminMenu.SeeAllFilter:SetSize(100, 20)
	function CCP.AdminMenu.SeeAllFilter:DoClick()

		CCP.SeeAllFilter = vgui.Create("DFrame")
		CCP.SeeAllFilter:SetSize(140, 120)
		CCP.SeeAllFilter:SetPos(gui.MousePos())
		CCP.SeeAllFilter:SetTitle("SeeAll Filter")
		CCP.SeeAllFilter.lblTitle:SetFont("CombineControl.Window")
		CCP.SeeAllFilter:MakePopup()
		CCP.SeeAllFilter.PerformLayout = CCFramePerformLayout
		CCP.SeeAllFilter:PerformLayout()

		CCP.SeeAllFilter.Think = UIAutoClose

		local opts = {
			{Text = "Players", Var = "cc_seeallplayers"},
			{Text = "Health/Armour", Var = "cc_seeallhp"},
			{Text = "Items", Var = "cc_seeallitems"},
			{Text = "NPCs", Var = "cc_seeallnpcs"}
		}

		local y = 30
		for _, opt in pairs(opts) do
			local label = vgui.Create("DLabel", CCP.SeeAllFilter)
			label:SetText(opt.Text)
			label:SetPos(10, y)
			label:SetFont("CombineControl.LabelMedium")
			label:SizeToContents()
			label:PerformLayout()

			local box = vgui.Create("DCheckBoxLabel", CCP.SeeAllFilter)
			box:SetText("")
			box:SetPos(110, y)
			box:SetValue(cookie.GetNumber(opt.Var, 1))
			box:PerformLayout()
			function box:OnChange(val)
				cookie.Set(opt.Var, val and 1 or 0)
			end

			y = y + 20
		end

	end
	CCP.AdminMenu.SeeAllFilter:PerformLayout()

	CCP.AdminMenu.SeeAllL = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.SeeAllL:SetText("SeeAll Enabled")
	CCP.AdminMenu.SeeAllL:SetPos(10, 40)
	CCP.AdminMenu.SeeAllL:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.SeeAllL:SizeToContents()
	CCP.AdminMenu.SeeAllL:PerformLayout()

	CCP.AdminMenu.SeeAll = vgui.Create("DCheckBoxLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.SeeAll:SetText("")
	CCP.AdminMenu.SeeAll:SetPos(200, 40)
	CCP.AdminMenu.SeeAll:SetValue(self.SeeAll)
	CCP.AdminMenu.SeeAll:PerformLayout()
	function CCP.AdminMenu.SeeAll:OnChange(val)

		GAMEMODE.SeeAll = val

	end

	CCP.AdminMenu.SeeAll:PerformLayout()
	CCP.AdminMenu.SeeAll:SizeToContents()

	CCP.AdminMenu.HiddenL = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.HiddenL:SetText("Hidden Enabled")
	CCP.AdminMenu.HiddenL:SetPos(10, 70)
	CCP.AdminMenu.HiddenL:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.HiddenL:SizeToContents()
	CCP.AdminMenu.HiddenL:PerformLayout()

	CCP.AdminMenu.Hidden = vgui.Create("DCheckBoxLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.Hidden:SetText("")
	CCP.AdminMenu.Hidden:SetPos(200, 70)
	CCP.AdminMenu.Hidden:SetValue(LocalPlayer():HideAdmin())
	CCP.AdminMenu.Hidden:PerformLayout()
	function CCP.AdminMenu.Hidden:OnChange(val)

		RunConsoleCommand("rpa_hidebadge", val and 1 or 0)

	end

	CCP.AdminMenu.Hidden:PerformLayout()
	CCP.AdminMenu.Hidden:SizeToContents()

	CCP.AdminMenu.AIDisabledL = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.AIDisabledL:SetText("AI Disabled")
	CCP.AdminMenu.AIDisabledL:SetPos(10, 100)
	CCP.AdminMenu.AIDisabledL:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.AIDisabledL:SizeToContents()
	CCP.AdminMenu.AIDisabledL:PerformLayout()

	CCP.AdminMenu.AIDisabled = vgui.Create("DCheckBoxLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.AIDisabled:SetText("")
	CCP.AdminMenu.AIDisabled:SetPos(200, 100)
	CCP.AdminMenu.AIDisabled:SetValue(GetConVarNumber("ai_disabled"))
	CCP.AdminMenu.AIDisabled:PerformLayout()
	function CCP.AdminMenu.AIDisabled:OnChange(val)

		RunConsoleCommand("rpa_aidisabled", val and 1 or 0)

	end

	CCP.AdminMenu.AIDisabled:PerformLayout()
	CCP.AdminMenu.AIDisabled:SizeToContents()

	CCP.AdminMenu.OOCDelayLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.OOCDelayLabel:SetText("OOC Delay")
	CCP.AdminMenu.OOCDelayLabel:SetPos(10, 130)
	CCP.AdminMenu.OOCDelayLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.OOCDelayLabel:SizeToContents()
	CCP.AdminMenu.OOCDelayLabel:PerformLayout()

	CCP.AdminMenu.OOCDelay = vgui.Create("DTextEntry", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.OOCDelay:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.OOCDelay:SetPos(200, 130)
	CCP.AdminMenu.OOCDelay:SetSize(40, 20)
	CCP.AdminMenu.OOCDelay:SetNumeric(true)
	CCP.AdminMenu.OOCDelay:SetValue(GAMEMODE:OOCDelay())
	CCP.AdminMenu.OOCDelay:PerformLayout()

	function CCP.AdminMenu.OOCDelay:OnEnter()
		CCP.AdminMenu.OOCDelayBut:DoClick()
	end

	CCP.AdminMenu.OOCDelayBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.OOCDelayBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.OOCDelayBut:SetText("Apply")
	CCP.AdminMenu.OOCDelayBut:SetPos(250, 130)
	CCP.AdminMenu.OOCDelayBut:SetSize(100, 20)
	function CCP.AdminMenu.OOCDelayBut:DoClick()

		RunConsoleCommand("rpa_oocdelay", CCP.AdminMenu.OOCDelay:GetValue())

	end
	CCP.AdminMenu.OOCDelayBut:PerformLayout()

	CCP.AdminMenu.OOCDisableBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.OOCDisableBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.OOCDisableBut:SetText(self:OOCDisabled() and "Enable" or "Disable")
	CCP.AdminMenu.OOCDisableBut:SetPos(360, 130)
	CCP.AdminMenu.OOCDisableBut:SetSize(100, 20)
	function CCP.AdminMenu.OOCDisableBut:DoClick()
		CCP.AdminMenu.OOCDisableBut:SetText(GAMEMODE:OOCDisabled() and "Disable" or "Enable")

		net.Start("nDisableOOC")
		net.SendToServer()
	end
	CCP.AdminMenu.OOCDisableBut:PerformLayout()

	CCP.AdminMenu.EntityStats = vgui.Create("DTextEntry", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.EntityStats:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.EntityStats:SetPos(10, 160)
	CCP.AdminMenu.EntityStats:SetSize(385, 255)
	CCP.AdminMenu.EntityStats:SetMultiline(true)
	CCP.AdminMenu.EntityStats:SetDisabled(true)

	function CCP.AdminMenu.EntityStats:Think()

		if not self.NextRefresh or self.NextRefresh <= CurTime() then
			local unsavedProps = 0
			local savedProps = 0

			local unsavedEffects = 0
			local savedEffects = 0

			local ragdolls = 0
			local lights = 0

			local activePlayers = -1 -- Subtract ourselves

			local totalEntities = 0
			local activeEntities = 0

			for _, v in pairs(ents.GetAll()) do
				if v:IsPlayer() then
					if v:IsDormant() then
						continue
					end

					activePlayers = activePlayers + 1

					continue
				end

				if v:EntIndex() != -1 then
					totalEntities = totalEntities + 1

					if not v:IsDormant() then
						activeEntities = activeEntities + 1
					end
				end

				local class = v:GetClass()

				if class == "prop_physics" then
					if v:PropSaved() == 1 then
						savedProps = savedProps + 1
					else
						unsavedProps = unsavedProps + 1
					end
				elseif class == "prop_effect" then
					if v:PropSaved() == 1 then
						savedEffects = savedEffects + 1
					else
						unsavedEffects = unsavedEffects + 1
					end
				elseif class == "prop_ragdoll" then
					ragdolls = ragdolls + 1
				elseif class == "gmod_light" then
					lights = lights + 1
				end
			end

			self.Stats = {
				Props = {
					Unsaved = unsavedProps,
					Saved = savedProps
				},
				Effects = {
					Unsaved = unsavedEffects,
					Saved = savedEffects
				},
				Ragdolls = ragdolls,
				Lights = lights,
				Entities = {
					Active = activeEntities,
					Total = totalEntities
				},
				Players = {
					Active = activePlayers
				}
			}

			self.NextRefresh = CurTime() + 1
		end

		self:SetValue(string.format([[
			Server uptime: %s
			Server FPS: %.0f (Tickrate: %.0f)

			Players online: %i

			Estimated Entity counts: (Not 100%% accurate)
			  All: %i
			  Props: %i / %i Permaprops
			  Effects: %i / %i Permaprops
			  Ragdolls: %i
			  Lights: %i

			Active players: %i
			Active entities: %i
		]], string.NiceTime(CurTime()),
			1 / engine.ServerFrameTime(), 1 / engine.TickInterval(),
			player.GetCount(),
			self.Stats.Entities.Total,
			self.Stats.Props.Unsaved, self.Stats.Props.Saved,
			self.Stats.Effects.Unsaved, self.Stats.Effects.Saved,
			self.Stats.Ragdolls,
			self.Stats.Lights,
			self.Stats.Players.Active,
			self.Stats.Entities.Active
		))
	end

	if LocalPlayer():IsDeveloper() then
		CCP.AdminMenu.DevButton = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
		CCP.AdminMenu.DevButton:SetFont("CombineControl.LabelSmall")
		CCP.AdminMenu.DevButton:SetText("Open Dev UI")
		CCP.AdminMenu.DevButton:SetPos(340, 10)
		CCP.AdminMenu.DevButton:SetSize(100, 20)

		function CCP.AdminMenu.DevButton:DoClick()
			GAMEMODE:OpenDevUI()
			CCP.AdminMenu:Close()
		end

		CCP.AdminMenu.DevButton:PerformLayout()
	end
end

function GM:AdminPlayerMenuDisable()
	CCP.AdminMenu.KickReason:SetValue("")
	CCP.AdminMenu.KickBut:SetDisabled(true)
	CCP.AdminMenu.BanReason:SetValue("")
	CCP.AdminMenu.BanDuration:SetValue("60")
	CCP.AdminMenu.BanBut:SetDisabled(true)
	CCP.AdminMenu.PBanBut:SetDisabled(true)
	CCP.AdminMenu.BringBut:SetDisabled(true)
	CCP.AdminMenu.GotoBut:SetDisabled(true)
	CCP.AdminMenu.KillBut:SetDisabled(true)
	CCP.AdminMenu.SlapBut:SetDisabled(true)
	CCP.AdminMenu.KOBut:SetDisabled(true)
	CCP.AdminMenu.GiveMoney:SetValue(0)
	CCP.AdminMenu.GiveMoneyBut:SetDisabled(true)
	CCP.AdminMenu.CharSkin:SetValue(0)
	CCP.AdminMenu.CharSkinBut:SetDisabled(true)
	CCP.AdminMenu.CharFlag:SetValue("")
	CCP.AdminMenu.CharFlagBut:SetDisabled(true)
	CCP.AdminMenu.ModelBut:SetDisabled(true)
	CCP.AdminMenu.PhysTrust0:SetDisabled(true)
	CCP.AdminMenu.PhysTrust1:SetDisabled(true)
	CCP.AdminMenu.PropTrust0:SetDisabled(true)
	CCP.AdminMenu.PropTrust1:SetDisabled(true)
	CCP.AdminMenu.TT0:SetDisabled(true)
	CCP.AdminMenu.TT1:SetDisabled(true)
	CCP.AdminMenu.TT2:SetDisabled(true)
	CCP.AdminMenu.EditInventory:SetDisabled(true)
	CCP.AdminMenu.WarnName:SetDisabled(true)
	CCP.AdminMenu.PlayerNotes:SetDisabled(true)
	CCP.AdminMenu.OOCMute:SetDisabled(true)
	CCP.AdminMenu.TravelBan:SetDisabled(true)
end

function GM:AdminPlayerMenuEnable(ply)
	CCP.AdminMenu.KickBut:SetDisabled(false)
	CCP.AdminMenu.BanBut:SetDisabled(false)
	CCP.AdminMenu.PBanBut:SetDisabled(false)
	CCP.AdminMenu.BringBut:SetDisabled(false)
	CCP.AdminMenu.GotoBut:SetDisabled(false)
	CCP.AdminMenu.KillBut:SetDisabled(false)
	CCP.AdminMenu.SlapBut:SetDisabled(false)
	CCP.AdminMenu.KOBut:SetDisabled(false)
	CCP.AdminMenu.GiveMoneyBut:SetDisabled(false)
	CCP.AdminMenu.CharSkinBut:SetDisabled(false)
	CCP.AdminMenu.CharFlagBut:SetDisabled(false)
	CCP.AdminMenu.ModelBut:SetDisabled(false)
	CCP.AdminMenu.CharFlag:SetValue(ply:CharFlags())

	if ply:PhysTrust() == 0 then
		CCP.AdminMenu.PhysTrust0:SetDisabled(true)
		CCP.AdminMenu.PhysTrust1:SetDisabled(false)
	else
		CCP.AdminMenu.PhysTrust0:SetDisabled(false)
		CCP.AdminMenu.PhysTrust1:SetDisabled(true)
	end

	if ply:PropTrust() == 0 then
		CCP.AdminMenu.PropTrust0:SetDisabled(true)
		CCP.AdminMenu.PropTrust1:SetDisabled(false)
	else
		CCP.AdminMenu.PropTrust0:SetDisabled(false)
		CCP.AdminMenu.PropTrust1:SetDisabled(true)
	end

	if ply:ToolTrust() == 0 then
		CCP.AdminMenu.TT0:SetDisabled(true)
		CCP.AdminMenu.TT1:SetDisabled(false)
		CCP.AdminMenu.TT2:SetDisabled(false)
	elseif ply:ToolTrust() == 1 then
		CCP.AdminMenu.TT0:SetDisabled(false)
		CCP.AdminMenu.TT1:SetDisabled(true)
		CCP.AdminMenu.TT2:SetDisabled(false)
	else
		CCP.AdminMenu.TT0:SetDisabled(false)
		CCP.AdminMenu.TT1:SetDisabled(false)
		CCP.AdminMenu.TT2:SetDisabled(true)
	end

	CCP.AdminMenu.EditInventory:SetDisabled(false)
	CCP.AdminMenu.WarnName:SetDisabled(false)
	CCP.AdminMenu.PlayerNotes:SetDisabled(false)
	CCP.AdminMenu.OOCMute:SetDisabled(false)
	CCP.AdminMenu.TravelBan:SetDisabled(false)
end

function GM:AdminCreatePlayersMenu()
	CCP.AdminMenu.PlayerList = vgui.Create("DListView", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PlayerList:SetPos(10, 10)
	CCP.AdminMenu.PlayerList:SetSize(200, 403)
	CCP.AdminMenu.PlayerList:AddColumn("Character Name")
	CCP.AdminMenu.PlayerList:AddColumn("Player")

	for _, v in pairs(player.GetAll()) do

		local line = CCP.AdminMenu.PlayerList:AddLine(v:VisibleRPName(), v:Nick())
		line.Player = v
		line.SteamID = v:SteamID()

	end

	CCP.AdminMenu.SelectedID = nil

	function CCP.AdminMenu.PlayerList:OnRowSelected(id, line)

		CCP.AdminMenu.SelectedID = id

		GAMEMODE:AdminPlayerMenuEnable(line.Player)

	end

	CCP.AdminMenu.KickLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.KickLabel:SetText("Kick Reason")
	CCP.AdminMenu.KickLabel:SetPos(220, 10)
	CCP.AdminMenu.KickLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.KickLabel:SizeToContents()
	CCP.AdminMenu.KickLabel:PerformLayout()

	CCP.AdminMenu.KickReason = vgui.Create("DTextEntry", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.KickReason:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.KickReason:SetPos(340, 10)
	CCP.AdminMenu.KickReason:SetSize(340, 20)
	CCP.AdminMenu.KickReason:SetFocusTopLevel()
	CCP.AdminMenu.KickReason:PerformLayout()

	CCP.AdminMenu.KickBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.KickBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.KickBut:SetText("Kick")
	CCP.AdminMenu.KickBut:SetPos(690, 10)
	CCP.AdminMenu.KickBut:SetSize(100, 20)
	function CCP.AdminMenu.KickBut:DoClick()

		RunConsoleCommand("rpa_kick", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, CCP.AdminMenu.KickReason:GetValue())

		CCP.AdminMenu.PlayerList:RemoveLine(CCP.AdminMenu.SelectedID)

		GAMEMODE:AdminPlayerMenuDisable()

	end
	CCP.AdminMenu.KickBut:SetDisabled(true)
	CCP.AdminMenu.KickBut:PerformLayout()

	CCP.AdminMenu.BanLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.BanLabel:SetText("Ban Reason")
	CCP.AdminMenu.BanLabel:SetPos(220, 40)
	CCP.AdminMenu.BanLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.BanLabel:SizeToContents()
	CCP.AdminMenu.BanLabel:PerformLayout()

	CCP.AdminMenu.BanReason = vgui.Create("DTextEntry", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.BanReason:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.BanReason:SetPos(340, 40)
	CCP.AdminMenu.BanReason:SetSize(450, 20)
	CCP.AdminMenu.BanReason:PerformLayout()

	CCP.AdminMenu.BanDLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.BanDLabel:SetText("Ban Duration")
	CCP.AdminMenu.BanDLabel:SetPos(220, 70)
	CCP.AdminMenu.BanDLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.BanDLabel:SizeToContents()
	CCP.AdminMenu.BanDLabel:PerformLayout()

	CCP.AdminMenu.BanDuration = vgui.Create("DTextEntry", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.BanDuration:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.BanDuration:SetPos(340, 70)
	CCP.AdminMenu.BanDuration:SetSize(40, 20)
	CCP.AdminMenu.BanDuration:PerformLayout()
	CCP.AdminMenu.BanDuration:SetValue("60")

	CCP.AdminMenu.BanBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.BanBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.BanBut:SetText("Ban")
	CCP.AdminMenu.BanBut:SetPos(580, 70)
	CCP.AdminMenu.BanBut:SetSize(100, 20)
	function CCP.AdminMenu.BanBut:DoClick()

		RunConsoleCommand("rpa_ban", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, CCP.AdminMenu.BanDuration:GetValue(), CCP.AdminMenu.BanReason:GetValue())

		CCP.AdminMenu.PlayerList:RemoveLine(CCP.AdminMenu.SelectedID)

		GAMEMODE:AdminPlayerMenuDisable()

	end
	CCP.AdminMenu.BanBut:SetDisabled(true)
	CCP.AdminMenu.BanBut:PerformLayout()

	CCP.AdminMenu.PBanBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PBanBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PBanBut:SetText("Permaban")
	CCP.AdminMenu.PBanBut:SetPos(690, 70)
	CCP.AdminMenu.PBanBut:SetSize(100, 20)
	function CCP.AdminMenu.PBanBut.DoClick()

		RunConsoleCommand("rpa_ban", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, "0", CCP.AdminMenu.BanReason:GetValue())

		CCP.AdminMenu.PlayerList:RemoveLine(CCP.AdminMenu.SelectedID)

		GAMEMODE:AdminPlayerMenuDisable()

	end
	CCP.AdminMenu.PBanBut:SetDisabled(true)
	CCP.AdminMenu.PBanBut:PerformLayout()

	CCP.AdminMenu.BringBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.BringBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.BringBut:SetText("Bring")
	CCP.AdminMenu.BringBut:SetPos(220, 100)
	CCP.AdminMenu.BringBut:SetSize(100, 20)
	function CCP.AdminMenu.BringBut:DoClick()

		RunConsoleCommand("rpa_bring", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID)

	end
	CCP.AdminMenu.BringBut:SetDisabled(true)
	CCP.AdminMenu.BringBut:PerformLayout()

	CCP.AdminMenu.GotoBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.GotoBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.GotoBut:SetText("Goto")
	CCP.AdminMenu.GotoBut:SetPos(340, 100)
	CCP.AdminMenu.GotoBut:SetSize(100, 20)
	function CCP.AdminMenu.GotoBut:DoClick()

		RunConsoleCommand("rpa_goto", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID)

	end
	CCP.AdminMenu.GotoBut:SetDisabled(true)
	CCP.AdminMenu.GotoBut:PerformLayout()

	CCP.AdminMenu.KillBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.KillBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.KillBut:SetText("Kill")
	CCP.AdminMenu.KillBut:SetPos(460, 100)
	CCP.AdminMenu.KillBut:SetSize(100, 20)
	function CCP.AdminMenu.KillBut:DoClick()

		RunConsoleCommand("rpa_kill", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID)

	end
	CCP.AdminMenu.KillBut:SetDisabled(true)
	CCP.AdminMenu.KillBut:PerformLayout()

	CCP.AdminMenu.SlapBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.SlapBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.SlapBut:SetText("Slap")
	CCP.AdminMenu.SlapBut:SetPos(580, 100)
	CCP.AdminMenu.SlapBut:SetSize(100, 20)
	function CCP.AdminMenu.SlapBut:DoClick()

		RunConsoleCommand("rpa_slap", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID)

	end
	CCP.AdminMenu.SlapBut:SetDisabled(true)
	CCP.AdminMenu.SlapBut:PerformLayout()

	CCP.AdminMenu.KOBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.KOBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.KOBut:SetText("KO")
	CCP.AdminMenu.KOBut:SetPos(690, 100)
	CCP.AdminMenu.KOBut:SetSize(100, 20)
	function CCP.AdminMenu.KOBut:DoClick()

		RunConsoleCommand("rpa_ko", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID)

	end
	CCP.AdminMenu.KOBut:SetDisabled(true)
	CCP.AdminMenu.KOBut:PerformLayout()

	CCP.AdminMenu.GiveMoneyLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.GiveMoneyLabel:SetText("Give Money")
	CCP.AdminMenu.GiveMoneyLabel:SetPos(220, 130)
	CCP.AdminMenu.GiveMoneyLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.GiveMoneyLabel:SizeToContents()
	CCP.AdminMenu.GiveMoneyLabel:PerformLayout()

	CCP.AdminMenu.GiveMoney = vgui.Create("DTextEntry", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.GiveMoney:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.GiveMoney:SetPos(340, 130)
	CCP.AdminMenu.GiveMoney:SetSize(40, 20)
	CCP.AdminMenu.GiveMoney:SetNumeric(true)
	CCP.AdminMenu.GiveMoney:SetValue(0)
	CCP.AdminMenu.GiveMoney:PerformLayout()

	CCP.AdminMenu.GiveMoneyBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.GiveMoneyBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.GiveMoneyBut:SetText("Give")
	CCP.AdminMenu.GiveMoneyBut:SetPos(390, 130)
	CCP.AdminMenu.GiveMoneyBut:SetSize(100, 20)
	function CCP.AdminMenu.GiveMoneyBut:DoClick()

		RunConsoleCommand("rpa_givemoney", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, CCP.AdminMenu.GiveMoney:GetValue())

	end
	CCP.AdminMenu.GiveMoneyBut:SetDisabled(true)
	CCP.AdminMenu.GiveMoneyBut:PerformLayout()

	CCP.AdminMenu.CharSkinLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.CharSkinLabel:SetText("Character Skin")
	CCP.AdminMenu.CharSkinLabel:SetPos(500, 130)
	CCP.AdminMenu.CharSkinLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.CharSkinLabel:SizeToContents()
	CCP.AdminMenu.CharSkinLabel:PerformLayout()

	CCP.AdminMenu.CharSkin = vgui.Create("DTextEntry", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.CharSkin:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.CharSkin:SetPos(620, 130)
	CCP.AdminMenu.CharSkin:SetSize(30, 20)
	CCP.AdminMenu.CharSkin:SetNumeric(true)
	CCP.AdminMenu.CharSkin:SetValue(0)
	CCP.AdminMenu.CharSkin:PerformLayout()

	CCP.AdminMenu.CharSkinBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.CharSkinBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.CharSkinBut:SetText("Apply")
	CCP.AdminMenu.CharSkinBut:SetPos(690, 130)
	CCP.AdminMenu.CharSkinBut:SetSize(100, 20)
	function CCP.AdminMenu.CharSkinBut:DoClick()

		RunConsoleCommand("rpa_setcharskin", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, CCP.AdminMenu.CharSkin:GetValue())

	end
	CCP.AdminMenu.CharSkinBut:SetDisabled(true)
	CCP.AdminMenu.CharSkinBut:PerformLayout()

	CCP.AdminMenu.CharFlagLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.CharFlagLabel:SetText("Character Flag")
	CCP.AdminMenu.CharFlagLabel:SetPos(220, 160)
	CCP.AdminMenu.CharFlagLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.CharFlagLabel:SizeToContents()
	CCP.AdminMenu.CharFlagLabel:PerformLayout()

	CCP.AdminMenu.CharFlag = vgui.Create("DTextEntry", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.CharFlag:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.CharFlag:SetPos(340, 160)
	CCP.AdminMenu.CharFlag:SetSize(40, 20)
	CCP.AdminMenu.CharFlag:PerformLayout()

	CCP.AdminMenu.CharFlagBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.CharFlagBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.CharFlagBut:SetText("Apply")
	CCP.AdminMenu.CharFlagBut:SetPos(390, 160)
	CCP.AdminMenu.CharFlagBut:SetSize(100, 20)
	function CCP.AdminMenu.CharFlagBut:DoClick()

		RunConsoleCommand("rpa_setcharflag", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, CCP.AdminMenu.CharFlag:GetValue())

	end
	CCP.AdminMenu.CharFlagBut:SetDisabled(true)
	CCP.AdminMenu.CharFlagBut:PerformLayout()

	CCP.AdminMenu.ModelLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.ModelLabel:SetText("Character Model")
	CCP.AdminMenu.ModelLabel:SetPos(220, 220)
	CCP.AdminMenu.ModelLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.ModelLabel:SizeToContents()
	CCP.AdminMenu.ModelLabel:PerformLayout()

	CCP.AdminMenu.Model = vgui.Create("DTextEntry", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.Model:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.Model:SetPos(340, 220)
	CCP.AdminMenu.Model:SetSize(300, 20)
	CCP.AdminMenu.Model:PerformLayout()

	CCP.AdminMenu.ModelBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.ModelBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.ModelBut:SetText("Apply")
	CCP.AdminMenu.ModelBut:SetPos(650, 220)
	CCP.AdminMenu.ModelBut:SetSize(100, 20)
	function CCP.AdminMenu.ModelBut:DoClick()

		RunConsoleCommand("rpa_setcharmodel", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, CCP.AdminMenu.Model:GetValue())

	end
	CCP.AdminMenu.ModelBut:SetDisabled(true)
	CCP.AdminMenu.ModelBut:PerformLayout()

	CCP.AdminMenu.PhysTrust0 = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PhysTrust0:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PhysTrust0:SetText("Remove Physgun")
	CCP.AdminMenu.PhysTrust0:SetPos(220, 250)
	CCP.AdminMenu.PhysTrust0:SetSize(100, 20)
	function CCP.AdminMenu.PhysTrust0:DoClick()

		RunConsoleCommand("rpa_setphystrust", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, 0)
		CCP.AdminMenu.PhysTrust0:SetDisabled(true)
		CCP.AdminMenu.PhysTrust1:SetDisabled(false)

	end
	CCP.AdminMenu.PhysTrust0:SetDisabled(true)
	CCP.AdminMenu.PhysTrust0:PerformLayout()

	CCP.AdminMenu.PhysTrust1 = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PhysTrust1:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PhysTrust1:SetText("Give Physgun")
	CCP.AdminMenu.PhysTrust1:SetPos(330, 250)
	CCP.AdminMenu.PhysTrust1:SetSize(100, 20)
	function CCP.AdminMenu.PhysTrust1:DoClick()

		RunConsoleCommand("rpa_setphystrust", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, 1)
		CCP.AdminMenu.PhysTrust0:SetDisabled(false)
		CCP.AdminMenu.PhysTrust1:SetDisabled(true)

	end
	CCP.AdminMenu.PhysTrust1:SetDisabled(true)
	CCP.AdminMenu.PhysTrust1:PerformLayout()

	CCP.AdminMenu.PropTrust0 = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PropTrust0:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PropTrust0:SetText("Remove Proptrust")
	CCP.AdminMenu.PropTrust0:SetPos(220, 280)
	CCP.AdminMenu.PropTrust0:SetSize(100, 20)
	function CCP.AdminMenu.PropTrust0:DoClick()

		RunConsoleCommand("rpa_setproptrust", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, 0)
		CCP.AdminMenu.PropTrust0:SetDisabled(true)
		CCP.AdminMenu.PropTrust1:SetDisabled(false)

	end
	CCP.AdminMenu.PropTrust0:SetDisabled(true)
	CCP.AdminMenu.PropTrust0:PerformLayout()

	CCP.AdminMenu.PropTrust1 = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PropTrust1:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PropTrust1:SetText("Give Proptrust")
	CCP.AdminMenu.PropTrust1:SetPos(330, 280)
	CCP.AdminMenu.PropTrust1:SetSize(100, 20)
	function CCP.AdminMenu.PropTrust1:DoClick()

		RunConsoleCommand("rpa_setproptrust", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, 1)
		CCP.AdminMenu.PropTrust0:SetDisabled(false)
		CCP.AdminMenu.PropTrust1:SetDisabled(true)

	end
	CCP.AdminMenu.PropTrust1:SetDisabled(true)
	CCP.AdminMenu.PropTrust1:PerformLayout()

	CCP.AdminMenu.TT0 = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.TT0:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TT0:SetText("TT: None")
	CCP.AdminMenu.TT0:SetPos(220, 310)
	CCP.AdminMenu.TT0:SetSize(100, 20)
	function CCP.AdminMenu.TT0:DoClick()

		RunConsoleCommand("rpa_settooltrust", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, 0)
		CCP.AdminMenu.TT0:SetDisabled(true)
		CCP.AdminMenu.TT1:SetDisabled(false)
		CCP.AdminMenu.TT2:SetDisabled(false)

	end
	CCP.AdminMenu.TT0:SetDisabled(true)
	CCP.AdminMenu.TT0:PerformLayout()

	CCP.AdminMenu.TT1 = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.TT1:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TT1:SetText("TT: Basic")
	CCP.AdminMenu.TT1:SetPos(330, 310)
	CCP.AdminMenu.TT1:SetSize(100, 20)
	function CCP.AdminMenu.TT1:DoClick()

		RunConsoleCommand("rpa_settooltrust", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, 1)
		CCP.AdminMenu.TT0:SetDisabled(false)
		CCP.AdminMenu.TT1:SetDisabled(true)
		CCP.AdminMenu.TT2:SetDisabled(false)

	end
	CCP.AdminMenu.TT1:SetDisabled(true)
	CCP.AdminMenu.TT1:PerformLayout()

	CCP.AdminMenu.TT2 = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.TT2:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TT2:SetText("TT: Advanced")
	CCP.AdminMenu.TT2:SetPos(440, 310)
	CCP.AdminMenu.TT2:SetSize(100, 20)
	function CCP.AdminMenu.TT2:DoClick()

		RunConsoleCommand("rpa_settooltrust", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID, 2)
		CCP.AdminMenu.TT0:SetDisabled(false)
		CCP.AdminMenu.TT1:SetDisabled(false)
		CCP.AdminMenu.TT2:SetDisabled(true)

	end
	CCP.AdminMenu.TT2:SetDisabled(true)
	CCP.AdminMenu.TT2:PerformLayout()

	CCP.AdminMenu.OOCMute = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.OOCMute:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.OOCMute:SetText("OOC Mute")
	CCP.AdminMenu.OOCMute:SetPos(550, 250)
	CCP.AdminMenu.OOCMute:SetSize(100, 20)

	function CCP.AdminMenu.OOCMute:DoClick()
		RunConsoleCommand("rpa_oocmute", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID)
	end

	CCP.AdminMenu.OOCMute:SetDisabled(true)
	CCP.AdminMenu.OOCMute:PerformLayout()

	CCP.AdminMenu.TravelBan = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.TravelBan:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TravelBan:SetText("Travel Ban")
	CCP.AdminMenu.TravelBan:SetPos(550, 280)
	CCP.AdminMenu.TravelBan:SetSize(100, 20)

	function CCP.AdminMenu.TravelBan:DoClick()
		RunConsoleCommand("rpa_travelban", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID)
	end

	CCP.AdminMenu.TravelBan:SetDisabled(true)
	CCP.AdminMenu.TravelBan:PerformLayout()

	CCP.AdminMenu.EditInventory = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.EditInventory:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.EditInventory:SetText("Edit inventory...")
	CCP.AdminMenu.EditInventory:SetPos(220, 370)
	CCP.AdminMenu.EditInventory:SetSize(100, 20)
	function CCP.AdminMenu.EditInventory:DoClick()

		RunConsoleCommand("rpa_editinventory", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID)

	end
	CCP.AdminMenu.EditInventory:SetDisabled(true)
	CCP.AdminMenu.EditInventory:PerformLayout()

	CCP.AdminMenu.WarnName = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.WarnName:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.WarnName:SetText("Name Warning")
	CCP.AdminMenu.WarnName:SetPos(330, 370)
	CCP.AdminMenu.WarnName:SetSize(100, 20)
	function CCP.AdminMenu.WarnName:DoClick()

		RunConsoleCommand("rpa_namewarn", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID)

	end
	CCP.AdminMenu.WarnName:SetDisabled(true)
	CCP.AdminMenu.WarnName:PerformLayout()

	CCP.AdminMenu.PlayerNotes = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PlayerNotes:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PlayerNotes:SetText("Player Notes")
	CCP.AdminMenu.PlayerNotes:SetPos(440, 370)
	CCP.AdminMenu.PlayerNotes:SetSize(100, 20)
	function CCP.AdminMenu.PlayerNotes:DoClick()

		RunConsoleCommand("rpa_playernotes", CCP.AdminMenu.PlayerList:GetLine(CCP.AdminMenu.SelectedID).SteamID)

	end
	CCP.AdminMenu.PlayerNotes:SetDisabled(true)
	CCP.AdminMenu.PlayerNotes:PerformLayout()
end

function GM:AdminCreateBansMenu()
	CCP.AdminMenu.BansList = vgui.Create("DListView", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.BansList:SetPos(10, 10)
	CCP.AdminMenu.BansList:SetSize(780, 366)
	CCP.AdminMenu.BansList:AddColumn("User SteamID")
	CCP.AdminMenu.BansList:AddColumn("Admin SteamID")
	CCP.AdminMenu.BansList:AddColumn("Length")
	CCP.AdminMenu.BansList:AddColumn("Reason")
	CCP.AdminMenu.BansList:AddColumn("Date")
	CCP.AdminMenu.BansList:AddColumn("Time Remaining")

	CCP.AdminMenu.SelectedBanID = nil

	function CCP.AdminMenu.BansList:OnRowSelected(id, line)

		CCP.AdminMenu.SelectedBanID = id
		CCP.AdminMenu.UnbanBut:SetDisabled(false)

	end

	CCP.AdminMenu.BanBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.BanBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.BanBut:SetText("Ban SteamID")
	CCP.AdminMenu.BanBut:SetPos(10, 386)
	CCP.AdminMenu.BanBut:SetSize(100, 30)
	function CCP.AdminMenu.BanBut:DoClick()

		GAMEMODE:AMCreateBanEntry()

	end
	CCP.AdminMenu.BanBut:PerformLayout()

	CCP.AdminMenu.UnbanBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.UnbanBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.UnbanBut:SetText("Unban")
	CCP.AdminMenu.UnbanBut:SetPos(690, 386)
	CCP.AdminMenu.UnbanBut:SetSize(100, 30)
	function CCP.AdminMenu.UnbanBut:DoClick()

		RunConsoleCommand("rpa_unban", CCP.AdminMenu.BansList:GetLine(CCP.AdminMenu.SelectedBanID).SteamID)
		self:SetDisabled(true)

	end
	CCP.AdminMenu.UnbanBut:SetDisabled(true)
	CCP.AdminMenu.UnbanBut:PerformLayout()

	net.Start("nGetBansList")
	net.SendToServer()
end

function GM:AMCreateBanEntry()
	CCP.AdminMenu.BanEntry = vgui.Create("DFrame")
	CCP.AdminMenu.BanEntry:SetSize(300, 194)
	CCP.AdminMenu.BanEntry:Center()
	CCP.AdminMenu.BanEntry:SetTitle("Ban SteamID")
	CCP.AdminMenu.BanEntry.lblTitle:SetFont("CombineControl.Window")
	CCP.AdminMenu.BanEntry:MakePopup()
	CCP.AdminMenu.BanEntry.PerformLayout = CCFramePerformLayout
	CCP.AdminMenu.BanEntry:PerformLayout()

	CCP.AdminMenu.BanEntry.Think = UIAutoClose

	CCP.AdminMenu.BanEntry.Label1 = vgui.Create("DLabel", CCP.AdminMenu.BanEntry)
	CCP.AdminMenu.BanEntry.Label1:SetText("SteamID: ")
	CCP.AdminMenu.BanEntry.Label1:SetPos(10, 34)
	CCP.AdminMenu.BanEntry.Label1:SetSize(280, 30)
	CCP.AdminMenu.BanEntry.Label1:SetFont("CombineControl.LabelGiant")
	CCP.AdminMenu.BanEntry.Label1:PerformLayout()

	CCP.AdminMenu.BanEntry.Entry1 = vgui.Create("DTextEntry", CCP.AdminMenu.BanEntry)
	CCP.AdminMenu.BanEntry.Entry1:SetFont("CombineControl.LabelBig")
	CCP.AdminMenu.BanEntry.Entry1:SetPos(100, 34)
	CCP.AdminMenu.BanEntry.Entry1:SetSize(190, 30)
	CCP.AdminMenu.BanEntry.Entry1:PerformLayout()
	CCP.AdminMenu.BanEntry.Entry1:SetValue("")
	CCP.AdminMenu.BanEntry.Entry1:RequestFocus()

	CCP.AdminMenu.BanEntry.Label2 = vgui.Create("DLabel", CCP.AdminMenu.BanEntry)
	CCP.AdminMenu.BanEntry.Label2:SetText("Duration: ")
	CCP.AdminMenu.BanEntry.Label2:SetPos(10, 74)
	CCP.AdminMenu.BanEntry.Label2:SetSize(280, 30)
	CCP.AdminMenu.BanEntry.Label2:SetFont("CombineControl.LabelGiant")
	CCP.AdminMenu.BanEntry.Label2:PerformLayout()

	CCP.AdminMenu.BanEntry.Entry2 = vgui.Create("DTextEntry", CCP.AdminMenu.BanEntry)
	CCP.AdminMenu.BanEntry.Entry2:SetFont("CombineControl.LabelBig")
	CCP.AdminMenu.BanEntry.Entry2:SetPos(100, 74)
	CCP.AdminMenu.BanEntry.Entry2:SetSize(190, 30)
	CCP.AdminMenu.BanEntry.Entry2:PerformLayout()
	CCP.AdminMenu.BanEntry.Entry2:SetValue("")
	CCP.AdminMenu.BanEntry.Entry2:SetNumeric(true)

	CCP.AdminMenu.BanEntry.Label3 = vgui.Create("DLabel", CCP.AdminMenu.BanEntry)
	CCP.AdminMenu.BanEntry.Label3:SetText("Reason: ")
	CCP.AdminMenu.BanEntry.Label3:SetPos(10, 114)
	CCP.AdminMenu.BanEntry.Label3:SetSize(280, 30)
	CCP.AdminMenu.BanEntry.Label3:SetFont("CombineControl.LabelGiant")
	CCP.AdminMenu.BanEntry.Label3:PerformLayout()

	CCP.AdminMenu.BanEntry.Entry3 = vgui.Create("DTextEntry", CCP.AdminMenu.BanEntry)
	CCP.AdminMenu.BanEntry.Entry3:SetFont("CombineControl.LabelBig")
	CCP.AdminMenu.BanEntry.Entry3:SetPos(100, 114)
	CCP.AdminMenu.BanEntry.Entry3:SetSize(190, 30)
	CCP.AdminMenu.BanEntry.Entry3:PerformLayout()
	CCP.AdminMenu.BanEntry.Entry3:SetValue("")

	CCP.AdminMenu.BanEntry.OK = vgui.Create("DButton", CCP.AdminMenu.BanEntry)
	CCP.AdminMenu.BanEntry.OK:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.BanEntry.OK:SetText("OK")
	CCP.AdminMenu.BanEntry.OK:SetPos(240, 154)
	CCP.AdminMenu.BanEntry.OK:SetSize(50, 30)
	function CCP.AdminMenu.BanEntry.OK:DoClick()

		local sid = string.Trim(CCP.AdminMenu.BanEntry.Entry1:GetValue())
		local dur = string.Trim(CCP.AdminMenu.BanEntry.Entry2:GetValue())
		local reason = string.Trim(CCP.AdminMenu.BanEntry.Entry3:GetValue())

		if string.find(sid, "STEAM_") then

			if tonumber(dur) then

				if math.ceil(tonumber(dur)) > -1 then

					CCP.AdminMenu.BanEntry:Remove()

					RunConsoleCommand("rpa_ban", sid, math.ceil(tonumber(dur)), reason)

				else

					GAMEMODE:AddChat("Error: Negative duration specified.", Color(200, 0, 0, 255))

				end

			else

				GAMEMODE:AddChat("Error: Invalid duration specified.", Color(200, 0, 0, 255))

			end

		else

			GAMEMODE:AddChat("Error: Invalid SteamID specified.", Color(200, 0, 0, 255))

		end

	end
	CCP.AdminMenu.BanEntry.OK:PerformLayout()

	CCP.AdminMenu.BanEntry.Entry3.OnEnter = CCP.AdminMenu.BanEntry.OK.DoClick
end

net.Receive("nBansList", function(len)
	GAMEMODE.BanTable = net.ReadTable()

	if CCP.AdminMenu and CCP.AdminMenu.BansList and CCP.AdminMenu.BansList:IsValid() then

		CCP.AdminMenu.BansList:Clear()

		for id, data in pairs(GAMEMODE.BanTable) do

			local tr = math.max(math.ceil((data.Date + data.Length - os.time()) / 60), 0)

			if tonumber(data.Length) == 0 then

				data.Length = "Permanent"
				tr = ""

			else

				data.Length = tonumber(data.Length) / 60

			end

			local line = CCP.AdminMenu.BansList:AddLine(data.UserSteamID, data.AdminSteamID, data.Length, data.Reason, os.date("!%Y-%m-%d %H:%M:%S", data.Date), tr)
			line.SteamID = data.UserSteamID

		end

	end
end)

function GM:AdminCreateLogsMenu()
	CCP.AdminMenu.LogsPanel = vgui.Create("CCLogs", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.LogsPanel:Dock(FILL)
end

net.Receive("nLogList", function(len)
	local tab = net.ReadTable()
	local e = net.ReadFloat()

	if CCP.AdminMenu.LogList and CCP.AdminMenu.LogList:IsValid() then

		CCP.AdminMenu.LogList:Clear()

		if e == 1 then

			CCP.AdminMenu.LogList:AddLine("No logs to display.")

		elseif e > 1 then

			CCP.AdminMenu.LogList:AddLine("Showing " .. #tab - 1 .. "/" .. e - 1 .. " logs...")

		else

			CCP.AdminMenu.LogList:AddLine("Showing " .. #tab - 1 .. "/" .. #tab - 1 .. " logs...")

		end

		for k, v in pairs(tab) do

			if v != "" then

				CCP.AdminMenu.LogList:AddLine(string.gsub(v, "\t", "     "))

			end

		end

	end

	timer.Simple(0.01, function()

		if CCP.AdminMenu and CCP.AdminMenu.LogList and CCP.AdminMenu.LogList.VBar and CCP.AdminMenu.LogList.VBar:IsValid() then

			CCP.AdminMenu.LogList.VBar:SetScroll(math.huge)

		end

	end)
end)

function GM:AdminCreateArmory()
	local x = CCP.AdminMenu.ContentPane:GetWide() * 0.5

	CCP.AdminMenu.ArmoryOptions = vgui.Create("DComboBox", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.ArmoryOptions:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.ArmoryOptions:SetPos(x - 100, 10)
	CCP.AdminMenu.ArmoryOptions:SetSize(200, 20)
	CCP.AdminMenu.ArmoryOptions:SetSortItems(false)
	CCP.AdminMenu.ArmoryOptions:PerformLayout()

	function CCP.AdminMenu.ArmoryOptions:OnSelect(index, val)
		CCP.AdminMenu.ContentPane:Clear()

		GAMEMODE:CreateArmoryGUI(val, CCP.AdminMenu)
	end

	net.Start("nArmoryList")
	net.SendToServer()
end

net.Receive("nArmoryList", function(len)
	if not IsValid(CCP.AdminMenu.ArmoryOptions) then
		return
	end

	local count = net.ReadUInt(6)

	for i = 1, count do
		CCP.AdminMenu.ArmoryOptions:AddChoice(net.ReadString())
	end
end)

function GM:AdminCreateRoleplayMenu()
	CCP.AdminMenu.PlayMusicLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PlayMusicLabel:SetText("Music")
	CCP.AdminMenu.PlayMusicLabel:SetPos(10, 10)
	CCP.AdminMenu.PlayMusicLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.PlayMusicLabel:SizeToContents()
	CCP.AdminMenu.PlayMusicLabel:PerformLayout()

	CCP.AdminMenu.PlayMusic = vgui.Create("DListView", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PlayMusic:SetPos(150, 10)
	CCP.AdminMenu.PlayMusic:SetSize(420, 200)
	CCP.AdminMenu.PlayMusic:AddColumn("Song Type"):SetWidth(100)
	CCP.AdminMenu.PlayMusic:AddColumn("Song Name"):SetWidth(220)
	CCP.AdminMenu.PlayMusic:AddColumn("Length"):SetWidth(100)

	for k, v in pairs(GAMEMODE.TRPMusic) do

		local type = "Idle"

		if v[3] == SONG_ALERT then type = "Alert" end
		if v[3] == SONG_ACTION then type = "Action" end
		if v[3] == SONG_STINGER then type = "Stinger" end

		CCP.AdminMenu.PlayMusic:AddLine(type, v[4], string.ToMinutesSeconds(v[2])).Path = v[1]

	end

	function CCP.AdminMenu.PlayMusic:OnRowSelected(id, line)

		CCP.AdminMenu.PlayMusicBut:SetDisabled(false)
		CCP.AdminMenu.PreviewBut:SetDisabled(false)
		CCP.AdminMenu.TargetBut:SetDisabled(false)

	end

	CCP.AdminMenu.PlayMusicBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PlayMusicBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PlayMusicBut:SetText("Play")
	CCP.AdminMenu.PlayMusicBut:SetPos(580, 10)
	CCP.AdminMenu.PlayMusicBut:SetSize(100, 20)
	function CCP.AdminMenu.PlayMusicBut:DoClick()

		RunConsoleCommand("rpa_playmusic", CCP.AdminMenu.PlayMusic:GetSelected()[1].Path)

	end
	CCP.AdminMenu.PlayMusicBut:SetDisabled(true)
	CCP.AdminMenu.PlayMusicBut:PerformLayout()

	CCP.AdminMenu.StopMusicBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.StopMusicBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.StopMusicBut:SetText("Stop All Music")
	CCP.AdminMenu.StopMusicBut:SetPos(580, 40)
	CCP.AdminMenu.StopMusicBut:SetSize(100, 20)
	function CCP.AdminMenu.StopMusicBut:DoClick()

		RunConsoleCommand("rpa_stopmusic")

	end
	CCP.AdminMenu.StopMusicBut:PerformLayout()

	CCP.AdminMenu.StopMusicBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.StopMusicBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.StopMusicBut:SetText("Stop Your Music")
	CCP.AdminMenu.StopMusicBut:SetPos(580, 70)
	CCP.AdminMenu.StopMusicBut:SetSize(100, 20)
	function CCP.AdminMenu.StopMusicBut:DoClick()

		GAMEMODE:FadeOutMusic()

	end
	CCP.AdminMenu.StopMusicBut:PerformLayout()

	CCP.AdminMenu.PreviewBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PreviewBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PreviewBut:SetText("Preview")
	CCP.AdminMenu.PreviewBut:SetPos(580, 100)
	CCP.AdminMenu.PreviewBut:SetSize(100, 20)
	function CCP.AdminMenu.PreviewBut:DoClick()

		GAMEMODE:PlayMusic(CCP.AdminMenu.PlayMusic:GetSelected()[1].Path)

	end
	CCP.AdminMenu.PreviewBut:SetDisabled(true)
	CCP.AdminMenu.PreviewBut:PerformLayout()

	CCP.AdminMenu.TargetBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.TargetBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.TargetBut:SetText("Targets...")
	CCP.AdminMenu.TargetBut:SetPos(580, 130)
	CCP.AdminMenu.TargetBut:SetSize(100, 20)
	function CCP.AdminMenu.TargetBut:DoClick()

		CCP.MusicTargets = vgui.Create("DFrame")
		CCP.MusicTargets:SetSize(400, 534)
		CCP.MusicTargets:Center()
		CCP.MusicTargets:SetTitle("Targeted Music")
		CCP.MusicTargets.lblTitle:SetFont("CombineControl.Window")
		CCP.MusicTargets:MakePopup()
		CCP.MusicTargets.PerformLayout = CCFramePerformLayout
		CCP.MusicTargets:PerformLayout()

		CCP.MusicTargets.Think = UIAutoClose

		CCP.MusicTargets.AllPlayers = vgui.Create("DListView", CCP.MusicTargets)
		CCP.MusicTargets.AllPlayers:SetPos(10, 34)
		CCP.MusicTargets.AllPlayers:SetSize(185, 430)
		CCP.MusicTargets.AllPlayers:AddColumn("Players")
		function CCP.MusicTargets.AllPlayers:DoDoubleClick(id, line)

			local ply = CCP.MusicTargets.AllPlayers:GetLine(id).Player

			CCP.MusicTargets.AllPlayers:RemoveLine(id)
			CCP.MusicTargets.Targets:AddLine(ply:VisibleRPName()).Player = ply

		end

		for k, v in pairs(player.GetAll()) do

			CCP.MusicTargets.AllPlayers:AddLine(v:VisibleRPName()).Player = v

		end

		CCP.MusicTargets.Targets = vgui.Create("DListView", CCP.MusicTargets)
		CCP.MusicTargets.Targets:SetPos(205, 34)
		CCP.MusicTargets.Targets:SetSize(185, 430)
		CCP.MusicTargets.Targets:AddColumn("Targets")
		function CCP.MusicTargets.Targets:DoDoubleClick(id, line)

			local ply = CCP.MusicTargets.Targets:GetLine(id).Player

			CCP.MusicTargets.Targets:RemoveLine(id)
			CCP.MusicTargets.AllPlayers:AddLine(ply:VisibleRPName()).Player = ply

		end

		CCP.MusicTargets.MakeTarget = vgui.Create("DButton", CCP.MusicTargets)
		CCP.MusicTargets.MakeTarget:SetFont("CombineControl.LabelSmall")
		CCP.MusicTargets.MakeTarget:SetText(">")
		CCP.MusicTargets.MakeTarget:SetPos(10, 474)
		CCP.MusicTargets.MakeTarget:SetSize(185, 20)
		function CCP.MusicTargets.MakeTarget:DoClick()

			if not CCP.MusicTargets.AllPlayers:GetSelected()[1] then return end

			local ply = CCP.MusicTargets.AllPlayers:GetSelected()[1].Player
			CCP.MusicTargets.AllPlayers:RemoveLine(CCP.MusicTargets.AllPlayers:GetSelected()[1]:GetID())
			CCP.MusicTargets.Targets:AddLine(ply:VisibleRPName()).Player = ply

		end
		CCP.MusicTargets.MakeTarget:PerformLayout()

		CCP.MusicTargets.MakePlayer = vgui.Create("DButton", CCP.MusicTargets)
		CCP.MusicTargets.MakePlayer:SetFont("CombineControl.LabelSmall")
		CCP.MusicTargets.MakePlayer:SetText("<")
		CCP.MusicTargets.MakePlayer:SetPos(205, 474)
		CCP.MusicTargets.MakePlayer:SetSize(185, 20)
		function CCP.MusicTargets.MakePlayer:DoClick()

			if not CCP.MusicTargets.Targets:GetSelected()[1] then return end

			local ply = CCP.MusicTargets.Targets:GetSelected()[1].Player
			CCP.MusicTargets.Targets:RemoveLine(CCP.MusicTargets.Targets:GetSelected()[1]:GetID())
			CCP.MusicTargets.AllPlayers:AddLine(ply:VisibleRPName()).Player = ply

		end
		CCP.MusicTargets.MakePlayer:PerformLayout()

		CCP.MusicTargets.PlayBut = vgui.Create("DButton", CCP.MusicTargets)
		CCP.MusicTargets.PlayBut:SetFont("CombineControl.LabelSmall")
		CCP.MusicTargets.PlayBut:SetText("Play Music")
		CCP.MusicTargets.PlayBut:SetPos(10, 504)
		CCP.MusicTargets.PlayBut:SetSize(100, 20)
		function CCP.MusicTargets.PlayBut:DoClick()

			if CCP.AdminMenu and CCP.AdminMenu:IsValid() then

				local tab = {}

				for k, v in pairs(CCP.MusicTargets.Targets:GetLines()) do

					table.insert(tab, v.Player:SteamID())

				end

				RunConsoleCommand("rpa_playmusictarget", CCP.AdminMenu.PlayMusic:GetSelected()[1].Path, unpack(tab))

			end

		end
		CCP.MusicTargets.PlayBut:PerformLayout()

		CCP.MusicTargets.VisibleBut = vgui.Create("DButton", CCP.MusicTargets)
		CCP.MusicTargets.VisibleBut:SetFont("CombineControl.LabelSmall")
		CCP.MusicTargets.VisibleBut:SetText("Select Visible")
		CCP.MusicTargets.VisibleBut:SetPos(120, 504)
		CCP.MusicTargets.VisibleBut:SetSize(100, 20)
		function CCP.MusicTargets.VisibleBut:DoClick()

			CCP.MusicTargets.AllPlayers:Clear()
			CCP.MusicTargets.Targets:Clear()

			for _, v in pairs(player.GetAll()) do

				if LocalPlayer():CanSee(v) then

					CCP.MusicTargets.Targets:AddLine(v:VisibleRPName()).Player = v

				else

					CCP.MusicTargets.AllPlayers:AddLine(v:VisibleRPName()).Player = v

				end

			end

		end
		CCP.MusicTargets.VisibleBut:PerformLayout()

		CCP.MusicTargets.RadialBut = vgui.Create("DButton", CCP.MusicTargets)
		CCP.MusicTargets.RadialBut:SetFont("CombineControl.LabelSmall")
		CCP.MusicTargets.RadialBut:SetText("Select Radius...")
		CCP.MusicTargets.RadialBut:SetPos(230, 504)
		CCP.MusicTargets.RadialBut:SetSize(100, 20)
		function CCP.MusicTargets.RadialBut:DoClick()

			CCP.MusicTargets.RadialWin = vgui.Create("DFrame")
			CCP.MusicTargets.RadialWin:SetSize(250, 114)
			CCP.MusicTargets.RadialWin:Center()
			CCP.MusicTargets.RadialWin:SetTitle("Select Radius")
			CCP.MusicTargets.RadialWin.lblTitle:SetFont("CombineControl.Window")
			CCP.MusicTargets.RadialWin:MakePopup()
			CCP.MusicTargets.RadialWin.PerformLayout = CCFramePerformLayout
			CCP.MusicTargets.RadialWin:PerformLayout()

			CCP.MusicTargets.RadialWin.Think = UIAutoClose

			CCP.MusicTargets.RadialWin.Entry = vgui.Create("DTextEntry", CCP.MusicTargets.RadialWin)
			CCP.MusicTargets.RadialWin.Entry:SetFont("CombineControl.LabelBig")
			CCP.MusicTargets.RadialWin.Entry:SetPos(10, 34)
			CCP.MusicTargets.RadialWin.Entry:SetSize(100, 30)
			CCP.MusicTargets.RadialWin.Entry:PerformLayout()
			CCP.MusicTargets.RadialWin.Entry:RequestFocus()
			CCP.MusicTargets.RadialWin.Entry:SetNumeric(true)
			CCP.MusicTargets.RadialWin.Entry:SetCaretPos(#CCP.MusicTargets.RadialWin.Entry:GetValue())

			CCP.MusicTargets.RadialWin.Label = vgui.Create("DLabel", CCP.MusicTargets.RadialWin)
			CCP.MusicTargets.RadialWin.Label:SetText("meters")
			CCP.MusicTargets.RadialWin.Label:SetPos(120, 34)
			CCP.MusicTargets.RadialWin.Label:SetSize(130, 30)
			CCP.MusicTargets.RadialWin.Label:SetFont("CombineControl.LabelBig")
			CCP.MusicTargets.RadialWin.Label:PerformLayout()

			CCP.MusicTargets.RadialWin.OK = vgui.Create("DButton", CCP.MusicTargets.RadialWin)
			CCP.MusicTargets.RadialWin.OK:SetFont("CombineControl.LabelSmall")
			CCP.MusicTargets.RadialWin.OK:SetText("OK")
			CCP.MusicTargets.RadialWin.OK:SetPos(190, 74)
			CCP.MusicTargets.RadialWin.OK:SetSize(50, 30)
			function CCP.MusicTargets.RadialWin.OK:DoClick()

				local val = tonumber(CCP.MusicTargets.RadialWin.Entry:GetValue())

				if val < 1 then

					CCP.MusicTargets.RadialWin:Remove()
					return

				end

				CCP.MusicTargets.AllPlayers:Clear()
				CCP.MusicTargets.Targets:Clear()

				for _, v in pairs(player.GetAll()) do

					if math.ceil(LocalPlayer():EyePos():Distance(v:EyePos()) * 0.01905) <= val then

						CCP.MusicTargets.Targets:AddLine(v:VisibleRPName()).Player = v

					else

						CCP.MusicTargets.AllPlayers:AddLine(v:VisibleRPName()).Player = v

					end

				end

				CCP.MusicTargets.RadialWin:Remove()

			end
			CCP.MusicTargets.RadialWin.OK:PerformLayout()

			CCP.MusicTargets.RadialWin.Entry.OnEnter = CCP.MusicTargets.RadialWin.OK.DoClick

		end
		CCP.MusicTargets.RadialBut:PerformLayout()

	end
	CCP.AdminMenu.TargetBut:SetDisabled(true)
	CCP.AdminMenu.TargetBut:PerformLayout()

	CCP.AdminMenu.PlayMusicIdle = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PlayMusicIdle:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PlayMusicIdle:SetText("Random Idle")
	CCP.AdminMenu.PlayMusicIdle:SetPos(690, 10)
	CCP.AdminMenu.PlayMusicIdle:SetSize(100, 20)
	function CCP.AdminMenu.PlayMusicIdle:DoClick()

		RunConsoleCommand("rpa_playmusic", SONG_IDLE)

	end
	CCP.AdminMenu.PlayMusicIdle:PerformLayout()

	CCP.AdminMenu.PlayMusicAlert = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PlayMusicAlert:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PlayMusicAlert:SetText("Random Alert")
	CCP.AdminMenu.PlayMusicAlert:SetPos(690, 40)
	CCP.AdminMenu.PlayMusicAlert:SetSize(100, 20)
	function CCP.AdminMenu.PlayMusicAlert:DoClick()

		RunConsoleCommand("rpa_playmusic", SONG_ALERT)

	end
	CCP.AdminMenu.PlayMusicAlert:PerformLayout()

	CCP.AdminMenu.PlayMusicAction = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PlayMusicAction:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PlayMusicAction:SetText("Random Action")
	CCP.AdminMenu.PlayMusicAction:SetPos(690, 70)
	CCP.AdminMenu.PlayMusicAction:SetSize(100, 20)
	function CCP.AdminMenu.PlayMusicAction:DoClick()

		RunConsoleCommand("rpa_playmusic", SONG_ACTION)

	end
	CCP.AdminMenu.PlayMusicAction:PerformLayout()

	CCP.AdminMenu.PlayMusicStinger = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PlayMusicStinger:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PlayMusicStinger:SetText("Random Stinger")
	CCP.AdminMenu.PlayMusicStinger:SetPos(690, 100)
	CCP.AdminMenu.PlayMusicStinger:SetSize(100, 20)
	function CCP.AdminMenu.PlayMusicStinger:DoClick()

		RunConsoleCommand("rpa_playmusic", SONG_STINGER)

	end
	CCP.AdminMenu.PlayMusicStinger:PerformLayout()

	CCP.AdminMenu.OWLineLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.OWLineLabel:SetText("Overwatch Line")
	CCP.AdminMenu.OWLineLabel:SetPos(10, 220)
	CCP.AdminMenu.OWLineLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.OWLineLabel:SizeToContents()
	CCP.AdminMenu.OWLineLabel:PerformLayout()

	CCP.AdminMenu.OWLine = vgui.Create("DComboBox", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.OWLine:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.OWLine:SetValue("Overwatch Line")
	CCP.AdminMenu.OWLine:SetPos(150, 220)
	CCP.AdminMenu.OWLine:SetSize(310, 20)
	CCP.AdminMenu.OWLine:PerformLayout()

	for k, v in pairs(GAMEMODE.OverwatchLines) do

		CCP.AdminMenu.OWLine:AddChoice(v[2], k)

	end

	function CCP.AdminMenu.OWLine:OnSelect(index, val, data)

		CCP.AdminMenu.OWLine.DataVal = data

	end

	CCP.AdminMenu.PlayOWLine = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.PlayOWLine:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.PlayOWLine:SetText("Play")
	CCP.AdminMenu.PlayOWLine:SetPos(470, 220)
	CCP.AdminMenu.PlayOWLine:SetSize(100, 20)
	function CCP.AdminMenu.PlayOWLine:DoClick()

		if CCP.AdminMenu.OWLine.DataVal then

			RunConsoleCommand("rpa_playoverwatch", CCP.AdminMenu.OWLine.DataVal)

		end

	end
	CCP.AdminMenu.PlayOWLine:PerformLayout()

	CCP.AdminMenu.SpawnItemLabel = vgui.Create("DLabel", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.SpawnItemLabel:SetText("Spawn Item")
	CCP.AdminMenu.SpawnItemLabel:SetPos(10, 250)
	CCP.AdminMenu.SpawnItemLabel:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.SpawnItemLabel:SizeToContents()
	CCP.AdminMenu.SpawnItemLabel:PerformLayout()

	CCP.AdminMenu.SpawnItem = vgui.Create("DTextEntry", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.SpawnItem:SetFont("CombineControl.LabelMedium")
	CCP.AdminMenu.SpawnItem:SetPos(150, 250)
	CCP.AdminMenu.SpawnItem:SetSize(140, 20)
	CCP.AdminMenu.SpawnItem:PerformLayout()

	CCP.AdminMenu.SpawnItemBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.SpawnItemBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.SpawnItemBut:SetText("Spawn")
	CCP.AdminMenu.SpawnItemBut:SetPos(300, 250)
	CCP.AdminMenu.SpawnItemBut:SetSize(100, 20)
	function CCP.AdminMenu.SpawnItemBut:DoClick()

		if CCP.AdminMenu.SpawnItem:GetValue() != "" then

			RunConsoleCommand("rpa_createitem", CCP.AdminMenu.SpawnItem:GetValue())

		end

	end
	CCP.AdminMenu.SpawnItemBut:PerformLayout()

	CCP.AdminMenu.ListItemsBut = vgui.Create("DButton", CCP.AdminMenu.ContentPane)
	CCP.AdminMenu.ListItemsBut:SetFont("CombineControl.LabelSmall")
	CCP.AdminMenu.ListItemsBut:SetText("Item List...")
	CCP.AdminMenu.ListItemsBut:SetPos(410, 250)
	CCP.AdminMenu.ListItemsBut:SetSize(100, 20)
	function CCP.AdminMenu.ListItemsBut:DoClick()

		CCP.ItemsList = vgui.Create("DFrame")
		CCP.ItemsList:SetSize(590, 450)
		CCP.ItemsList:Center()
		CCP.ItemsList:SetTitle("Item List")
		CCP.ItemsList.lblTitle:SetFont("CombineControl.Window")
		CCP.ItemsList:MakePopup()
		CCP.ItemsList.PerformLayout = CCFramePerformLayout
		CCP.ItemsList:PerformLayout()

		CCP.ItemsList.Think = UIAutoClose

		CCP.ItemsList.Pane = vgui.Create("DScrollPanel", CCP.ItemsList)
		CCP.ItemsList.Pane:SetSize(570, 406)
		CCP.ItemsList.Pane:SetPos(10, 34)
		function CCP.ItemsList.Pane:Paint(w, h)

			surface.SetDrawColor(30, 30, 30, 255)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(20, 20, 20, 100)
			surface.DrawOutlinedRect(0, 0, w, h)

		end

		local y = 0

		for _, v in pairs(GAMEMODE.Items) do

			if not v.EasterEgg then

				local itempane = vgui.Create("DPanel")
				itempane:SetPos(0, y)
				itempane:SetSize(556, 64)
				function itempane:Paint(w, h)

					surface.SetDrawColor(0, 0, 0, 70)
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(0, 0, 0, 100)
					surface.DrawOutlinedRect(0, 0, w, h)

				end

				local icon = vgui.Create("DModelPanel", itempane)
				icon:SetPos(0, 0)
				icon:SetModel(v.Model)
				icon:SetSize(64, 64)

				if v.LookAt then

					icon:SetFOV(v.FOV)
					icon:SetCamPos(v.CamPos)
					icon:SetLookAt(v.LookAt)

				else

					local a, b = icon.Entity:GetModelBounds()

					icon:SetFOV(20)
					icon:SetCamPos(Vector(math.abs(a.x), math.abs(a.y), math.abs(a.z)) * 5)
					icon:SetLookAt((a + b) / 2)

				end

				if v.IconMaterial then icon.Entity:SetMaterial(v.IconMaterial) end
				if v.IconSkin then icon.Entity:SetSkin(v.IconSkin) end
				if v.IconColor then icon.Entity:SetColor(v.IconColor) end

				icon.Entity:SetBodygroup(v.BodygroupCategory or 1, v.Bodygroup or 0)

				function icon:LayoutEntity() end

				local p = icon.Paint

				function icon:Paint(w, h)

					local pnl = CCP.ItemsList.Pane
					local x2, y2 = pnl:LocalToScreen(0, 0)
					local w2, h2 = pnl:GetSize()
					render.SetScissorRect(x2, y2, x2 + w2, y2 + h2, true)

					p(self, w, h)

					render.SetScissorRect(0, 0, 0, 0, false)

				end

				function icon:DoClick()

					if CCP.AdminMenu and CCP.AdminMenu:IsValid() and CCP.AdminMenu.SpawnItem then

						CCP.AdminMenu.SpawnItem:SetValue(v.ID)
						CCP.ItemsList:Remove()

					end

				end

				local name = vgui.Create("DLabel", itempane)
				name:SetText(v.Name)
				name:SetPos(74, 10)
				name:SetFont("CombineControl.LabelSmall")
				name:SizeToContents()
				name:PerformLayout()

				surface.SetFont("CombineControl.LabelSmall")
				local a, b = surface.GetTextSize(v.Name)

				local id = vgui.Create("DLabel", itempane)
				id:SetText("ID: " .. v.ID)
				id:SetPos(74 + a + 10, 10)
				id:SetFont("CombineControl.LabelTiny")
				id:SetTextColor(Color(200, 200, 100, 255))
				id:SizeToContents()
				id:PerformLayout()

				local d, n = GAMEMODE:FormatLine(v.Description, "CombineControl.LabelTiny", 472)

				local desc = vgui.Create("DLabel", itempane)
				desc:SetText(d)
				desc:SetPos(74, 24)
				desc:SetFont("CombineControl.LabelTiny")
				desc:SizeToContents()
				desc:PerformLayout()

				CCP.ItemsList.Pane:Add(itempane)

				y = y + 64

			end

		end

	end
	CCP.AdminMenu.ListItemsBut:PerformLayout()
end
