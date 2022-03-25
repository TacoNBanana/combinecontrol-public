local meta = FindMetaTable("Player")

GM.AnimTable = {}

GM.AnimTable["models/vortigaunt.mdl"] = {}
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_STAND_IDLE] 				= ACT_IDLE
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_WALK] 						= ACT_WALK
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_RUN] 						= ACT_RUN
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_CROUCH_IDLE] 				= "CrouchIdle"
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_CROUCHWALK] 				= ACT_WALK
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] = ACT_IDLE
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_RELOAD_CROUCH] 			= ACT_IDLE
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_JUMP] 						= ACT_RUN
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_SWIM_IDLE] 				= ACT_IDLE
GM.AnimTable["models/vortigaunt.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/vortigaunt.mdl"][ACT_LAND] 						= ACT_IDLE

GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"] = {}
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_STAND_IDLE] 				= ACT_IDLE_ANGRY
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_WALK] 						= ACT_WALK
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_RUN] 						= ACT_RUN
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_CROUCH_IDLE] 				= "CrouchIdle"
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_CROUCHWALK] 				= ACT_WALK
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE_ANGRY
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] = ACT_IDLE_ANGRY
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE_ANGRY
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_RELOAD_CROUCH] 			= ACT_IDLE_ANGRY
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_JUMP] 						= ACT_RUN
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_SWIM_IDLE] 				= ACT_IDLE_ANGRY
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_MP_SWIM] 						= ACT_IDLE_ANGRY
GM.AnimTable["models/vortigaunt.mdl"]["_UNHOLSTERED"][ACT_LAND] 						= ACT_IDLE_ANGRY

GM.AnimTable["models/vortigaunt_slave.mdl"] = GM.AnimTable["models/vortigaunt.mdl"]
GM.AnimTable["models/vortigaunt_doctor.mdl"] = GM.AnimTable["models/vortigaunt.mdl"]
GM.AnimTable["models/tnb/skynet/t400.mdl"] = GM.AnimTable["models/vortigaunt.mdl"]
GM.AnimTable["models/tnb/skynet/t400_repro.mdl"] = GM.AnimTable["models/vortigaunt.mdl"]
GM.AnimTable["models/tnb/skynet/t500_reaver.mdl"] = GM.AnimTable["models/vortigaunt.mdl"]

GM.AnimTable["models/stalker.mdl"] = {}
GM.AnimTable["models/stalker.mdl"][ACT_MP_STAND_IDLE] 					= ACT_IDLE
GM.AnimTable["models/stalker.mdl"][ACT_MP_WALK] 						= ACT_WALK
GM.AnimTable["models/stalker.mdl"][ACT_MP_RUN] 							= ACT_WALK
GM.AnimTable["models/stalker.mdl"][ACT_MP_CROUCH_IDLE] 					= ACT_IDLE
GM.AnimTable["models/stalker.mdl"][ACT_MP_CROUCHWALK] 					= ACT_WALK
GM.AnimTable["models/stalker.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/stalker.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE]	= ACT_IDLE
GM.AnimTable["models/stalker.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE
GM.AnimTable["models/stalker.mdl"][ACT_MP_RELOAD_CROUCH] 				= ACT_IDLE
GM.AnimTable["models/stalker.mdl"][ACT_MP_JUMP] 						= ACT_WALK
GM.AnimTable["models/stalker.mdl"][ACT_MP_SWIM_IDLE] 					= ACT_IDLE
GM.AnimTable["models/stalker.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/stalker.mdl"][ACT_LAND] 							= ACT_IDLE
GM.AnimTable["models/stalker.mdl"]["Vehicle"] 							= "podconvulse"

GM.AnimTable["models/zombie/classic.mdl"] = GM.AnimTable["models/stalker.mdl"]
GM.AnimTable["models/zombie/poison.mdl"] = GM.AnimTable["models/stalker.mdl"]
GM.AnimTable["models/zombie/classic_torso.mdl"] = GM.AnimTable["models/stalker.mdl"]

GM.AnimTable["models/zombie/fast.mdl"] = {}
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_STAND_IDLE] 					= ACT_IDLE
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_WALK] 						= ACT_WALK
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_RUN] 							= ACT_RUN
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_CROUCH_IDLE] 					= ACT_IDLE
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_CROUCHWALK] 					= ACT_WALK
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_RELOAD_CROUCH] 				= ACT_IDLE
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_JUMP] 						= ACT_JUMP
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_SWIM_IDLE] 					= ACT_IDLE
GM.AnimTable["models/zombie/fast.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/zombie/fast.mdl"][ACT_LAND] 							= ACT_IDLE

