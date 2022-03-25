-- Perm format: {<Combineflags>, <Characterflags>}

PERM_CP 		= nil
PERM_OW 		= nil
PERM_TYRANT 	= nil
PERM_DISPATCH 	= nil
PERM_ANTLION 	= nil
PERM_SCANNER 	= nil

GM.SoundData = {}

-- Sound format: {<SoundData>, <Title>, <Chatmsg (optional)>}

-- CP sound data
GM.SoundData[1] = {
	name = "Response",
	perm = PERM_CP,
	sounds = {
		{{"npc/metropolice/vo/", "$cpon", "affirmative", "$cpoff"}, "Affirmative", "Affirmative."},
		{{"npc/metropolice/vo/", "$cpon", "copy", "$cpoff"}, "Copy", "Copy."},
		{{"npc/metropolice/vo/", "$cpon", "ten4", "$cpoff"}, "10-4", "10-4."},
		{{"npc/metropolice/vo/", "$cpon", "rodgerthat", "$cpoff"}, "Roger that", "Roger that."}
	}
}

GM.SoundData[2] = {
	name = "Warn",
	perm = PERM_CP,
	sounds = {
		{{"npc/metropolice/vo/", "$cpon", "movealong", "$cpoff"}, "Move along", "Move along."},
		{{"npc/metropolice/vo/", "$cpon", "keepmoving", "$cpoff"}, "Keep moving", "Keep moving."},
		{{"npc/metropolice/vo/", "$cpon", "move", "$cpoff"}, "Move", "Move."},
		{{"npc/metropolice/vo/", "$cpon", "dontmove", "$cpoff"}, "Don't move", "Don't move."},
		{{"npc/metropolice/vo/", "$cpon", "holditrightthere", "$cpoff"}, "Hold it", "Hold it right there."},
		{{"npc/metropolice/vo/", "$cpon", "finalwarning", "$cpoff"}, "Final warning", "Final warning."},
		{{"npc/metropolice/vo/", "$cpon", "prepareforjudgement", "$cpoff"}, "Prepare for judgement", "Suspect, prepare to receive civil judgement!"},
		{{"npc/metropolice/vo/", "$cpon", "youwantamalcomplianceverdict", "$cpoff"}, "Malcompliance verdict", "You want a malcompliance verdict?"},
		{{"npc/metropolice/vo/", "$cpon", "lookingfortrouble", "$cpoff"}, "Looking for trouble", "Looking for trouble?"},
		{{"npc/metropolice/vo/", "$cpon", "getoutofhere", "$cpoff"}, "Get out of here", "Get out of here."}
	}
}

GM.SoundData[3] = {
	name = "Order",
	perm = PERM_CP,
	sounds = {
		{{"npc/metropolice/vo/", "$cpon", "amputate", "$cpoff"}, "Amputate", "Amputate."},
		{{"npc/metropolice/vo/", "$cpon", "innoculate", "$cpoff"}, "Innoculate", "Innoculate."},
		{{"npc/metropolice/vo/", "$cpon", "investigate", "$cpoff"}, "Investigate", "Investigate."},
		{{"npc/metropolice/vo/", "$cpon", "sterilize", "$cpoff"}, "Sterilize", "Sterilize."},
		{{"npc/metropolice/vo/", "$cpon", "suspend", "$cpoff"}, "Suspend", "Suspend."},
		{{"npc/metropolice/vo/", "$cpon", "prosecute", "$cpoff"}, "Prosecute", "Prosecute."},
		{{"npc/metropolice/vo/", "$cpon", "cauterize", "$cpoff"}, "Cauterize", "Cauterize."},
		{{"npc/metropolice/vo/", "$cpon", "restrict", "$cpoff"}, "Restrict", "Restrict."},
		{{"npc/metropolice/vo/", "$cpon", "sacrificecode1maintaincp", "$cpoff"}, "Sacrifice code", "/y All units, sacrifice code 1, maintain this CP!"},
		{{"npc/metropolice/vo/", "$cpon", "assaultpointsecureadvance", "$cpoff"}, "AP secure advance", "/y Assault point secure, advance!"},
		{{"npc/metropolice/vo/", "$cpon", "allunitsmovein", "$cpoff"}, "All: Move in", "/y All units, move in."},
		{{"npc/metropolice/vo/", "$cpon", "movetoarrestpositions", "$cpoff"}, "All: Move to arrest", "/y All units, move to arrest positions."},
		{{"npc/metropolice/vo/", "$cpon", "lockyourposition", "$cpoff"}, "All: Lock your position", "/y All units, lock your position!"},
		{{"npc/metropolice/vo/", "$cpon", "allunitsmaintainthiscp", "$cpoff"}, "All: Maintain this CP", "/y All units, maintain this CP!"},
		{{"npc/metropolice/vo/", "$cpon", "allunitsreportlocationsuspect", "$cpoff"}, "All: Report location suspect", "/y All units, report location suspect."}
	}
}

