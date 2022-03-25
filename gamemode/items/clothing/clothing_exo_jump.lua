ITEM = class.Create("base_clothing")

ITEM.Name 				= "Exoskeleton - 5th Gen Jump-pack"
ITEM.Description 		= "Experimental infantry suit designed to allow soldiers to rapidly redeploy to other areas."

ITEM.Model				= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd			= 300
ITEM.DamageReduction	= 15

ITEM.Weight 			= 4

ITEM.Slots 				= {EQUIPMENT_EXO}

ITEM.ModelData 			= {}
ITEM.ModelData.model 	= Model("models/tnb/techcom/exoskeleton_jumppack.mdl")

local function getJumpVelocity(startPos, endPos, minHeight, maxHorizontalVelocity) -- Thanks valve
	local gravity = -physenv.GetGravity().z
	local stepHeight = endPos.z - startPos.z

	local targetDir2D = endPos - startPos
	targetDir2D.z = 0

	local distance = endPos:Distance(startPos)

	local minHorzTime = distance / maxHorizontalVelocity
	local minHorzHeight = 0.5 * gravity * (minHorzTime * 0.5) * (minHorzTime * 0.5)

	minHeight = math.max(minHeight, minHorzHeight)
	minHeight = math.max(minHeight, stepHeight)

	local t0 = math.sqrt((2 * minHeight) / gravity)
	local t1 = math.sqrt((2 * math.abs(minHeight - stepHeight)) / gravity)

	local velHorz = distance / (t0 + t1)
	local jumpVel = targetDir2D:GetNormalized() * velHorz

	jumpVel.z = math.sqrt(2 * gravity * minHeight)

	return jumpVel
end

local snd = Sound("^thrusters/hover00.wav")

function ITEM:SetupMove(ply, mv)
	if ply:OnGround() or ply:GetMoveType() != MOVETYPE_WALK then
		if SERVER and ply:JumpPackActive() then
			ply:SetJumpPackActive(false)
			ply:StopSound(snd)
		end

		return
	end

	if ply:KeyPressed(IN_JUMP) and not ply:JumpPackActive() then
		local tr = ply:GetEyeTrace()
		local startPos = ply:GetPos()
		local endPos = tr.HitPos
		local dist = startPos:Distance(endPos)

		if dist > 1600 then
			return
		end

		local max = math.min(800, dist)
		local height = math.max(endPos.z - startPos.z, 0)

		if not ply:KeyDown(IN_DUCK) then
			height = height + 150
		end

		local vel = getJumpVelocity(startPos, endPos, height, max)

		if vel != vel then
			return
		end

		mv:SetVelocity(vel)

		if IsFirstTimePredicted() then
			local ed = EffectData()

			ed:SetEntity(ply)
			ed:SetOrigin(ply:EyePos())

			util.Effect("cc_e_jumppack", ed, true, true)
		end

		if SERVER then
			ply:SetJumpPackActive(true)
			ply:EmitSound(snd)
		end
	end
end

ITEM.NoFallDamage 	= true