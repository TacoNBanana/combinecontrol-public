AddCSLuaFile()

local whitelisted = table.MakeAssociative({
	ACT_VM_FIRE_LAST, ACT_VM_DRYFIRE
})

local empty = {
	[ACT_VM_DRAW] = ACT_VM_DRAW_EMPTY,
	[ACT_VM_IDLE] = ACT_VM_IDLE_EMPTY,
	[ACT_VM_RELOAD] = ACT_VM_RELOAD_EMPTY,
	[ACT_VM_PRIMARYATTACK]  = ACT_VM_PRIMARYATTACK_EMPTY
}

function SWEP:DoWeaponAnim(act)
	if whitelisted[act] and not self.AnimWhitelist[act] then
		return 0
	end

	if self.AnimEmptySupport[act] and empty[act] and self:Clip1() == 0 then
		act = empty[act]
	end

	if self.AnimReplacements[act] then
		act = self.AnimReplacements[act]
	end

	if isstring(act) then
		local vm = self:GetOwner():GetViewModel()

		vm:SendViewModelMatchingSequence(vm:LookupSequence(act))

		return vm:SequenceDuration()
	else
		self:SendWeaponAnim(act)

		local duration = self:SequenceDuration()

		return duration
	end
end

local baseHoldTypes = {
	["pistol"]		= ACT_HL2MP_IDLE_PISTOL,
	["smg"]			= ACT_HL2MP_IDLE_SMG1,
	["grenade"]		= ACT_HL2MP_IDLE_GRENADE,
	["ar2"]			= ACT_HL2MP_IDLE_AR2,
	["shotgun"]		= ACT_HL2MP_IDLE_SHOTGUN,
	["rpg"]			= ACT_HL2MP_IDLE_RPG,
	["physgun"]		= ACT_HL2MP_IDLE_PHYSGUN,
	["crossbow"]	= ACT_HL2MP_IDLE_CROSSBOW,
	["melee"]		= ACT_HL2MP_IDLE_MELEE,
	["slam"]		= ACT_HL2MP_IDLE_SLAM,
	["normal"]		= ACT_HL2MP_IDLE,
	["fist"]		= ACT_HL2MP_IDLE_FIST,
	["melee2"]		= ACT_HL2MP_IDLE_MELEE2,
	["passive"]		= ACT_HL2MP_IDLE_PASSIVE,
	["knife"]		= ACT_HL2MP_IDLE_KNIFE,
	["duel"]		= ACT_HL2MP_IDLE_DUEL,
	["camera"]		= ACT_HL2MP_IDLE_CAMERA,
	["magic"]		= ACT_HL2MP_IDLE_MAGIC,
	["revolver"]	= ACT_HL2MP_IDLE_REVOLVER
}

local holdTypes = {}

for k, v in pairs(baseHoldTypes) do
	holdTypes[k] = {
		[ACT_MP_STAND_IDLE]					= v,
		[ACT_MP_WALK]						= v + 1,
		[ACT_MP_RUN]						= v + 2,
		[ACT_MP_CROUCH_IDLE]				= v + 3,
		[ACT_MP_CROUCHWALK]					= v + 4,
		[ACT_MP_ATTACK_STAND_PRIMARYFIRE]	= v + 5,
		[ACT_MP_ATTACK_CROUCH_PRIMARYFIRE]	= v + 5,
		[ACT_MP_RELOAD_STAND]				= v + 6,
		[ACT_MP_RELOAD_CROUCH]				= v + 6,
		[ACT_MP_JUMP]						= v + 7,
		[ACT_RANGE_ATTACK1]					= v + 8,
		[ACT_MP_SWIM]						= v + 9
	}
end

holdTypes.normal[ACT_MP_JUMP] = ACT_HL2MP_JUMP_SLAM

holdTypes.passive[ACT_MP_CROUCH_IDLE] = ACT_HL2MP_IDLE_CROUCH
holdTypes.passive[ACT_MP_CROUCHWALK] = ACT_HL2MP_WALK_CROUCH

holdTypes.slam[ACT_MP_ATTACK_STAND_PRIMARYFIRE] = ACT_INVALID

holdTypes.revolver[ACT_MP_CROUCH_IDLE] = ACT_HL2MP_IDLE_CROUCH_PISTOL

holdTypes.pistol[ACT_MP_STAND_IDLE] = ACT_HL2MP_IDLE_REVOLVER
holdTypes.pistol[ACT_MP_WALK] = ACT_HL2MP_WALK_REVOLVER

