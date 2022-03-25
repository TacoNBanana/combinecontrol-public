FLAG.PrintName 					= "Model override"
FLAG.Flag 						= "Z"

function FLAG.ModelFunc(ply)
	return ply.CharModel, ply.CharSkin
end