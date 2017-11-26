CombatScript = { }
CombatScript.__index = CombatScript
CombatScript.InitDone = false

setmetatable(CombatScript, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CombatScript.new()
	local instance = {}
	local self = setmetatable(instance, CombatScript)
		
	instance.ActiveSkills = {}
	instance.PassiveSkills = {}

	instance.Whirlwind = {Name = "Whirlwind", PowerSNO = 96296, Rune = 3, Slot = 0, LastCast = 0, ForcedCooldown = 0}
	instance.BattleRage = {Name = "BattleRage", PowerSNO = 79076, Rune = 2, Slot = 1, LastCast = 0, ForcedCooldown = 0}
	instance.WoTB = {Name = "WoTB", PowerSNO = 79607, Rune = 0, Slot = 2, LastCast = 0, ForcedCooldown = 0}
	instance.WarCry = {Name = "WarCry", PowerSNO = 375483, Rune = 2, Slot = 3, LastCast = 0, ForcedCooldown = 0}
	instance.Sprint = {Name = "Sprint", PowerSNO = 78551, Rune = 4, Slot = 5, LastCast = 0, ForcedCooldown = 0}
	instance.FuriousCharge = {Name = "FuriousCharge", PowerSNO = 97435, Rune = 2, Slot = 4, LastCast = 0, ForcedCooldown = 2000}
	
	table.insert(instance.ActiveSkills, instance.Whirlwind)
	table.insert(instance.ActiveSkills, instance.BattleRage)
	table.insert(instance.ActiveSkills, instance.WoTB)
	table.insert(instance.ActiveSkills, instance.WarCry)
	table.insert(instance.ActiveSkills, instance.Sprint)
	table.insert(instance.ActiveSkills, instance.FuriousCharge)
	
	for k,v in pairs(instance.ActiveSkills) do
		print("ActiveSkill " .. v.Name .. " loaded!")
	end

	instance.BoonOfBulKathos = {Name = "BoonOfBulKathos", PowerSNO = 204603, Slot = 0}
	instance.Ruthless = {Name = "Ruthless", PowerSNO = 205175, Slot = 1}
	instance.Rampage = {Name = "Rampage", PowerSNO = 296572, Slot = 2}
	instance.BerserkerRage = {Name = "BerserkerRage", PowerSNO = 205187, Slot = 3}

	table.insert(instance.PassiveSkills, instance.BoonOfBulKathos)
	table.insert(instance.PassiveSkills, instance.Ruthless)
	table.insert(instance.PassiveSkills, instance.Rampage)
	table.insert(instance.PassiveSkills, instance.BerserkerRage)

	for k,v in pairs(instance.PassiveSkills) do
		print("PassiveSkill " .. v.Name .. " loaded!")
	end

	return self
end

function CombatScript:IsUsableSkill(skill)
	if SkillHelper.GetActiveSkill(skill.PowerSNO) ~= nil and not SkillHelper.IsOnCooldown(skill.PowerSNO) then		
		if skill.ForcedCooldown > 0 then
			if skill.LastCast + skill.ForcedCooldown < Infinity.Win32.GetTickCount() then				
				return true
			else
				return false
			end
		else
			return true
		end

		return true
	end

	return false
end

function CombatScript:UseSkill(skill, targetPosition)
	if not self:IsUsableSkill(skill) then
		return false
	end

	Infinity.D3.CastPowerAtLocation(skill.PowerSNO, targetPosition)
		
	skill.LastCast = Infinity.Win32.GetTickCount()

	return true
end

function CombatScript:UseSkillAtCursorLocation(skill)
	if not self:IsUsableSkill(skill) then
		return false
	end

	Infinity.D3.CastPowerAtCursorLocation(skill.PowerSNO)
	
	skill.LastCast = Infinity.Win32.GetTickCount()

	return true
end

function CombatScript:UseHealthPotion()
	UIInteractionHelper.UseFunctionByName("UI_PotionButton_OnLeftClick")
end

function CombatScript:Init(player)
	if not AttributeHelper.IsInTown(player) then
		print("CombatScript Init failed cause player is not in town!")
		self.InitDone = true
		return
	end

	for k,v in pairs(self.ActiveSkills) do
		SkillHelper.ChangeActiveSkill(v.Slot, v.PowerSNO, v.Rune)
	end

	for k,v in pairs(self.PassiveSkills) do
		SkillHelper.ChangePassiveSkill(v.Slot, v.PowerSNO)
	end

	print("CombatScript Init done!")
	self.InitDone = true
end

function CombatScript:Defend(player, monsterTarget, actors)	
	if player == nil then
		return
	end

	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end

	if AttributeHelper.GetHitpointPercentage(player) <= 50 then
		self:UseHealthPotion()
	end

	--[[if AttributeHelper.GetHitpointPercentage(player) <= 30 and not AttributeHelper.IsBuffActive(player, self.IgnorePain.PowerSNO) then
		self:UseSkill(self.IgnorePain, player:GetPosition())
	end]]--
end

function CombatScript:Buff(player, monsterTarget, actors)	
	if player == nil then
		return
	end

	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end

	local nearby = TargetHelper.GetMonsterCountAroundLocalPlayer(25)

	if not AttributeHelper.IsBuffActive(player, self.BattleRage.PowerSNO) then
		self:UseSkill(self.BattleRage, player:GetPosition())
	end

	if not AttributeHelper.IsBuffActive(player, self.WarCry.PowerSNO) then
		self:UseSkill(self.WarCry, player:GetPosition())
	end

	if not AttributeHelper.IsBuffActive(player, self.WoTB.PowerSNO) and nearby >= 1 then
		self:UseSkill(self.WoTB, player:GetPosition())
	end

	--[[if nearby >= 1 then			
		self:UseSkill(self.ThreateningShout, player:GetPosition())
	end]]--

	if not AttributeHelper.IsBuffActive(player, self.Sprint.PowerSNO) then
		self:UseSkill(self.Sprint, player:GetPosition())
	end	
end

function CombatScript:Attack(player, monsterTarget, actors)		
	if player == nil then
		return
	end
	
	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end
	
	if monsterTarget ~= nil and monsterTarget:GetActorType() == Enums.ActorType.Monster and monsterTarget:GetMonsterQuality() == Boss then			
		self:UseSkill(self.Whirlwind, monsterTarget:GetPosition())
	end
	
	if monsterTarget ~= nil and AttributeHelper.GetSkillCharges(player, self.FuriousCharge.PowerSNO) >= 1 then			
		self:UseSkill(self.FuriousCharge, monsterTarget:GetPosition())
	end

	if InputHelper.IsSpacePressed() then
		self:UseSkillAtCursorLocation(self.Whirlwind)
	end
end


return CombatScript()