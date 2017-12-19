Collector = { }
Collector.__index = Collector

setmetatable(Collector, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Collector.new()
    local self = setmetatable({}, Collector)

    self.ClientRect = nil
    self.CurrentGameTick = 0
    self.LocalACD = nil
    self.LevelAreaSNO = 0
    self.WorldId = 0
    self.MonsterRiftProgress = 0.0

    self.NavMesh = nil
    self.NavMeshCells = {}

    self.LocalAttributes = {}
    self.LocalAttributes.All = {}
    self.LocalAttributes.BuffCount = {}
    self.LocalAttributes.BuffStartTick = {}
    self.LocalAttributes.BuffEndTick = {}

    self.PlayerData = {}
    self.PlayerData.All = {}
    self.PlayerData.Others = {}
    self.PlayerData.OthersCount = 0

    self.Actors = {}
    self.Actors.All = {}
    self.Actors.Monster = {}
    self.Actors.Item = {}    
    self.Actors.GroundEffect = {}
    self.Actors.Pylon = {}
    self.Actors.Shrine = {}

    self.Actors.Monster.All = {}
    self.Actors.Monster.Normal = {}
    self.Actors.Monster.Champion = {}
    self.Actors.Monster.Minion = {}
    self.Actors.Monster.Rare = {}
    self.Actors.Monster.Unique = {}
    self.Actors.Monster.Boss = {}
    self.Actors.Monster.Goblin = {}
    self.Actors.Monster.Elites = {}
    self.Actors.Monster.ElitesLeaders = {}
    self.Actors.Monster.Pets = {}

    self.Actors.Player = {}
    
    self.Actors.Corpse = {}

    self.Actors.Marker = {}

    self.Actors.Item.All = {}
    self.Actors.Item.Ground = {}
    self.Actors.Item.Backpack = {}
    self.Actors.Item.RiftProgress = {}

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

    self.Actors.Pylon.SpawnMarker = {}
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
    self.NavMeshCells = {}

    self.MonsterRiftProgress = 0.0

    self.LocalAttributes.All = {}
    self.LocalAttributes.BuffCount = {}
    self.LocalAttributes.BuffStartTick = {}
    self.LocalAttributes.BuffEndTick = {}

    self.PlayerData.All = {}
    self.PlayerData.Others = {}
    self.PlayerData.OthersCount = 0

    self.Actors.All = {}

    self.Actors.Monster.All = {}
    self.Actors.Monster.Normal = {}
    self.Actors.Monster.Champion = {}
    self.Actors.Monster.Minion = {}
    self.Actors.Monster.Rare = {}
    self.Actors.Monster.Unique = {}
    self.Actors.Monster.Boss = {}
    self.Actors.Monster.Goblin = {}
    self.Actors.Monster.Elites = {}
    self.Actors.Monster.ElitesLeaders = {}
    self.Actors.Monster.Pets = {}

    self.Actors.Player = {}

    self.Actors.Corpse = {}
    
    self.Actors.Marker = {}

    self.Actors.Item.All = {}
    self.Actors.Item.Ground = {}
    self.Actors.Item.Backpack = {}
    self.Actors.Item.RiftProgress = {}

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

    self.Actors.Pylon.SpawnMarker = {}
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

function Collector:GetActors(getriftprogress)
    for k, acd in pairs(Infinity.D3.GetACDList()) do
        if acd:GetActorId() ~= -1 then
            table.insert(self.Actors.All, acd)

        local aType = acd:GetActorType()

            if aType == Enums.ActorType.Monster then
                local mQuality = acd:GetMonsterQuality()

                if GroundEffectHelper.IsOccuCircle(acd) then
                    table.insert(self.Actors.GroundEffect.OccuCircle, acd)
                elseif AttributeHelper.IsGoblin(acd) then
                    table.insert(self.Actors.Monster.Goblin, acd)
                    table.insert(self.Actors.Monster.All, acd)
                    table.insert(self.Actors.Monster.Elites, acd)
                    table.insert(self.Actors.Monster.ElitesLeaders, acd)

                    if getriftprogress == true and acd:GetPosition():GetDistance(self.LocalACD:GetPosition()) <= 60 then
                        self.MonsterRiftProgress = self.MonsterRiftProgress + SNOGroups.GetMonsterRiftProgressByActorSNO(acd:GetActorSNO())
                    end
                elseif mQuality == Normal and not AttributeHelper.IsNPC(acd) and not AttributeHelper.IsPet(acd) then
                    table.insert(self.Actors.Monster.Normal, acd)
                    table.insert(self.Actors.Monster.All, acd)

                    if getriftprogress == true and acd:GetPosition():GetDistance(self.LocalACD:GetPosition()) <= 60 then
                        self.MonsterRiftProgress = self.MonsterRiftProgress + SNOGroups.GetMonsterRiftProgressByActorSNO(acd:GetActorSNO())
                    end
                elseif mQuality == Normal and AttributeHelper.IsPet(acd) then
                    table.insert(self.Actors.Monster.Pets, acd)
                    table.insert(self.Actors.Monster.All, acd)
                elseif mQuality == Champion then
                    table.insert(self.Actors.Monster.Champion, acd)
                    table.insert(self.Actors.Monster.All, acd)
                    table.insert(self.Actors.Monster.Elites, acd)
                    table.insert(self.Actors.Monster.ElitesLeaders, acd)

                    if getriftprogress == true and acd:GetPosition():GetDistance(self.LocalACD:GetPosition()) <= 60 then
                        self.MonsterRiftProgress = self.MonsterRiftProgress + SNOGroups.GetMonsterRiftProgressByActorSNO(acd:GetActorSNO())
                    end
                elseif mQuality == Minion then
                    table.insert(self.Actors.Monster.Minion, acd)
                    table.insert(self.Actors.Monster.All, acd)
                    table.insert(self.Actors.Monster.Elites, acd)

                    if getriftprogress == true and acd:GetPosition():GetDistance(self.LocalACD:GetPosition()) <= 60 then
                        self.MonsterRiftProgress = self.MonsterRiftProgress + SNOGroups.GetMonsterRiftProgressByActorSNO(acd:GetActorSNO())
                    end
                elseif mQuality == Rare then
                    table.insert(self.Actors.Monster.Rare, acd)
                    table.insert(self.Actors.Monster.All, acd)
                    table.insert(self.Actors.Monster.Elites, acd)
                    table.insert(self.Actors.Monster.ElitesLeaders, acd)

                    if getriftprogress == true and acd:GetPosition():GetDistance(self.LocalACD:GetPosition()) <= 60 then
                        self.MonsterRiftProgress = self.MonsterRiftProgress + SNOGroups.GetMonsterRiftProgressByActorSNO(acd:GetActorSNO())
                    end
                elseif mQuality == Unique then
                    table.insert(self.Actors.Monster.Unique, acd)
                    table.insert(self.Actors.Monster.All, acd)
                    table.insert(self.Actors.Monster.Elites, acd)
                    table.insert(self.Actors.Monster.ElitesLeaders, acd)

                    if getriftprogress == true and acd:GetPosition():GetDistance(self.LocalACD:GetPosition()) <= 60 then
                        self.MonsterRiftProgress = self.MonsterRiftProgress + SNOGroups.GetMonsterRiftProgressByActorSNO(acd:GetActorSNO())
                    end
                elseif mQuality == Boss then          
                    table.insert(self.Actors.Monster.Boss, acd)
                    table.insert(self.Actors.Monster.All, acd)
                end
            elseif aType == Enums.ActorType.Gizmo then

                if acd:GetGizmoType() == 84 then
                    table.insert(self.Actors.Corpse, acd)
                elseif  AttributeHelper.IsPowerPylon(acd) then
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

                if AttributeHelper.IsPylonSpawnMarker(acd) then
                    table.insert(self.Actors.Pylon.SpawnMarker, acd)
                elseif  GroundEffectHelper.IsPlagued(acd) then
                    table.insert(self.Actors.GroundEffect.Plagued, acd)
                elseif GroundEffectHelper.IsDesecrator(acd) then
                    table.insert(self.Actors.GroundEffect.Desecrator, acd)
                elseif GroundEffectHelper.IsPoisonEnchanted(acd) then
                    table.insert(self.Actors.GroundEffect.PoisonEnchanted, acd)
                elseif GroundEffectHelper.IsMolten(acd) then
                    table.insert(self.Actors.GroundEffect.Molten, acd)
                elseif GroundEffectHelper.IsMortar(acd) then
                    table.insert(self.Actors.GroundEffect.Mortar, acd)                
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
                table.insert(self.Actors.Item.All, acd)

                if AttributeHelper.IsRiftProgressOrb(acd) then
                    table.insert(self.Actors.Item.RiftProgress, acd)

                    if getriftprogress == true and acd:GetPosition():GetDistance(self.LocalACD:GetPosition()) <= 60 then
                        self.MonsterRiftProgress = self.MonsterRiftProgress + 6.5
                    end
                elseif acd:GetItemLocation() == -1 then
                    table.insert(self.Actors.Item.Ground, acd)
                elseif acd:GetItemLocation() == 0 then
                    table.insert(self.Actors.Item.Backpack, acd)
                end
            end
        end
    end
end

function Collector:GetClientRect()
    self.ClientRect = Infinity.D3.GetClientRect()
end

function Collector:GetTicks()
    self.CurrentGameTick = Infinity.D3.GetGameTick()
end

function Collector:GetLocalAttributes()
    if self.LocalACD == nil or self.LocalACD.Address == 0 then
        return
    end

    local attributes = self.LocalACD:GetAttributes()

    for k,v in pairs(attributes) do
        local attribDescriptor = AttributeHelper.AttributeDescriptors[v:GetId()]

        if attribDescriptor ~= nil then
            local value = v:GetValueInt32()

            if attribDescriptor:GetDataType() == 0 then
                value = v:GetValueFloat()
            end

            if value > 0 then
                local powerName = AttributeHelper.PowerSNOs[v:GetModifier()]

                if v:GetModifier() == -1 or powerName == nil then
                  powerName = ""
              end

              table.insert(self.LocalAttributes.All, {Address = v.Address, AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})           

              if v:GetModifier() ~= -1 and v:GetId() >= Enums.AttributeId.Buff_Icon_Count0 and v:GetId() <= Enums.AttributeId.Buff_Icon_Count31 then 
                table.insert(self.LocalAttributes.BuffCount, {Address = v.Address, AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})
                elseif v:GetModifier() ~= -1 and v:GetId() >= Enums.AttributeId.Buff_Icon_Start_Tick0 and v:GetId() <= Enums.AttributeId.Buff_Icon_Start_Tick31 then
                    table.insert(self.LocalAttributes.BuffStartTick, {Address = v.Address, AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})
                    elseif v:GetModifier() ~= -1 and v:GetId() >= Enums.AttributeId.Buff_Icon_End_Tick0 and v:GetId() <= Enums.AttributeId.Buff_Icon_End_Tick31 then
                        table.insert(self.LocalAttributes.BuffEndTick, {Address = v.Address, AttributeId = v:GetId(), AttributeName = attribDescriptor:GetName(), PowerSNO = v:GetModifier(), PowerName = powerName, Value = value})
                    end 
                end
            end
        end
    end

function Collector:GetLocalACD()
    self.LocalACD = Infinity.D3.GetLocalACD()
end

function Collector:GetLevelArea()
    self.LevelAreaSNO = Infinity.D3.GetCurrentLevelAreaSNO()
    self.WorldId = Infinity.D3.GetWorldId()
end

function Collector:GetNavMesh()
    if self.NavMesh == nil then
        self.NavMesh = Infinity.D3.NavMesh()
    end

    self.NavMeshCells = self.NavMesh:GetNavMeshCells()
end

function Collector:GetPlayers()
    self.PlayerData.All = Infinity.D3.GetPlayers()

    for k,playerdata in pairs(self.PlayerData.All) do
      local acd = Infinity.D3.GetACDbyACDId(playerdata:GetACDId())

        if acd.Address ~= 0 then
            if acd:GetActorId() ~= self.LocalACD:GetActorId() then
                table.insert(self.PlayerData.Others, playerdata)
                self.PlayerData.OthersCount = self.PlayerData.OthersCount + 1
            end
        end
    end
end

function Collector:InitReloads()
    UIControlHelper.Reload()
end

function Collector:Collect(getLocalAttributes, getriftprogress, getnavmesh)
    if getnavmesh == nil then
        getnavmesh = false
    end

    self:InitReloads()

    self:ClearTables()

    self:GetLocalACD()

    self:GetLevelArea()

    if getriftprogress == true then
        if AttributeHelper.IsInGreaterRift(self.LocalACD) == false then
            getriftprogress = false
        end
    end

    self:GetPlayers()

    self:GetActors(getriftprogress)
    
    if getLocalAttributes == true then
        self:GetLocalAttributes()
    end

    self:GetClientRect()
    self:GetTicks()

    if getnavmesh == true then
        self:GetNavMesh()
    end
end