GM.SoundData[4] = {
	name = "Alert",
	perm = PERM_CP,
	sounds = {
		{{"npc/metropolice/vo/", "$cpon", "11-99officerneedsassistance", "$cpoff"}, "11-99", "/y 11-99 officer needs assistance!"},
		{{"npc/metropolice/vo/", "$cpon", "officerunderfiretakingcover", "$cpoff"}, "Under fire", "/y Officer under fire, taking cover!"},
		{{"npc/metropolice/vo/", "$cpon", "shit"}, "Shit!", "/y Shit!"},
		{{"npc/metropolice/vo/", "$cpon", "watchit"}, "Watch it!", "/y Watch it!"},
		{{"npc/metropolice/vo/", "$cpon", "lookout"}, "Look out!", "/y Look out!"},
		{{"npc/metropolice/vo/", "$cpon", "takecover", "$cpoff"}, "Take cover!", "/y Take cover!"},
		{{"npc/metropolice/vo/", "$cpon", "$3cid", "movingtocover", "$cpoff"}, "Moving to cover", "/y Moving to cover!"},
		{{"npc/metropolice/vo/", "$cpon", "grenade"}, "Grenade", "/y Grenade!"},
		{{"npc/metropolice/vo/", "$cpon", "runninglowonverdicts", "$cpoff"}, "Low ammo", "/y Running low on verdicts, taking cover!"},
		{{"npc/metropolice/vo/", "$cpon", "firingtoexposetarget", "$cpoff"}, "Expose target", "/y Firing to expose target!"},
		{{"npc/metropolice/vo/", "$cpon", "cpisoverrunwehavenocontainment", "$cpoff"}, "Overrun", "/y CP is overrun, we have no containment!"},
		{{"npc/metropolice/vo/", "$cpon", "backmeupImout", "$cpoff"}, "I'm out", "/y Back me up, I'm out!"}
	}
}

GM.SoundData[5] = {
	name = "Contact",
	perm = PERM_CP,
	sounds = {
		{{"npc/metropolice/vo/", "$cpon", "confirmpriority1sighted", "$cpoff"}, "Priority 1", "Confirm a priority 1 sighted."},
		{{"npc/metropolice/vo/", "$cpon", "bugsontheloose", "$cpoff"}, "Antlions", "We've got bugs on the loose."},
		{{"npc/metropolice/vo/", "$cpon", "outlandbioticinhere", "$cpoff"}, "Vortigaunt", "We got an outland biotic in here."},
		{{"npc/metropolice/vo/", "$cpon", "noncitizen", "outbreak", "$cpoff"}, "Rebels", "Non-citizen, outbreak."},
		{{"npc/metropolice/vo/", "$cpon", "gotoneaccomplicehere", "$cpoff"}, "Accomplice", "I've got one accomplice here."},
		{{"npc/metropolice/vo/", "$cpon", "necrotics", "$cpoff"}, "Zombies", "Necrotics."},
		{{"npc/metropolice/vo/", "$cpon", "looseparasitics", "$cpoff"}, "Headcrabs", "Loose parasitics."}
	}
}