GM.AnimTable["models/antlion.mdl"] = GM.AnimTable["models/zombie/fast.mdl"]
GM.AnimTable["models/antlion_worker.mdl"] = GM.AnimTable["models/zombie/fast.mdl"]

GM.AnimTable["models/headcrabclassic.mdl"] = {}
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_STAND_IDLE] 					= ACT_IDLE
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_WALK] 						= ACT_RUN
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_RUN] 							= ACT_RUN
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_CROUCH_IDLE] 					= ACT_IDLE
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_CROUCHWALK] 					= ACT_RUN
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_RELOAD_CROUCH] 				= ACT_IDLE
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_JUMP] 						= ACT_RANGE_ATTACK1
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_SWIM_IDLE] 					= ACT_IDLE
GM.AnimTable["models/headcrabclassic.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/headcrabclassic.mdl"][ACT_LAND] 							= ACT_IDLE

GM.AnimTable["models/headcrab.mdl"] = GM.AnimTable["models/headcrabclassic.mdl"]
GM.AnimTable["models/lamarr.mdl"] = GM.AnimTable["models/headcrabclassic.mdl"]

GM.AnimTable["models/headcrabblack.mdl"] = {}
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_STAND_IDLE] 				= ACT_IDLE
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_WALK] 						= ACT_RUN
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_RUN] 						= ACT_RUN
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_CROUCH_IDLE] 				= ACT_IDLE
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_CROUCHWALK] 				= ACT_RUN
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_RELOAD_CROUCH] 				= ACT_IDLE
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_JUMP] 						= ACT_RUN
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_SWIM_IDLE] 					= ACT_IDLE
GM.AnimTable["models/headcrabblack.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/headcrabblack.mdl"][ACT_LAND] 							= ACT_IDLE

GM.AnimTable["models/tnb/skynet/t70.mdl"] = GM.AnimTable["models/headcrabblack.mdl"]
GM.AnimTable["models/tnb/skynet/t70_widow.mdl"] = GM.AnimTable["models/headcrabblack.mdl"]
GM.AnimTable["models/tnb/skynet/t70_scorpion.mdl"] = GM.AnimTable["models/headcrabblack.mdl"]

GM.AnimTable["models/antlion_guard.mdl"] = {}
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_STAND_IDLE] 				= ACT_IDLE
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_WALK] 						= ACT_WALK
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_RUN] 						= ACT_RUN
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_CROUCH_IDLE] 				= ACT_IDLE
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_CROUCHWALK] 				= ACT_WALK
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_RELOAD_CROUCH] 				= ACT_IDLE
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_JUMP] 						= ACT_RUN
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_SWIM_IDLE] 					= ACT_IDLE
GM.AnimTable["models/antlion_guard.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/antlion_guard.mdl"][ACT_LAND] 							= ACT_IDLE

GM.AnimTable["models/tnb/skynet/t100.mdl"] = GM.AnimTable["models/antlion_guard.mdl"]
GM.AnimTable["models/tnb/skynet/t200.mdl"] = GM.AnimTable["models/antlion_guard.mdl"]
GM.AnimTable["models/tnb/skynet/t100_mech.mdl"] = GM.AnimTable["models/antlion_guard.mdl"]

