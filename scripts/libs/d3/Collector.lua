Collector = { }
Collector.__index = Collector

setmetatable(Collector, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Collector.new()
    local self = setmetatable({}, Collector)

    self.LastCollect = 0

    self.TotalClock = 0
    self.MaxClock = 0
    self.TotalTicks = 0

    self.ClientRect = nil
    self.CurrentGameTick = 0
    self.LocalACD = nil
    self.LevelAreaSNO = 0
    self.WorldId = 0
    self.MonsterRiftProgress = 0.0

    self.LastWorldId = 0
    self.LastLevelAreaSNO = 0
    self.Scenes = {}
    self.ExitScene = nil
    
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

    self.Actors.WizardMeteor = {}
    self.Actors.WizardMeteor.ArcanePending = {}
    self.Actors.WizardMeteor.ArcaneImpact = {}

    self.Actors.Item.All = {}
    self.Actors.Item.Ground = {}
    self.Actors.Item.Backpack = {}
    self.Actors.Item.Equip = {}
    self.Actors.Item.Stash = {}
    self.Actors.Item.Merchant = {}
    self.Actors.Item.Gamble = {}
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
    self.Actors.GroundEffect.GrotesqueExplosion = {}

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

    self.Actors.PoolOfReflection = {}
        
    return self
end

function Collector:GetTables() 
    self.Actors.All = Infinity.D3.GetAcdContainerByName("Actors.All")

    self.Actors.Monster.All = Infinity.D3.GetAcdContainerByName("Actors.Monster.All")
    self.Actors.Monster.Normal = Infinity.D3.GetAcdContainerByName("Actors.Monster.Normal")
    self.Actors.Monster.Champion = Infinity.D3.GetAcdContainerByName("Actors.Monster.Champion")
    self.Actors.Monster.Minion = Infinity.D3.GetAcdContainerByName("Actors.Monster.Minion")
    self.Actors.Monster.Rare = Infinity.D3.GetAcdContainerByName("Actors.Monster.Rare")
    self.Actors.Monster.Unique = Infinity.D3.GetAcdContainerByName("Actors.Monster.Unique")
    self.Actors.Monster.Boss = Infinity.D3.GetAcdContainerByName("Actors.Monster.Boss")
    self.Actors.Monster.Goblin = Infinity.D3.GetAcdContainerByName("Actors.Monster.Goblin")
    self.Actors.Monster.Elites = Infinity.D3.GetAcdContainerByName("Actors.Monster.Elites")
    self.Actors.Monster.ElitesLeaders = Infinity.D3.GetAcdContainerByName("Actors.Monster.ElitesLeaders")
    self.Actors.Monster.Pets = Infinity.D3.GetAcdContainerByName("Actors.Monster.Pets")
    self.Actors.Player = Infinity.D3.GetAcdContainerByName("Actors.Player")
    
    self.Actors.Corpse = Infinity.D3.GetAcdContainerByName("Actors.Corpse")
    self.Actors.Marker = Infinity.D3.GetAcdContainerByName("Actors.Marker")
    
    self.Actors.WizardMeteor.ArcanePending = Infinity.D3.GetAcdContainerByName("Actors.WizardMeteor.ArcanePending")
    self.Actors.WizardMeteor.ArcaneImpact = Infinity.D3.GetAcdContainerByName("Actors.WizardMeteor.ArcaneImpact")
    self.Actors.Item.All = Infinity.D3.GetAcdContainerByName("Actors.Item.All")
    self.Actors.Item.Ground = Infinity.D3.GetAcdContainerByName("Actors.Item.Ground")
    self.Actors.Item.Backpack = Infinity.D3.GetAcdContainerByName("Actors.Item.Backpack")
    self.Actors.Item.Equip = Infinity.D3.GetAcdContainerByName("Actors.Item.Equip")
    self.Actors.Item.Stash = Infinity.D3.GetAcdContainerByName("Actors.Item.Stash")
    self.Actors.Item.Merchant = Infinity.D3.GetAcdContainerByName("Actors.Item.Merchant")
    self.Actors.Item.Gamble = Infinity.D3.GetAcdContainerByName("Actors.Item.Gamble")
    self.Actors.Item.RiftProgress = Infinity.D3.GetAcdContainerByName("Actors.Item.RiftProgress")
    self.Actors.GroundEffect.Plagued = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.Plagued")
    self.Actors.GroundEffect.Desecrator = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.Desecrator")
    self.Actors.GroundEffect.PoisonEnchanted = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.PoisonEnchanted")
    self.Actors.GroundEffect.Molten = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.Molten")
    self.Actors.GroundEffect.Mortar = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.Mortar")
    self.Actors.GroundEffect.OccuCircle = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.OccuCircle")
    self.Actors.GroundEffect.Frozen = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.Frozen")
    self.Actors.GroundEffect.Wormwhole = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.Wormwhole")
    self.Actors.GroundEffect.Arcane = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.Arcane")
    self.Actors.GroundEffect.FrozenPulse = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.FrozenPulse")
    self.Actors.GroundEffect.Orbiter = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.Orbiter")
    self.Actors.GroundEffect.Thunderstorm = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.Thunderstorm")
    self.Actors.GroundEffect.GrotesqueExplosion = Infinity.D3.GetAcdContainerByName("Actors.GroundEffect.GrotesqueExplosion")
    self.Actors.Pylon.SpawnMarker = Infinity.D3.GetAcdContainerByName("Actors.Pylon.SpawnMarker")
    self.Actors.Pylon.Power = Infinity.D3.GetAcdContainerByName("Actors.Pylon.Power")
    self.Actors.Pylon.Conduit = Infinity.D3.GetAcdContainerByName("Actors.Pylon.Conduit")
    self.Actors.Pylon.Channeling = Infinity.D3.GetAcdContainerByName("Actors.Pylon.Channeling")
    self.Actors.Pylon.Shield = Infinity.D3.GetAcdContainerByName("Actors.Pylon.Shield")
    self.Actors.Pylon.Speed = Infinity.D3.GetAcdContainerByName("Actors.Pylon.Speed")
    self.Actors.Shrine.Protection = Infinity.D3.GetAcdContainerByName("Actors.Shrine.Protection")
    self.Actors.Shrine.Enlightened = Infinity.D3.GetAcdContainerByName("Actors.Shrine.Enlightened")
    self.Actors.Shrine.Fortune = Infinity.D3.GetAcdContainerByName("Actors.Shrine.Fortune")
    self.Actors.Shrine.Frenzied = Infinity.D3.GetAcdContainerByName("Actors.Shrine.Frenzied")
    self.Actors.Shrine.Fleeting = Infinity.D3.GetAcdContainerByName("Actors.Shrine.Fleeting")
    self.Actors.Shrine.Empowered = Infinity.D3.GetAcdContainerByName("Actors.Shrine.Empowered")
    self.Actors.Shrine.Bandit = Infinity.D3.GetAcdContainerByName("Actors.Shrine.Bandit")
    self.Actors.PoolOfReflection = Infinity.D3.GetAcdContainerByName("Actors.PoolOfReflection")

    --[[self.Actors.All = Infinity.D3.ACDCache_Actors_All
    self.Actors.Monster.All = Infinity.D3.ACDCache_Actors_All
    self.Actors.Monster.Normal = Infinity.D3.ACDCache_Actors_Monster_Normal
    self.Actors.Monster.Champion = Infinity.D3.ACDCache_Actors_Monster_Champion
    self.Actors.Monster.Minion = Infinity.D3.ACDCache_Actors_Monster_Minion
    self.Actors.Monster.Rare = Infinity.D3.ACDCache_Actors_Monster_Rare
    self.Actors.Monster.Unique = Infinity.D3.ACDCache_Actors_Monster_Unique
    self.Actors.Monster.Boss = Infinity.D3.ACDCache_Actors_Monster_Boss
    self.Actors.Monster.Goblin = Infinity.D3.ACDCache_Actors_Monster_Goblin
    self.Actors.Monster.Elites = Infinity.D3.ACDCache_Actors_Monster_Elites
    self.Actors.Monster.ElitesLeaders = Infinity.D3.ACDCache_Actors_Monster_ElitesLeaders
    self.Actors.Monster.Pets = Infinity.D3.ACDCache_Actors_Monster_Pets
    self.Actors.Player = Infinity.D3.ACDCache_Actors_Player
    
    self.Actors.Corpse = Infinity.D3.ACDCache_Actors_Corpse
    self.Actors.Marker = Infinity.D3.ACDCache_Actors_Marker
    
    self.Actors.WizardMeteor.ArcanePending = Infinity.D3.ACDCache_Actors_WizardMeteor_ArcanePending
    self.Actors.WizardMeteor.ArcaneImpact = Infinity.D3.ACDCache_Actors_WizardMeteor_ArcaneImpact
    self.Actors.Item.All = Infinity.D3.ACDCache_Actors_Item_All
    self.Actors.Item.Ground = Infinity.D3.ACDCache_Actors_Item_Ground
    self.Actors.Item.Backpack = Infinity.D3.ACDCache_Actors_Item_Backpack
    self.Actors.Item.Equip = Infinity.D3.ACDCache_Actors_Item_Equip
    self.Actors.Item.Stash = Infinity.D3.ACDCache_Actors_Item_Stash
    self.Actors.Item.Merchant = Infinity.D3.ACDCache_Actors_Item_Merchant
    self.Actors.Item.Gamble = Infinity.D3.ACDCache_Actors_Item_Gamble
    self.Actors.Item.RiftProgress = Infinity.D3.ACDCache_Actors_Item_RiftProgress
    self.Actors.GroundEffect.Plagued = Infinity.D3.ACDCache_Actors_GroundEffect_Plagued
    self.Actors.GroundEffect.Desecrator = Infinity.D3.ACDCache_Actors_GroundEffect_Desecrator
    self.Actors.GroundEffect.PoisonEnchanted = Infinity.D3.ACDCache_Actors_GroundEffect_PoisonEnchanted
    self.Actors.GroundEffect.Molten = Infinity.D3.ACDCache_Actors_GroundEffect_Molten
    self.Actors.GroundEffect.Mortar = Infinity.D3.ACDCache_Actors_GroundEffect_Mortar
    self.Actors.GroundEffect.OccuCircle = Infinity.D3.ACDCache_Actors_GroundEffect_OccuCircle
    self.Actors.GroundEffect.Frozen = Infinity.D3.ACDCache_Actors_GroundEffect_Frozen
    self.Actors.GroundEffect.Wormwhole = Infinity.D3.ACDCache_Actors_GroundEffect_Wormwhole
    self.Actors.GroundEffect.Arcane = Infinity.D3.ACDCache_Actors_GroundEffect_Arcane
    self.Actors.GroundEffect.FrozenPulse = Infinity.D3.ACDCache_Actors_GroundEffect_FrozenPulse
    self.Actors.GroundEffect.Orbiter = Infinity.D3.ACDCache_Actors_GroundEffect_Orbiter
    self.Actors.GroundEffect.Thunderstorm = Infinity.D3.ACDCache_Actors_GroundEffect_Thunderstorm
    self.Actors.GroundEffect.GrotesqueExplosion = Infinity.D3.ACDCache_Actors_GroundEffect_GrotesqueExplosion
    self.Actors.Pylon.SpawnMarker = Infinity.D3.ACDCache_Actors_Pylon_SpawnMarker
    self.Actors.Pylon.Power = Infinity.D3.ACDCache_Actors_Pylon_Power
    self.Actors.Pylon.Conduit = Infinity.D3.ACDCache_Actors_Pylon_Conduit
    self.Actors.Pylon.Channeling = Infinity.D3.ACDCache_Actors_Pylon_Channeling
    self.Actors.Pylon.Shield = Infinity.D3.ACDCache_Actors_Pylon_Shield
    self.Actors.Pylon.Speed = Infinity.D3.ACDCache_Actors_Pylon_Speed
    self.Actors.Shrine.Protection = Infinity.D3.ACDCache_Actors_Shrine_Protection
    self.Actors.Shrine.Enlightened = Infinity.D3.ACDCache_Actors_Shrine_Enlightened
    self.Actors.Shrine.Fortune = Infinity.D3.ACDCache_Actors_Shrine_Fortune
    self.Actors.Shrine.Frenzied = Infinity.D3.ACDCache_Actors_Shrine_Frenzied
    self.Actors.Shrine.Fleeting = Infinity.D3.ACDCache_Actors_Shrine_Fleeting
    self.Actors.Shrine.Empowered = Infinity.D3.ACDCache_Actors_Shrine_Empowered
    self.Actors.Shrine.Bandit = Infinity.D3.ACDCache_Actors_Shrine_Bandit
    self.Actors.PoolOfReflection = Infinity.D3.ACDCache_Actors_PoolOfReflection]]--
end

function Collector:ClearTables()    
    self.MonsterRiftProgress = 0.0

    self.LocalAttributes.All = {}
    self.LocalAttributes.BuffCount = {}
    self.LocalAttributes.BuffStartTick = {}
    self.LocalAttributes.BuffEndTick = {}

    self.PlayerData.All = {}
    self.PlayerData.Others = {}
    self.PlayerData.OthersCount = 0
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

function Collector:GetRiftProgress()
    for k,acd in pairs(Infinity.D3.GetAcdContainerByName("Actors.Monster.Elites")) do
        if acd:GetPosition():GetDistance(self.LocalACD:GetPosition()) <= 60 then
            self.MonsterRiftProgress = self.MonsterRiftProgress + SNOGroups.GetMonsterRiftProgressByActorSNO(acd:GetActorSNO())
        end
    end

    for k,acd in pairs(Infinity.D3.GetAcdContainerByName("Actors.Monster.Normal")) do
        if acd:GetPosition():GetDistance(self.LocalACD:GetPosition()) <= 60 then
            self.MonsterRiftProgress = self.MonsterRiftProgress + SNOGroups.GetMonsterRiftProgressByActorSNO(acd:GetActorSNO())
        end
    end

    for k,acd in pairs(Infinity.D3.GetAcdContainerByName("Actors.Item.RiftProgress")) do
        if acd:GetPosition():GetDistance(self.LocalACD:GetPosition()) <= 60 then
            self.MonsterRiftProgress = self.MonsterRiftProgress + 6.5
        end
    end
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

function Collector:GetScenes()
    if self.WorldId ~= self.LastWorldId then
        self.LastWorldId = self.WorldId
        self.Scenes = {}
        self.ExitScene = nil
    end

    for index, scene in pairs(Infinity.D3.GetScenes()) do
        local SnoId = scene:GetSceneSNO()

        if  scene:GetSWorldID() == self.WorldId then            
            if self.Scenes[SnoId] == nil then                
                self.Scenes[SnoId] = {Scene = {SceneSno = SnoId, WorldId = scene:GetSWorldID(), LevelAreaSno = scene:GetLevelAreaSNO() ,Points = scene:GetPoints()}, SceneData = ScenesHelper.GetSceneData(SnoId)}

                if self.Scenes[SnoId].SceneData ~= nil and self.Scenes[SnoId].SceneData:GetIsExit() then
                    self.ExitScene = self.Scenes[SnoId]
                    self.ExitScene.CellPoints = {}

                    local sceneDef = SNOGroups.GetSceneDefBySceneSNO(SnoId)

                    if sceneDef ~= nil then
                        local meshMinX = scene:GetMeshMinX()
                        local meshMinY = scene:GetMeshMinY()
                        local meshMinZ = scene:GetMeshMinZ()

                        for k,cell in pairs(sceneDef:GetNavCells()) do
                            if cell:GetIsWalkable() then
                                local points = {}

                                for a, point in pairs(cell:GetPoints()) do
                                    table.insert(points, Vector3(meshMinX + point.X, meshMinY + point.Y, meshMinZ))
                                end

                                table.insert(self.ExitScene.CellPoints, points)
                            end
                        end
                    end
                end
            end
        end
    end
end

function Collector:InitReloads()
    UIControlHelper.Reload()
end

function Collector:Collect(getLocalAttributes, getriftprogress, getscenes, tickrate)
    if tickrate > 60 then
        tickrate = 60
    end

    if tickrate ~= -1 and self.LastCollect + (1000/tickrate) > Infinity.Win32.GetTickCount() then
        return
    end
    
    self:InitReloads()

    self:ClearTables()

    self:GetLocalACD()
   
    self:GetTables()
       
    self:GetLevelArea()

    if getscenes and Infinity.D3.GetIsNewScenes() then        
        self:GetScenes()
    end

    if getriftprogress == true then
        if AttributeHelper.IsInGreaterRift(self.LocalACD) == false then
            getriftprogress = false
        else
            self:GetRiftProgress()
        end
    end

    self:GetPlayers()
        
    if getLocalAttributes == true then
        self:GetLocalAttributes()
    end

    self:GetClientRect()
    self:GetTicks()
    
    self.LastCollect = Infinity.Win32.GetTickCount()
end