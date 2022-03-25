local PLAYER = {}

PLAYER.DisplayName			= "CombineControl"
PLAYER.TeammateNoCollide	= false
PLAYER.AvoidPlayers			= false

PLAYER.WalkSpeed 			= 95
PLAYER.RunSpeed 			= 150
PLAYER.JumpPower 			= 160


function PLAYER:GetHandsModel()
end

function PLAYER:StartMove(move)
end

function PLAYER:FinishMove(move)
end

player_manager.RegisterClass("player_cc", PLAYER, "player_sandbox")

player_manager.AddValidModel("t600_cc", "models/tnb/skynet/t600.mdl")
player_manager.AddValidModel("t800_cc", "models/tnb/skynet/t800.mdl")

player_manager.AddValidHands("t600_cc", "models/tnb/trpweapons/c_arms_t600.mdl", 0, "0000000")
player_manager.AddValidHands("t800_cc", "models/tnb/trpweapons/c_arms_t800.mdl", 0, "0000000")
