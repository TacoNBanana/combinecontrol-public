AddCSLuaFile()

SWEP.Base 					= "tekka_base_throwing"

SWEP.PrintName 				= "Pipebomb"

SWEP.Category 				= "Tekka"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_pipebomb.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_pipebomb.mdl")

SWEP.UseHands 				= true

SWEP.FireDelay 				= 0

SWEP.AmmoItem 				= "weapon_grenade_pipebomb"
SWEP.ThrowEntity 			= "cc_grenade_pipebomb"
SWEP.ThrowSound 			= "WeaponFrag.Throw"

SWEP.SwayIntensity 			= 1
SWEP.RunThreshold 			= 1.2

SWEP.ApproachSpeed 			= 10

SWEP.VMMovementScale 		= 0.4

SWEP.VMBodyGroups 			= {}
SWEP.WMBodyGroups 			= {}

SWEP.VMSubMaterials 		= {}
SWEP.WMSubMaterials 		= {}

if CLIENT then
	SWEP.HideWM					= false

	SWEP.VElements 	= {}
	SWEP.WElements 	= {}
	SWEP.VMBoneMods = {}
end

SWEP.Animations = {}
SWEP.SoundScripts = {}

SWEP.HoldType 			= "grenade"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

function SWEP:CreateEntity()
	local ent = self.BaseClass.CreateEntity(self)

	ent:SetTimer(3)

	return ent
end