GM.AnimTable["models/dog.mdl"] = {}
GM.AnimTable["models/dog.mdl"][ACT_MP_STAND_IDLE] 						= ACT_IDLE
GM.AnimTable["models/dog.mdl"][ACT_MP_WALK] 							= ACT_WALK
GM.AnimTable["models/dog.mdl"][ACT_MP_RUN] 								= ACT_WALK
GM.AnimTable["models/dog.mdl"][ACT_MP_CROUCH_IDLE] 						= ACT_IDLE
GM.AnimTable["models/dog.mdl"][ACT_MP_CROUCHWALK] 						= ACT_WALK
GM.AnimTable["models/dog.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 		= ACT_IDLE
GM.AnimTable["models/dog.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 		= ACT_IDLE
GM.AnimTable["models/dog.mdl"][ACT_MP_RELOAD_STAND] 					= ACT_IDLE
GM.AnimTable["models/dog.mdl"][ACT_MP_RELOAD_CROUCH] 					= ACT_IDLE
GM.AnimTable["models/dog.mdl"][ACT_MP_JUMP] 							= ACT_RUN
GM.AnimTable["models/dog.mdl"][ACT_MP_SWIM_IDLE] 						= ACT_IDLE
GM.AnimTable["models/dog.mdl"][ACT_MP_SWIM] 							= ACT_IDLE
GM.AnimTable["models/dog.mdl"][ACT_LAND] 								= ACT_IDLE

GM.AnimTable["models/tnb/skynet/t300_mech.mdl"] = GM.AnimTable["models/dog.mdl"]

GM.AnimTable["models/babygarg.mdl"] = {}
GM.AnimTable["models/babygarg.mdl"][ACT_MP_STAND_IDLE] 						= ACT_IDLE
GM.AnimTable["models/babygarg.mdl"][ACT_MP_WALK] 							= ACT_WALK
GM.AnimTable["models/babygarg.mdl"][ACT_MP_RUN] 							= ACT_WALK
GM.AnimTable["models/babygarg.mdl"][ACT_MP_CROUCH_IDLE] 					= ACT_IDLE
GM.AnimTable["models/babygarg.mdl"][ACT_MP_CROUCHWALK] 						= ACT_WALK
GM.AnimTable["models/babygarg.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 		= ACT_IDLE
GM.AnimTable["models/babygarg.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 		= ACT_IDLE
GM.AnimTable["models/babygarg.mdl"][ACT_MP_RELOAD_STAND] 					= ACT_IDLE
GM.AnimTable["models/babygarg.mdl"][ACT_MP_RELOAD_CROUCH] 					= ACT_IDLE
GM.AnimTable["models/babygarg.mdl"][ACT_MP_JUMP] 							= ACT_WALK
GM.AnimTable["models/babygarg.mdl"][ACT_MP_SWIM_IDLE] 						= ACT_IDLE
GM.AnimTable["models/babygarg.mdl"][ACT_MP_SWIM] 							= ACT_IDLE
GM.AnimTable["models/babygarg.mdl"][ACT_LAND] 								= ACT_IDLE

GM.AnimTable["models/tnb/skynet/t300.mdl"] = GM.AnimTable["models/babygarg.mdl"]
GM.AnimTable["models/tnb/skynet/t300_new.mdl"] = GM.AnimTable["models/babygarg.mdl"]

GM.AnimTable["models/hunter.mdl"] = {}
GM.AnimTable["models/hunter.mdl"][ACT_MP_STAND_IDLE] 				= ACT_IDLE
GM.AnimTable["models/hunter.mdl"][ACT_MP_WALK] 						= ACT_WALK
GM.AnimTable["models/hunter.mdl"][ACT_MP_RUN] 						= ACT_RUN
GM.AnimTable["models/hunter.mdl"][ACT_MP_CROUCH_IDLE] 				= ACT_IDLE
GM.AnimTable["models/hunter.mdl"][ACT_MP_CROUCHWALK] 				= ACT_WALK
GM.AnimTable["models/hunter.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/hunter.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] = ACT_IDLE
GM.AnimTable["models/hunter.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE
GM.AnimTable["models/hunter.mdl"][ACT_MP_RELOAD_CROUCH] 			= ACT_IDLE
GM.AnimTable["models/hunter.mdl"][ACT_MP_JUMP] 						= ACT_RUN
GM.AnimTable["models/hunter.mdl"][ACT_MP_SWIM_IDLE] 				= ACT_IDLE
GM.AnimTable["models/hunter.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/hunter.mdl"][ACT_LAND] 						= ACT_IDLE

GM.AnimTable["models/hound_eye.mdl"] = {}
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_STAND_IDLE] 				= "idle2"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_WALK] 						= "walk2"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_RUN] 						= "run"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_CROUCH_IDLE] 				= "idle2"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_CROUCHWALK] 				= "walk2"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE]	= "idle2"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 	= "idle2"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_RELOAD_STAND] 				= "idle2"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_RELOAD_CROUCH] 				= "idle2"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_JUMP] 						= "idle2"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_SWIM_IDLE] 					= "idle2"
GM.AnimTable["models/hound_eye.mdl"][ACT_MP_SWIM] 						= "idle2"
GM.AnimTable["models/hound_eye.mdl"][ACT_LAND] 							= "idle2"

