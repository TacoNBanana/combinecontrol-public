FLAG.PrintName 					= "Model override"
FLAG.Flag 						= "A"

function FLAG.ModelFunc(ply)
	return ply.CharModel, ply.CharSkin
end