GM.SoundData[6] = {
	name = "Idle",
	perm = PERM_CP,
	sounds = {
		{{"npc/metropolice/vo/", "on2", "$cpoff"}, "*Radio click*"},
		{{"npc/metropolice/vo/", "$cpon", "chuckle", "$cpoff"}, "*Chuckle*", "/me chuckles."},
		{{"npc/metropolice/vo/", "$cpon", "ten97suspectisgoa", "$cpoff"}, "10-97 GOA"},
		{{"npc/metropolice/vo/", "$cpon", "holdingon10-14duty", "$cpoff"}, "Holding 10-14"},
		{{"npc/metropolice/vo/", "$cpon", "unitis10-65", "$cpoff"}, "10-65"},
		{{"npc/metropolice/vo/", "$cpon", "code7", "$cpoff"}, "Code 7"},
		{{"npc/metropolice/vo/", "$cpon", "code100", "$cpoff"}, "Code 100"},
		{{"npc/metropolice/vo/", "$cpon", "confirmadw", "$cpoff"}, "Confirm ADW"},
		{{"npc/metropolice/vo/", "$cpon", "possible647erequestairwatch", "$cpoff"}, "647e airwatch"},
		{{"npc/metropolice/vo/", "$cpon", "gota10-107sendairwatch", "$cpoff"}, "10-107 airwatch"},
		{{"npc/metropolice/vo/", "$cpon", "possible10-103alerttagunits", "$cpoff"}, "10-103 tag units"}
	}
}

GM.SoundData[7] = {
	name = "Clear",
	perm = PERM_CP,
	sounds = {
		{{"npc/metropolice/vo/", "$cpon", "wearesociostablethislocation", "$cpoff"}, "Sociostable"},
		{{"npc/metropolice/vo/", "$cpon", "blockisholdingcohesive", "$cpoff"}, "Block cohesive"},
		{{"npc/metropolice/vo/", "$cpon", "suspectlocationunknown", "$cpoff"}, "Suspect location unknown"},
		{{"npc/metropolice/vo/", "$cpon", "clearandcode100", "$cpoff"}, "Clear code 100"},
		{{"npc/metropolice/vo/", "$cpon", "novisualonupi", "$cpoff"}, "No vis UPI"},
		{{"npc/metropolice/vo/", "$cpon", "searchingforsuspect", "$cpoff"}, "Searching for suspect"},
		{{"npc/metropolice/vo/", "$cpon", "utlthatsuspect", "$cpoff"}, "Unable to locate"}
	}
}

-- Dispatch sound data
GM.SoundData[8] = {
	name = "Status",
	perm = PERM_DISPATCH,
	dispatch = true,
	sounds = {
		{{"npc/overwatch/radiovoice/", "on3", "sociostabilizationrestored", "off2"}, "Socio restored", "Sociostabilization restored."},
		{{"npc/overwatch/radiovoice/", "on3", "socialfractureinprogress", "off2"}, "Social fracture", "Social fracture in progress, respond."},
		{{"npc/overwatch/radiovoice/", "on3", "accomplicesoperating", "off2"}, "Accomplice in area", "Protection team, be advised. Accomplice is operating in area."},
		{{"npc/overwatch/radiovoice/", "on3", "engagingteamisnoncohesive", "_comma", "reinforcementteamscode3", "off2"}, "Team down", "Engaging protection team is non-cohesive, reinforcement teams code 3."},
		{{"npc/overwatch/radiovoice/", "on3", "airwatchcopiesnoactivity", "off2"}, "No activity", "Airwatch copies no activity in location."},
		{{"npc/overwatch/radiovoice/", "on3", "officerclosingonsuspect", "off2"}, "Officer closing", "Officer closing on suspect."}
	}
}

GM.SoundData[9] = {
	name = "Order",
	perm = PERM_DISPATCH,
	dispatch = true,
	sounds = {
		{{"npc/overwatch/radiovoice/", "on3", "teamsreportstatus", "off2"}, "Report status", "Local civil protection teams, report status."},
		{{"npc/overwatch/radiovoice/", "on3", "lockdownlocationsacrificecode", "one", "off2"}, "Lock down: sacrifice code", "Protection teams, lock down your location. Sacrifice code one."},
		{{"npc/overwatch/radiovoice/", "on3", "allunitsdeliverterminalverdict", "off2"}, "All: Deliver terminal verdict", "All units, deliver terminal verdict immediately."},
		{{"npc/overwatch/radiovoice/", "on3", "allunitsreturntocode12", "off2"}, "All: Return to code 12", "All units, return to code 12."},
		{{"npc/overwatch/radiovoice/", "on3", "allunitsapplyforwardpressure", "off2"}, "All: Apply pressure", "All units, apply forward pressure."}
	}
}