GM.AnimTable["models/bullsquiddy.mdl"] = {}
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_STAND_IDLE] 					= "idle"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_WALK] 						= "walk"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_RUN] 							= "run"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_CROUCH_IDLE] 					= "idle"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_CROUCHWALK] 					= "walk"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE]		= "idle"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 	= "idle"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_RELOAD_STAND] 				= "idle"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_RELOAD_CROUCH] 				= "idle"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_JUMP] 						= "surprisedhop"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_SWIM_IDLE] 					= "idle"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_MP_SWIM] 						= "idle"
GM.AnimTable["models/bullsquiddy.mdl"][ACT_LAND] 							= "idle"

GM.AnimTable["models/charger/charger.mdl"] = {}
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_STAND_IDLE] 					= "Idle"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_WALK] 						= "Walk"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_RUN] 							= "Run"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_CROUCH_IDLE] 					= "Idle"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_CROUCHWALK] 					= "Walk"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE]		= "Idle"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 	= "Idle"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_RELOAD_STAND] 				= "Idle"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_RELOAD_CROUCH] 				= "Idle"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_JUMP] 						= "Idle"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_SWIM_IDLE] 					= "Idle"
GM.AnimTable["models/charger/charger.mdl"][ACT_MP_SWIM] 						= "Idle"
GM.AnimTable["models/charger/charger.mdl"][ACT_LAND] 							= "Idle"

GM.AnimTable["models/pigeon.mdl"] = {}
GM.AnimTable["models/pigeon.mdl"][ACT_MP_STAND_IDLE] 				= ACT_IDLE
GM.AnimTable["models/pigeon.mdl"][ACT_MP_WALK] 						= ACT_WALK
GM.AnimTable["models/pigeon.mdl"][ACT_MP_RUN] 						= ACT_RUN
GM.AnimTable["models/pigeon.mdl"][ACT_MP_CROUCH_IDLE] 				= ACT_IDLE
GM.AnimTable["models/pigeon.mdl"][ACT_MP_CROUCHWALK] 				= ACT_WALK
GM.AnimTable["models/pigeon.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/pigeon.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] = ACT_IDLE
GM.AnimTable["models/pigeon.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE
GM.AnimTable["models/pigeon.mdl"][ACT_MP_RELOAD_CROUCH] 			= ACT_IDLE
GM.AnimTable["models/pigeon.mdl"][ACT_MP_JUMP] 						= ACT_HOP
GM.AnimTable["models/pigeon.mdl"][ACT_MP_SWIM_IDLE] 				= ACT_IDLE
GM.AnimTable["models/pigeon.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/pigeon.mdl"][ACT_LAND] 						= ACT_IDLE

GM.AnimTable["models/crow.mdl"] = GM.AnimTable["models/pigeon.mdl"]
GM.AnimTable["models/seagull.mdl"] = GM.AnimTable["models/pigeon.mdl"]

GM.AnimTable["models/gman.mdl"] = {}
GM.AnimTable["models/gman.mdl"][ACT_MP_STAND_IDLE] 					= ACT_IDLE
GM.AnimTable["models/gman.mdl"][ACT_MP_WALK] 						= ACT_WALK
GM.AnimTable["models/gman.mdl"][ACT_MP_RUN] 						= ACT_RUN
GM.AnimTable["models/gman.mdl"][ACT_MP_CROUCH_IDLE] 				= ACT_IDLE
GM.AnimTable["models/gman.mdl"][ACT_MP_CROUCHWALK] 					= ACT_WALK
GM.AnimTable["models/gman.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/gman.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/gman.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE
GM.AnimTable["models/gman.mdl"][ACT_MP_RELOAD_CROUCH] 				= ACT_IDLE
GM.AnimTable["models/gman.mdl"][ACT_MP_JUMP] 						= ACT_JUMP
GM.AnimTable["models/gman.mdl"][ACT_MP_SWIM_IDLE] 					= ACT_IDLE
GM.AnimTable["models/gman.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/gman.mdl"][ACT_LAND] 							= ACT_IDLE

GM.AnimTable["models/gman_high.mdl"] = GM.AnimTable["models/gman.mdl"]
GM.AnimTable["models/breen.mdl"] = GM.AnimTable["models/gman.mdl"]

GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"] = {}
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_STAND_IDLE] 				= ACT_IDLE
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_WALK] 						= ACT_WALK
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_RUN] 						= ACT_RUN
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_CROUCH_IDLE] 				= ACT_IDLE
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_CROUCHWALK] 				= ACT_WALK
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_IDLE
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_RELOAD_CROUCH] 				= ACT_IDLE
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_JUMP] 						= ACT_JUMP
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_SWIM_IDLE] 					= ACT_IDLE
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/lostcoast/fisherman/fisherman.mdl"][ACT_LAND] 							= ACT_LAND


