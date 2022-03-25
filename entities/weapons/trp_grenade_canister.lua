AddCSLuaFile()
DEFINE_BASECLASS("tekka_base_throwing")

SWEP.Base 				= "tekka_base_throwing"
SWEP.RenderGroup 		= RENDERGROUP_OPAQUE

SWEP.PrintName 			= "Canister Bomb"
SWEP.Category 			= "TRP - Grenades"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/c_grenade.mdl")
SWEP.WorldModel 		= Model("models/halo_package.mdl")

SWEP.AmmoItem 			= "grenade_canister"

SWEP.ThrowEntity 		= "cc_grenade_canister"
SWEP.ThrowSound 		= "WeaponFrag.Throw"

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "ThrowMode")
	self:NetworkVar("Int", 1, "Timer")

	self:NetworkVar("Float", 0, "FinishReload")
	self:NetworkVar("Float", 1, "NextModeSwitch")
	self:NetworkVar("Float", 2, "FinishThrow")

	self:NetworkVar("Bool", 0, "Holstered")

	self:SetTimer(3)
end

function SWEP:CreateEntity()
	local ent = BaseClass.CreateEntity(self)

	ent:SetTimer(self:GetTimer())

	return ent
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

if CLIENT then
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

				local fixPos = Vector(3.3, 2, 0)
				local fixAng = Angle(0, 0, 0)

				pos = pos + (ang:Forward() * fixPos.x) + (ang:Right() * fixPos.y) + (ang:Up() * fixPos.z)

				ang:RotateAroundAxis(ang:Up(), fixAng.p)
				ang:RotateAroundAxis(ang:Right(), fixAng.y)
				ang:RotateAroundAxis(ang:Forward(), fixAng.r)

				self:SetRenderOrigin(pos)
				self:SetRenderAngles(ang)

				self:SetModelScale(1, 0)
			end
		else
			self:SetRenderOrigin(self:GetPos())
			self:SetRenderAngles(self:GetAngles())
		end

		self:DrawModel()
	end

	function SWEP:CreateBombModel()
		self.BombModel = ClientsideModel("models/halo_package.mdl", RENDERGROUP_OTHER)
		self.BombModel:SetNoDraw(true)
	end

	function SWEP:DrawVM()
		if self.ViewModelFlip then
			render.CullMode(MATERIAL_CULLMODE_CW)
		end

		self.VM:FrameAdvance(FrameTime())
		self.VM:SetupBones()

		-- Drawing hands
		if self.UseHands then
			local ply = self:GetOwner()
			local hands = ply:GetHands()

			if IsValid(hands) then
				if hands:GetParent() != self.VM then
					hands:AttachToViewmodel(self.VM)
				end

				hands:SetupBones()
				hands:DrawModel()
			end
		end

		render.CullMode(MATERIAL_CULLMODE_CCW)
	end

	function SWEP:PostDrawViewModel(vm, weapon, ply)
		if not self.VM then
			return
		end

		self:HandleVMOffsets()
		self:ApplyVMOffsets()
		self:DrawVM()
		self:DrawVMSCK()

		local hands = ply:GetHands()

		if not IsValid(self.BombModel) then
			self:CreateBombModel()
		end

		local bonePos, boneAng = hands:GetBonePosition(23)
		local pos, ang = LocalToWorld(Vector(3.3, -2.5, 0), Angle(0, -45, 0), bonePos, boneAng)

		self.BombModel:SetParent(NULL)
		self.BombModel:SetModelScale(1, 0)
		self.BombModel:SetPos(pos)
		self.BombModel:SetAngles(ang)

		self.BombModel:SetupBones()
		self.BombModel:DrawModel()
	end
end

if CLIENT then
	hook.Add("PlayerBindPress", "trp_grenade_canister", function(ply, bind, down)
		local weapon = ply:GetActiveWeapon()

		if not down then
			return
		end

		if not IsValid(weapon) or weapon:GetClass() != "trp_grenade_canister" then
			return
		end

		if not ply:KeyDown(IN_RELOAD) or not weapon:CanFire() then
			return
		end

		if bind == "invnext" then
			net.Start("canister_next")
			net.SendToServer()

			return true
		elseif bind == "invprev" then
			net.Start("canister_prev")
			net.SendToServer()

			return true
		end
	end)

	function SWEP:GetHudText()
		return "Timer: " .. self:GetTimer()
	end
else
	util.AddNetworkString("canister_next")
	util.AddNetworkString("canister_prev")

	net.Receive("canister_next", function(_, ply)
		local weapon = ply:GetActiveWeapon()

		if not IsValid(weapon) or weapon:GetClass() != "trp_grenade_canister" then
			return
		end

		if not ply:KeyDown(IN_RELOAD) or not weapon:CanFire() then
			return
		end

		weapon:SetTimer(weapon:GetTimer() + 1)

		if weapon:GetTimer() % 5 == 0 then
			weapon:EmitSound(math.random() > 0.5 and "ambient/office/tech_oneshot_06.wav" or "ambient/office/tech_oneshot_08.wav")
		end
	end)

	net.Receive("canister_prev", function(_, ply)
		local weapon = ply:GetActiveWeapon()

		if not IsValid(weapon) or weapon:GetClass() != "trp_grenade_canister" then
			return
		end

		if not ply:KeyDown(IN_RELOAD) or not weapon:CanFire() then
			return
		end

		weapon:SetTimer(math.max(weapon:GetTimer() - 1, 0))

		if weapon:GetTimer() != 0 and weapon:GetTimer() % 5 == 0 then
			weapon:EmitSound(math.random() > 0.5 and "ambient/office/tech_oneshot_06.wav" or "ambient/office/tech_oneshot_08.wav")
		end
	end)
end
