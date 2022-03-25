GM.EntityTable = {
	prop = { },
	item = { },
	paper = { },
	npc = { },
	door = { },
}

language.Add("npc_clawscanner", "Claw Scanner")
language.Add("npc_combine_camera", "Combine Camera")
language.Add("npc_helicopter", "Helicopter")
language.Add("npc_barnacle_tongue_tip", "Barnacle Tongue Tip")
language.Add("prop_vehicle_apc", "APC")
language.Add("npc_fisherman", "Fisherman")

function draw.DrawTextShadow(text, font, x, y, col1, col2, align)
	if align != 0 then

		draw.DrawText(text, font, x + 1, y + 1, col2, align) -- Less efficient than surface, so we only use this if we need special alignment stuff.
		draw.DrawText(text, font, x, y, col1, align)

	else

		surface.SetFont(font)

		surface.SetTextColor(col2)
		surface.SetTextPos(x + 1, y + 1)
		surface.DrawText(text)
		surface.SetTextColor(col1)
		surface.SetTextPos(x, y)
		surface.DrawText(text)

	end
end

local matBlurScreen = Material("pp/blurscreen")

function draw.DrawBackgroundBlur(frac)
	DisableClipping(true)

	surface.SetMaterial(matBlurScreen)
	surface.SetDrawColor(255, 255, 255, 255)

	for i = 1, 3 do

		matBlurScreen:SetFloat("$blur", frac * 5 * (i / 3))
		matBlurScreen:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

	end

	DisableClipping(false)
end

function GM:DrawWorldText(pos, text, noz)
	local ang = (pos - EyePos()):Angle()

	cam.Start3D2D(pos, Angle(0, ang.y - 90, 90), 0.25)
		if noz then
			render.DepthRange(0, 0)
		end

		render.PushFilterMag(TEXFILTER.NONE)
		render.PushFilterMin(TEXFILTER.NONE)
			surface.SetFont("BudgetLabel")

			local w, h = surface.GetTextSize(text)

			surface.SetTextColor(255, 255, 255, 255)
			surface.SetTextPos(-w * 0.5, -h * 0.5)

			surface.DrawText(text)
		render.PopFilterMin()
		render.PopFilterMag()

		if noz then
			render.DepthRange(0, 1)
		end
	cam.End3D2D()
end

GM.ThirdCurPos = Vector()
GM.ThirdCurAng = Angle()
GM.ThirdDestPos = Vector()
GM.ThirdDestAng = Angle()

function GM:ShouldDoThirdPerson(ply)
	local wep = ply:GetActiveWeapon()

	if wep and wep:IsValid() and wep != NULL then

		if wep:GetClass() == "weapon_cc_binoculars" then
			return false
		end

		if wep.InScope and wep:InScope() then

			return false

		end

	end

	if ply:GetMoveType() == MOVETYPE_NOCLIP then

		return false

	end

	if ply:GetViewEntity() != ply then

		return false

	end

	return true
end

GM.IntroCamDelay = 15

function GM:StartIntroCam()
	if not self.IntroCamData then return end

	self.IntroCamStart = CurTime()
	self:PlayMusic("music/hl2_song26_trainstation1.mp3", 0)
end

net.Receive("nIntroStart", function(len)
	local force = net.ReadFloat()

	if force == 0 and GAMEMODE.QuizEnabled then

		if cookie.GetNumber("cc_doneintro", 0) < 2 then

			GAMEMODE:CreateQuiz()

		end

	else

		if GAMEMODE.IntroCinematicEnabled then

			GAMEMODE:StartIntroCam()

		else

			GAMEMODE.QueueCharCreate = false
			cookie.Set("cc_doneintro", 2)

			GAMEMODE:CreateCharEditor()

		end

	end
end)

function GM:InIntroCam()
	if not self.IntroCamData then return false end

	if self.IntroCamStart and CurTime() - self.IntroCamStart < self.IntroCamDelay * #self.IntroCamText then

		return true

	end

	return false
end