GM.AnimTable["models/Police.mdl"] = {}
GM.AnimTable["models/Police.mdl"][ACT_MP_STAND_IDLE] 					= ACT_IDLE
GM.AnimTable["models/Police.mdl"][ACT_MP_WALK] 						= "walk_all"
GM.AnimTable["models/Police.mdl"][ACT_MP_RUN] 							= ACT_RUN_RIFLE
GM.AnimTable["models/Police.mdl"][ACT_MP_CROUCH_IDLE] 					= ACT_COVER
GM.AnimTable["models/Police.mdl"][ACT_MP_CROUCHWALK] 					= ACT_WALK_CROUCH_RIFLE
GM.AnimTable["models/Police.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/Police.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] 	= ACT_IDLE
GM.AnimTable["models/Police.mdl"][ACT_MP_RELOAD_STAND] 				= ACT_GESTURE_RELOAD
GM.AnimTable["models/Police.mdl"][ACT_MP_RELOAD_CROUCH] 				= ACT_GESTURE_RELOAD
GM.AnimTable["models/Police.mdl"][ACT_MP_JUMP] 						= ACT_JUMP
GM.AnimTable["models/Police.mdl"][ACT_MP_SWIM_IDLE] 					= ACT_IDLE
GM.AnimTable["models/Police.mdl"][ACT_MP_SWIM] 						= ACT_IDLE
GM.AnimTable["models/Police.mdl"][ACT_LAND] 							= ACT_IDLE

GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"] = {}
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_STAND_IDLE] 					= ACT_IDLE_ANGRY
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_WALK] 						= "walk_aiming_all"
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_RUN] 							= ACT_RUN_AIM_RIFLE
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_CROUCH_IDLE] 					= "CrouchIdle"
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_CROUCHWALK] 					= ACT_WALK_CROUCH_RIFLE
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 	= ACT_IDLE_ANGRY
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE]	= ACT_IDLE_ANGRY
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_RELOAD_STAND] 				= ACT_GESTURE_RELOAD
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_RELOAD_CROUCH] 				= ACT_GESTURE_RELOAD
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_JUMP] 						= ACT_JUMP
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_SWIM_IDLE] 					= ACT_IDLE_ANGRY
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_MP_SWIM] 						= ACT_IDLE_ANGRY
GM.AnimTable["models/Police.mdl"]["_UNHOLSTERED"][ACT_LAND] 							= ACT_IDLE_ANGRY

