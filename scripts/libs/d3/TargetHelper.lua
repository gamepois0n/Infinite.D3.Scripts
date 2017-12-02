TargetHelper = {}

function TargetHelper.GetMonsterTargetACD()
	local acds = Infinity.D3.GetACDList()
	local tActorId = Infinity.D3.GetTargetActorId()

	if tActorId == -1 then
		return nil
	end

	local target = acds[tActorId]

	if target == nil then
		return nil
	end

	if target:GetActorType() == Enums.ActorType.Monster and target:GetMonsterQuality() >= 0 then
		return target
	else
		return nil
	end	
end

function TargetHelper.GetMonsterCountAroundTarget(radius)
	local target = TargetHelper.GetTargetACD()

	local nearby = {}

	if target == nil then
		return 0
	end

	for k,v in pairs(Infinity.D3.GetACDList()) do
		if v:GetActorId() ~= -1 and v:GetActorType() == Enums.ActorType.Monster then
			if v:GetPosition():GetDistance(target:GetPosition()) <= radius then
				table.insert(nearby, v)
			end
		end
	end

	return table.length(nearby)
end

function TargetHelper.GetMonsterCountAroundLocalPlayer(radius)	
	local nearby = {}

	for k,v in pairs(Infinity.D3.GetACDList()) do
		if v:GetActorId() ~= -1 and v:GetActorType() == Enums.ActorType.Monster and v:GetMonsterQuality() >= 0 then
			if v:GetPosition():GetDistanceFromMe() <= radius then
				table.insert(nearby, v)
			end
		end
	end

	return table.length(nearby)
end

function TargetHelper.GetACDsAroundLocalPlayer(acdtable, radius)	
	local nearby = {}

	for k,v in pairs(acdtable) do
		if v:GetPosition():GetDistanceFromMe() <= radius then
			table.insert(nearby, v)
		end
	end

	return nearby
end

function TargetHelper.FilterACDsByActorSNO(acdtable, actorsno)	
	local acds = {}

	for k,v in pairs(acdtable) do
		if v:GetActorSNO() == actorsno then
			table.insert(acds, v)
		end
	end

	return acds
end

function TargetHelper.GetMonstersAroundLocalPlayer(radius, outNormal, outElite, outMinion, outBoss, outGoblin)	
	for k,v in pairs(Infinity.D3.GetACDList()) do
		if v:GetActorId() ~= -1 and v:GetActorType() == Enums.ActorType.Monster then
			if v:GetPosition():GetDistanceFromMe() <= radius then
				if AttributeHelper.IsGoblin(v) then
					table.insert(outGoblin, v)
				elseif v:GetMonsterQuality() == Normal then
					table.insert(outNormal, v)
				elseif v:GetMonsterQuality() == Champion or v:GetMonsterQuality() == Rare or v:GetMonsterQuality() == Unique then
					table.insert(outElite, v)
				elseif v:GetMonsterQuality() == Minion then
					table.insert(outMinion, v)
				elseif v:GetMonsterQuality() == Boss then
					table.insert(outBoss, v)
				end	
			end
		end
	end
	return
end

function TargetHelper.GetClosestTarget(radius)	
	local closest = nil
	local lastDist = 100000

	for k,v in pairs(Infinity.D3.GetACDList()) do
		if v:GetActorId() ~= -1 and v:GetActorType() == Enums.ActorType.Monster and v:GetMonsterQuality() >= 0 then
			local dist = v:GetPosition():GetDistanceFromMe()

			if dist <= radius and dist < lastDist then
				lastDist = dist
				closest = v
			end
		end
	end

	return closest
end