function GM:CalcView(ply, pos, ang, fov, znear, zfar)
	local view = self.BaseClass:CalcView(ply, pos, ang, fov, znear, zfar)

	if LocalPlayer():PassedOut() then
		local ragdoll = LocalPlayer():Ragdoll()

		if IsValid(ragdoll) then
			local mn, mx = ragdoll:GetRenderBounds()
			local radius = (mn - mx):Length()
			local target = (ragdoll:GetPos() + Vector(0, 0, 10)) + (mn + mx) / 2 + view.angles:Forward() * -radius

			local trace = {}
			trace.start = view.origin
			trace.endpos = target
			trace.filter = {ragdoll, ply}
			trace.mins = Vector(-4, -4, -4)
			trace.maxs = Vector(4, 4, 4)
			local tr = util.TraceHull(trace)

			view.origin = tr.HitPos
			view.drawviewer = true

			if tr.Hit and not tr.StartSolid then
				view.origin = view.origin + tr.HitNormal * 4
			end

			return view
		end
	end

	local camera = ply:CombineCamera()

	if IsValid(camera) then
		local attach = camera:GetAttachment(2)

		if camera:IsPlayer() then
			view.origin = camera:EyePos()
			view.angles = camera:EyeAngles()

			return view
		else
			if camera:GetClass() == "npc_combine_camera" then
				attach.Ang:RotateAroundAxis(attach.Ang:Forward(), -90)
				attach.Ang:RotateAroundAxis(attach.Ang:Up(), -90)
			end

			attach.Pos = attach.Pos + attach.Ang:Forward() * 5

			view.origin = attach.Pos
			view.angles = attach.Ang

			return view
		end
	end

	if self.IntroCamStart and self.IntroCamData and (CurTime() - self.IntroCamStart) < (self.IntroCamDelay * #self.IntroCamText) then
		local stage = math.Clamp(math.ceil((CurTime() - self.IntroCamStart) / self.IntroCamDelay), 1, #self.IntroCamText)
		local p1, p2, a1, a2

		if self.IntroCamData[stage] then
			p1 = self.IntroCamData[stage][1][1]
			p2 = self.IntroCamData[stage][1][2]
			a1 = self.IntroCamData[stage][2][1]
			a2 = self.IntroCamData[stage][2][2]
		else
			p1 = self.IntroCamData[#self.IntroCamData][1][1]
			p2 = self.IntroCamData[#self.IntroCamData][1][2]
			a1 = self.IntroCamData[#self.IntroCamData][2][1]
			a2 = self.IntroCamData[#self.IntroCamData][2][2]
		end

		local mul = ((CurTime() - self.IntroCamStart) / self.IntroCamDelay) - (stage - 1)

		view.origin = LerpVector(mul, p1, p2)
		view.angles = LerpAngle(mul, a1, a2)

		return view
	end

	if (self.CharCreate or CCP.Quiz) and self.GetHL2CamPos then
		local tab = self:GetHL2CamPos()

		self.ThirdCurPos = view.origin
		self.ThirdCurAng = view.angles

		view.origin = tab[1]
		view.angles = tab[2]

		return view
	end

	if cookie.GetNumber("cc_headbob", 0) == 1 then
		local hmul = 0
		local len2d = ply:GetVelocity():Length2D()

		if len2d > 5 and ply:GetMoveType() != MOVETYPE_NOCLIP and ply:OnGround() then
			hmul = math.Clamp(len2d / 200, 0, 1)
		end

		if hmul > 0 then
			view.angles.p = view.angles.p + math.sin(CurTime() * 5) * hmul
			view.angles.y = view.angles.y + math.cos(CurTime() * 4) * 0.5 * hmul
		end
	end

	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.TranslateFOV and false then
		view.fov = wep:TranslateFOV(view.fov)
	end

	return view
end

function GM:ShouldDrawLocalPlayer(ply)
	if self:InIntroCam() then return true end
	if IsValid(ply:CombineCamera()) then return true end
	if cookie.GetNumber("cc_thirdperson", 0) == 1 then return self:ShouldDoThirdPerson(ply) end

	return false
end

function GM:DrawCharCreate()
	if self.CharCreate then
		if not self.GetHL2CamPos then
			surface.SetDrawColor(Color(0, 0, 0, 255))
			surface.DrawRect(0, 0, ScrW(), ScrH())
		else
			draw.DrawBackgroundBlur(1)
		end
	end
end

function GM:DrawFancyIntro()
	if self.IntroCamStart and self.IntroCamData and (CurTime() - self.IntroCamStart) < (self.IntroCamDelay * #self.IntroCamText) then
		local stage = math.Clamp(math.ceil((CurTime() - self.IntroCamStart) / self.IntroCamDelay), 1, #self.IntroCamText)

		if self.IntroCamText[stage] then
			local timesince = (CurTime() - self.IntroCamStart) - ((stage - 1) * self.IntroCamDelay)
			local a = 1

			if timesince < 2.5 then
				a = timesince / 2.5
			end

			if timesince > self.IntroCamDelay - 1 then
				a = 1 - (timesince - (self.IntroCamDelay - 1))
			end

			local _, h = surface.GetTextSize(self.IntroCamText[stage])
			h = h + 20
			draw.RoundedBox(0, 0, ScrH() * (360 / 480) - 10, ScrW(), h, Color(30, 30, 30, a * 200))
			draw.DrawText(self.IntroCamText[stage], "CombineControl.HL2CreditText", ScrW() * (96 / 640), ScrH() * (360 / 480), Color(255, 255, 255, a * 128), 0)
		end
	end
end

function GM:DrawQuiz()
	draw.DrawBackgroundBlur(1)
end

function GM:DrawCombineCamera()
	local text = "REC " .. os.date("!%Y-%m-%d %H:%M:%S")
	local ent = LocalPlayer():CombineCamera()

	local pos = ent:GetPos()
	pos.x = math.floor(pos.x)
	pos.y = math.floor(pos.y)
	pos.z = math.floor(pos.z)

	local attach = ent:GetAttachment(2)
	local id = ent:EntIndex()

	if ent:GetClass() == "npc_combine_camera" then
		attach.Ang:RotateAroundAxis(attach.Ang:Forward(), -90)
		attach.Ang:RotateAroundAxis(attach.Ang:Up(), -90)

		id = ent:GetNWString("camname")
	end

	attach.Ang.p = math.floor(attach.Ang.p)
	attach.Ang.y = math.floor(attach.Ang.y)
	attach.Ang.r = math.floor(attach.Ang.r)

	text = text .. "\nCAMERA #" .. id
	text = text .. "\nCOORD " .. pos.x .. " " .. pos.y .. " " .. pos.z
	text = text .. "\nANG " .. attach.Ang.p .. " " .. attach.Ang.y .. " " .. attach.Ang.r

	draw.DrawText(text, "CombineControl.CombineCamera", 10, 10, Color(255, 0, 0, 255), 0)

	for _, v in pairs(player.GetAll()) do

		local poss = (v:EyePos() + Vector(0, 0, 10)):ToScreen()

		if v:Ragdoll() and v:Ragdoll():IsValid() then

			poss = (v:Ragdoll():EyePos() + Vector(0, 0, 10)):ToScreen()

		end

		if (poss.visible and GAMEMODE:CanSeePos(pos, v:EyePos(), {ent, v}) and pos:Distance(v:GetPos()) < 1024) and v:Alive() then

			draw.DrawText(v:VisibleRPName(), "CombineControl.CombineCameraSmall", poss.x, poss.y, Color(200, 200, 200, 255), 1)

		end

	end
end

function GM:DrawConsciousness()
	if not LocalPlayer():PassedOut() and LocalPlayer():Consciousness() < 60 then
		draw.DrawBackgroundBlur(1 - LocalPlayer():Consciousness() / 60)
	end

	if LocalPlayer().DrawWakeUp and CurTime() - LocalPlayer().DrawWakeUp <= 3 then
		local frac = (CurTime() - LocalPlayer().DrawWakeUp) / 3

		draw.DrawBackgroundBlur(1 - frac)
	end
end

function GM:DrawTimedProgress()
	local yc = 0

	if not self.TimedProgressBars then self.TimedProgressBars = {} end

	for k, v in pairs(self.TimedProgressBars) do
		if v.Start and CurTime() < v.End then
			local ply = v.Player
			local y = self.FontHeight["CombineControl.LabelBig"]

			if not IsValid(ply) or ply:GetPos():Distance(LocalPlayer():GetPos()) > 100 or ply:GetVelocity():Length() > 5 or LocalPlayer():GetVelocity():Length() > 5 then
				table.remove(self.TimedProgressBars, k)

				continue
			end

			surface.SetDrawColor(30, 30, 30, 200)
			surface.DrawRect(ScrW() / 2 - 400 / 2, ScrH() / 2 + 40 + yc, 400, 40)

			surface.SetDrawColor(150, 20, 20, 255)
			surface.DrawRect(ScrW() / 2 - 400 / 2 + 1, ScrH() / 2 + 40 + 1 + yc, (400 - 2) * math.min((CurTime() - v.Start) / (v.End - v.Start), 1), 40 - 2)

			draw.DrawText(v.Text, "CombineControl.LabelBig", ScrW() / 2, ScrH() / 2 + 40 + y / 2 + yc, Color(200, 200, 200, 255), 1)
		end

		if v.End and CurTime() >= v.End then
			v.CB(self)

			table.remove(self.TimedProgressBars, k)
		end

		yc = yc + 60
	end
end

function GM:DrawPassedOut()
	if LocalPlayer():PassedOut() then
		if not LocalPlayer():Alive() then
			surface.SetDrawColor(Color(0, 0, 0, 255))
			surface.DrawRect(0, 0, ScrW(), ScrH())

			draw.DrawText("You have died.", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 2, Color(200, 200, 200, 255), 1)

			return
		end

		draw.DrawBackgroundBlur(1)

		draw.DrawText("You are unconscious.", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 2, Color(200, 200, 200, 255), 1)

		surface.SetDrawColor(30, 30, 30, 150)
		surface.DrawRect(ScrW() / 2 - 400 / 2, ScrH() / 2 + 40, 400, 40)

		surface.SetDrawColor(20, 20, 20, 100)
		surface.DrawOutlinedRect(ScrW() / 2 - 400 / 2, ScrH() / 2 + 40, 400, 40)

		surface.SetDrawColor(150, 20, 20, 255)
		surface.DrawRect(ScrW() / 2 - 400 / 2 + 1, ScrH() / 2 + 40 + 1, (400 - 2) * math.min(LocalPlayer():Consciousness() / 100, 1), 40 - 2)

		local y = self.FontHeight["CombineControl.LabelBig"]
		local ragdoll = LocalPlayer():Ragdoll()

		if IsValid(ragdoll) and ragdoll:GetVelocity():Length() > 15 then
			draw.DrawText("You're being moved.", "CombineControl.LabelBig", ScrW() / 2, ScrH() / 2 + 40 + y / 2, Color(200, 200, 200, 255), 1)
			return
		end

		draw.DrawText(tostring(LocalPlayer():Consciousness()) .. "%", "CombineControl.LabelBig", ScrW() / 2, ScrH() / 2 + 40 + y / 2, Color(200, 200, 200, 255), 1)
	end
end

function GM:DrawPlayerInfo()
	local w = 220

	surface.SetFont("CombineControl.LabelGiant")
	local x = surface.GetTextSize(LocalPlayer():VisibleRPName())

	if x + 8 > w then
		w = x + 8
	end

	draw.RoundedBox(0, 20, ScrH() - 102, w, 82, Color(30, 30, 30, 200))

	draw.DrawTextShadow(LocalPlayer():VisibleRPName(), "CombineControl.LabelGiant", w + 20 - 4, ScrH() - 102 + 4, Color(200, 200, 200, 255), Color(0, 0, 0, 255), 2)
	draw.DrawTextShadow(util.FormatCurrency(LocalPlayer():Money(), true), "CombineControl.LabelGiant", w + 20 - 4, ScrH() - 102 + 4 + 22 + 4, Color(200, 200, 200, 255), Color(0, 0, 0, 255), 2)
	draw.DrawTextShadow("CID #" .. LocalPlayer():FormattedCID(), "CombineControl.LabelGiant", w + 20 - 4, ScrH() - 102 + 4 + 22 + 4 + 22 + 4, Color(200, 200, 200, 255), Color(0, 0, 0, 255), 2)
end

function GM:DrawHealthBars()
	if not self.HPDraw then self.HPDraw = 100 end
	if not self.ARDraw then self.ARDraw = 0 end

	self.HPDraw = math.Approach(self.HPDraw, LocalPlayer():Health(), math.max(math.abs(LocalPlayer():Health() - self.HPDraw) * 0.1, 1))
	self.ARDraw = math.Approach(self.ARDraw, LocalPlayer():BodyArmor(), math.max(math.abs(LocalPlayer():BodyArmor() - self.ARDraw) * 0.1, 1))

	local w = 220
	local y = ScrH() - 102 - 24

	draw.RoundedBox(0, 20, y, w, 14, Color(30, 30, 30, 200))

	if self.HPDraw > 0 then
		draw.RoundedBox(0, 22, y + 2, (w - 4) * (math.Clamp(self.HPDraw, 1, LocalPlayer():GetMaxHealth()) / LocalPlayer():GetMaxHealth()), 10, Color(150, 20, 20, 255))
	end

	y = y - 16

	if self.ARDraw > 0 then
		draw.RoundedBox(0, 20, y, w, 14, Color(30, 30, 30, 200))
		draw.RoundedBox(0, 22, y + 2, (w - 4) * (math.Clamp(self.ARDraw, 1, LocalPlayer():MaxBodyArmor()) / LocalPlayer():MaxBodyArmor()), 10, Color(37, 84, 158, 255))
		y = y - 16
	end

	hook.Run("CC.CL.DrawHUDBars", y, w)
end

function GM:GetPlayerSight()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if self.FlashbangStart and CurTime() - self.FlashbangStart < 5 then
		return 0
	elseif IsValid(wep) and (wep.UseRTScope and (wep.AimingDownSights and wep:AimingDownSights())) then
		return 5000
	else
		return self.PlayerSight
	end
end

GM.NPCDrawBlacklist = {
	"npc_antlion_grub",
	"npc_barnacle_tongue_tip",
	"npc_bullseye",
	"monster_generic"
}

GM.TypeText = {
	"Typing...",
	"Radioing...",
	"Requesting..."
}

local PlayerCache = {}

function GM:DrawEntities()
	if self.SeeAll and not LocalPlayer():IsAdmin() then
		self.SeeAll = false
	end

	if cookie.GetNumber("cc_noscopelabels", 0) == 1 then
		local weapon = LocalPlayer():GetActiveWeapon()

		if IsValid(weapon) and weapon.UseRTScope and weapon:AimingDownSights() then
			PlayerCache = {}

			for _, v in pairs(player.GetAll()) do
				v.HUDAlpha = 0
				v.TitleAlpha = 0
			end

			for _, tab in pairs({"prop", "item", "paper", "npc"}) do
				for _, v in pairs(self.EntityTable[tab]) do
					v.HUDAlpha = 0
				end
			end

			return
		end
	end

	local tr = LocalPlayer():GetEyeTrace()

	if (cookie.GetNumber("cc_legacyhud", 1) == 0) and not self.SeeAll then
		-- New HUD
		if IsValid(tr.Entity) and tr.Entity:IsPlayer() then
			-- cache the entity so we remember it for drawing
			local eIndex = tr.Entity:EntIndex()

			if (tr.StartPos:Distance(tr.HitPos) <= GAMEMODE:GetPlayerSight()) then
				if not PlayerCache[eIndex] then
					PlayerCache[eIndex] = tr.Entity
					PlayerCache[eIndex].HUDAlpha = FrameTime()
					PlayerCache[eIndex].FadeOutTime = CurTime() + 0.05
				else
					-- if we look @ the player, fade in and delay fadeout
					PlayerCache[eIndex].HUDAlpha = math.Clamp(PlayerCache[eIndex].HUDAlpha + 1 * FrameTime(), 0, 1)
					PlayerCache[eIndex].FadeOutTime = CurTime() + 0.05
				end
			end
		end

		-- draw things we need
		for k, v in pairs(PlayerCache) do
			if not IsValid(v) then PlayerCache[k] = nil continue end
			if v.HUDAlpha <= 0 then PlayerCache[k] = nil continue end

			local pos = Vector(0, 0, 0)

			if v:GetModel() == "models/hunter.mdl" then -- work with me
				pos = (v:EyePos() + Vector(0, 0, 40)):ToScreen()
			else
				pos = (v:EyePos() + Vector(0, 0, 10)):ToScreen()
			end

			if v.FadeOutTime <= CurTime() then
				v.HUDAlpha = math.Clamp(v.HUDAlpha - FrameTime(), 0, 1)
			end

			if v.HUDAlpha > 0 then
				local c = team.GetColor(v:Team())

				draw.DrawTextShadow(v:VisibleRPName(), "CombineControl.PlayerFont", pos.x, pos.y, Color(c.r, c.g, c.b, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
				pos.y = pos.y + 20

				if self.SeeAll and tobool(cookie.GetNumber("cc_seeallplayers", 1)) then
					draw.DrawTextShadow(v:Nick(), "CombineControl.PlayerFont", pos.x, pos.y, Color(87, 165, 255, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
					pos.y = pos.y + 20
				elseif v.HUDAlpha > 0 then
					local desc = v:Description():match("^[^\r\n]*")

					if #desc > 0 then
						if #desc > 64 then
							desc = desc:sub(1, 64) .. "..."
						end

						draw.DrawTextShadow(desc, "CombineControl.PlayerFont", pos.x, pos.y, Color(220, 220, 220, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
						pos.y = pos.y + 20
					end
				end

				if v:TiedUp() then
					draw.DrawTextShadow("They're tied up.", "CombineControl.LabelSmall", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
					pos.y = pos.y + 20
				end

				if v:Typing() > 0 then
					draw.DrawTextShadow(self.TypeText[v:Typing()], "CombineControl.LabelSmallItalic", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
					pos.y = pos.y + 20
				end

				if v:NewbieStatus() < NEWBIE_STATUS_OLD then
					draw.DrawTextShadow("Inexperienced Roleplayer", "CombineControl.LabelSmall", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
					pos.y = pos.y + 20
				end

				if self.SeeAll and tobool(cookie.GetNumber("cc_seeallhp", 1)) then
					draw.DrawTextShadow(tostring(v:Health()) .. "%", "CombineControl.PlayerFont", pos.x, pos.y, Color(200, 0, 0, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
					pos.y = pos.y + 20

					if v:BodyArmor() > 0 then
						draw.DrawTextShadow(tostring(math.floor(v:BodyArmor())) .. "%", "CombineControl.PlayerFont", pos.x, pos.y, Color(0, 63, 255, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
						pos.y = pos.y + 20
					end
				end
			end
		end
	else
		-- Legacy HUD
		for _, v in pairs(player.GetAll()) do
			if not IsValid(v) then continue end

			if v != LocalPlayer() or LocalPlayer():GetViewEntity() != LocalPlayer() then
				if not v.HUDAlpha then v.HUDAlpha = 0 end
				if not v.TitleAlpha then v.TitleAlpha = 0 end

				local pos = Vector(0, 0, 0)

				if v:GetModel() == "models/hunter.mdl" then -- work with me
					pos = (v:EyePos() + Vector(0, 0, 40)):ToScreen()
				else
					pos = (v:EyePos() + Vector(0, 0, 10)):ToScreen()
				end

				if IsValid(v:Ragdoll()) then
					pos = (v:Ragdoll():EyePos() + Vector(0, 0, 10)):ToScreen()

					if ((self.SeeAll and tobool(cookie.GetNumber("cc_seeallplayers", 1))) or (pos.visible and LocalPlayer():CanSee(v:Ragdoll()) and LocalPlayer():GetPos():Distance(v:GetPos()) < self:GetPlayerSight())) and v:Alive() then
						v.HUDAlpha = math.Clamp(v.HUDAlpha + FrameTime(), 0, 1)
					elseif v.HUDAlpha > 0 then
						v.HUDAlpha = math.Clamp(v.HUDAlpha - FrameTime(), 0, 1)
					end

					if v:Ragdoll() == tr.Entity then
						v.TitleAlpha = math.Clamp(v.TitleAlpha + FrameTime(), 0, v.HUDAlpha)
					else
						v.TitleAlpha = math.Clamp(v.TitleAlpha - FrameTime(), 0, v.HUDAlpha)
					end
				else
					if ((self.SeeAll and tobool(cookie.GetNumber("cc_seeallplayers", 1))) or (pos.visible and LocalPlayer():CanSee(v) and LocalPlayer():GetPos():Distance(v:GetPos()) < self:GetPlayerSight() and not v:GetNoDraw() and v:Alive())) then
						v.HUDAlpha = math.Clamp(v.HUDAlpha + FrameTime(), 0, 1)
					elseif v.HUDAlpha > 0 then
						v.HUDAlpha = math.Clamp(v.HUDAlpha - FrameTime(), 0, 1)
					end

					if v == tr.Entity then
						v.TitleAlpha = math.Clamp(v.TitleAlpha + FrameTime(), 0, v.HUDAlpha)
					else
						v.TitleAlpha = math.Clamp(v.TitleAlpha - FrameTime(), 0, v.HUDAlpha)
					end
				end

				if v.HUDAlpha > 0 then
					local c = team.GetColor(v:Team())

					draw.DrawTextShadow(v:VisibleRPName(), "CombineControl.PlayerFont", pos.x, pos.y, Color(c.r, c.g, c.b, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
					pos.y = pos.y + 20

					if self.SeeAll and tobool(cookie.GetNumber("cc_seeallplayers", 1)) then
						draw.DrawTextShadow(v:Nick(), "CombineControl.PlayerFont", pos.x, pos.y, Color(87, 165, 255, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
						pos.y = pos.y + 20
					elseif v.TitleAlpha > 0 then
						local desc = v:Description():match("^[^\r\n]*")

						if #desc > 0 then
							if #desc > 64 then
								desc = desc:sub(1, 64) .. "..."
							end

							draw.DrawTextShadow(desc, "CombineControl.PlayerFont", pos.x, pos.y, Color(220, 220, 220, v.TitleAlpha * 255), Color(0, 0, 0, v.TitleAlpha * 255), 1)
							pos.y = pos.y + 20
						end
					end

					if v:TiedUp() then
						draw.DrawTextShadow("They're tied up.", "CombineControl.LabelSmall", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
						pos.y = pos.y + 20
					end

					if v:Typing() > 0 then
						draw.DrawTextShadow(self.TypeText[v:Typing()], "CombineControl.LabelSmallItalic", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
						pos.y = pos.y + 20
					end

					if v:NewbieStatus() < NEWBIE_STATUS_OLD then
						draw.DrawTextShadow("Inexperienced Roleplayer", "CombineControl.LabelSmall", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
						pos.y = pos.y + 20
					end

					if self.SeeAll and tobool(cookie.GetNumber("cc_seeallhp", 1)) then
						draw.DrawTextShadow(tostring(v:Health()) .. "%", "CombineControl.PlayerFont", pos.x, pos.y, Color(200, 0, 0, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
						pos.y = pos.y + 20

						if v:BodyArmor() > 0 then
							draw.DrawTextShadow(tostring(math.floor(v:BodyArmor())) .. "%", "CombineControl.PlayerFont", pos.x, pos.y, Color(0, 63, 255, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
							pos.y = pos.y + 20
						end
					end
				end
			end
		end
	end

	for k, v in pairs(self.EntityTable.prop) do
		if not IsValid(v) then table.remove(self.EntityTable.prop, k) continue end
		if not v.HUDAlpha then v.HUDAlpha = 0 end

		local weapon = LocalPlayer():GetActiveWeapon()
		local distance = LocalPlayer():GetPos():Distance(v:GetPos())

		local seeCreator = distance < 512 and IsValid(weapon) and weapon:GetClass() == "weapon_physgun"
		local seeDesc = distance < 200 and v:PropDescription() != ""

		if not seeCreator and not seeDesc then continue end

		local pos = (v:GetPos() + Vector(0, 0, 10)):ToScreen()

		if pos.visible and LocalPlayer():CanSee(v) then
			if seeCreator or seeDesc then
				v.HUDAlpha = math.Clamp(v.HUDAlpha + FrameTime(), 0, 1)
			end
		elseif v.HUDAlpha > 0 then
			v.HUDAlpha = math.Clamp(v.HUDAlpha - FrameTime(), 0, 1)
		end

		if v.HUDAlpha > 0 then
			if seeCreator then
				draw.DrawTextShadow(v:PropCreator(), "CombineControl.PlayerFont", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
				draw.DrawTextShadow(v:PropSteamID(), "CombineControl.LabelSmall", pos.x, pos.y + 24, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
			end

			if seeDesc then
				local descPos = v:WorldSpaceCenter():ToScreen()
				draw.DrawTextShadow(v:PropDescription(), "CombineControl.PlayerFont", descPos.x, descPos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
			end
		end
	end

	for k, v in pairs(self.EntityTable.item) do
		if not IsValid(v) then
			table.remove(self.EntityTable.item, k)

			continue
		end

		if not v.Item then
			continue
		end

		local distance = LocalPlayer():GetPos():Distance(v:GetPos())

		if distance > self:GetPlayerSight() / 2 and not (self.SeeAll and tobool(cookie.GetNumber("cc_seeallitems", 1))) then
			continue
		end

		local pos = v:GetPos():ToScreen()

		if (self.SeeAll and tobool(cookie.GetNumber("cc_seeallitems", 1))) or (pos.visible and LocalPlayer():CanSee(v)) then
			v.HUDAlpha = math.Clamp(v.HUDAlpha + FrameTime(), 0, 1)
		elseif v.HUDAlpha > 0 then
			v.HUDAlpha = math.Clamp(v.HUDAlpha - FrameTime(), 0, 1)
		end

		if v.HUDAlpha > 0 then
			draw.DrawTextShadow(v.Item:GetName(), "CombineControl.PlayerFont", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
			pos.y = pos.y + 20

			draw.DrawTextShadow("Weight - " .. tostring(v.Item:GetWeight()), "CombineControl.LabelSmall", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
			pos.y = pos.y + 16

		end

	end

	for k, v in pairs(self.EntityTable.paper) do

		if not IsValid(v) then table.remove(self.EntityTable.paper, k) continue end
		if not v.HUDAlpha then v.HUDAlpha = 0 end

		local distance = LocalPlayer():GetPos():Distance(v:GetPos())

		if distance > self:GetPlayerSight() / 2 and not self.SeeAll then
			continue
		end

		local a, b = v:GetRotatedAABB(v:OBBMins(), v:OBBMaxs())
		local wpos = (v:GetPos() + (a + b) / 2)
		local pos = wpos:ToScreen()

		if self.SeeAll or (pos.visible and LocalPlayer():CanSee(v)) then
			v.HUDAlpha = math.Clamp(v.HUDAlpha + FrameTime(), 0, 1)
		elseif v.HUDAlpha > 0 then
			v.HUDAlpha = math.Clamp(v.HUDAlpha - FrameTime(), 0, 1)
		end

		if v.HUDAlpha > 0 then
			draw.DrawTextShadow("Paper", "CombineControl.PlayerFont", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
			pos.y = pos.y + 20

			draw.DrawTextShadow("Press C to read.", "CombineControl.LabelSmall", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
			pos.y = pos.y + 16
		end
	end

	for k, v in pairs(self.EntityTable.npc) do
		if not IsValid(v) then table.remove(self.EntityTable.npc, k) continue end
		if table.HasValue(self.NPCDrawBlacklist, v:GetClass()) then table.remove(self.EntityTable.npc, k) continue end
		if not self.SeeAll then continue end

		if not v.HUDAlpha then v.HUDAlpha = 0 end

		local pos = (v:EyePos() + Vector(0, 0, 10)):ToScreen()

		if (self.SeeAll and tobool(cookie.GetNumber("cc_seeallnpcs", 1))) and v:Health() > 0 then
			v.HUDAlpha = math.Clamp(v.HUDAlpha + FrameTime(), 0, 1)
		elseif v.HUDAlpha > 0 then
			v.HUDAlpha = math.Clamp(v.HUDAlpha - FrameTime(), 0, 1)
		end

		if v.HUDAlpha > 0 then
			draw.DrawTextShadow("#" .. v:GetClass(), "CombineControl.PlayerFont", pos.x, pos.y, Color(200, 200, 100, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
			pos.y = pos.y + 20
		end
	end
end

function GM:DrawDoors()
	-- Indexing some variables to cut down on unnecessary calls
	local sight = self:GetPlayerSight()
	local eyeEnt = LocalPlayer():GetEyeTrace().Entity

	for k, v in pairs(self.EntityTable.door) do
		-- Doors without an original name don't need to be drawn, they aren't buyable and don't have names to show
		if #v:DoorOriginalName() < 1 then continue end
		if not IsValid(v) then table.remove(self.EntityTable.door, k) continue end
		if not v.HUDAlpha then v.HUDAlpha = 0 end

		local a, b = v:GetRotatedAABB(v:OBBMins(), v:OBBMaxs())
		local wpos = (v:GetPos() + (a + b) / 2)

		local pos = wpos:ToScreen()

		if pos.visible and v:GetPos():Distance(LocalPlayer():GetPos()) <= sight then
			-- GetEyeTrace() is already cached for us, let's use that instead of doing a new trace FOR EVERY VISIBLE DOOR ON EVERY FRAME
			if eyeEnt == v then
				v.HUDAlpha = math.Clamp(v.HUDAlpha + FrameTime(), 0, 1)
			elseif v.HUDAlpha > 0 then
				v.HUDAlpha = math.Clamp(v.HUDAlpha - FrameTime(), 0, 1)
			end
		else
			v.HUDAlpha = math.Clamp(v.HUDAlpha - FrameTime(), 0, 1)
		end

		if v.HUDAlpha > 0 then
			local name = v:DoorOriginalName()

			if v:DoorName() != "" then
				name = v:DoorName()
			end

			draw.DrawTextShadow(name, "CombineControl.PlayerFont", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
			pos.y = pos.y + 20

			if (v:DoorType() == DOOR_BUYABLE or v:DoorType() == DOOR_BUYABLE_ASSIGNABLE) and #v:DoorOwners() == 0 and #v:DoorAssignedOwners() == 0 then
				draw.DrawTextShadow(util.FormatCurrency(v:DoorPrice()), "CombineControl.PlayerFont", pos.x, pos.y, Color(226, 205, 95, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
				pos.y = pos.y + 20
			end

			if self.SeeAll then
				local tab = v:DoorOwners()
				table.Merge(tab, v:DoorAssignedOwners())

				for _, owner in pairs(tab) do
					local ply = nil

					for _, l in pairs(player.GetAll()) do
						if l:CharID() == owner then
							ply = l
						end
					end

					local text = "Owner: CharID #" .. owner

					if IsValid(ply) then
						text = "Owner: " .. ply:VisibleRPName()
					end

					draw.DrawTextShadow(text, "CombineControl.PlayerFont", pos.x, pos.y, Color(200, 200, 200, v.HUDAlpha * 255), Color(0, 0, 0, v.HUDAlpha * 255), 1)
					pos.y = pos.y + 20
				end
			end
		end
	end
end

GM.WeaponOutText = {}
GM.WeaponOutText["weapon_physgun"] = "Your physgun is out! Switch to your hands when you're done building."
GM.WeaponOutText["weapon_physcannon"] = "Your gravgun is out! Switch to your hands when you're done moving things."
GM.WeaponOutText["gmod_tool"] = "Your toolgun is out! Switch to your hands when you're done building."

function GM:DrawAmmo()
	if LocalPlayer():InVehicle() then
		return
	end

	local w = LocalPlayer():GetActiveWeapon()

	if w != NULL then
		if LocalPlayer():TiedUp() then
			surface.SetFont("CombineControl.LabelGiant")
			local x1, y1 = surface.GetTextSize("You're tied up.")

			draw.RoundedBox(0, ScrW() - 24 - x1, ScrH() - 24 - y1, x1 + 4, y1 + 4, Color(30, 30, 30, 200))
			draw.DrawTextShadow("You're tied up.", "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() - 22 - y1, Color(200, 200, 200, 255), Color(0, 0, 0, 255), 0)

			return
		elseif LocalPlayer():Holstered() and w.Holsterable or (w.Tekka and w:GetHolstered()) then
			surface.SetFont("CombineControl.LabelGiant")
			local x1, y1 = surface.GetTextSize("Press B to unholster.")

			draw.RoundedBox(0, ScrW() - 24 - x1, ScrH() - 24 - y1, x1 + 4, y1 + 4, Color(30, 30, 30, 200))
			draw.DrawTextShadow("Press B to unholster.", "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() - 22 - y1, Color(200, 200, 200, 255), Color(0, 0, 0, 255), 0)

			return
		elseif w.UnholsterText then
			surface.SetFont("CombineControl.LabelGiant")
			local x1, y1 = surface.GetTextSize(w.UnholsterText)

			draw.RoundedBox(0, ScrW() - 24 - x1, ScrH() - 24 - y1, x1 + 4, y1 + 4, Color(30, 30, 30, 200))
			draw.DrawTextShadow(w.UnholsterText, "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() - 22 - y1, Color(200, 200, 200, 255), Color(0, 0, 0, 255), 0)

			return
		elseif self.WeaponOutText[w:GetClass()] then
			surface.SetFont("CombineControl.LabelMassive")
			local x1, y1 = surface.GetTextSize(self.WeaponOutText[w:GetClass()])

			draw.RoundedBox(0, ScrW() - 24 - x1, ScrH() - 24 - y1, x1 + 4, y1 + 4, Color(30, 30, 30, 200))
			draw.DrawTextShadow(self.WeaponOutText[w:GetClass()], "CombineControl.LabelMassive", ScrW() - 22 - x1, ScrH() - 22 - y1, Color(200, 0, 0, 255), Color(0, 0, 0, 255), 0)

			return
		end

		if (w.Firearm or w.Tekka) and w.Primary.ClipSize > -1 then
			local clip = w:Clip1()

			surface.SetFont("CombineControl.HUDAmmo")
			local x1, y1 = surface.GetTextSize(clip)
			local y2 = self.FontHeight["CombineControl.HUDAmmo"]

			local x = x1
			local y = math.max(y1, y2)

			draw.RoundedBox(0, ScrW() - 24 - x, ScrH() - 24 - y, x + 4, y + 4, Color(30, 30, 30, 200))
			draw.DrawTextShadow(clip, "CombineControl.HUDAmmo", ScrW() - 22 - x, ScrH() - 22 - y, Color(200, 200, 200, 255), Color(0, 0, 0, 255), 0)

			if w.Firemodes then
				local text = w:GetFiremode().Name

				surface.SetFont("CombineControl.LabelGiant")

				local x3, y3 = surface.GetTextSize(text)

				draw.RoundedBox(0, ScrW() - 24 - x3, ScrH() - 28 - y - y3, x3 + 4, y3 + 4, Color(30, 30, 30, 200))
				draw.DrawTextShadow(text, "CombineControl.LabelGiant", ScrW() - 22 - x3, ScrH() - 26 - y - y3, Color(200, 200, 200, 255), Color(0, 0, 0, 255), 0)
			end
		end
	end
end

net.Receive("nWarnName", function(len)
	GAMEMODE.NameWarning = true
	GAMEMODE.NameWarningStart = CurTime()
end)

function GM:DrawWarnings()
	if self.NameWarning and CurTime() - self.NameWarningStart < 15 then
		local t = CurTime() - self.NameWarningStart
		local a = 1

		if t < 1 then
			a = t
		elseif t > 14 then
			a = 1 - (t - 14)
		end

		local h = 250
		local dh = (ScrH() - h) / 2

		draw.RoundedBox(0, 0, dh, ScrW(), h, Color(30, 30, 30, 200 * a))

		draw.DrawText("YOU HAVE BEEN ISSUED A NAME WARNING", "CombineControl.LabelStupid", ScrW() / 2, dh + 20, Color(150, 20, 20, 255 * a), 1)
		draw.DrawText("An administrator considers your character's name to be inappropriate for Terminator RP.\n\nPlease change it through the player menu (F3) to a proper, realistic first and last name.\n\nIf you ignore this warning, you may be subject to a kick or ban.", "CombineControl.LabelGiant", ScrW() / 2, dh + 100, Color(200, 200, 200, 255 * a), 1)
	end
end

function GM:DrawUnconnected()
	if not self.CharCreateOpened then
		surface.SetDrawColor(Color(0, 0, 0, 150))
		surface.DrawRect(0, 0, ScrW(), ScrH())

		draw.DrawBackgroundBlur(1)

		draw.DrawText("Please wait...", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 2, Color(200, 200, 200, 255), 1)
	end
end

net.Receive("nFlashRed", function(len)
	GAMEMODE.FlashRedStart = CurTime()
end)

function GM:DrawDamage()
	if self.FlashRedStart and LocalPlayer():Alive() then
		local t = CurTime() - self.FlashRedStart
		local a = 0

		if t < 0.1 then
			a = 0.5
		elseif t < 0.6 then
			a = 0.5 - (t - 0.1)
		end

		if a > 0 then
			surface.SetDrawColor(128, 0, 0, 255 * a)
			surface.DrawRect(0, 0, ScrW(), ScrH())
		end
	end
end

GM.Notifications = {}

net.Receive("nAddNotification", function(len)
	local str = net.ReadString()
	GAMEMODE:AddNotification(str)
end)

function GM:AddNotification(text, col)
	local n = 0

	for _, m in pairs(self.Notifications) do
		for _, v in pairs(self.Notifications) do
			if v[3] == n then
				n = v[3] + 1
			end
		end
	end

	table.insert(self.Notifications, {text, CurTime(), n, col})
	surface.PlaySound("ambient/water/drip" .. math.random(1, 4) .. ".wav")
end

function GM:DrawNotifications()
	for k, v in pairs(self.Notifications) do
		local t = v[2]
		local n = v[3]
		local col = v[4]

		if CurTime() - t > 10 then
			table.remove(self.Notifications, k)
			continue
		end

		local a = 1

		if CurTime() - t < 0.5 then
			a = (CurTime() - t) / 0.5
		elseif CurTime() - t > 6 then
			a = 1 - (CurTime() - t - 6) / 4
		end

		if not col then
			col = Color(200, 200, 200, 255 * a)
		else
			col = Color(col.r, col.g, col.b, 255 * a)
		end

		surface.SetFont("CombineControl.LabelGiant")
		local x1, y1 = surface.GetTextSize(v[1])

		draw.RoundedBox(0, ScrW() - 24 - x1, ScrH() * (3 / 4) - (n * (y1 + 8)), x1 + 4, y1 + 4, Color(30, 30, 30, 200 * a))
		draw.DrawTextShadow(v[1], "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() * (3 / 4) - (n * (y1 + 8)) + 2, Color(200, 200, 200, 255 * a), Color(0, 0, 0, 255 * a), 0)
	end
end

function GM:HUDPaint()
	if not CCP then return end

	if self:InIntroCam() then
		self:DrawFancyIntro()
		return
	end

	if CCP.Quiz then
		self:DrawQuiz()
		return
	end

	if IsValid(LocalPlayer():CombineCamera()) then
		self:DrawCombineCamera()
		return
	end

	self:DrawCharCreate()

	if not self.CharCreate then
		local mode = LocalPlayer():OverlayMode()

		if mode == OVERLAY_TARGET then
			self:DrawTargetHUD()
		end

		if cookie.GetNumber("cc_hud", 1) == 1 and not self.Mastermind then
			self:DrawDamage()
			self:DrawDrugs()
			self:DrawConsciousness()
			self:DrawPassedOut()
			self:DrawDoors()

			if mode != OVERLAY_TARGET then
				self:DrawEntities()
				self:DrawPlayerInfo()
				self:DrawHealthBars()
			end

			self:DrawAmmo()
			self:DrawWeaponSelect()
			self:DrawTimedProgress()
			self:DrawNotifications()
		end

		if self.Mastermind then
			self:DrawEntities()
		end

		if cookie.GetNumber("cc_hud", 1) != 1 then
			self:DrawConsciousness()
			self:DrawPassedOut()
			self:DrawWeaponSelect()
		end

		self:DrawWarnings()
		self:DrawUnconnected()

		local wep = LocalPlayer():GetActiveWeapon()

		if IsValid(wep) and wep.HUDPaint then
			wep:HUDPaint()
		end
	end
end

function GM:HUDShouldDraw(str)
	if str == "CHudWeaponSelection" then return false end
	if str == "CHudAmmo" then return false end
	if str == "CHudAmmoSecondary" then return false end
	if str == "CHudHealth" then return false end
	if str == "CHudBattery" then return false end
	if str == "CHudChat" then return false end
	if str == "CHudDamageIndicator" then return false end

	return true
end

GM.MastermindMat = Material("vgui/white")

function GM:RenderNPCTargets()
	if self.Mastermind then
		for _, v in pairs(ents.GetNPCs()) do
			if v:NPCTargetPos() != Vector() then
				local col = v:NPCMastermindColor()

				cam.Start3D2D(v:NPCTargetPos() + Vector(0, 0, 1), Angle(), 1)
					surface.SetTexture(surface.GetTextureID("effects/select_ring"))
					surface.SetDrawColor(col.x, col.y, col.z, 255)
					surface.DrawTexturedRect(-10, -10, 20, 20)
				cam.End3D2D()

				render.DrawLine(v:GetPos(), v:NPCTargetPos(), Color(col.x, col.y, col.z, 255), false)
			end
		end

		if IsValid(self.MastermindSelected) then
			local trace = {}
			trace.start = LocalPlayer():GetShootPos()
			trace.endpos = trace.start + gui.ScreenToVector(gui.MousePos()) * 32768
			trace.filter = LocalPlayer()

			if self.MastermindMouse and self.MastermindMouse == 109 then
				trace.endpos = LocalPlayer():GetPos()
			end

			local tr = util.TraceLine(trace)

			cam.Start3D2D(tr.HitPos + Vector(0, 0, 1), Angle(), 1)
				surface.SetTexture(surface.GetTextureID("effects/select_ring"))
				surface.SetDrawColor(200, 200, 200, 255)
				surface.DrawTexturedRect(-10, -10, 20, 20)
			cam.End3D2D()

			render.DrawLine(self.MastermindSelected:GetPos(), tr.HitPos, Color(200, 200, 200, 255), false)
		end
	end
end

function GM:PostDrawOpaqueRenderables()
	for _, v in pairs(player.GetAll()) do
		local wep = v:GetActiveWeapon()

		if IsValid(wep) and wep.PostDrawOpaqueRenderables then
			wep:PostDrawOpaqueRenderables()
		end
	end

	self:RenderNPCTargets()

	if self.MapPostDrawOpaqueRenderables then
		self:MapPostDrawOpaqueRenderables()
	end

	self:DrugPostDrawOpaqueRenderables()
end

function GM:PostDrawTranslucentRenderables()
	for _, v in pairs(player.GetAll()) do
		local wep = v:GetActiveWeapon()

		if IsValid(wep) and wep.PostDrawTranslucentRenderables then
			wep:PostDrawTranslucentRenderables()
		end
	end
end

function GM:PostRenderVGUI()
	if self.CursorItem and cookie.GetNumber("cc_tooltips", 1) == 1 then
		self.CursorItem:DrawTooltip()
	end
end

function GM:GetCursorNPC(max)
	local dist = max
	local ent = nil

	for _, v in pairs(ents.GetNPCs()) do
		local pos = v:GetPos():ToScreen()
		local x, y = gui.MousePos()

		local d = math.sqrt((pos.x - x) ^ 2 + (pos.y - y) ^ 2)

		if d < dist then
			ent = v
			dist = d
		end
	end

	return ent
end

function GM:GetCursorEnt()
	local trace = {}
	trace.start = LocalPlayer():GetShootPos()
	trace.endpos = trace.start + gui.ScreenToVector(gui.MousePos()) * 32768
	trace.filter = LocalPlayer()
	local tr = util.TraceLine(trace)

	if IsValid(tr.Entity) then
		return tr.Entity
	end
end

function GM:PreDrawHalos()
	if self.Mastermind then
		local hEnt = nil

		if vgui.IsHoveringWorld() and not self.MastermindSelected then
			hEnt = self:GetCursorNPC(200)
		end

		if hEnt then
			if IsValid(hEnt:GetActiveWeapon()) then
				halo.Add({hEnt, hEnt:GetActiveWeapon()}, Color(255, 255, 255, 255), 4, 4, 2, true, true)
			else
				halo.Add({hEnt}, Color(255, 255, 255, 255), 4, 4, 2, true, true)
			end
		end

		local tab = {}

		for _, v in pairs(ents.GetNPCs()) do
			if v != hEnt then
				if not tab[v:NPCMastermindColor()] then
					tab[v:NPCMastermindColor()] = {}
				end

				table.insert(tab[v:NPCMastermindColor()], v)

				if v.GetActiveWeapon and v:GetActiveWeapon() and v:GetActiveWeapon():IsValid() then
					table.insert(tab[v:NPCMastermindColor()], v:GetActiveWeapon())
				end
			end
		end

		for _, v in pairs(ents.FindByClass("prop_vehicle_apc")) do
			if v != hEnt then
				if not tab[v:NPCMastermindColor()] then
					tab[v:NPCMastermindColor()] = {}
				end

				table.insert(tab[v:NPCMastermindColor()], v)
			end
		end

		for k, v in pairs(tab) do
			halo.Add({v}, Color(k.x, k.y, k.z, 255), 2, 2, 1, true, true)
		end
	end

	if GAMEMODE.SeeAll and IsValid(LocalPlayer():GetActiveWeapon()) and GAMEMODE.WeaponOutText[LocalPlayer():GetActiveWeapon():GetClass()] then
		local tab = {}

		for _, v in pairs(GAMEMODE.EntityTable.prop) do -- Only props can be permapropped so...
			if v:PropSaved() == 1 then
				table.insert(tab, v)
			end
		end

		halo.Add(tab, Color(255, 0, 255, 255), 1, 1, 1, true, false)
	end
end

function GM:RenderScreenspaceEffects()
	self.BaseClass:RenderScreenspaceEffects()

	if self:InIntroCam() then return end

	if LocalPlayer():PassedOut() then
		local tab = {}

		tab[ "$pp_colour_addr" ] 		= 0
		tab[ "$pp_colour_addg" ] 		= 0
		tab[ "$pp_colour_addb" ] 		= 0
		tab[ "$pp_colour_brightness" ] 	= -1
		tab[ "$pp_colour_contrast" ] 	= 1
		tab[ "$pp_colour_colour" ] 		= 1
		tab[ "$pp_colour_mulr" ] 		= 0
		tab[ "$pp_colour_mulg" ] 		= 0
		tab[ "$pp_colour_mulb" ] 		= 0

		--DrawColorModify(tab)
	end

	if self.FlashbangStart and LocalPlayer():Alive() then
		local t = CurTime() - self.FlashbangStart
		local a = 0

		if t < 5 then
			a = 1
		elseif t < 7 then
			a = 1 - (t - 5) / 2
		end

		local tab = {}

		tab[ "$pp_colour_addr" ] 		= 0
		tab[ "$pp_colour_addg" ] 		= 0
		tab[ "$pp_colour_addb" ] 		= 0
		tab[ "$pp_colour_brightness" ] 	= a
		tab[ "$pp_colour_contrast" ] 	= 1
		tab[ "$pp_colour_colour" ] 		= 1
		tab[ "$pp_colour_mulr" ] 		= 0
		tab[ "$pp_colour_mulg" ] 		= 0
		tab[ "$pp_colour_mulb" ] 		= 0

		DrawColorModify(tab)
	end

	local mode = LocalPlayer():OverlayMode()

	if mode == OVERLAY_NVG then
		self:DrawNVG()
	elseif mode == OVERLAY_TARGET then
		self:DrawTargetHUDPP()
	elseif mode == OVERLAY_THERMAL then
		self:DrawThermal()
	end

	if IsValid(LocalPlayer():CombineCamera()) then
		DrawMaterialOverlay("effects/combine_binocoverlay", 0)

		local tab = {}

		tab[ "$pp_colour_addr" ] 		= 0
		tab[ "$pp_colour_addg" ] 		= 0
		tab[ "$pp_colour_addb" ] 		= 0
		tab[ "$pp_colour_brightness" ] 	= 0
		tab[ "$pp_colour_contrast" ] 	= 1
		tab[ "$pp_colour_colour" ] 		= 0
		tab[ "$pp_colour_mulr" ] 		= 0
		tab[ "$pp_colour_mulg" ] 		= 0
		tab[ "$pp_colour_mulb" ] 		= 0

		DrawColorModify(tab)
	end

	local weapon = LocalPlayer():GetActiveWeapon()

	if IsValid(weapon) and weapon.RenderScreenspaceEffects then
		weapon:RenderScreenspaceEffects()
	end

	self:RenderScreenspaceDrugs()
end

function GM:PlayerStartVoice(ply)
	if not game.IsDedicated() then
		self.BaseClass:PlayerStartVoice(ply)
	end
end

function GM:PlayerEndVoice(ply)
	if not game.IsDedicated() then
		self.BaseClass:PlayerEndVoice(ply)
	end
end

GM.NVGMat = Material("effects/combine_binocoverlay")
GM.NVGMat:SetFloat("$alpha", 0)

GM.NVGScale = 0.5

function GM:DrawNVG()
	if self.NVGScale < 1 then
		self.NVGScale = self.NVGScale + 0.1 * (1 - self.NVGScale)
	else
		self.NVGScale = 1
	end

	render.UpdateScreenEffectTexture()
	render.SetMaterial(self.NVGMat)
	render.DrawScreenQuad()

	local light = DynamicLight(LocalPlayer():EntIndex())

	if light then
		light.Pos = EyePos()
		light.r = 75
		light.g = 75
		light.b = 75
		light.Brightness = 1
		light.Size = 2048
		light.Decay = 0
		light.DieTime = CurTime() + 0.1
		light.Style = 0
	end

	local tab = {}

	tab["$pp_colour_addr"] 			= -1
	tab["$pp_colour_addg"] 			= -0.65
	tab["$pp_colour_addb"] 			= -1
	tab["$pp_colour_brightness"] 	= self.NVGScale * 0.8
	tab["$pp_colour_contrast"] 		= self.NVGScale * 1.106
	tab["$pp_colour_colour"] 		= 0
	tab["$pp_colour_mulr"] 			= 0
	tab["$pp_colour_mulg"] 			= 0.1
	tab["$pp_colour_mulb"] 			= 0

	DrawColorModify(tab)
	DrawBloom(0.75, self.NVGScale * 1.5, 10, 10, 1, self.NVGScale, 1, 1, 1)
	DrawMotionBlur(0.5, 0.4, 0.04)
end

function GM:DrawTargetHUD()
	local target = LocalPlayer():GetEyeTrace().Entity

	if not IsValid(target) or not (target:IsPlayer() or target:IsNPC()) then
		target = nil
	end

	local pos

	if LocalPlayer():ShouldDrawLocalPlayer() then
		local vec = (LocalPlayer():EyeAngles() + LocalPlayer():GetViewPunchAngles()):Forward()
		local trace = util.TraceLine({
			start = LocalPlayer():GetShootPos(),
			endpos = LocalPlayer():EyePos() + (vec * 10000),
			filter = {LocalPlayer()}
		})

		local tab = trace.HitPos:ToScreen()

		pos = Vector(tab.x, tab.y, 0)
	else
		pos = Vector(ScrW() * 0.5, ScrH() * 0.5, 0)
	end

	self:DrawTargetHUDText(pos, target)
end

GM.TargetHUDUpdate = CurTime()
GM.TargetHUDText = {}
GM.TargetHUDFont = "CombineControl.CombineScanner"
GM.TargetHUDColor = Color(255, 0, 0)
GM.TargetHUDColorReprog = Color(0, 191, 255)

function GM:DrawTargetHUDText(pos, target)
	local col = ColorAlpha(LocalPlayer():Team() == TEAM_REPROG and self.TargetHUDColorReprog or self.TargetHUDColor, self.TargetScale * 255)
	local size = 80

	surface.SetDrawColor(col)
	surface.SetTexture(surface.GetTextureID("models/tnb/trpweapons/reticule_square"))

	surface.DrawTexturedRect(pos.x - size, pos.y - size, size * 2, size * 2)

	local dist = LocalPlayer():GetEyeTrace().HitPos:Distance(LocalPlayer():EyePos())

	draw.DrawText(string.format("DIST: %s (%s)", math.Round(dist * 0.0254), math.Round(dist)), "DebugFixed", pos.x - size, pos.y + size, col)
	draw.DrawText("BEARING: " .. math.floor(math.AngleToHeading(LocalPlayer():EyeAngles().y)), "DebugFixed", pos.x - size, pos.y + size + draw.GetFontHeight("DebugFixed"), col)

	if self.TargetHUDUpdate <= CurTime() then
		table.insert(self.TargetHUDText, 1, string.Right(tostring({}), 10))

		if #self.TargetHUDText > 8 then
			table.remove(self.TargetHUDText)
		end

		self.TargetHUDUpdate = CurTime() + 0.1
	end

	surface.SetFont(self.TargetHUDFont)

	local x = 20
	local y = 20

	local function drawText(text, align)
		align = align or TEXT_ALIGN_LEFT

		draw.DrawText(text, self.TargetHUDFont, x, y, col, align)

		y = y + self.FontHeight[self.TargetHUDFont]
	end

	drawText("DATA RECV:")
	drawText("**********")

	for _, v in pairs(self.TargetHUDText) do
		drawText(v)
	end

	x = ScrW() - 20
	y = ScrH() * 0.4

	if target then
		local tab = {}
		local width = 0

		local function add(preface, text)
			width = math.max(width, #tostring(text))

			table.insert(tab, {preface, text})
		end

		add("389 TARGID", target:IsPlayer() and target:VisibleRPName() or "NULL")
		add("105 STRCTR", math.Round(target:Health()))
		add("127 EXTERN", (target:IsPlayer() and target:BodyArmor() >= 0.5) and math.Round(target:BodyArmor()) or "NULL")

		if target:IsPlayer() then
			local weaponlist = target:GetWeapons()
			local output = {}

			for _, v in pairs(weaponlist) do
				if v.Tekka then
					table.insert(output, self:GetWeaponName(v))
				end
			end

			table.sort(output)

			add("790 WEAPON", table.remove(output, 1) or "NULL")

			for _, v in pairs(output) do
				add("", v)
			end
		else
			add("790 WEAPON", "NULL")
		end

		drawText("TARGET ANALYSIS:", TEXT_ALIGN_RIGHT)
		drawText(string.rep("*", width + 12), TEXT_ALIGN_RIGHT)

		for _, v in pairs(tab) do
			drawText(string.format("%s  %-" .. width .. "s", unpack(v)), TEXT_ALIGN_RIGHT)
		end
	end

	x = 20
	y = ScrH() - 20 - (self.FontHeight[self.TargetHUDFont] * 4)

	drawText("DEBUG QUERY")
	drawText("SYSCHECK...")
	drawText(string.format("NETWORK MASK: %s...", LocalPlayer():VisibleRPName()))
	drawText(string.format("STRCTR: %d/%d... EXTERN: %d/%d... VEL: %.2f M/S...", LocalPlayer():Health(), LocalPlayer():GetMaxHealth(), LocalPlayer():BodyArmor(), LocalPlayer():MaxBodyArmor(), LocalPlayer():GetVelocity():Length() * 0.0254))
end

function GM:GetWeaponName(ent)
	local blacklist = {
		["admin"] = true,
		["drone"] = true,
		["dual"] = true,
		["infiltrator"] = true,
		["skynet"] = true,
		["tc"] = true,
		["tekka"] = true,
		["trp"] = true
	}

	local expl = string.Explode("_", ent:GetClass())
	local weapon = {}

	for _, v in pairs(expl) do
		if blacklist[v] then
			continue
		end

		table.insert(weapon, v)
	end

	return table.concat(weapon, "_")
end

function GM:DrawTargetHUDPP()
	self.TargetScale = math.Clamp(self.TargetScale + 0.02 * (1 - self.TargetScale), 0, 1)

	local tab = {}

	tab["$pp_colour_addr"] 			= 0
	tab["$pp_colour_addg"] 			= 0
	tab["$pp_colour_addb"] 			= 0
	tab["$pp_colour_brightness"] 	= 0
	tab["$pp_colour_contrast"] 		= 1 * self.TargetScale
	tab["$pp_colour_colour"] 		= 0
	tab["$pp_colour_mulr"] 			= 0.1 * self.TargetScale
	tab["$pp_colour_mulg"] 			= 0.1 * self.TargetScale
	tab["$pp_colour_mulb"] 			= 0.1 * self.TargetScale

	DrawColorModify(tab)

	local bloom = self.TargetScale * 2

	if bloom > 1 then
		bloom = 1 - (bloom - 1)
	end

	DrawBloom(0.07, bloom * 5, 9, 9, 1, 1, 1, 1, 1 )
end

local white = Material("engine/singlecolor")

function GM:DrawThermal()
	local tab = {}

	table.Add(tab, player.GetAll())
	table.Add(tab, ents.FindByClass("npc_*"))

	render.SetStencilEnable(true)

	render.SetStencilWriteMask(255)
	render.SetStencilTestMask(255)

	render.SetStencilReferenceValue(1)

	render.SetStencilCompareFunction(STENCIL_ALWAYS)

	render.SetStencilPassOperation(STENCIL_REPLACE)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)

	render.ClearStencil()

	render.SuppressEngineLighting(true)
	render.MaterialOverride(white)

	cam.Start3D()
		for _, v in pairs(tab) do
			local thermal = v:IsPlayer() and v:ThermalHidden() or false
			local ent = GAMEMODE:ShouldDrawStencilEnt(v)

			if not IsValid(ent) or ent:IsDormant() then
				continue
			end

			GAMEMODE:DrawStencilEnt(ent, thermal)
		end
	cam.End3D()

	render.MaterialOverride()
	render.SuppressEngineLighting(false)

	render.SetStencilCompareFunction(STENCIL_NOTEQUAL)

	DrawColorModify({
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = -0.1,
		["$pp_colour_contrast"] = 0.25,
		["$pp_colour_colour"] = 0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	})

	DrawColorModify({
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	})

	render.SetStencilEnable(false)

	DrawBloom(0, 2, 1, 1, 1, 1, 1, 1, 1)
	DrawMotionBlur(0.5, 0.4, 0.04)
end

hook.Add("OnOverlayModeChanged", "CL.Hud.OverlayMode", function(ply, mode)
	local snd = (mode == OVERLAY_NONE) and "items/nvg_off.wav" or "items/nvg_on.wav"

	surface.PlaySound(snd)

	if mode == OVERLAY_NVG then
		GAMEMODE.NVGScale = 0.5
	elseif mode == OVERLAY_TARGET then
		GAMEMODE.TargetScale = 0
	end
end)

hook.Add("PreDrawOutlines", "CL.Hud.Outlines", function()
	if LocalPlayer():OverlayMode() != OVERLAY_TARGET then
		return
	end

	local target = LocalPlayer():GetEyeTrace().Entity

	if not IsValid(target) or not (target:IsPlayer() or target:IsNPC()) then
		target = nil
	end

	for _, v in pairs(ents.GetAll()) do
		if not IsValid(v) then
			continue
		end

		if v:IsDormant() then
			continue
		end

		if not (v:IsNPC() or v:IsPlayer()) then
			continue
		end

		local ent = GAMEMODE:ShouldDrawStencilEnt(v)

		if not IsValid(ent) then
			continue
		end

		local color = (ent:IsPlayer() and ent != target) and GAMEMODE:GetTeamColor(ent) or color_white

		local tab = {ent}
		local body, ext, weapon

		if ent:IsPlayer() then
			weapon = ent:GetActiveWeapon()
			body = Entity(ent:CompoundBodyEnt())
			ext = Entity(ent:CompoundExtEnt())
		else
			weapon = ent.GetActiveWeapon and ent:GetActiveWeapon()
			body = Entity(ent:GetNWInt("CompoundBody", -1))
			ext = Entity(ent:GetNWInt("CompoundExt", -1))
		end

		if IsValid(body) then
			table.insert(tab, body)
		end

		if IsValid(ext) then
			table.insert(tab, ext)
		end

		if IsValid(weapon) then
			table.insert(tab, weapon)
		end

		outline.Add(tab, color, OUTLINE_MODE_VISIBLE)
	end
end)