GM.AnimTable["models/combine_scanner.mdl"] = { }
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_STAND_IDLE]								= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_WALK] 									= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_RUN] 										= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_CROUCH_IDLE]								= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_CROUCHWALK] 								= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_ATTACK_STAND_PRIMARYFIRE] 				= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_ATTACK_CROUCH_PRIMARYFIRE]				= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_RELOAD_STAND] 							= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_RELOAD_CROUCH]							= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_JUMP] 									= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_SWIM_IDLE] 								= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_MP_SWIM] 									= ACT_IDLE
GM.AnimTable["models/combine_scanner.mdl"][ACT_LAND]										= ACT_IDLE

GM.AnimTable["models/shield_scanner.mdl"] = GM.AnimTable["models/combine_scanner.mdl"]

GM.AnimTable["models/characters/hostage_01.mdl"] = GM.AnimTable["models/gman.mdl"]
GM.AnimTable["models/characters/hostage_02.mdl"] = GM.AnimTable["models/characters/hostage_01.mdl"]
GM.AnimTable["models/characters/hostage_03.mdl"] = GM.AnimTable["models/characters/hostage_01.mdl"]
GM.AnimTable["models/characters/hostage_04.mdl"] = GM.AnimTable["models/characters/hostage_01.mdl"]

function GM:HandlePlayerNonPlayermodel(ply, vel)
	if not self.AnimTable[ply:GetModel()] then return end

	local tab = self.AnimTable[string.lower(ply:GetModel())]

	local wep = ply:GetActiveWeapon()

	if IsValid(wep) then
		local bool

		if wep.Tekka then
			bool = wep:ShouldLower()
		else
			bool = ply:Holstered()
		end

		if not bool and tab["_UNHOLSTERED"] then
			tab = tab["_UNHOLSTERED"]
		end
	end

	if tab[ply.CalcIdeal] then

		if type(tab[ply.CalcIdeal]) == "number" then

			ply.CalcIdeal = tab[ply.CalcIdeal]

		else

			ply.CalcSeqOverride = ply:LookupSequence(tab[ply.CalcIdeal])

		end

	end
end

function GM:CalcMainActivity(ply, vel)
	if SERVER then
		if ply:KeyDown(IN_ATTACK2) then
			ply:SetInAttack2(true)
		else
			ply:SetInAttack2(false)
		end
	end

	ply.CalcIdeal = ACT_MP_STAND_IDLE
	ply.CalcSeqOverride = -1

	self:HandlePlayerLanding(ply, vel, ply.m_bWasOnGround)

	local bool = self:HandlePlayerNoClipping(ply, vel) or self:HandlePlayerDriving(ply) or self:HandlePlayerVaulting(ply, vel) or self:HandlePlayerJumping(ply, vel) or self:HandlePlayerDucking(ply, vel) or self:HandlePlayerSwimming(ply, vel)

	if not bool then
		local len2d = vel:Length2D()

		if len2d > ply:GetRunSpeed() / math.sqrt(2) - 8 then
			ply.CalcIdeal = ACT_MP_RUN
		elseif len2d > 0.5 then
			ply.CalcIdeal = ACT_MP_WALK
		end
	end

	ply.m_bWasOnGround = ply:IsOnGround()
	ply.m_bWasNoclipping = ply:GetMoveType() == MOVETYPE_NOCLIP and not ply:InVehicle()

	self:HandlePlayerNonPlayermodel(ply, vel)

	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CalcMainActivity then
		wep:CalcMainActivity(ply, vel)
	end

	return ply.CalcIdeal, ply.CalcSeqOverride
end

function GM:UpdateAnimation(ply, vel, max)
	if CLIENT then
		max = max * ply:PlayerScale()
	end

	self.BaseClass:UpdateAnimation(ply, vel, max)

	if CLIENT then
		if self.AnimTable[ply:GetModel()] then
			ply:SetIK(false)
		else
			ply:SetIK(true)
		end

		local moveang = Vector(vel.x, vel.y, 0):Angle()
		local eyeang = Vector(ply:GetAimVector().x, ply:GetAimVector().y, 0):Angle()

		local diff = moveang.y - eyeang.y

		if diff > 180 then diff = diff - 360 end
		if diff < -180 then diff = diff + 360 end

		ply:SetPoseParameter("move_yaw", diff)
	end

	if CLIENT then
		self:FistAnimation(ply)
		self:RadioAnimation(ply)
	end
