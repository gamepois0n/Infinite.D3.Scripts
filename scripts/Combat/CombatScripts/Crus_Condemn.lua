--[[
AUTHOR		Pete
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

	instance.Slash = Skill:new("Slash", 289243)--, Rune = 0, Slot = 0, LastCast = 0, ForcedCooldown = 250}
	instance.IronSkin = Skill:new("IronSkin", 291804)--, Rune = 4, Slot = 1, LastCast = 0, ForcedCooldown = 0}
	instance.IronSkin:SetForcedCooldown(500)
	instance.Condemn = Skill:new("Condemn", 266627)--, Rune = 1, Slot = 2, LastCast = 0, ForcedCooldown = 0}
	instance.LawsOfHope = Skill:new("LawsOfHope", 342279)--, Rune = 0, Slot = 3, LastCast = 0, ForcedCooldown = 0}
	instance.LawsOfHope:SetForcedCooldown(500)
	instance.Provoke = Skill:new("Provoke", 290545)--, Rune = 4, Slot = 5, LastCast = 0, ForcedCooldown = 0}
	instance.Provoke:SetForcedCooldown(500)
	instance.AkaratsChamp = Skill:new("AkaratsChampion", 269032)--, Rune = 2, Slot = 4, LastCast = 0, ForcedCooldown = 0}
	instance.AkaratsChamp:SetForcedCooldown(500)
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
	table.sort(Combat.Collector.Actors.Monster.All, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)
	table.sort(Combat.Collector.Actors.Monster.ElitesLeaders, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)
	table.sort(Combat.Collector.Actors.Monster.Boss, function(a, b) return a:GetPosition():GetDistanceFromMe() < b:GetPosition():GetDistanceFromMe() end)

	local all10yards = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.All, 10)
	local all15yards = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.All, 15)
	local all60yards = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.All, 60)
	local elites10yards = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.ElitesLeaders, 10)
	local elites15yards = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.ElitesLeaders, 15)
	local elites60yards = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.ElitesLeaders, 60)
	local boss60yards = TargetHelper.GetACDsAroundLocalPlayer(Combat.Collector.Actors.Monster.Boss, 60)

	
	if not AttributeHelper.IsBuffActive(player, self.AkaratsChamp.PowerSNO) then
		self.AkaratsChamp:CastAtLocation(player:GetPosition())
	end

	if not AttributeHelper.IsBuffActive(player, self.LawsOfHope.PowerSNO) then
		self.LawsOfHope:CastAtLocation(player:GetPosition())
	end

	local hpplay = AttributeHelper.GetHitpointPercentage(player)
	local rescur = AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Cur, 7)
	local resmax = AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Max, 7)
	local resgaibonus = AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Gain_Bonus_Percent, 7)
	resgaibonus = resgaibonus > 0 and resgaibonus or 0
	local reshexmalus = AttributeHelper.GetAttributeValue(player, 1288, 318817)	-- hexing pants Item_Power_Passive
	local reshexstand = AttributeHelper.GetAttributeValue(player, 763, 318817)	-- hexing pants "standing"
	resgaihex = reshexstand > 0 and reshexmalus or 0
	local resgai = 1 + resgaibonus - resgaihex
	local resred = AttributeHelper.GetAttributeValue(player, Enums.AttributeId.Resource_Cost_Reduction_Percent_All, -1)
	
	if table.length(boss60yards) >= 1 then
		self.IronSkin:CastAtLocation(player:GetPosition())
	elseif table.length(all60yards) >= 1 and hpplay < 80 then
		self.IronSkin:CastAtLocation(player:GetPosition())
	end

	if table.length(elites10yards) >= 1 or table.length(all10yards) >= 4 then
		self.Provoke:CastAtLocation(player:GetPosition())
	elseif rescur + 30*resgai < resmax then
		self.Provoke:CastAtLocation(player:GetPosition())
	end
	
	if table.length(all15yards) >= 1 and rescur >= 40*(1-resred) then
		self.Condemn:CastAtLocation(player:GetPosition())
	elseif (table.length(elites15yards) >= 1 or table.length(all15yards) >= 4) and rescur >= 2*40*(1-resred) then
		self.Condemn:CastAtLocation(player:GetPosition())
	elseif AttributeHelper.GetPrimaryResourcePercentage(player) > 80 then
		self.Condemn:CastAtLocation(player:GetPosition())
	end
end

function CombatScript:Attack(player, monsterTarget, isMoving)
	if monsterTarget ~= nil and monsterTarget:GetActorType() == Enums.ActorType.Monster then
--		self.Slash:CastAtLocation(monsterTarget:GetPosition())
	end
end


return CombatScript()
