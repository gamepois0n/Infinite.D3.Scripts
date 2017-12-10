SNOGroups = {}
SNOGroups.MonsterDefinitions = Infinity.D3.SNOGroups.GetMonsterDefinitions()
SNOGroups.GlobalsDefinitions = Infinity.D3.SNOGroups.GetGlobalsDefinitions()
--SNOGroups.SceneDefinitions = Infinity.D3.SNOGroups.GetSceneDefinitions()

function SNOGroups.DumpToFile(table, filename)
    local json = JSON:new()
    Infinity.FileSystem.WriteFile(filename, json:encode_pretty(table))
end

function SNOGroups.GetMonsterDefByActorSNO(actorSNO)
	local mDef = SNOGroups.MonsterDefinitions[actorSNO]

	if mDef == nil then
		SNOGroups.MonsterDefinitions = Infinity.D3.SNOGroups.GetMonsterDefinitions()

		mDef = SNOGroups.MonsterDefinitions[actorSNO]
	end

	return mDef
end

function SNOGroups.GetRiftProgressPercentByPoints(points)
	if SNOGroups.GlobalsDefinitions[1] == nil then
		return 0.0
	end

	return (points / SNOGroups.GlobalsDefinitions[1]:GetMaxRiftPoints()) * 100
end

function SNOGroups.GetMonsterRiftProgressByActorSNO(actorSNO)
	local mDef = SNOGroups.GetMonsterDefByActorSNO(actorSNO)

	if mDef == nil or SNOGroups.GlobalsDefinitions[1] == nil then
		return 0.0
	end
	
	return mDef:GetRiftProgress()
end

function SNOGroups.GetMonsterRiftProgressPercentByActorSNO(actorSNO)
	local mDef = SNOGroups.GetMonsterDefByActorSNO(actorSNO)

	if mDef == nil or SNOGroups.GlobalsDefinitions[1] == nil then
		return 0.0
	end
	
	return (mDef:GetRiftProgress() / SNOGroups.GlobalsDefinitions[1]:GetMaxRiftPoints()) * 100
end