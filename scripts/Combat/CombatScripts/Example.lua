--[[
Example Combat Script 1.0
]]--

CombatScript = { }
CombatScript.__index = CombatScript
CombatScript.InitDone = false -- If you wanna do some Init Loads when the Combat script is loaded u can use this bool to check and to set if your Init is done

setmetatable(CombatScript, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CombatScript.new()
	local instance = {}
	local self = setmetatable(instance, CombatScript)
		
	--[[
		This stuff int this function happens when a new instance of this Combat script is being initialized
		You should use it to set some initial parameters like ActiveSkills, PassiveSkills , ....
	]]--

	instance.ActiveSkills = {} --this is the default table where u can insert your active skills into
	instance.PassiveSkills = {} --this is the default table where u can insert your passive skills into

	-- create a new skill object like this
	instance.Whirlwind = {Name = "Whirlwind", PowerSNO = 96296, Rune = 3, Slot = 0, LastCast = 0, ForcedCooldown = 0}
	-- instance.#### can be anything u like, its the name of the object/variable
	-- Name defines the name of the skill
	-- PowerSNO defines the powerSNO of the skill, use the Inspector to check Skill parameters
	-- Rune defines the rune of the skill, use Inspector for this too
	-- Slot defines the quickslot number of the skill, lmb = 0, rmb = 1, 1 = 2, 2 = 3, 3 = 4, 4 = 5
	-- LastCast can be set to 0 initialy, its just used later on to store last time the skill was used
	-- ForcedCooldown defines a forced time the skill wont be used in ms, so for example when u have a skill which could be used permanently but you just want it to be used min every 2 secs, you set the value to 2000
	
	
	-- table.insert adds the defined object to specified table
	table.insert(instance.ActiveSkills, instance.Whirlwind)
		
	-- this just prints out all skills inside ActiveSkills table to confirm they are all loaded	
	for k,v in pairs(instance.ActiveSkills) do
		print("ActiveSkill " .. v.Name .. " loaded!")
	end

	instance.BoonOfBulKathos = {Name = "BoonOfBulKathos", PowerSNO = 204603, Slot = 0}
	-- a bit less Parameters for Passive Skills but same functionality

	table.insert(instance.PassiveSkills, instance.BoonOfBulKathos)
	
	for k,v in pairs(instance.PassiveSkills) do
		print("PassiveSkill " .. v.Name .. " loaded!")
	end

	return self
end

-- !!! DO NOT CHANGE THIS FUNCTION UNTIL YOU KNOW WHAT YOU DO !!!
function CombatScript:IsUsableSkill(skill) -- this function just checks if a passed skill is usable
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

-- !!! DO NOT CHANGE THIS FUNCTION UNTIL YOU KNOW WHAT YOU DO !!!
function CombatScript:UseSkill(skill, targetPosition)-- call this function and pass a skill like self.WhirlWind and a targetPosition like acd:GetPosition()
	if not self:IsUsableSkill(skill) then
		return false
	end

	Infinity.D3.CastPowerAtLocation(skill.PowerSNO, targetPosition)
		
	skill.LastCast = Infinity.Win32.GetTickCount()

	return true
end

-- !!! DO NOT CHANGE THIS FUNCTION UNTIL YOU KNOW WHAT YOU DO !!!
function CombatScript:UseSkillAtCursorLocation(skill)-- call this function and pass a skill like self.WhirlWind
	if not self:IsUsableSkill(skill) then
		return false
	end

	Infinity.D3.CastPowerAtCursorLocation(skill.PowerSNO)
	
	skill.LastCast = Infinity.Win32.GetTickCount()

	return true
end

-- !!! DO NOT CHANGE THIS FUNCTION UNTIL YOU KNOW WHAT YOU DO !!!
function CombatScript:UseHealthPotion()-- call this function to use your HealthPotion
	UIInteractionHelper.UseFunctionByName("UI_PotionButton_OnLeftClick")
end

function CombatScript:Init(player)-- this function gets called once per OnPulse tick which is 10 times per sec, it receives localACD(ActorCommonData) as player
	
end

function CombatScript:Defend(player, monsterTarget, actors)
--[[
	this function gets called once per OnPulse tick which is 10 times per sec
	(ActorCommonData) as player
	(ActorCommonData) as monsterTarget
	(map<int, ActorCommonData>) as actors , iterate this with (for k,v in pairs(actors) do ... end) where v is the ActorCommonData
]]--
	if player == nil then -- player nil checkup
		return
	end

	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then -- player inTown and isTeleporting checkup
		return
	end

	if AttributeHelper.GetHitpointPercentage(player) <= 50 then -- sample HealthPotion Use condition
		self:UseHealthPotion()
	end	
end

function CombatScript:Buff(player, monsterTarget, actors)
--[[
	this function gets called once per OnPulse tick which is 10 times per sec
	(ActorCommonData) as player
	(ActorCommonData) as monsterTarget
	(map<int, ActorCommonData>) as actors , iterate this with (for k,v in pairs(actors) do ... end) where v is the ActorCommonData
]]--	
	if player == nil then
		return
	end

	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end	
end

function CombatScript:Attack(player, monsterTarget, actors)
--[[
	this function gets called once per OnPulse tick which is 10 times per sec
	(ActorCommonData) as player
	(ActorCommonData) as monsterTarget
	(map<int, ActorCommonData>) as actors , iterate this with (for k,v in pairs(actors) do ... end) where v is the ActorCommonData
]]--		
	if player == nil then
		return
	end
	
	if AttributeHelper.IsInTown(player) or AttributeHelper.IsTeleportingTown(player) then
		return
	end

	-- this condition automatically uses the given skill at monsterTarget:GetPosition() if the monsterTarget is Monster and Quality is Boss
	if monsterTarget ~= nil and monsterTarget:GetActorType() == Enums.ActorType.Monster and monsterTarget:GetMonsterQuality() == Boss then			
		self:UseSkill(self.Whirlwind, monsterTarget:GetPosition())
	end
		
	-- this condition automatically uses the given skill at cursor location when Space is pressed	
	if InputHelper.IsSpacePressed() then
		self:UseSkillAtCursorLocation(self.Whirlwind)
	end
end

-- !!! DO NOT CHANGE THIS UNTIL YOU KNOW WHAT YOU DO !!!
return CombatScript()