GM.SoundData[10] = {
	name = "Idle",
	perm = PERM_DISPATCH,
	dispatch = true,
	sounds = {
		{{"npc/overwatch/radiovoice/", "on3", "confirmupialert", "off2"}, "Confirm UPI"},
		{{"npc/overwatch/radiovoice/", "on3", "recalibratesocioscan", "off2"}, "Recalibrate socio scan"},
		{{"npc/overwatch/radiovoice/", "on3", "recalibratesocioscan", "_comma", "recievingconflictingdata", "off2"}, "Recalibrate conflicting data"},
		{{"npc/overwatch/radiovoice/", "on3", "airwatchreportspossiblemiscount", "off2"}, "Airwatch reports possible miscount"},
		{{"npc/overwatch/radiovoice/", "on3", "rewardnotice", "off2"}, "Reward notice"},
		{{"npc/overwatch/radiovoice/", "on3", "politistablizationmarginal", "off2"}, "Stabilization marginal"},
		{{"npc/overwatch/radiovoice/", "on3", "antifatigueration3mg", "off2"}, "Antifatigue ration"},
		{{"npc/overwatch/radiovoice/", "on3", "switchtotac5reporttocp", "off2"}, "Switch to tac 5"},
		{{"npc/overwatch/radiovoice/", "on3", "$randCode", "off2"}, "Random codes"}
	}
}

-- Overwatch sound data
GM.SoundData[11] = {
	name = "Response",
	perm = PERM_OW,
	sounds = {
		{{"npc/combine_soldier/vo/", "$owon", "affirmative", "$owoff"}, "Affirmative", "Affirmative."},
		{{"npc/combine_soldier/vo/", "$owon", "copy", "$owoff"}, "Copy", "Copy."},
		{{"npc/combine_soldier/vo/", "$owon", "copythat", "$owoff"}, "Copy that", "Copy that."}
	}
}

GM.SoundData[12] = {
	name = "Status",
	perm = PERM_OW,
	sounds = {
		{{"npc/combine_soldier/vo/", "$owon", "$3cid", "suppressing", "$owoff"}, "Suppressing", "Suppressing."},
		{{"npc/combine_soldier/vo/", "$owon", "$3cid", "prosecuting", "$owoff"}, "Prosecuting", "Prosecuting."},
		{{"npc/combine_soldier/vo/", "$owon", "$3cid", "engaging", "$owoff"}, "Engaging", "Engaging."},
		{{"npc/combine_soldier/vo/", "$owon", "$3cid", "closing", "$owoff"}, "Closing", "Closing."},
		{{"npc/combine_soldier/vo/", "$owon", "$3cid", "inbound", "$owoff"}, "Inbound", "Inbound."},
		{{"npc/combine_soldier/vo/", "$owon", "$3cid", "sweepingin", "$owoff"}, "Sweeping in", "Sweeping in."},
		{{"npc/combine_soldier/vo/", "$owon", "$3cid", "unitismovingin", "$owoff"}, "Moving in", "Unit is moving in."}
	}
}

GM.SoundData[13] = {
	name = "Alert",
	perm = PERM_OW,
	sounds = {
		{{"npc/combine_soldier/vo/", "$owon", "alert1", "$owoff"}, "Alert 1", "Alert 1."},
		{{"npc/combine_soldier/vo/", "$owon", "executingfullresponse", "$owoff"}, "Full response", "Executing full response!"},
		{{"npc/combine_soldier/vo/", "$owon", "onedown", "onedown", "$owoff"}, "One down", "/y One down one down!"},
		{{"npc/combine_soldier/vo/", "$owon", "coverhurt", "$owoff"}, "Cover", "/y Cover!"},
		{{"npc/combine_soldier/vo/", "$owon", "coverme", "$owoff"}, "Cover me", "Cover me."},
		{{"npc/combine_soldier/vo/", "$owon", "bouncerbouncer", "$owoff"}, "Bouncer", "/y Bouncer bouncer!"},
		{{"npc/combine_soldier/vo/", "$owon", "extractorislive", "$owoff"}, "Extractor live", "/y Extractor is live!"},
		{{"npc/combine_soldier/vo/", "$owon", "_period", "six", "_comma", "five", "_comma", "four", "_comma", "three", "_comma", "two", "_comma", "one", "_comma", "flash", "flash:105", "flash:110", "$owoff"}, "Grenade countdown"},
		{{"npc/combine_soldier/vo/", "$owon", "bodypackholding", "$owoff", "$owon"}, "Armor holding", "Bodypack holding."},
		{{"npc/combine_soldier/vo/", "$owon", "$3cid", "requestmedical", "$owoff"}, "Request medical", "/y Request medical!"},
		{{"npc/combine_soldier/vo/", "$owon", "contained", "$owoff"}, "Enemy down", "One contained."},
		{{"npc/combine_soldier/vo/", "$owon", "ripcordripcord", "$owoff"}, "Ripcord", "/y Ripcord ripcord!"},
		{{"npc/combine_soldier/vo/", "$owon", "overwatchteamisdown", "$owoff"}, "Team is down", "/r Overwatch team is down, sector is not controlled."},
		{{"npc/combine_soldier/vo/", "targetcompromisedmovein", "$owoff"}, "Target compromised", "/y Target compromised, move in move in!"}
	}
}

