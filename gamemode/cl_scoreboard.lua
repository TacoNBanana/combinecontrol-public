function GM:ScoreboardHide()
	if CCP.Scoreboard then

		CCP.Scoreboard:Remove()

	end

	CCP.Scoreboard = nil
end

local function sortf(a, b)
	return a:VisibleRPName() < b:VisibleRPName()
end

local function isHiddenFromScoreboard(ply)
	if ply:Hidden() then return true end
	if ply:GetCharFlagAttribute("IsHidden") then return true end

	if not LocalPlayer():IsAdmin() and ply:Team() == TEAM_SKYNET and LocalPlayer():Team() ~= TEAM_SKYNET then return true end
end

function GM:ScoreboardShow()
	CCP.Scoreboard = vgui.Create("DPanel")
	CCP.Scoreboard:SetSize(620, 600)
	CCP.Scoreboard:Center()
	CCP.Scoreboard:MakePopup()
	CCP.Scoreboard:SetKeyboardInputEnabled(false)

	function CCP.Scoreboard:Paint(w, h)

		draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 230))
		draw.RoundedBox(0, 0, 0, w, 50, Color(20, 20, 20, 255))

		surface.SetFont("CombineControl.LabelMassive")
		surface.SetTextColor(200, 200, 200, 255)
		surface.SetTextPos(10, 10)
		surface.DrawText("Taco N Banana")

		return true

	end

	CCP.Scoreboard.Players = vgui.Create("DScrollPanel", CCP.Scoreboard)
	CCP.Scoreboard.Players:SetPos(0, 50)
	CCP.Scoreboard.Players:SetSize(620, CCP.Scoreboard:GetTall() - 50)
	function CCP.Scoreboard.Players:Paint(w, h) end

	local y = 10

	for _, t in pairs(table.GetKeys(team.GetAllTeams())) do
		if team.NumPlayers(t) > 0 then
			local name = nil
			local n = true

			local plys = team.GetPlayers(t)
			table.sort(plys, sortf)

			for _, p in ipairs(plys) do
				if isHiddenFromScoreboard(p, t) then continue end

				if not name then -- Lazyload labels for hidden characters
					name = vgui.Create("DLabel", CCP.Scoreboard.Players)
					name:SetText(team.GetName(t))
					name:SetPos(10, y)
					name:SetFont("CombineControl.LabelGiant")
					name:SizeToContents()
					name:PerformLayout()
					CCP.Scoreboard.Players:AddItem(name)
					y = y + 32
				end

				self:ScoreboardAdd(p, y, n)
				y = y + 58
				n = not n

			end

			y = y + 10

		end

	end

	CCP.Scoreboard.Players:PerformLayout()
end

GM.BronzeMat = Material("icon16/medal_bronze_1.png")
GM.SilverMat = Material("icon16/medal_silver_1.png")
GM.GoldMat = Material("icon16/medal_gold_1.png")
GM.AdminMat = Material("icon16/shield.png")
GM.SuperAdminMat = Material("icon16/shield_add.png")
GM.DeveloperMat = Material("icon16/tag.png")
GM.UnreadNotesMat = Material("icon16/comment_add.png")
GM.OOCMutedMat = Material("icon16/keyboard_mute.png")
GM.TravelBannedMat = Material("icon16/delete.png")

GM.ScoreboardBadges = {}
GM.ScoreboardBadges[BADGE_BETATEST] = {Material("icon16/controller.png"), "Beta Tester"}
GM.ScoreboardBadges[BADGE_BETASCR] = {Material("icon16/picture_edit.png"), "Screenshot Contest Winner"}
GM.ScoreboardBadges[BADGE_BIRTHDAY] = {Material("icon16/cake.png"), "Gang's Birthday"}
GM.ScoreboardBadges[BADGE_BUGGER] = {Material("icon16/bug.png"), "Bug Hunter"}

