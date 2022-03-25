AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "Binoculars"
SWEP.Category 			= "TRP - Misc"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/c_slam.mdl")
SWEP.WorldModel 		= Model("models/saraphines/binoculars/binoculars_ru/binoculars_ru.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "camera"
SWEP.PassiveHoldType 	= "normal"

SWEP.Firemodes 			= 0

SWEP.ClipSize 			= -1

SWEP.AimTime 			= 0.6
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= true
SWEP.ZoomLevel 			= {4, 12, 2}

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -10),
		Ang = Angle(-20, 0, 0)
	},
	Holster = {
		Pos = Vector(0, 0, -15),
		Ang = Angle(-20, 0, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, -15),
		Ang = Angle(-20, 0, 0)
	},
	Aim = {
		Pos = Vector(20, 2.15, -24.2),
		Ang = Angle(-90, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_DRAW] = ACT_SLAM_THROW_ND_DRAW
}

function SWEP:Holster(new)
	local ok = BaseClass.Holster(self, new)

	if CLIENT and ok then
		SafeRemoveEntity(self.BinocsModel)
	end

	return ok
end

function SWEP:OnRemove()
	if CLIENT then
		SafeRemoveEntity(self.BinocsModel)
	end
end

function SWEP:HandleHoldType()
	local holdtype = (self:GetHolstered() or self:GetAimFraction() < 0.7 or self:GetOwner():IsSprinting()) and self.PassiveHoldType or self.ActiveHoldType

	if self:GetHoldType() != holdtype then
		self:SetHoldType(holdtype)
	end
end


function SWEP:PrimaryAttack() end
function SWEP:Reload() end

if CLIENT then
	function SWEP:DoDrawCrosshair() end

	function SWEP:CreateBinocsModel()
		self.BinocsModel = ClientsideModel("models/saraphines/binoculars/binoculars_ru/binoculars_ru.mdl", RENDERGROUP_OTHER)
		self.BinocsModel:SetNoDraw(true)
	end

	function SWEP:PreDrawViewModel(vm, weapon, ply)
		BaseClass.PreDrawViewModel(self, vm, weapon, ply)

		local hands = ply:GetHands()

		vm:ManipulateBoneAngles(33, Angle(10, -20, 20), true)
		vm:SetupBones()

		hands:DrawModel()

		if not IsValid(self.BinocsModel) then
			self:CreateBinocsModel()
		end

		local bonePos, boneAng = hands:GetBonePosition(23)
		local pos, ang = LocalToWorld(Vector(4.2, -6, -2.155540), Angle(81.978, -149.326, -15.795), bonePos, boneAng)

		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Forward(), 180)

		self.BinocsModel:SetParent(vm)
		self.BinocsModel:SetModelScale(1, 0)
		self.BinocsModel:SetPos(pos)
		self.BinocsModel:SetAngles(ang)

		self.BinocsModel:SetupBones()
		self.BinocsModel:DrawModel()

		vm:ManipulateBoneAngles(33, angle_zero, true)

		return true
	end

	function SWEP:DrawWorldModel()
		local ply = self:GetOwner()

		if IsValid(ply) then
			local hand = ply:LookupBone("ValveBiped.Bip01_R_Hand")

			if hand then
				local pos, ang

				local matrix = ply:GetBoneMatrix(hand)

				if matrix then
					pos, ang = matrix:GetTranslation(), matrix:GetAngles()
				else
					pos, ang = ply:GetBonePosition(hand)
				end

				local fixPos = Vector(5, 6, 0)
				local fixAng = Angle(-5, 15, 192)

				pos = pos + (ang:Forward() * fixPos.x) + (ang:Right() * fixPos.y) + (ang:Up() * fixPos.z)

				ang:RotateAroundAxis(ang:Up(), fixAng.p)
				ang:RotateAroundAxis(ang:Right(), fixAng.y)
				ang:RotateAroundAxis(ang:Forward(), fixAng.r)

				self:SetRenderOrigin(pos)
				self:SetRenderAngles(ang)

				self:SetModelScale(1, 0)
			end
		end
	end
end
