local meta = FindMetaTable("Player")

GM.MastermindBinds = {
	"+forward",
	"+back",
	"+moveright",
	"+moveleft",
	"+jump",
	"+duck",
	"+speed",
	"+use",
	"+attack",
	"+attack2",
	"+menu_context",
	"+menu",
	"+showscores",
	"+jump",
	"gm_showspare1",
	"noclip",
	"undo",
	"jpeg",
	"impulse 100",
	"slot1",
	"slot2",
	"slot3",
	"invnext",
	"invprev",
	"rp_thirdperson",
}

GM.AllowedProgressBinds = {}
GM.AllowedProgressBinds["messagemode"] = true

function GM:PlayerBindPress(ply, bind, down)
	if down and not self.CharCreateOpened then

		return true

	end

	if down and self:InIntroCam() then

		return true

	end

	if down and not self.AllowedProgressBinds[bind] and table.Count(self.TimedProgressBars) > 0 then
		table.Empty(self.TimedProgressBars)
	end

	if down and IsValid(ply:CombineCamera()) then

		if bind ~= "messagemode" then

			net.Start("nResetCombineCamera")
			net.SendToServer()

			return true

		end

	end

	if down and string.find(bind, "messagemode") then

		self:ShowChat()
		return true

	end

	if down and string.find(bind, "showspare2") and LocalPlayer():IsAdmin() then

		self:CreateAdminMenu()
		return true

	end

	if down and self.Mastermind then

		if not table.HasValue(self.MastermindBinds, bind) then

			if bind == "gm_showhelp" then

				self:CreateNPCModifierMenu()

			end

			if bind == "gm_showteam" then

				self:CreateNPCCreatorMenu()

			end

			return true

		end

	end

	if down and string.find(bind, "showhelp") then

		self:CreateHelpMenu()
		return true

	end

	if down and string.find(bind, "showteam") then

		if LocalPlayer():TiedUp() then

			self:AddChat("You can't switch characters while tied up.", Color(200, 0, 0, 255))
			return true

		end

		local mul = LocalPlayer():IsSuperAdmin() and 3 or LocalPlayer():IsAdmin() and 2 or 1
		if table.Count(self.Characters) >= self.MaxCharacters*mul or (not LocalPlayer():IsAdmin() and GAMEMODE.CurrentLocation ~= LOCATION_CITY) then
			self.CCMode = CC_SELECT_C
		else
			self.CCMode = CC_CREATESELECT_C
		end
		self:CreateCharEditor()

		return true

	end

	if down and string.find(bind, "showspare1") then

		self:CreatePlayerMenu()
		return true

	end

	if down and string.find(bind, "rp_toggleholster") then
		if LocalPlayer():PassedOut() then return end
		if LocalPlayer():TiedUp() then return end
		if LocalPlayer():MountedGun() and LocalPlayer():MountedGun():IsValid() then return end

		net.Start("nToggleHolster")
		net.SendToServer()

		local weapon = LocalPlayer():GetActiveWeapon()

		if IsValid(weapon) then

			if weapon.Tekka then
				weapon:ToggleHolster()
			end

			if weapon.Holsterable then
				LocalPlayer():SetHolstered(not LocalPlayer():Holstered())
			else
				LocalPlayer():SetHolstered(false)
			end

		end

		return true

	end

	if down and string.find(bind, "+menu_context") then

		if LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon():GetClass() ~= "gmod_tool" then

			if self.Mastermind then

				gui.EnableScreenClicker(true)

			else

				local trace = {}
				trace.start = LocalPlayer():GetShootPos()
				trace.endpos = trace.start + LocalPlayer():GetAimVector() * 32768
				trace.filter = LocalPlayer()
				local tr = util.TraceLine(trace)

				self:CreateCCContext(tr.Entity)
				gui.EnableScreenClicker(true)

			end

			self.CCContext = true

			return true

		end

	end

	if not down and string.find(bind, "+menu_context") then

		gui.EnableScreenClicker(false)
		self.MastermindSelected = nil

		if LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon() ~= NULL and LocalPlayer():GetActiveWeapon():GetClass() ~= "gmod_tool" then

			if not self.Mastermind then

				self:RemoveCCContext()

			end

			self.CCContext = false

			return true

		end

	end

	if string.lower(ply:GetModel()) == "models/stalker.mdl" then

		if down and string.find(bind, "+jump") and ply:GetMoveType() == MOVETYPE_WALK then

			return true

		end

		if down and string.find(bind, "+duck") and ply:GetMoveType() == MOVETYPE_WALK then

			return true

		end

	end

	if string.lower(ply:GetModel()) == "models/hunter.mdl" then

		if down and string.find(bind, "+duck") and ply:GetMoveType() == MOVETYPE_WALK then

			return true

		end

	end

	if string.lower( ply:GetModel() ) == "models/combine_scanner.mdl" then
		if down and string.find( bind, "+duck" ) and ply:GetMoveType() == 4 then
			return true
		end
	end

	if ply.FreezeTime and CurTime() < ply.FreezeTime then

		if down and string.find(bind, "+jump") then

			return true

		end

		if down and string.find(bind, "+duck") then

			return true

		end

	end

	if ply:MountedGun() and ply:MountedGun():IsValid() then

		if down and string.find(bind, "+jump") then

			return true

		end

		if down and string.find(bind, "+duck") then

			return true

		end

	end

	if down and string.find(bind, "+attack") and LocalPlayer():TiedUp() then

		return true

	end

	if down and string.find(bind, "+reload") and LocalPlayer():TiedUp() then

		return true

	end

	return hook.Run("CC.CL.PlayerBindPress", ply, bind, down)
end

function GM:ToggleHolsterThink()
	if not self.ToggleHolsterPressed then self.ToggleHolsterPressed = false end

	if vgui.CursorVisible() then self.ToggleHolsterPressed = false return end

	if input.IsKeyDown(KEY_B) and not self.ToggleHolsterPressed then
		self.ToggleHolsterPressed = true

		if LocalPlayer():PassedOut() then return end
		if LocalPlayer():TiedUp() then return end
		if LocalPlayer():MountedGun() and LocalPlayer():MountedGun():IsValid() then return end

		net.Start("nToggleHolster")
		net.SendToServer()

		local weapon = LocalPlayer():GetActiveWeapon()

		if IsValid(weapon) then
			if weapon.Holsterable then
				LocalPlayer():SetHolstered(not LocalPlayer():Holstered())
			else
				LocalPlayer():SetHolstered(false)
			end

			if weapon.Tekka then
				weapon:ToggleHolster()
			end
		end
	elseif not input.IsKeyDown(KEY_B) and self.ToggleHolsterPressed then
		self.ToggleHolsterPressed = false
	end
end
