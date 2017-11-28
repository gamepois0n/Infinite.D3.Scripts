Collector = { }
Collector.__index = Collector

setmetatable(Collector, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Collector.new()
    local self = setmetatable({}, Collector)

    self.Actors = {}
    self.Actors.Monster = {}
    self.Actors.Item = {}
    self.Actors.GroundEffect = {}
    self.Actors.Pylon = {}
    self.Actors.Shrine = {}

    self.Actors.Monster.Normal = {}
    self.Actors.Monster.Champion = {}
    self.Actors.Monster.Minion = {}
    self.Actors.Monster.Rare = {}
    self.Actors.Monster.Unique = {}
    self.Actors.Monster.Boss = {}
    self.Actors.Monster.Goblin = {}

    self.Actors.Player = {}
    
    self.Actors.Item.Ground = {}
    
    self.Actors.GroundEffect.Plagued = {}
    self.Actors.GroundEffect.Desecrator = {}
    self.Actors.GroundEffect.PoisonEnchanted = {}
    self.Actors.GroundEffect.Molten = {}
    self.Actors.GroundEffect.Mortar = {}
    self.Actors.GroundEffect.OccuCircle = {}
    self.Actors.GroundEffect.Frozen = {}
    self.Actors.GroundEffect.Wormwhole = {}
    self.Actors.GroundEffect.Arcane = {}
    self.Actors.GroundEffect.FrozenPulse = {}
    self.Actors.GroundEffect.Orbiter = {}
    self.Actors.GroundEffect.Thunderstorm = {}

    self.Actors.Pylon.Power = {}
    self.Actors.Pylon.Conduit = {}
    self.Actors.Pylon.Channeling = {}
    self.Actors.Pylon.Shield = {}
    self.Actors.Pylon.Speed = {}

    self.Actors.Shrine.Protection = {}
    self.Actors.Shrine.Enlightened = {}
    self.Actors.Shrine.Fortune = {}
    self.Actors.Shrine.Frenzied = {}
    self.Actors.Shrine.Fleeting = {}
    self.Actors.Shrine.Empowered = {}
    self.Actors.Shrine.Bandit = {}

    return self
end

function Collector:ClearTables()
    self.Actors.Monster.Normal = {}
    self.Actors.Monster.Champion = {}
    self.Actors.Monster.Minion = {}
    self.Actors.Monster.Rare = {}
    self.Actors.Monster.Unique = {}
    self.Actors.Monster.Boss = {}
    self.Actors.Monster.Goblin = {}
    
    self.Actors.Player = {}
    
    self.Actors.Item.Ground = {}

    self.Actors.GroundEffect.Plagued = {}
    self.Actors.GroundEffect.Desecrator = {}
    self.Actors.GroundEffect.PoisonEnchanted = {}
    self.Actors.GroundEffect.Molten = {}
    self.Actors.GroundEffect.Mortar = {}
    self.Actors.GroundEffect.OccuCircle = {}
    self.Actors.GroundEffect.Frozen = {}
    self.Actors.GroundEffect.Wormwhole = {}
    self.Actors.GroundEffect.Arcane = {}
    self.Actors.GroundEffect.FrozenPulse = {}
    self.Actors.GroundEffect.Orbiter = {}
    self.Actors.GroundEffect.Thunderstorm = {}

    self.Actors.Pylon.Power = {}
    self.Actors.Pylon.Conduit = {}
    self.Actors.Pylon.Channeling = {}
    self.Actors.Pylon.Shield = {}
    self.Actors.Pylon.Speed = {}

    self.Actors.Shrine.Protection = {}
    self.Actors.Shrine.Enlightened = {}
    self.Actors.Shrine.Fortune = {}
    self.Actors.Shrine.Frenzied = {}
    self.Actors.Shrine.Fleeting = {}
    self.Actors.Shrine.Empowered = {}
    self.Actors.Shrine.Bandit = {}
end

function Collector:GetActors()
    for k, acd in pairs(Infinity.D3.GetACDList()) do
        if acd:GetActorId() ~= -1 then
        local aType = acd:GetActorType()

            if aType == Enums.ActorType.Monster then
                local mQuality = acd:GetMonsterQuality()

                if AttributeHelper.IsGoblin(acd) then
                    table.insert(self.Actors.Monster.Goblin, acd)
                elseif mQuality == Normal then
                    table.insert(self.Actors.Monster.Normal, acd)
                elseif mQuality == Champion then
                    table.insert(self.Actors.Monster.Champion, acd)
                elseif mQuality == Minion then
                    table.insert(self.Actors.Monster.Minion, acd)
                elseif mQuality == Rare then
                    table.insert(self.Actors.Monster.Rare, acd)
                elseif mQuality == Unique then
                    table.insert(self.Actors.Monster.Unique, acd)
                elseif mQuality == Boss then          
                    table.insert(self.Actors.Monster.Boss, acd)
                end
            elseif aType == Enums.ActorType.Gizmo then

                if  AttributeHelper.IsPowerPylon(acd) then
                    table.insert(self.Actors.Pylon.Power, acd)
                elseif AttributeHelper.IsConduitPylon(acd) then
                    table.insert(self.Actors.Pylon.Conduit, acd)
                elseif AttributeHelper.IsChannelingPylon(acd) then
                    table.insert(self.Actors.Pylon.Channeling, acd)
                elseif AttributeHelper.IsShieldPylon(acd) then
                    table.insert(self.Actors.Pylon.Shield, acd)
                elseif AttributeHelper.IsSpeedPylon(acd) then
                    table.insert(self.Actors.Pylon.Speed, acd)
                elseif AttributeHelper.IsProtectionShrine(acd) then
                    table.insert(self.Actors.Shrine.Protection, acd)
                elseif AttributeHelper.IsEnlightenedShrine(acd) then
                    table.insert(self.Actors.Shrine.Enlightened, acd)
                elseif AttributeHelper.IsFortuneShrine(acd) then
                    table.insert(self.Actors.Shrine.Fortune, acd)
                elseif AttributeHelper.IsFrenziedShrine(acd) then
                    table.insert(self.Actors.Shrine.Frenzied, acd)
                elseif AttributeHelper.IsFleetingShrine(acd) then
                    table.insert(self.Actors.Shrine.Fleeting, acd)
                elseif AttributeHelper.IsEmpoweredShrine(acd) then
                    table.insert(self.Actors.Shrine.Empowered, acd)
                elseif AttributeHelper.IsBanditShrine(acd) then
                    table.insert(self.Actors.Shrine.Bandit, acd)
                end
            elseif aType == Enums.ActorType.ServerProp then

                if  GroundEffectHelper.IsPlagued(acd) then
                    table.insert(self.Actors.GroundEffect.Plagued, acd)
                elseif GroundEffectHelper.IsDesecrator(acd) then
                    table.insert(self.Actors.GroundEffect.Desecrator, acd)
                elseif GroundEffectHelper.IsPoisonEnchanted(acd) then
                    table.insert(self.Actors.GroundEffect.PoisonEnchanted, acd)
                elseif GroundEffectHelper.IsMolten(acd) then
                    table.insert(self.Actors.GroundEffect.Molten, acd)
                elseif GroundEffectHelper.IsMortar(acd) then
                    table.insert(self.Actors.GroundEffect.Mortar, acd)
                elseif GroundEffectHelper.IsOccuCircle(acd) then
                    table.insert(self.Actors.GroundEffect.OccuCircle, acd)
                elseif GroundEffectHelper.IsFrozen(acd) then
                    table.insert(self.Actors.GroundEffect.Frozen, acd)
                elseif GroundEffectHelper.IsWormwhole(acd) then
                    table.insert(self.Actors.GroundEffect.Wormwhole, acd)
                elseif GroundEffectHelper.IsArcane(acd) then
                    table.insert(self.Actors.GroundEffect.Arcane, acd)
                elseif GroundEffectHelper.IsFrozenPulse(acd) then
                    table.insert(self.Actors.GroundEffect.FrozenPulse, acd)
                elseif GroundEffectHelper.IsOrbiter(acd) then
                    table.insert(self.Actors.GroundEffect.Orbiter, acd)
                elseif GroundEffectHelper.IsThunderstorm(acd) then
                    table.insert(self.Actors.GroundEffect.Thunderstorm, acd)
                end
            elseif aType == Enums.ActorType.Environment then
            elseif aType == Enums.ActorType.Critter then
            elseif aType == Enums.ActorType.Player then
                table.insert(self.Actors.Player, acd)
            elseif aType == Enums.ActorType.Item then
                if acd:GetItemLocation() == -1 then
                    table.insert(self.Actors.Item.Ground, acd)
                end
            end
        end
    end
end

function Collector:Collect()
    self:ClearTables()

    self:GetActors()
end