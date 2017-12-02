CombatScript = { }
CombatScript.__index = CombatScript

setmetatable(CombatScript, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CombatScript.new()
	local instance = {}
	local self = setmetatable(instance, CombatScript)
		
	instance.RaiseDead = Skill:new("RaiseDead", 462089)
	instance.BloodRush = Skill:new("BloodRush", 454090)
	instance.Decrepify = Skill:new("Decrepify", 451491)
	instance.Devour = Skill:new("Devour", 460757)
	instance.Devour:SetForcedCooldown(500)
	instance.Simulacrum = Skill:new("Simulacrum", 465350)
	instance.BoneArmor = Skill:new("BoneArmor", 466857)
		
	return self
end

function CombatScript:UseHealthPotion()
	UIInteractionHelper.UseFunctionByName("UI_PotionButton_OnLeftClick")
end

function CombatScript:Defend(player, monsterTarget)	
	if player == nil then
		return
	end

	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end

	if AttributeHelper.GetHitpointPercentage(player) <= 50 then
		self:UseHealthPotion()
	end
end

function CombatScript:Buff(player, monsterTarget)	
	if player == nil then
		return
	end

	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end
	
	table.sort(Combat.Collector.Actors.Monster.All, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)
	table.sort(Combat.Collector.Actors.Corpse, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)

	local all20yards = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.All, 20)
	local all60yards = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.All, 60)

	if table.length(all20yards) >= 10 then
		self.BoneArmor:CastAtLocation(player:GetPosition())
	end
	
	if table.length(Combat.Collector.Actors.Corpse) > 1 then
		self.Devour:CastAtLocation(player:GetPosition())
	end

	local skeletalMages = TargetHelper.FilterACDsByActorSNO(Combat.Collector.Actors.Monster.Pets, 472606)	

	if table.length(skeletalMages) < 10 and (AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Cur, 8) / AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Max_Total, 8)) >= 0.90 and table.length(all60yards) >= 1 then
		self.RaiseDead:CastAtLocation(player:GetPosition())
	end	
end

function CombatScript:Attack(player, monsterTarget)		
	if player == nil then
		return
	end
	
	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end
		
	
end


return CombatScript()