function GM:ScoreboardAdd(ply, y, n)
	local entry = vgui.Create("DPanel", CCP.Scoreboard.Players)
	entry:SetSize(620, 58)
	function entry:Paint(w, h)

		if not ply or not ply:IsValid() then

			self:Remove()
			return

		end

		if n then

			draw.RoundedBox(0, 0, 0, w, h, Color(20, 20, 20, 130))

		end

		local desc = ply:Description():match("^[^\r\n]*")
		if #desc > 64 then
			desc = desc:sub(1, 64) .. "..."
		end

		local nameY, descY, titleY = 10, 28, 28
		if #desc > 0 and not ply:HideAdmin() and #ply:ScoreboardTitle() > 0 then
			nameY = 5
			descY = 22
			titleY = 40
		end

		local pingY, badgeY, infoY = nameY, descY, titleY
		if badgeY == infoY and ply:ScoreboardBadges() > 0 or ((ply:IsAdmin() or ply:DonationAmount() > GAMEMODE.BronzeDonorAmount) and not ply:HideAdmin()) or (LocalPlayer():IsAdmin() and ply:LastNotesUpdate() > 0 and cookie.GetNumber("cc_lastnoteread_" .. ply:SteamID64(), 0) < ply:LastNotesUpdate()) or (LocalPlayer():IsAdmin() and (ply:IsOOCMuted() or ply:IsTravelBanned())) then
			pingY = 5
			badgeY = 22
			infoY = 40
		end

		surface.SetTextColor(200, 200, 200, 255)
		surface.SetFont("CombineControl.LabelSmall")
		surface.SetTextPos(58, nameY)
		surface.DrawText(ply:VisibleRPName())

		if #desc > 0 then
			surface.SetTextColor(150, 150, 150)
			surface.SetTextPos(58, descY)
			surface.DrawText(desc)
		end


		local x, _ = surface.GetTextSize(ply:Ping())

		surface.SetTextColor(200, 200, 200, 255)
		surface.SetTextPos(w - 30 - x, pingY)
		surface.DrawText(ply:Ping())

		if not ply:HideAdmin() then

			local titlec = ply:ScoreboardTitleC()

			surface.SetTextColor(titlec.x, titlec.y, titlec.z, 255)
			surface.SetFont("CombineControl.LabelTiny")
			surface.SetTextPos(58, titleY)
			surface.DrawText(ply:ScoreboardTitle())

		end

		local badgepos = w - 39

		if LocalPlayer():IsAdmin() and ply:LastNotesUpdate() > 0 and cookie.GetNumber("cc_lastnoteread_" .. ply:SteamID64(), 0) < ply:LastNotesUpdate() then
			surface.SetMaterial(GAMEMODE.UnreadNotesMat)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(badgepos, badgeY, 14, 14)

			badgepos = badgepos - 16
		end

		if LocalPlayer():IsAdmin() and ply:IsOOCMuted() then
			surface.SetMaterial(GAMEMODE.OOCMutedMat)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(badgepos, badgeY, 14, 14)

			badgepos = badgepos - 16
		end

		if LocalPlayer():IsAdmin() and ply:IsTravelBanned() then
			surface.SetMaterial(GAMEMODE.TravelBannedMat)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(badgepos, badgeY, 14, 14)

			badgepos = badgepos - 16
		end

		if ply:IsAdmin() and not ply:HideAdmin() then

			local mat = GAMEMODE.AdminMat

			if ply:IsDeveloper() then

				mat = GAMEMODE.DeveloperMat

			elseif ply:IsSuperAdmin() then

				mat = GAMEMODE.SuperAdminMat

			end

			surface.SetMaterial(mat)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(badgepos, badgeY, 14, 14)

			badgepos = badgepos - 16

		end

		if ply:DonationAmount() > GAMEMODE.BronzeDonorAmount and not ply:HideAdmin() then

			local mat = GAMEMODE.BronzeMat

			if ply:DonationAmount() > GAMEMODE.GoldDonorAmount then

				mat = GAMEMODE.GoldMat

			elseif ply:DonationAmount() > GAMEMODE.SilverDonorAmount then

				mat = GAMEMODE.SilverMat

			end

			surface.SetMaterial(mat)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(badgepos, badgeY, 14, 14)

			badgepos = badgepos - 16

		end

		for k, v in pairs(GAMEMODE.ScoreboardBadges) do

			if ply:HasBadge(k) and not ply:HideAdmin() then

				surface.SetMaterial(v[1])
				surface.SetDrawColor(255, 255, 255, 255)
				surface.DrawTexturedRect(badgepos, badgeY, 14, 14)

				badgepos = badgepos - 16

			end

		end

		if LocalPlayer():IsAdmin() then
			surface.SetFont("CombineControl.LabelTiny")
			local x, _ = surface.GetTextSize(ply:Nick())

			surface.SetTextColor(200, 200, 200, 255)
			surface.SetTextPos(w - 30 - x, infoY)
			surface.DrawText(ply:Nick())
		end

	end

	entry:SetPos(0, y)

	local icon = vgui.Create("DModelPanel", entry)
	icon:SetPos(0, 0)
	icon:SetModel(ply:GetModel())
	icon:SetSize(48, 48)

	local a, b = icon.Entity:GetModelBounds()

	icon:SetFOV(20)
	icon:SetCamPos(Vector(60, -20, math.max(a.z, b.z) - 8))
	icon:SetLookAt(Vector(0, 0, math.max(a.z, b.z) - 8))

	function icon:LayoutEntity() end

	local p = icon.Paint

	function icon:Paint(w, h)
		local pnl = CCP.Scoreboard.Players
		local x2, y2 = pnl:LocalToScreen(0, 0)
		local w2, h2 = pnl:GetSize()

		render.SetScissorRect(x2, y2, x2 + w2, y2 + h2, true)

		p(self, w, h)

		render.SetScissorRect(0, 0, 0, 0, false)
	end

	function icon.Entity:GetPlayerColor()
		if not IsValid(ply) then
			return Vector(1, 1, 1)
		end

		return ply:GetPlayerColor()
	end

	compound.SetupModelPanel(icon, ply)

	function icon:DoClick()
	end

	local but = vgui.Create("DButton", entry)
	but:SetText("")
	but:SetPos(0, 0)
	but:SetSize(520, 58)

	function but:DoClick()
		GAMEMODE:CCCreatePlayerViewer(ply)
	end

	function but:DoRightClick()
		GAMEMODE:CCCreateMiniAdminMenu(ply)
	end

	function but:Paint()
	end

	but:PerformLayout()

	local but2 = vgui.Create("DButton", entry)
	but2:SetText("")
	but2:SetPos(520, 0)
	but2:SetSize(100, 58)

	function but2:DoClick()
		GAMEMODE:CCCreatePlayerData(ply)
	end

	function but2:Paint()
	end

	but2:PerformLayout()

	CCP.Scoreboard.Players:AddItem(entry)