end

function GM:GrabEarAnimation(ply)
end

function GM:FistAnimation(ply)
	ply.FistWeight = ply.FistWeight or 0

	if ply:IsPlayingTaunt() then return end

	if ply:GetActiveWeapon() and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon() ~= NULL and ply:GetActiveWeapon().SecondaryBlock and not ply:Holstered() and ply:InAttack2() then

		ply.FistWeight = math.Approach(ply.FistWeight, 1, FrameTime() * 5.0)

	else

		ply.FistWeight = math.Approach(ply.FistWeight, 0, FrameTime() * 5.0)

	end

	if ply.FistWeight > 0 then

		ply:AnimRestartGesture(GESTURE_SLOT_VCD, ACT_HL2MP_FIST_BLOCK, true)
		ply:AnimSetGestureWeight(GESTURE_SLOT_VCD, ply.FistWeight)

	end
end

function GM:RadioAnimation(ply)
	ply.RadioWeight = ply.RadioWeight or 0

	if ply:IsPlayingTaunt() or ply:HasTerminatorTeam() then return end

	if ply:Typing() > 1 then

		ply.RadioWeight = math.Approach(ply.RadioWeight, 1, FrameTime() * 5.0)

	else

		ply.RadioWeight = math.Approach(ply.RadioWeight, 0, FrameTime() * 5.0)

	end

	if ply.RadioWeight > 0 then

		ply:AnimRestartGesture(GESTURE_SLOT_VCD, ACT_GMOD_IN_CHAT, true)
		ply:AnimSetGestureWeight(GESTURE_SLOT_VCD, ply.RadioWeight)

	end
end

net.Receive("nPlayVCD", function(len)
	if SERVER then return end

	local ent = net.ReadEntity()
	local seq = net.ReadString()

	if ent and ent:IsValid() then

		ent:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, ent:LookupSequence(seq), 0, true)

	end
end)

function meta:PlayVCD(seq, sendtoself)
	if CLIENT then

		self:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, self:LookupSequence(seq), 0, true)

	else

		local rf = {}

		for _, v in pairs(player.GetAll()) do

			if v ~= self or sendtoself then

				table.insert(rf, v)

			end

		end

		net.Start("nPlayVCD")
			net.WriteEntity(self)
			net.WriteString(seq)
		net.Send(rf)

	end
end

function GM:GetValidGestures(ply)
	local tab = {}

	if not ply or not ply:IsValid() then return tab end

	tab["Gesture: Forward"] = ACT_SIGNAL_FORWARD
	tab["Gesture: Halt"] = ACT_SIGNAL_HALT
	tab["Gesture: Group"] = ACT_SIGNAL_GROUP

	return tab
end

net.Receive("nPlaySignal", function(len)
	local enum = net.ReadBool()

	local activity = enum and net.ReadFloat() or net.ReadString()
	local source = net.ReadEntity()

	if not table.HasValue(GAMEMODE:GetValidGestures(source), activity) then
		return
	end

	if CLIENT then
		if enum then
			source:AnimRestartGesture(GESTURE_SLOT_CUSTOM, activity, true)
		else
			source:PlayVCD(activity)
		end
	else
		net.Start("nPlaySignal")
			net.WriteBool(enum)
			if enum then
				net.WriteFloat(activity)
			else
				net.WriteString(activity)
			end
			net.WriteEntity(source)
		net.SendPVS(source:GetPos())
	end
end)

function meta:PlaySignal(activity)
	if not table.HasValue(GAMEMODE:GetValidGestures(self), activity) then
		return
	end

	local enum = type(activity) == "number"

	net.Start("nPlaySignal")
		net.WriteBool(enum)
		if enum then
			net.WriteFloat(activity)
		else
			net.WriteString(activity)
		end
		net.WriteEntity(self)
	if CLIENT then
		net.SendToServer()
	else
		net.SendPVS(self:GetPos())
	end
end
