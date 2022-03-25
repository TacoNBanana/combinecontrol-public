AddCSLuaFile()

ENT.Base 				= "cc_base_ent"

ENT.RenderGroup 		= RENDERGROUP_OPAQUE

ENT.C4					= true

ENT.Model 				= Model("models/weapons/w_c4_planted.mdl")

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Timer")

	self:NetworkVar("Float", 0, "NextBeep")
	self:NetworkVar("Float", 1, "ExplodeTimer")

	self:NetworkVar("Bool", 0, "IsArmed")
	self:NetworkVar("Bool", 1, "IsAdminSpawned")

	self:NetworkVar("Entity", 0, "Instigator")
end

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)

		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	end

	function ENT:Use(ply)
		if self:GetIsArmed() then
			return
		end

		net.Start("nOpenC4Menu")
			net.WriteEntity(self)
		net.Send(ply)
	end

	function ENT:Think()
		self:NextThink(CurTime())

		if not self:GetIsArmed() then
			return true
		end

		if self:GetExplodeTimer() <= CurTime() then
			local pos = self:GetPos()

			GAMEMODE:SoundRange(pos, 5000, "gbombs_5/explosions/light_bomb/mine_explosion.mp3")

			local ent = ents.Create("cc_shockwave")

			ent:SetPos(self:GetPos())
			ent:SetAngles(angle_zero)
			ent:SetOwner(self:GetInstigator())

			ent.MaxRange = 350
			ent.Damage = 500
			ent.Force = 155

			ent:Spawn()
			ent:Activate()

			ParticleEffect("high_explosive_main", pos, angle_zero)

			SafeRemoveEntity(self)

			return true
		end

		if self:GetNextBeep() <= CurTime() then
			self:EmitSound("weapons/c4/c4_click.wav")

			local nextBeep = math.RemapC(self:GetExplodeTimer() - CurTime(), 1, 5, 0.1, 1)

			self:SetNextBeep(CurTime() + nextBeep)
		end
	end

	util.AddNetworkString("nOpenC4Menu")
	util.AddNetworkString("nCloseC4Menu")
	util.AddNetworkString("nClickC4Menu")
	util.AddNetworkString("nSetC4Menu")
	util.AddNetworkString("nArmC4Menu")
	util.AddNetworkString("nPickupC4Menu")

	local check = function(ent, ply)
		if not IsValid(ent) or ent:GetClass() != "cc_c4" then
			return false
		end

		if ply:GetEyeTrace().Entity != ent then
			return false
		end

		if ent:GetIsArmed() then
			return false
		end

		return true
	end

	net.Receive("nClickC4Menu", function(_, ply)
		local ent = net.ReadEntity()

		if not check(ent, ply) then
			return
		end

		ent:EmitSound("weapons/c4/key_press" .. math.random(1, 7) .. ".wav")
	end)

	net.Receive("nSetC4Menu", function(_, ply)
		local ent = net.ReadEntity()

		if not check(ent, ply) then
			return
		end

		ent:SetTimer(math.Clamp(net.ReadUInt(12), 0, 3599))
		ent:EmitSound("weapons/c4/c4_beep2.wav")
	end)

	net.Receive("nArmC4Menu", function(_, ply)
		local ent = net.ReadEntity()

		if not check(ent, ply) then
			return
		end

		ent:SetInstigator(ply)
		ent:SetIsArmed(true)
		ent:SetExplodeTimer(CurTime() + ent:GetTimer())
		ent:SetNextBeep(CurTime() + 1)

		net.Start("nCloseC4Menu")
			net.WriteEntity(ent)
		net.Broadcast()
	end)

	net.Receive("nPickupC4Menu", function(_, ply)
		local ent = net.ReadEntity()

		if not check(ent, ply) then
			return
		end

		ply:EmitSound("weapons/c4/c4_draw.wav")

		if not ent:GetIsAdminSpawned() then
			ply:GiveItem("c4", 1)
		end

		SafeRemoveEntity(ent)
	end)
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()

		cam.Start3D2D(self:LocalToWorld(Vector(4.6, -1.55, 9)), self:LocalToWorldAngles(Angle(-180, 90, 180)), 0.06)
			local time = self:GetIsArmed() and math.ceil(self:GetExplodeTimer() - CurTime()) or self:GetTimer()

			if self:GetIsArmed() and GAMEMODE:AprilFools() then
				time = self:GetTimer() + math.abs(math.ceil(self:GetExplodeTimer() - CurTime()) - self:GetTimer())
			end

			draw.DrawText(os.date("%M:%S", time), "CombineControl.LabelStupid", 0, 0, Color(151, 12, 12))
		cam.End3D2D()
	end

	net.Receive("nCloseC4Menu", function()
		local ent = net.ReadEntity()

		if not IsValid(ent) or not IsValid(CCP.C4) then
			return
		end

		if CCP.C4.Entity == ent then
			CCP.C4:Close()
		end
	end)

	net.Receive("nOpenC4Menu", function()
		local ent = net.ReadEntity()

		CCP.C4 = vgui.Create("DFrame")
		CCP.C4:SetSize(200, 139)
		CCP.C4:Center()
		CCP.C4:SetTitle("C4")
		CCP.C4.lblTitle:SetFont("CombineControl.Window")
		CCP.C4:MakePopup()
		CCP.C4.PerformLayout = CCFramePerformLayout
		CCP.C4:PerformLayout()

		CCP.C4.Entity = ent
		CCP.C4.Timer = 0

		CCP.C4.Think = function(pnl)
			UIAutoClose(pnl)

			if not IsValid(pnl.Entity) then
				pnl:Close()
			end
		end

		function CCP.C4:UpdateTimer(time)
			CCP.C4.Timer = math.Clamp(time, 0, 3599)
			CCP.C4.Display:SetValue(os.date("%M:%S", CCP.C4.Timer))
		end

		CCP.C4.Display = vgui.Create("DTextEntry", CCP.C4)
		CCP.C4.Display:SetFont("CombineControl.HUDAmmo")
		CCP.C4.Display:SetPos(5, 53)
		CCP.C4.Display:SetSize(110, 55)
		CCP.C4.Display:PerformLayout()
		CCP.C4.Display:SetTextColor(Color(151, 12, 12))
		CCP.C4.Display:SetDisabled(true)

		CCP.C4:UpdateTimer(ent:GetTimer())

		CCP.C4.Min10Plus = vgui.Create("DButton", CCP.C4)
		CCP.C4.Min10Plus:SetFont("CombineControl.LabelBig")
		CCP.C4.Min10Plus:SetPos(10, 30)
		CCP.C4.Min10Plus:SetSize(19, 19)
		CCP.C4.Min10Plus:SetText("+")

		function CCP.C4.Min10Plus:DoClick()
			CCP.C4:UpdateTimer(CCP.C4.Timer + 600)
			CCP.C4.ArmButton:SetDisabled(true)
			CCP.C4.ArmButton:SetTextColor(nil)

			net.Start("nClickC4Menu")
				net.WriteEntity(CCP.C4.Entity)
			net.SendToServer()
		end

		CCP.C4.Min10Minus = vgui.Create("DButton", CCP.C4)
		CCP.C4.Min10Minus:SetFont("CombineControl.LabelBig")
		CCP.C4.Min10Minus:SetPos(10, 113)
		CCP.C4.Min10Minus:SetSize(19, 19)
		CCP.C4.Min10Minus:SetText("-")

		function CCP.C4.Min10Minus:DoClick()
			CCP.C4:UpdateTimer(CCP.C4.Timer - 600)
			CCP.C4.ArmButton:SetDisabled(true)
			CCP.C4.ArmButton:SetTextColor(nil)

			net.Start("nClickC4Menu")
				net.WriteEntity(CCP.C4.Entity)
			net.SendToServer()
		end

		CCP.C4.Min1Plus = vgui.Create("DButton", CCP.C4)
		CCP.C4.Min1Plus:SetFont("CombineControl.LabelBig")
		CCP.C4.Min1Plus:SetPos(32, 30)
		CCP.C4.Min1Plus:SetSize(19, 19)
		CCP.C4.Min1Plus:SetText("+")

		function CCP.C4.Min1Plus:DoClick()
			CCP.C4:UpdateTimer(CCP.C4.Timer + 60)
			CCP.C4.ArmButton:SetDisabled(true)
			CCP.C4.ArmButton:SetTextColor(nil)

			net.Start("nClickC4Menu")
				net.WriteEntity(CCP.C4.Entity)
			net.SendToServer()
		end

		CCP.C4.Min1Minus = vgui.Create("DButton", CCP.C4)
		CCP.C4.Min1Minus:SetFont("CombineControl.LabelBig")
		CCP.C4.Min1Minus:SetPos(32, 113)
		CCP.C4.Min1Minus:SetSize(19, 19)
		CCP.C4.Min1Minus:SetText("-")

		function CCP.C4.Min1Minus:DoClick()
			CCP.C4:UpdateTimer(CCP.C4.Timer - 60)
			CCP.C4.ArmButton:SetDisabled(true)
			CCP.C4.ArmButton:SetTextColor(nil)

			net.Start("nClickC4Menu")
				net.WriteEntity(CCP.C4.Entity)
			net.SendToServer()
		end

		CCP.C4.Sec10Plus = vgui.Create("DButton", CCP.C4)
		CCP.C4.Sec10Plus:SetFont("CombineControl.LabelBig")
		CCP.C4.Sec10Plus:SetPos(69, 30)
		CCP.C4.Sec10Plus:SetSize(19, 19)
		CCP.C4.Sec10Plus:SetText("+")

		function CCP.C4.Sec10Plus:DoClick()
			CCP.C4:UpdateTimer(CCP.C4.Timer + 10)
			CCP.C4.ArmButton:SetDisabled(true)
			CCP.C4.ArmButton:SetTextColor(nil)

			net.Start("nClickC4Menu")
				net.WriteEntity(CCP.C4.Entity)
			net.SendToServer()
		end

		CCP.C4.Sec10Minus = vgui.Create("DButton", CCP.C4)
		CCP.C4.Sec10Minus:SetFont("CombineControl.LabelBig")
		CCP.C4.Sec10Minus:SetPos(69, 113)
		CCP.C4.Sec10Minus:SetSize(19, 19)
		CCP.C4.Sec10Minus:SetText("-")

		function CCP.C4.Sec10Minus:DoClick()
			CCP.C4:UpdateTimer(CCP.C4.Timer - 10)
			CCP.C4.ArmButton:SetDisabled(true)
			CCP.C4.ArmButton:SetTextColor(nil)

			net.Start("nClickC4Menu")
				net.WriteEntity(CCP.C4.Entity)
			net.SendToServer()
		end

		CCP.C4.Sec1Plus = vgui.Create("DButton", CCP.C4)
		CCP.C4.Sec1Plus:SetFont("CombineControl.LabelBig")
		CCP.C4.Sec1Plus:SetPos(91, 30)
		CCP.C4.Sec1Plus:SetSize(19, 19)
		CCP.C4.Sec1Plus:SetText("+")

		function CCP.C4.Sec1Plus:DoClick()
			CCP.C4:UpdateTimer(CCP.C4.Timer + 1)
			CCP.C4.ArmButton:SetDisabled(true)
			CCP.C4.ArmButton:SetTextColor(nil)

			net.Start("nClickC4Menu")
				net.WriteEntity(CCP.C4.Entity)
			net.SendToServer()
		end

		CCP.C4.Sec1Minus = vgui.Create("DButton", CCP.C4)
		CCP.C4.Sec1Minus:SetFont("CombineControl.LabelBig")
		CCP.C4.Sec1Minus:SetPos(91, 113)
		CCP.C4.Sec1Minus:SetSize(19, 19)
		CCP.C4.Sec1Minus:SetText("-")

		function CCP.C4.Sec1Minus:DoClick()
			CCP.C4:UpdateTimer(CCP.C4.Timer - 1)
			CCP.C4.ArmButton:SetDisabled(true)
			CCP.C4.ArmButton:SetTextColor(nil)

			net.Start("nClickC4Menu")
				net.WriteEntity(CCP.C4.Entity)
			net.SendToServer()
		end

		CCP.C4.SetButton = vgui.Create("DButton", CCP.C4)
		CCP.C4.SetButton:SetFont("CombineControl.LabelMedium")
		CCP.C4.SetButton:SetPos(120, 30)
		CCP.C4.SetButton:SetSize(74, 30)
		CCP.C4.SetButton:SetText("Set")

		function CCP.C4.SetButton:DoClick()
			net.Start("nSetC4Menu")
				net.WriteEntity(CCP.C4.Entity)
				net.WriteUInt(CCP.C4.Timer, 12)
			net.SendToServer()

			CCP.C4.ArmButton:SetDisabled(false)

			if CCP.C4.Timer == 0 then
				CCP.C4.ArmButton:SetTextColor(Color(255, 0, 0))
			else
				CCP.C4.ArmButton:SetTextColor(nil)
			end
		end

		CCP.C4.ArmButton = vgui.Create("DButton", CCP.C4)
		CCP.C4.ArmButton:SetFont("CombineControl.LabelMedium")
		CCP.C4.ArmButton:SetPos(120, 66)
		CCP.C4.ArmButton:SetSize(74, 30)
		CCP.C4.ArmButton:SetText("Arm")
		CCP.C4.ArmButton:SetDisabled(ent:GetTimer() == 0)

		function CCP.C4.ArmButton:DoClick()
			net.Start("nArmC4Menu")
				net.WriteEntity(CCP.C4.Entity)
			net.SendToServer()
		end

		CCP.C4.PickupButton = vgui.Create("DButton", CCP.C4)
		CCP.C4.PickupButton:SetFont("CombineControl.LabelMedium")
		CCP.C4.PickupButton:SetPos(120, 102)
		CCP.C4.PickupButton:SetSize(74, 30)
		CCP.C4.PickupButton:SetText(ent:GetIsAdminSpawned() and "Remove" or "Pick up")
		CCP.C4.PickupButton:SetDisabled(false)

		function CCP.C4.PickupButton:DoClick()
			net.Start("nPickupC4Menu")
				net.WriteEntity(CCP.C4.Entity)
			net.SendToServer()
		end
	end)
end
