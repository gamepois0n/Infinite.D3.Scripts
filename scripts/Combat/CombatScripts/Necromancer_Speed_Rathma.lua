--[[
AUTHOR		R3p
]]--


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

function CombatScript:Defend(player, monsterTarget, isMoving)		
	if AttributeHelper.GetHitpointPercentage(player) <= 50 then
		self:UseHealthPotion()
	end
end

function CombatScript:Buff(player, monsterTarget, isMoving)	
	local elitesleadersTable = Combat.Collector.Actors.Monster.ElitesLeaders
	local allTable = Combat.Collector.Actors.Monster.All

	table.sort(allTable, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)
	table.sort(elitesleadersTable, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)
	
	local all20yards = TargetHelper.GetACDsAroundLocalPlayer(allTable, 20)
	local all60yards = TargetHelper.GetACDsAroundLocalPlayer(allTable, 60)
	local elites60yards = TargetHelper.GetACDsAroundLocalPlayer(elitesleadersTable, 60)

	if table.length(all20yards) >= 10 then
		self.BoneArmor:CastAtLocation(player:GetPosition())
	end
	
	if Infinity.D3.GetAcdContainerSizeByName("Actors.Corpse") > 1 or AttributeHelper.IsBuffActive(player, 465839) then
		self.Devour:CastAtLocation(player:GetPosition())
	end

	local skeletalMages = TargetHelper.FilterACDsByActorSNO(Combat.Collector.Actors.Monster.Pets, 472606)	

	if table.length(elites60yards) == 0 then
		if table.length(skeletalMages) < 10 and AttributeHelper.GetPrimaryResourcePercentage(player) >= 90 and table.length(all60yards) >= 1 then
			self.RaiseDead:CastAtLocation(player:GetPosition())
		end	
	else
		if AttributeHelper.GetPrimaryResourcePercentage(player) >= 90 then
			self.RaiseDead:CastAtLocation(elites60yards[1]:GetPosition())
		end	
	end
end

function CombatScript:Attack(player, monsterTarget, isMoving)		
	
end


return CombatScript()