end

local function CreateBadge(parent, mat, text, y)

	local icon = vgui.Create("DImage", parent)
	icon:SetMaterial(mat)
	icon:SetPos(10, y)
	icon:SetSize(14, 14)

	local badge = vgui.Create("DLabel", parent)
	badge:SetText(text)
	badge:SetPos(10 + 18, y)
	badge:SetSize(170, 14)
	badge:SetFont("CombineControl.LabelSmall")
	badge:PerformLayout()

	return y + 20
end

function GM:CCCreatePlayerData(ply)
	if not ply or not ply:IsValid() then return end

	CCP.PlayerData = vgui.Create("DFrame")
	CCP.PlayerData:SetSize(200, 200)
	CCP.PlayerData:Center()
	CCP.PlayerData:SetTitle("Badges")
	CCP.PlayerData.lblTitle:SetFont("CombineControl.Window")
	CCP.PlayerData:MakePopup()
	CCP.PlayerData.PerformLayout = CCFramePerformLayout
	CCP.PlayerData:PerformLayout()

	CCP.PlayerData.Think = UIAutoClose

	local y = 34

	if LocalPlayer():IsAdmin() and ply:LastNotesUpdate() > 0 and cookie.GetNumber("cc_lastnoteread_" .. ply:SteamID64(), 0) < ply:LastNotesUpdate() then
		y = CreateBadge(CCP.PlayerData, self.UnreadNotesMat, "Unread Player Notes", y)
	end

	if LocalPlayer():IsAdmin() and ply:IsOOCMuted() then
		y = CreateBadge(CCP.PlayerData, self.OOCMutedMat, "OOC Muted", y)
	end

	if LocalPlayer():IsAdmin() and ply:IsTravelBanned() then
		y = CreateBadge(CCP.PlayerData, self.TravelBannedMat, "Travel Banned", y)
	end

	if ply:IsDeveloper() and not ply:HideAdmin() then

		y = CreateBadge(CCP.PlayerData, self.DeveloperMat, "Developer", y)

	elseif ply:IsSuperAdmin() and not ply:HideAdmin() then

		y = CreateBadge(CCP.PlayerData, self.SuperAdminMat, "Superadmin", y)

	elseif ply:IsAdmin() and not ply:HideAdmin() then

		y = CreateBadge(CCP.PlayerData, self.AdminMat, "Admin", y)

	end

	if not ply:HideAdmin() then

		if ply:DonationAmount() > GAMEMODE.GoldDonorAmount then

			y = CreateBadge(CCP.PlayerData, self.GoldMat, "Gold Donor", y)

		elseif ply:DonationAmount() > GAMEMODE.SilverDonorAmount then

			y = CreateBadge(CCP.PlayerData, self.SilverMat, "Silver Donor", y)

		elseif ply:DonationAmount() > GAMEMODE.BronzeDonorAmount then

			y = CreateBadge(CCP.PlayerData, self.BronzeMat, "Bronze Donor", y)

		end

	end


	for k, v in pairs(self.ScoreboardBadges) do

		if ply:HasBadge(k) and not ply:HideAdmin() then

			y = CreateBadge(CCP.PlayerData, v[1], v[2], y)

		end

	end
end