GM.SoundData[14] = {
	name = "Contact",
	perm = PERM_OW,
	sounds = {
		{{"npc/combine_soldier/vo/", "$owon", "viscon", "viscon:110", "$owoff"}, "Viscon", "/y Viscon viscon!"},
		{{"npc/combine_soldier/vo/", "$owon", "gosharpgosharp", "$owoff"}, "Go sharp", "/y Go sharp go sharp!"},
		{{"npc/combine_soldier/vo/", "$owon", "contact", "$owoff"}, "Contact", "Contact."},
		{{"npc/combine_soldier/vo/", "$owon", "contact", "_comma", "$dist", "$owoff"}, "Contact w/ range", "Contact."},
		{{"npc/combine_soldier/vo/", "$owon", "targetmyradial", "$owoff"}, "Target radial", "Target my radial."},
		{{"npc/combine_soldier/vo/", "$owon", "overwatch", "_comma", "sectorisnotsecure", "$owoff"}, "Sector not secure", "Overwatch, sector is not secure."},
		{{"npc/combine_soldier/vo/", "swarmoutbreakinsector", "$owoff"}, "Antlions", "Swarm outbreak in sector."},
		{{"npc/combine_soldier/vo/", "target", "_comma", "prioritytwoescapee", "$owoff"}, "Rebels", "Target, priority two escapee."},
		{{"npc/combine_soldier/vo/", "necrotics", "$owoff"}, "Zombies", "Necrotics."},
		{{"npc/combine_soldier/vo/", "callcontactparasitics", "$owoff"}, "Headcrabs", "Call contact parasitics."}
	}
}

GM.SoundData[15] = {
	name = "Order",
	perm = PERM_OW,
	sounds = {
		{{"npc/combine_soldier/vo/", "$owon", "stayalert", "$owoff"}, "Stay alert", "Stay alert."},
		{{"npc/combine_soldier/vo/", "$owon", "prepforcontact", "$owoff"}, "Prep for contact"},
		{{"npc/combine_soldier/vo/", "$owon", "weaponsoffsafeprepforcontact", "$owoff"}, "Weapons off safe", "Weapons off safe, prep for contact."},
		{{"npc/combine_soldier/vo/", "$owon", "skyshieldreportslostcontact", "_comma", "readyweapons", "$owoff"}, "Skyshield lost contact", "Skyshield reports lost contact, ready weapons."},
		{{"npc/combine_soldier/vo/", "$owon", "stayalertreportsightlines", "$owoff"}, "Report sightlines", "Stay alert, report sightlines."},
		{{"npc/combine_soldier/vo/", "$owon", "reportallpositionsclear", "$owoff"}, "Report positions clear", "Report all positions clear."},
		{{"npc/combine_soldier/vo/", "$owon", "reportallradialsfree", "$owoff"}, "Report radials clear", "Report all radials free."},
		{{"npc/combine_soldier/vo/", "$owon", "motioncheckallradials", "$owoff"}, "Motion check radials", "Motion check all radials."},
		{{"npc/combine_soldier/vo/", "$owon", "readyweapons", "_comma", "stayalert", "$owoff"}, "Ready weapons", "Ready weapons, stay alert."},
		{{"npc/combine_soldier/vo/", "$owon", "movein", "$owoff"}, "Move in", "Move in."},
		{{"npc/combine_soldier/vo/", "$owon", "fixsightlinesmovein", "$owoff"}, "Fix sightlines", "Fix sightlines, move in."}
	}
}

