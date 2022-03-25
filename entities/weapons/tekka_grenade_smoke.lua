AddCSLuaFile()

SWEP.Base 				= "tekka_base_throwing"

SWEP.PrintName 			= "Smoke grenade"
SWEP.Category 			= "Tekka"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/c_grenade.mdl")
SWEP.WorldModel 		= Model("models/weapons/w_eq_flashbang.mdl")

SWEP.AmmoItem 			= "weapon_grenade_smoke"
SWEP.ThrowEntity 		= "cc_grenade_smoke"
SWEP.ThrowSound 		= "WeaponFrag.Throw"
SWEP.SmokeColor			= Vector(135, 135, 135)

SWEP.HoldType 			= "grenade"
SWEP.HoldTypeLowered 	= "normal"

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

function SWEP:CreateEntity()
	local ent = ents.Create(self.ThrowEntity)

	ent:SetPos(self.Owner:GetPos())
	ent:SetAngles(self.Owner:EyeAngles())
	ent:SetOwner(self.Owner)
	ent:Spawn()
	ent:Activate()

	ent.SmokeColor = self.SmokeColor
	ent:SetTimer(3)

	return ent
end
