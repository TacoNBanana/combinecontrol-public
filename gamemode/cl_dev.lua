if not game.IsDedicated() then

	GM.IronDevPos = GM.IronDevPos or Vector()
	GM.IronDevAng = GM.IronDevAng or Vector()

	function GM:CreateIronDev()

		CCP.IronDev = vgui.Create("DFrame")
		CCP.IronDev:SetSize(200, 250)
		CCP.IronDev:SetPos(20, 20)
		CCP.IronDev:SetTitle("Ironsights Dev")
		CCP.IronDev.lblTitle:SetFont("CombineControl.Window")
		CCP.IronDev:SetDeleteOnClose(true)
		CCP.IronDev:MakePopup()

		function CCP.IronDev.btnClose:DoClick()
			CCP.IronDev:Close()
			CCP.IronDev = nil
		end

		local n = 1

		CCP.IronDev.Pos = {}
		CCP.IronDev.Ang = {}

		for _, v in pairs({"x", "y", "z"}) do
			CCP.IronDev.Pos[v] = vgui.Create("DNumSlider", CCP.IronDev)
			CCP.IronDev.Pos[v]:SetPos(10, 30 + n * 20)
			CCP.IronDev.Pos[v]:SetSize(180, 16)
			CCP.IronDev.Pos[v]:SetText("Pos: " .. v)
			CCP.IronDev.Pos[v]:SetMin(-20)
			CCP.IronDev.Pos[v]:SetMax(20)
			CCP.IronDev.Pos[v]:SetDecimals(3)
			CCP.IronDev.Pos[v]:SetValue(self.IronDevPos[v])
			CCP.IronDev.Pos[v].PerformLayout = CCSliderPerformLayout
			CCP.IronDev.Pos[v]:PerformLayout()

			CCP.IronDev.Pos[v].OnValueChanged = function(pnl, val)
				GAMEMODE.IronDevPos[v] = val
			end

			n = n + 1
		end

		for _, v in pairs({"x", "y", "z"}) do
			CCP.IronDev.Ang[v] = vgui.Create("DNumSlider", CCP.IronDev)
			CCP.IronDev.Ang[v]:SetPos(10, 30 + n * 20)
			CCP.IronDev.Ang[v]:SetSize(180, 16)
			CCP.IronDev.Ang[v]:SetText("Ang: " .. v)
			CCP.IronDev.Ang[v]:SetMin(-45)
			CCP.IronDev.Ang[v]:SetMax(45)
			CCP.IronDev.Ang[v]:SetDecimals(3)
			CCP.IronDev.Ang[v]:SetValue(self.IronDevAng[v])
			CCP.IronDev.Ang[v].PerformLayout = CCSliderPerformLayout
			CCP.IronDev.Ang[v]:PerformLayout()

			CCP.IronDev.Ang[v].OnValueChanged = function(pnl, val)
				GAMEMODE.IronDevAng[v] = val
			end

			n = n + 1
		end

		CCP.IronDev.Copy = vgui.Create("DButton", CCP.IronDev)
		CCP.IronDev.Copy:SetFont("CombineControl.LabelSmall")
		CCP.IronDev.Copy:SetText("Copy from weapon")
		CCP.IronDev.Copy:SetPos(10, 30 + n * 20)
		CCP.IronDev.Copy:SetSize(180, 20)

		function CCP.IronDev.Copy:DoClick()
			local weapon = LocalPlayer():GetActiveWeapon()

			if not weapon.Tekka then
				return
			end

			GAMEMODE.IronDevPos = weapon.AimOffset.pos
			GAMEMODE.IronDevAng = weapon.AimOffset.ang

			for _, v in pairs({"x", "y", "z"}) do
				CCP.IronDev.Pos[v]:SetValue(GAMEMODE.IronDevPos[v])
			end

			for _, v in pairs({"x", "y", "z"}) do
				CCP.IronDev.Ang[v]:SetValue(GAMEMODE.IronDevAng[v])
			end
		end


		CCP.IronDev.Output = vgui.Create("DButton", CCP.IronDev)
		CCP.IronDev.Output:SetFont("CombineControl.LabelSmall")
		CCP.IronDev.Output:SetText("Output")
		CCP.IronDev.Output:SetPos(10, 30 + n * 20 + 25)
		CCP.IronDev.Output:SetSize(180, 20)

		function CCP.IronDev.Output:DoClick()
			MsgN("SWEP.AimOffset = {")
			MsgN("	ang = Vector(" .. tostring(math.ceil(GAMEMODE.IronDevAng.x * 1000) / 1000) .. ", " .. tostring(math.ceil(GAMEMODE.IronDevAng.y * 1000) / 1000) .. ", " .. tostring(math.ceil(GAMEMODE.IronDevAng.z * 1000) / 1000) .. "),")

			MsgN("	pos = Vector(" .. tostring(math.ceil(GAMEMODE.IronDevPos.x * 1000) / 1000) .. ", " .. tostring(math.ceil(GAMEMODE.IronDevPos.y * 1000) / 1000) .. ", " .. tostring(math.ceil(GAMEMODE.IronDevPos.z * 1000) / 1000) .. ")")
			MsgN("}")
		end

		CCP.IronDev.Output:PerformLayout()

		CCP.IronDev.Reset = vgui.Create("DButton", CCP.IronDev)
		CCP.IronDev.Reset:SetFont("CombineControl.LabelSmall")
		CCP.IronDev.Reset:SetText("Reset")
		CCP.IronDev.Reset:SetPos(10, 30 + n * 20 + 50)
		CCP.IronDev.Reset:SetSize(180, 20)
		function CCP.IronDev.Reset:DoClick()
			GAMEMODE.IronDevPos = Vector()
			GAMEMODE.IronDevAng = Vector()

			for _, v in pairs({"x", "y", "z"}) do
				CCP.IronDev.Pos[v]:SetValue(GAMEMODE.IronDevPos[v])
			end

			for _, v in pairs({"x", "y", "z"}) do
				CCP.IronDev.Ang[v]:SetValue(GAMEMODE.IronDevAng[v])
			end
		end

		CCP.IronDev.Reset:PerformLayout()
	end

	function ccCreateIronDev(ply, cmd, args)

		if not ply:IsAdmin() then return end

		GAMEMODE:CreateIronDev()

		gui.HideGameUI()
	end
	concommand.Add("rp_dev_irondev", ccCreateIronDev)

	concommand.Add("rp_dev_freezevm", function(ply, cmd, args)
		if not ply:IsDeveloper() then
			return
		end

		local weapon = ply:GetActiveWeapon()

		if not IsValid(weapon) or not weapon.Tekka then
			return
		end

		weapon.DevFrozen = not weapon.DevFrozen
	end)

	function GM:CreateItemDev()

		CCP.ItemDev = vgui.Create("DFrame")
		CCP.ItemDev:SetSize(400, 250)
		CCP.ItemDev:Center()
		CCP.ItemDev:SetTitle("Item Dev")
		CCP.ItemDev.lblTitle:SetFont("CombineControl.Window")
		CCP.ItemDev:SetDeleteOnClose(true)
		CCP.ItemDev:MakePopup()

		CCP.ItemDev.Think = UIAutoClose
		function CCP.ItemDev.btnClose:DoClick()

			CCP.ItemDev:Close()
			CCP.ItemDev = nil

		end

		local icon = vgui.Create("DModelPanel", CCP.ItemDev)
		icon:SetPos(10, 30)
		icon:SetModel("models/weapons/w_smg1.mdl")
		icon:SetSize(160, 160)

		local p = icon.Paint
		function icon:Paint(w, h)
			surface.SetDrawColor(0, 0, 0, 70)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawOutlinedRect(0, 0, w, h)
			p(self, w, h)
		end

		CCP.ItemDev.IconData = PositionSpawnIcon(icon:GetEntity(), icon:GetEntity():GetPos(), true)
		table.Merge(CCP.ItemDev.IconData, {
			FOVOverride = CCP.ItemDev.IconData.fov,
			CamOffset = Vector(),
			AngOffset = Angle()
		})

		icon:SetFOV(CCP.ItemDev.IconData.fov)
		icon:SetCamPos(CCP.ItemDev.IconData.origin)
		icon:SetLookAng(CCP.ItemDev.IconData.angles)

		function icon:LayoutEntity() end

		local n = 0

		CCP.ItemDev.CamOffset = {}
		CCP.ItemDev.AngOffset = {}

		CCP.ItemDev.FOV = vgui.Create("DNumSlider", CCP.ItemDev)
		CCP.ItemDev.FOV:SetPos(210, 30)
		CCP.ItemDev.FOV:SetSize(180, 16)
		CCP.ItemDev.FOV:SetText("FOV")
		CCP.ItemDev.FOV:SetMin(1)
		CCP.ItemDev.FOV:SetMax(50)
		CCP.ItemDev.FOV:SetDecimals(2)
		CCP.ItemDev.FOV:SetValue(CCP.ItemDev.IconData.fov)
		CCP.ItemDev.FOV.PerformLayout = CCSliderPerformLayout
		CCP.ItemDev.FOV:PerformLayout()

		function CCP.ItemDev.FOV:OnValueChanged(val)

			CCP.ItemDev.IconData.FOVOverride = val
			icon:SetFOV(CCP.ItemDev.IconData.FOVOverride)

		end

		CCP.ItemDev.FOV.Reset = vgui.Create("DButton", CCP.ItemDev)
		CCP.ItemDev.FOV.Reset:SetFont("marlett")
		CCP.ItemDev.FOV.Reset:SetText("r")
		CCP.ItemDev.FOV.Reset:SetPos(190, 30 + n * 20)
		CCP.ItemDev.FOV.Reset:SetSize(16, 16)
		function CCP.ItemDev.FOV.Reset:DoClick()
			CCP.ItemDev.IconData.FOVOverride = CCP.ItemDev.IconData.fov
			CCP.ItemDev.FOV:SetValue(CCP.ItemDev.IconData.fov)
			icon:SetFOV(CCP.ItemDev.IconData.fov)
		end

		CCP.ItemDev.Entry = vgui.Create("DTextEntry", CCP.ItemDev)
		CCP.ItemDev.Entry:SetFont("CombineControl.LabelSmall")
		CCP.ItemDev.Entry:SetPos(10, 200)
		CCP.ItemDev.Entry:SetSize(380, 20)
		CCP.ItemDev.Entry:PerformLayout()
		CCP.ItemDev.Entry:SetValue("")
		CCP.ItemDev.Entry:SetCaretPos(#CCP.ItemDev.Entry:GetValue())
		function CCP.ItemDev.Entry:OnEnter()

			local val = string.lower(self:GetValue())
			if not val:EndsWith(".mdl") then
				return
			end
			icon:SetModel(val)

			CCP.ItemDev.IconData = PositionSpawnIcon(icon:GetEntity(), icon:GetEntity():GetPos(), true)
			table.Merge(CCP.ItemDev.IconData, {
				FOVOverride = CCP.ItemDev.IconData.fov,
				CamOffset = Vector(),
				AngOffset = Angle()
			})

			icon:SetFOV(CCP.ItemDev.IconData.fov)
			icon:SetCamPos(CCP.ItemDev.IconData.origin)
			icon:SetLookAng(CCP.ItemDev.IconData.angles)

			CCP.ItemDev.FOV:SetValue(CCP.ItemDev.IconData.fov)
			for _, v in pairs{"x", "y", "z"} do
				CCP.ItemDev.CamOffset[v]:SetValue(0)
			end
			for _, v in pairs{"p", "y", "r"} do
				CCP.ItemDev.AngOffset[v]:SetValue(0)
			end

		end

		n = n + 1

		for _, v in pairs({"x", "y", "z"}) do

			CCP.ItemDev.CamOffset[v] = vgui.Create("DNumSlider", CCP.ItemDev)
			CCP.ItemDev.CamOffset[v]:SetPos(210, 30 + n * 20)
			CCP.ItemDev.CamOffset[v]:SetSize(180, 16)
			CCP.ItemDev.CamOffset[v]:SetText(v)
			CCP.ItemDev.CamOffset[v]:SetMin(-512)
			CCP.ItemDev.CamOffset[v]:SetMax(512)
			CCP.ItemDev.CamOffset[v]:SetDecimals(2)
			CCP.ItemDev.CamOffset[v]:SetValue(0)
			CCP.ItemDev.CamOffset[v].PerformLayout = CCSliderPerformLayout
			CCP.ItemDev.CamOffset[v]:PerformLayout()

			CCP.ItemDev.CamOffset[v].OnValueChanged = function(_, val)

				CCP.ItemDev.IconData.CamOffset[v] = val
				icon:SetCamPos(CCP.ItemDev.IconData.origin + CCP.ItemDev.IconData.CamOffset)

			end

			CCP.ItemDev.CamOffset[v].Reset = vgui.Create("DButton", CCP.ItemDev)
			CCP.ItemDev.CamOffset[v].Reset:SetFont("marlett")
			CCP.ItemDev.CamOffset[v].Reset:SetText("r")
			CCP.ItemDev.CamOffset[v].Reset:SetPos(190, 30 + n * 20)
			CCP.ItemDev.CamOffset[v].Reset:SetSize(16, 16)
			CCP.ItemDev.CamOffset[v].Reset.DoClick = function()
				CCP.ItemDev.IconData.CamOffset[v] = 0
				CCP.ItemDev.CamOffset[v]:SetValue(0)
				icon:SetCamPos(CCP.ItemDev.IconData.origin + CCP.ItemDev.IconData.CamOffset)
			end

			n = n + 1

		end

		for _, v in pairs({"p", "y", "r"}) do

			CCP.ItemDev.AngOffset[v] = vgui.Create("DNumSlider", CCP.ItemDev)
			CCP.ItemDev.AngOffset[v]:SetPos(210, 30 + n * 20)
			CCP.ItemDev.AngOffset[v]:SetSize(180, 16)
			CCP.ItemDev.AngOffset[v]:SetText(v)
			CCP.ItemDev.AngOffset[v]:SetMin(-180)
			CCP.ItemDev.AngOffset[v]:SetMax(180)
			CCP.ItemDev.AngOffset[v]:SetDecimals(2)
			CCP.ItemDev.AngOffset[v]:SetValue(0)
			CCP.ItemDev.AngOffset[v].PerformLayout = CCSliderPerformLayout
			CCP.ItemDev.AngOffset[v]:PerformLayout()

			CCP.ItemDev.AngOffset[v].OnValueChanged = function(_, val)

				CCP.ItemDev.IconData.AngOffset[v] = val
				icon:GetEntity():SetAngles(CCP.ItemDev.IconData.AngOffset)

			end

			CCP.ItemDev.AngOffset[v].Reset = vgui.Create("DButton", CCP.ItemDev)
			CCP.ItemDev.AngOffset[v].Reset:SetFont("marlett")
			CCP.ItemDev.AngOffset[v].Reset:SetText("r")
			CCP.ItemDev.AngOffset[v].Reset:SetPos(190, 30 + n * 20)
			CCP.ItemDev.AngOffset[v].Reset:SetSize(16, 16)
			CCP.ItemDev.AngOffset[v].Reset.DoClick = function()
				CCP.ItemDev.IconData.AngOffset[v] = 0
				CCP.ItemDev.AngOffset[v]:SetValue(0)
				icon:GetEntity():SetAngles(CCP.ItemDev.IconData.AngOffset)
			end

			n = n + 1

		end


		CCP.ItemDev.Output = vgui.Create("DButton", CCP.ItemDev)
		CCP.ItemDev.Output:SetFont("CombineControl.LabelSmall")
		CCP.ItemDev.Output:SetText("Output")
		CCP.ItemDev.Output:SetPos(210, 30 + n * 20)
		CCP.ItemDev.Output:SetSize(180, 20)
		function CCP.ItemDev.Output:DoClick()
			local p = CCP.ItemDev
			local fov = p.FOV:GetValue()
			local camOff = Vector(p.CamOffset.x:GetValue(), p.CamOffset.y:GetValue(), p.CamOffset.z:GetValue())
			local angOff = Angle(p.AngOffset.p:GetValue(), p.AngOffset.y:GetValue(), p.AngOffset.r:GetValue())

			MsgN("ITEM.IconFOV \t\t= " .. (fov ~= p.IconData.fov and
										string.format("%.2f", fov)
										or "-1"))
			MsgN("ITEM.CamOffset \t\t= " .. (camOff ~= Vector() and
										string.format("Vector(%.2f, %.2f, %.2f)", camOff.x, camOff.y, camOff.z)
										or "Vector()"))
			MsgN("ITEM.AngOffset \t\t= " .. (angOff ~= Angle() and
										string.format("Angle(%.2f, %.2f, %.2f)", angOff.p, angOff.y, angOff.r)
										or "Angle()"))

		end
		CCP.ItemDev.Output:PerformLayout()

	end

	function ccCreateItemDev(ply, cmd, args)

		if not ply:IsAdmin() then return end

		GAMEMODE:CreateItemDev()

	end
	concommand.Add("rp_dev_itemdev", ccCreateItemDev)

	function ccGetCamPos(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local p = ply:EyePos()
		MsgN("Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. ")")

	end
	concommand.Add("rp_dev_getcampos", ccGetCamPos)

	function ccGetAntlionPos(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local p = ply:GetEyeTrace().HitPos
		MsgN("self:AddAntlionSpawn(Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. "), 5)")

	end
	concommand.Add("rp_dev_getantlionpos", ccGetAntlionPos)

	function ccGetIntroCamPos(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local p = ply:EyePos()
		local a = ply:EyeAngles()
		MsgN("Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. ")")
		MsgN("Angle(" .. tostring(math.ceil(a.p)) .. ", " .. tostring(math.ceil(a.y)) .. ", 0)")

	end
	concommand.Add("rp_dev_getintrocampos", ccGetIntroCamPos)

	function ccGetHL2CamPos(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local p = ply:EyePos()
		local a = ply:EyeAngles()
		MsgN("return {Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. "), Angle(" .. tostring(math.ceil(a.p)) .. ", " .. tostring(math.ceil(a.y)) .. ", " .. tostring(math.ceil(a.r)) .. ")}")

	end
	concommand.Add("rp_dev_gethl2campos", ccGetHL2CamPos)

	function ccGetCombineCratePos(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local ent = ply:GetEyeTrace().Entity

		if ent and ent:IsValid() then

			local p = ent:GetPos()
			local a = ent:GetAngles()
			MsgN("return {Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. "), Angle(" .. tostring(math.ceil(a.p)) .. ", " .. tostring(math.ceil(a.y)) .. ", " .. tostring(math.ceil(a.r)) .. ")}")

		end

	end
	concommand.Add("rp_dev_getcombinecratepos", ccGetCombineCratePos)

	function ccGetStovePos(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local ent = ply:GetEyeTrace().Entity

		if ent and ent:IsValid() then

			local p = ent:GetPos()
			local a = ent:GetAngles()
			MsgN("{Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. "), Angle(0, " .. tostring(math.ceil(a.y)) .. ", 0), \"\", true},")

		end

	end
	concommand.Add("rp_dev_getstovepos", ccGetStovePos)

	function ccGetStovePosS(ply, cmd, args)

		if not ply:IsAdmin() then return end

		for _, v in pairs(ents.FindByClass("prop_physics")) do

			if v:GetModel() == "models/props_c17/furnitureStove001a.mdl" then

				local p = v:GetPos()
				local a = v:GetAngles()
				MsgN("{Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. "), Angle(0, " .. tostring(math.ceil(a.y)) .. ", 0), \"\", true},")

			end

		end

	end
	concommand.Add("rp_dev_getstovepossafe", ccGetStovePosS)

	function ccGetVendingMachinePos(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local ent = ply:GetEyeTrace().Entity

		if ent and ent:IsValid() then

			local p = ent:GetPos()
			local a = ent:GetAngles()
			MsgN("{Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. "), Angle(0, " .. tostring(math.ceil(a.y)) .. ", 0)},")

		end

	end
	concommand.Add("rp_dev_getvendingmachinepos", ccGetVendingMachinePos)

	function ccGetCACamPos(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local p = ply:EyePos()
		MsgN("return Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. ")")

	end
	concommand.Add("rp_dev_getcacampos", ccGetCACamPos)

	function ccGetCombineSpawnpoint(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local p = ply:GetPos()
		MsgN("Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. "),")

		local spawn = ClientsideModel("models/player/police.mdl", RENDERGROUP_BOTH)
		spawn:SetPos(Vector(math.ceil(p.x), math.ceil(p.y), math.ceil(p.z)))
		spawn:SetRenderMode(RENDERMODE_GLOW)
		spawn:SetRenderFX(16)

	end
	concommand.Add("rp_dev_getcombinespawnpoint", ccGetCombineSpawnpoint)

	function ccGetMicrophone(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local p = ply:GetPos()
		MsgN("{Vector(" .. tostring(math.ceil(p.x)) .. ", " .. tostring(math.ceil(p.y)) .. ", " .. tostring(math.ceil(p.z)) .. "), MICROPHONE_BIG},")

	end
	concommand.Add("rp_dev_getmicrophone", ccGetMicrophone)

	function ccGetModel(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local ent = ply:GetEyeTrace().Entity

		if ent and ent:IsValid() then

			MsgN(ent:GetModel())
			SetClipboardText(ent:GetModel())

		end

	end
	concommand.Add("rp_dev_model", ccGetModel)

	function ccGetModelSequenceInfo(ply, cmd, args)

		if not ply:IsAdmin() then return end

		local list = ply:GetSequenceList()

		local namelist = {}

		for k, v in pairs(list) do

			MsgN(tostring(ply:LookupSequence(v)) .. "\t" .. tostring(v) .. "\t" .. tostring(ply:GetSequenceActivityName(ply:LookupSequence(v))) .. "\t" .. tostring(ply:GetSequenceActivity(ply:LookupSequence(v))))

		end

		MsgN()

		local ppnum = ply:GetNumPoseParameters()

		MsgN(tostring(ply:GetNumPoseParameters()) .. " POSE PARAMETERS")

		for i = 0, ppnum - 1 do

			local a, b = ply:GetPoseParameterRange(i)
			MsgN(tostring(i) .. "\t" .. ply:GetPoseParameterName(i) .. "\t" .. tostring(a) .. "\t" .. tostring(b))

		end

	end
	concommand.Add("rp_dev_getseqinfo", ccGetModelSequenceInfo)

	function ccGetCamInfo(ply, cmd, args)
		if not ply:IsAdmin() then return end

		local ent = ply:GetEyeTrace().Entity

		if IsValid(ent) and ent:GetClass() == "npc_combine_camera" then
			local str = "{Vector(%g, %g, %g), Angle(%g, %g, %g), \"id\"},"
			local pos, ang = ent:GetPos(), ent:GetAngles()

			str = string.format(str, pos.x, pos.y, pos.z, ang.p, ang.y, ang.z)

			print(str)
			SetClipboardText(str)
		end
	end
	concommand.Add("rp_dev_getcombinecamera", ccGetCamInfo)

	function ccUptime(ply, cmd, args)
		print("Server uptime: " .. string.NiceTime(CurTime()))
	end
	concommand.Add("rp_uptime", ccUptime)
end