GM.SoundData[16] = {
	name = "Clear",
	perm = PERM_OW,
	sounds = {
		{{"npc/combine_soldier/vo/", "$owon", "overwatch", "_comma", "stabilizationteamhassector", "$owoff"}, "Sector control", "Overwatch, stabilization team has sector control."},
		{{"npc/combine_soldier/vo/", "$owon", "overwatchtargetcontained", "$owoff"}, "Target contained", "Overwatch, target contained."},
		{{"npc/combine_soldier/vo/", "$owon", "affirmative", "_comma", "noviscon", "$owoff"}, "Affirm, no viscon", "Affirmative, no viscon."},
		{{"npc/combine_soldier/vo/", "$owon", "sightlineisclear", "on1", "$owoff"}, "Sightline clear", "Sightline is clear."},
		{{"npc/combine_soldier/vo/", "$owon", "$3cid", "reportingclear", "on1", "$owoff"}, "Reporting clear", "Reporting clear."},
		{{"npc/combine_soldier/vo/", "$owon", "sectorissecurenovison", "$owon", "$owoff"}, "Sector secure, no viscon", "Sector is secure, no viscon."}
	}
}

GM.SoundData[17] = {
	name = "Idle",
	perm = PERM_OW,
	sounds = {
		{{"npc/combine_soldier/vo/", "$owon", "overwatchreportspossiblehostiles", "$owoff"}, "Possible hostiles"},
		{{"npc/combine_soldier/vo/", "$owon", "$3cid", "standingby]", "$owoff"}, "Standing by"},
		{{"npc/combine_soldier/vo/", "$owon", "stabilizationteamholding", "$owoff"}, "Team holding"},
		{{"npc/combine_soldier/vo/", "$owon", "ovewatchorders3ccstimboost", "$owoff"}, "3cc stimboost"},
		{{"npc/combine_soldier/vo/", "$owon", "overwatch", "_comma", "teamdeployedandscanning", "$owoff"}, "Team deployed"}
	}
}

-- Tyrant sound data
GM.SoundData[18] = {
	name = "Tyrant",
	perm = PERM_TYRANT,
	sounds = {
		{"tyrant/tyrant_alert01.wav", "Alert 1"},
		{"tyrant/tyrant_alert02.wav", "Alert 2"},
		{"tyrant/tyrant_alert03.wav", "Alert 3"},
		{"tyrant/tyrant_angry01.wav", "Angry"},
		{"tyrant/tyrant_die01.wav", "Deathcry"},
		{"tyrant/tyrant_distant01.wav", "Distant 1"},
		{"tyrant/tyrant_distant02.wav", "Distant 2"},
		{"tyrant/tyrant_idle01.wav", "Idle 1"},
		{"tyrant/tyrant_idle02.wav", "Idle 2"},
		{"tyrant/tyrant_idle03.wav", "Idle 3"},
		{"tyrant/tyrant_roar01.wav", "Roar 1"},
		{"tyrant/tyrant_roar02.wav", "Roar 2"}
	}
}

-- Antlion sound data
GM.SoundData[19] = {
	name = "Antlion",
	perm = PERM_ANTLION,
	sounds = {
		{"npc/antlion/idle1.wav", "Idle 1"},
		{"npc/antlion/idle2.wav", "Idle 2"},
		{"npc/antlion/idle3.wav", "Idle 3"},
		{"npc/antlion/idle4.wav", "Idle 4"},
		{"npc/antlion/idle5.wav", "Idle 5"}
	}
}

-- Scanner sound data
GM.SoundData[20] = {
	name = "Scanner",
	perm = PERM_SCANNER,
	sounds = {
		{{"npc/scanner/", "$scannerScan"}, "Scan"},
		{{"npc/scanner/", "$scannerAltScan"}, "Scan 2"},
		{"npc/scanner/scanner_blip1.wav", "Blip"}
	}
}

function GM:CanPlaySound(ply, data)
	local perm = data.perm

	if perm and ply:CharFlags():len() > 0 and perm:find(ply:CharFlags()) then
		return true
	end

	return false
end