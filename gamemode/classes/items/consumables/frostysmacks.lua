ITEM = class.Create("base_consumable")

ITEM.Name 				= "Horsey's Frosty Smacks"
ITEM.Description 		= "A cheap really old big bottle of cider.. It's time to forget your problems."

ITEM.Model				= Model("models/props_junk/garbage_plasticbottle003a.mdl")

ITEM.Weight 			= 1

ITEM.UseSelfName 		= "Inject"

ITEM.CanUseOthers 		= true
ITEM.UseOthersName 		= "Force feed"

local selfphrases = {
	"F-Fucking hell! This shit is GOOD",
	"Blurgghh, this is some good smasher.",
	"Mhmmm fucking peng!",
	"Fuckin' ell I think Im gonna shit my pants.",
	"Yer mums a fat fucking goose mate",
	"FUCK THE CIVIL PROTECTION!",
	"What the fuck are you looking at you fat gypsy cunt?",
	"YEH IM TALKING TO YOU",
	"I love you man, honestly. We're like, brothers, or sisters, or whatever",
	"IM A LOYALIST",
	"My penis has all these wierd spots and warts all over it.....",
	"I never asked for this....",
	"If its got a backbone, Ill do it.",
	"I hate black people",
	"Who am I?! What year is it?! WHO'S THE PRESIDENT?!",
	"Did you hear about that guy in City18? Bald guy named Dave Brown. He killed a Strider Synth with his bear hands. And yes, I mean with the actual hands of a bear.",
}

local otherphrases = {
	"I don't feel so good...",
	"Oh god...",
	"I'm gonna be sick!",
	"That's just not right!"
}

if SERVER then
	function ITEM:OnUse(ply)
		if math.random(1, 3) == 1 then
			ply:SendChat(ply, "YELL", selfphrases[math.random(1, #selfphrases)])
		end

		ply:HealOverTime(25, 5, 1.6)
	end

	function ITEM:OnUseOther(ply, target)
		if math.random(1, 3) == 1 then
			target:SendChat(target, "SAY", otherphrases[math.random(1, #otherphrases)])
		end

		local dmg = DamageInfo()
		dmg:SetAttacker(game.GetWorld())
		dmg:SetDamage(25)
		dmg:SetDamageForce(Vector())
		dmg:SetDamagePosition(target:GetPos())
		dmg:SetInflictor(game.GetWorld())
		dmg:SetDamageType(DMG_DROWN)

		target:TakeDamageInfo(dmg)

		return true
	end
end