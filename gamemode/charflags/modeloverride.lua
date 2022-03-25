FLAG.PrintName 					= "Model override"
FLAG.Flag 						= "Z"

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = ply.CharModel,
			skin = ply.CharSkin
		}
	}
end