holdTypes.rpg[ACT_MP_ATTACK_STAND_PRIMARYFIRE] = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
holdTypes.rpg[ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW

holdTypes.rpg[ACT_MP_RELOAD_STAND] = ACT_HL2MP_GESTURE_RELOAD_PISTOL
holdTypes.rpg[ACT_MP_RELOAD_CROUCH] = ACT_HL2MP_GESTURE_RELOAD_PISTOL

holdTypes.sniper = {
	[ACT_MP_STAND_IDLE]					= ACT_HL2MP_IDLE_RPG,
	[ACT_MP_WALK]						= ACT_HL2MP_WALK_RPG,
	[ACT_MP_RUN]						= ACT_HL2MP_RUN_RPG,
	[ACT_MP_CROUCH_IDLE]				= ACT_HL2MP_IDLE_CROUCH_AR2,
	[ACT_MP_CROUCHWALK]					= ACT_HL2MP_WALK_CROUCH_AR2,
	[ACT_MP_ATTACK_STAND_PRIMARYFIRE]	= ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
	[ACT_MP_ATTACK_CROUCH_PRIMARYFIRE]	= ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
	[ACT_MP_RELOAD_STAND]				= ACT_HL2MP_GESTURE_RELOAD_AR2,
	[ACT_MP_RELOAD_CROUCH]				= ACT_HL2MP_GESTURE_RELOAD_AR2,
	[ACT_MP_JUMP]						= ACT_HL2MP_JUMP_AR2,
	[ACT_RANGE_ATTACK1]					= ACT_HL2MP_SWIM_IDLE_AR2,
	[ACT_MP_SWIM]						= ACT_HL2MP_SWIM_AR2
}

holdTypes.shotgun_ar2 = {
	[ACT_MP_STAND_IDLE]					= ACT_HL2MP_IDLE_AR2,
	[ACT_MP_WALK]						= ACT_HL2MP_WALK_AR2,
	[ACT_MP_RUN]						= ACT_HL2MP_RUN_AR2,
	[ACT_MP_CROUCH_IDLE]				= ACT_HL2MP_IDLE_CROUCH_AR2,
	[ACT_MP_CROUCHWALK]					= ACT_HL2MP_WALK_CROUCH_AR2,
	[ACT_MP_ATTACK_STAND_PRIMARYFIRE]	= ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
	[ACT_MP_ATTACK_CROUCH_PRIMARYFIRE]	= ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
	[ACT_MP_RELOAD_STAND]				= ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
	[ACT_MP_RELOAD_CROUCH]				= ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
	[ACT_MP_JUMP]						= ACT_HL2MP_JUMP_AR2,
	[ACT_RANGE_ATTACK1]					= ACT_HL2MP_SWIM_IDLE_AR2,
	[ACT_MP_SWIM]						= ACT_HL2MP_SWIM_AR2
}

holdTypes.shotgun_smg = {
	[ACT_MP_STAND_IDLE]					= ACT_HL2MP_IDLE_SMG1,
	[ACT_MP_WALK]						= ACT_HL2MP_WALK_SMG1,
	[ACT_MP_RUN]						= ACT_HL2MP_RUN_SMG1,
	[ACT_MP_CROUCH_IDLE]				= ACT_HL2MP_IDLE_CROUCH_SMG1,
	[ACT_MP_CROUCHWALK]					= ACT_HL2MP_WALK_CROUCH_SMG1,
	[ACT_MP_ATTACK_STAND_PRIMARYFIRE]	= ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
	[ACT_MP_ATTACK_CROUCH_PRIMARYFIRE]	= ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
	[ACT_MP_RELOAD_STAND]				= ACT_HL2MP_GESTURE_RELOAD_SMG1,
	[ACT_MP_RELOAD_CROUCH]				= ACT_HL2MP_GESTURE_RELOAD_SMG1,
	[ACT_MP_JUMP]						= ACT_HL2MP_JUMP_SMG1,
	[ACT_RANGE_ATTACK1]					= ACT_HL2MP_SWIM_IDLE_SMG1,
	[ACT_MP_SWIM]						= ACT_HL2MP_SWIM_SMG1
}

SWEP.HoldTypes = holdTypes

function SWEP:SetWeaponHoldType(set)
	self.ActivityTranslate = holdTypes[set] or holdTypes.normal
end

function SWEP:TranslateActivity(act)
	return self.ActivityTranslate[act] or -1
end
