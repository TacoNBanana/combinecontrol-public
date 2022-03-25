AddCSLuaFile()

SWEP.PrintName 				= "Base"
SWEP.Author 				= "TankNut"

SWEP.RenderGroup 			= RENDERGROUP_BOTH

SWEP.DrawCrosshair 			= false

SWEP.PrintName 				= "C4"
SWEP.Category 				= "TRP - Misc"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.Slot 					= 2

SWEP.ViewModel 				= Model("models/weapons/c_slam.mdl")
SWEP.WorldModel 			= Model("models/weapons/w_c4.mdl")

SWEP.UseHands 				= true

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

function SWEP:Initialize()
	self:SetHoldType("revolver")
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_SLAM_TRIPMINE_DRAW)

	local time = CurTime() + self:SequenceDuration()

	self:SetNextPrimaryFire(time)
	self:SetNextSecondaryFire(time)
end

function SWEP:Holster(new)
	if CLIENT then
		SafeRemoveEntity(self.BombModel)
	end

	return true
end

function SWEP:OnRemove()
	if CLIENT then
		SafeRemoveEntity(self.BombModel)
	end
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()

	if SERVER then
		local tr = util.TraceLine({
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 75,
			filter = {ply},
			mask = MASK_SOLID
		})

		if not tr.Hit then
			return
		end

		local ang = tr.HitNormal:Angle()

		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(tr.HitNormal, 180)

		local dot = tr.HitNormal:Dot(Vector(0, 0, 1))

		if dot == 1 or dot == -1 then
			ang.y = ply:EyeAngles().y
		end

		local ent = ents.Create("cc_c4")

		ent:SetPos(tr.HitPos)
		ent:SetAngles(ang)
		ent:Spawn()
		ent:Activate()

		ply:EmitSound("weapons/c4/c4_plant_quiet.wav")

		if self.Item then
			GAMEMODE:DeleteItem(self.Item)

			return
		end

		ent:SetIsAdminSpawned(true)

		self:GetOwner():StripWeapon(self:GetClass())
	end
end

function SWEP:SecondaryAttack()
end

local holdtype = {
	[ACT_MP_STAND_IDLE]					= ACT_HL2MP_IDLE,
	[ACT_MP_WALK]						= ACT_HL2MP_WALK,
	[ACT_MP_RUN]						= ACT_HL2MP_RUN_SLAM,
	[ACT_MP_CROUCH_IDLE]				= ACT_HL2MP_IDLE_CROUCH_PISTOL,
	[ACT_MP_CROUCHWALK]					= ACT_HL2MP_WALK_CROUCH_PISTOL,
	[ACT_MP_ATTACK_STAND_PRIMARYFIRE]	= ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM,
	[ACT_MP_ATTACK_CROUCH_PRIMARYFIRE]	= ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM,
	[ACT_MP_JUMP]						= ACT_HL2MP_JUMP_SLAM,
	[ACT_RANGE_ATTACK1]					= ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM,
	[ACT_MP_SWIM]						= ACT_HL2MP_SWIM_SLAM
}


function SWEP:TranslateActivity(act)
	return holdtype[act] or -1
end

if CLIENT then
	function SWEP:CreateBombModel()
		self.BombModel = ClientsideModel("models/weapons/w_c4_planted.mdl", RENDERGROUP_OTHER)
		self.BombModel:SetNoDraw(true)
	end

	function SWEP:PreDrawViewModel(vm, weapon, ply)
		local hands = ply:GetHands()

		hands:DrawModel()

		if not IsValid(self.BombModel) then
			self:CreateBombModel()
		end

		local bonePos, boneAng = hands:GetBonePosition(23)
		local pos, ang = LocalToWorld(Vector(7.987732, -2.476807, 0.155540), Angle(81.978, -149.326, -15.795), bonePos, boneAng)

		self.BombModel:SetParent(vm)
		self.BombModel:SetModelScale(0.45, 0)
		self.BombModel:SetPos(pos)
		self.BombModel:SetAngles(ang)

		self.BombModel:SetupBones()
		self.BombModel:DrawModel()

		return true
	end
end
