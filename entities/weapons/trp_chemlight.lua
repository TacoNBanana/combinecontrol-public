AddCSLuaFile()
DEFINE_BASECLASS("tekka_base_throwing")

SWEP.m_WeaponDeploySpeed = 12

SWEP.Base 				= "tekka_base_throwing"
SWEP.RenderGroup 		= RENDERGROUP_OPAQUE

SWEP.PrintName 			= "Chemlight"
SWEP.Category 			= "TRP - Misc"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/c_glowstick.mdl")
SWEP.WorldModel 		= Model("models/glowstick/stick.mdl")

SWEP.AmmoItem 			= ""

SWEP.ThrowEntity 		= "cc_chemlight"
SWEP.ThrowSound 		= "WeaponFrag.Throw"

SWEP.Animations = {
	draw = "anim_draw"
}

SWEP.Colors = {
	Color(0, 255, 63):ToVector(), -- Green
	Color(0, 161, 255):ToVector(), -- Blue
	Color(255, 0, 0):ToVector(), -- Red
	Color(255, 93, 0):ToVector(), -- Orange
	Color(255, 191, 0):ToVector(), -- Yellow
	Color(220, 0, 255):ToVector(), -- Purple
	Color(255, 255, 255):ToVector() -- White
}

function SWEP:Initialize()
	BaseClass.Initialize(self)

	self:SetVecColor(self.Colors[1])
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Int", 0, "ItemID")

	self:NetworkVar("Vector", 0, "VecColor")

	self:NetworkVar("Bool", 1, "Reloaded")
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	self:PlayAnimation("idle")

	local ply = self:GetOwner()

	if IsValid(ply) and ply:GetActiveWeapon() == self then
		self:EmitSound("weapons/glowstick_snap.wav")
	end
end

function SWEP:GetItem()
	local id = self:GetItemID()

	if id == 0 then
		return
	end

	return GAMEMODE:GetItem(id)
end

function SWEP:Think()
	BaseClass.Think(self)

	local ply = self:GetOwner()

	self:SetColor(self:GetVecColor():ToColor())

	if IsValid(ply) and not ply:KeyDown(IN_RELOAD) then
		self:SetReloaded(false)
	end
end

function SWEP:Reload()
	if self:GetReloaded() or self:GetItem() then
		return
	end

	local index = table.KeyFromValue(self.Colors, self:GetVecColor()) + 1

	if index > #self.Colors then
		index = 1
	end

	self:SetVecColor(self.Colors[index])

	self:SetReloaded(true)
end

if CLIENT then
	function SWEP:DrawLight(pos)
		local dlight = DynamicLight(self:EntIndex())

		if dlight then
			local col = self:GetColor()
			local size = 256

			dlight.Pos = pos
			dlight.r = col.r
			dlight.g = col.g
			dlight.b = col.b
			dlight.Brightness = 0
			dlight.Decay = size * 5
			dlight.Size = size
			dlight.DieTime = CurTime() + 1
		end
	end

	local mat = Material("models/glowstick/glow")

	function SWEP:DrawVM()
		mat:SetVector("$color2", self:GetVecColor())

		BaseClass.DrawVM(self)

		mat:SetVector("$color2", Vector(1, 1, 1))
	end
else
	function SWEP:LoadFromItem(item)
		self:SetItemID(item.ID)

		local col = item:GetProperty("Color")

		self:SetVecColor(Vector(col.r / 255, col.g / 255, col.b / 255))
	end
end

function SWEP:CreateEntity()
	local ent = BaseClass.CreateEntity(self)

	ent:SetOwner(NULL)

	ent:SetVecColor(self:GetVecColor())
	ent:SetDieTime(CurTime() + 3600)

	return ent
end

if CLIENT then
	hook.Add("Think", "chemlight", function()
		for _, ply in pairs(player.GetAll()) do
			if ply:IsDormant() then
				continue
			end

			local weapon = ply:GetActiveWeapon()

			if not IsValid(weapon) or weapon:GetClass() != "trp_chemlight" then
				continue
			end

			local dlight = DynamicLight(weapon:EntIndex())

			if dlight then
				local pos = weapon:WorldSpaceCenter()

				if ply == LocalPlayer() and not LocalPlayer():ShouldDrawLocalPlayer() then
					pos = LocalPlayer():EyePos()
				elseif IsValid(ply) then
					ply:SetupBones()

					local attachment = ply:LookupAttachment("anim_attachment_RH")

					if attachment then
						pos = ply:GetAttachment(attachment).Pos
					end
				end

				local col = weapon:GetColor()
				local size = 256

				dlight.Pos = pos
				dlight.r = col.r
				dlight.g = col.g
				dlight.b = col.b
				dlight.Brightness = 0
				dlight.Decay = size * 5
				dlight.Size = size
				dlight.DieTime = CurTime() + 1
			end
		end
	end)
end
