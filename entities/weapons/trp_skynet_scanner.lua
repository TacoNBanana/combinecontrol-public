AddCSLuaFile()

SWEP.Base 					= "weapon_cc_base"

SWEP.PrintName 				= "HK Scanner"
SWEP.Slot 					= 1
SWEP.SlotPos 				= 1

SWEP.Category 				= "TRP Skynet"
SWEP.UseHands 				= false
SWEP.ViewModel 				= "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel 			= ""

SWEP.InfoText 				= [[Primary: Increase zoom.
Secondary: Decrease zoom.
Reload: Take a picture.]]

SWEP.Cooldown 				= 3

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Ammo			= ""
SWEP.Primary.Automatic 		= true

SWEP.Secondary.ClipSize 	= 1
SWEP.Secondary.DefaultClip 	= 1
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.Automatic 	= true

SWEP.HoldType = "normal"
SWEP.HoldTypeHolster = "normal"

SWEP.Holsterable = false
SWEP.NoDrawHolstered = true

SWEP.MinZoom 				= 90
SWEP.MaxZoom 				= 5

SWEP.ShootSound = Sound("NPC_CScanner.TakePhoto")

function SWEP:PrimaryAttack()
	if CLIENT then
		if not IsFirstTimePredicted() then
			return
		end

		if self.ScannerZoom <= self.MaxZoom then
			return
		end

		self.ScannerZoom = math.max(self.ScannerZoom - (FrameTime() * 66), self.MaxZoom)
	end
end

function SWEP:SecondaryAttack()
	if CLIENT then
		if not IsFirstTimePredicted() then
			return
		end

		if self.ScannerZoom >= self.MinZoom then
			return
		end

		self.ScannerZoom = math.min(self.ScannerZoom + (FrameTime() * 66), self.MinZoom)
	end
end


function SWEP:RenderScreenspaceEffects()
	if cookie.GetNumber("cc_thirdperson", 0) == 1 and GAMEMODE:ShouldDoThirdPerson(self.Owner) then
		return
	end

	local tab = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_colour"] = 0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	DrawColorModify(tab)
end

function SWEP:HUDPaint()
	if cookie.GetNumber("cc_thirdperson", 0) == 1 and GAMEMODE:ShouldDoThirdPerson(self.Owner) then
		return
	end

	local scrW2 = surface.ScreenWidth() * 0.5
	local scrH2 = surface.ScreenHeight() * 0.5
	local scanW2 = 290
	local scanH2 = 210

	local x = scrW2 - scanW2
	local y = scrH2 - scanH2

	if self.NextPic and self.NextPic > CurTime() then
		local percent = math.abs(math.Round(math.TimeFraction(self.NextPic - self.Cooldown, self.NextPic, CurTime()), 2) * 100)

		draw.SimpleText("RECHARGING: " .. percent .. "%", "CombineControl.CombineScanner", x, y - 24, Color(255, 255, 255))
	end

	local pos = LocalPlayer():GetPos()
	local ang = LocalPlayer():GetAimVector():Angle()

	draw.SimpleText("POS (" .. math.floor(pos.x) .. ", " .. math.floor(pos.y) .. ", " .. math.floor(pos.z) .. ")", "CombineControl.CombineScanner", x + 8, y + 8, Color(255, 255, 255))
	draw.SimpleText("ANG (" .. math.floor(ang.x) .. ", " .. math.floor(ang.y) .. ")", "CombineControl.CombineScanner", x + 8, y + 26, Color(255, 255, 255))
	draw.SimpleText("ID " .. LocalPlayer():FormattedCID(), "CombineControl.CombineScanner", x + 8, y + 44, Color(255, 255, 255))
	draw.SimpleText("VIT " .. LocalPlayer():Health() .. "-" .. LocalPlayer():Armor(), "CombineControl.CombineScanner", x + 8, y + 62, Color(255, 255, 255))
	draw.SimpleText("ZOOM " .. math.floor(math.Remap(self.ScannerZoom, self.MaxZoom, self.MinZoom, 100, 0)) .. "%", "CombineControl.CombineScanner", x + 8, y + 80, Color(255, 255, 255))

	local viewEnt = LocalPlayer():GetEyeTrace().Entity
	local name = "NULL"

	if IsValid(viewEnt) then
		if viewEnt:IsPlayer() then
			name = viewEnt:VisibleRPName()
		elseif IsValid(viewEnt:PropFakePlayer()) then
			name = viewEnt:PropFakePlayer():VisibleRPName()
		end
	end

	draw.SimpleText("TRG (" .. name .. ")", "CombineControl.CombineScanner", x + 8, y + 98, Color(255, 255, 255))

	surface.SetDrawColor(235, 235, 235, 230)

	surface.DrawLine(0, scrH2, x - 128, scrH2)
	surface.DrawLine(scrW2 + scanW2 + 128, scrH2, ScrW(), scrH2)
	surface.DrawLine(scrW2, 0, scrW2, y - 128)
	surface.DrawLine(scrW2, scrH2 + scanH2 + 128, scrW2, ScrH())

	surface.DrawLine(x, y, x + 128, y)
	surface.DrawLine(x, y, x, y + 128)

	x = scrW2 + scanW2

	surface.DrawLine(x, y, x - 128, y)
	surface.DrawLine(x, y, x, y + 128)

	x = scrW2 - scanW2
	y = scrH2 + scanH2

	surface.DrawLine(x, y, x + 128, y)
	surface.DrawLine(x, y, x, y - 128)

	x = scrW2 + scanW2

	surface.DrawLine(x, y, x - 128, y)
	surface.DrawLine(x, y, x, y - 128)

	surface.DrawLine(scrW2 - 48, scrH2, scrW2 - 8, scrH2)
	surface.DrawLine(scrW2 + 48, scrH2, scrW2 + 8, scrH2)
	surface.DrawLine(scrW2, scrH2 - 48, scrW2, scrH2 - 8)
	surface.DrawLine(scrW2, scrH2 + 48, scrW2, scrH2 + 8)
end

function SWEP:TranslateFOV(fov)
	if cookie.GetNumber("cc_thirdperson", 0) == 1 and GAMEMODE:ShouldDoThirdPerson(self.Owner) then
		return fov
	end

	self.ScannerZoom = self.ScannerZoom or self.MinZoom
	return self.ScannerZoom
end

function SWEP:AdjustMouseSensitivity()
	if cookie.GetNumber("cc_thirdperson", 0) == 1 and GAMEMODE:ShouldDoThirdPerson(self.Owner) then
		return 1
	end

	return math.Remap(self.ScannerZoom, self.MaxZoom, self.MinZoom, 0.05, 0.4)
end

function SWEP:Reload()
	if (self.NextPic or 0) >= CurTime() then
		return
	end

	self.NextPic = CurTime() + self.Cooldown
	self:EmitSound(self.ShootSound)

	if SERVER then return end

	local flash = DynamicLight(CurTime())

	if flash then
		local light = self.Owner:LookupAttachment("light")
		local attach = self.Owner:GetAttachment(light)

		flash.pos = attach.Pos + self.Owner:GetForward() * 16
		flash.r = 255
		flash.g = 255
		flash.b = 255
		flash.brightness = 0.2
		flash.Decay = 5000
		flash.Size = 3000
		flash.DieTime = CurTime() + 0.3
	end

end