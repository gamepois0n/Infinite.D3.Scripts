Radar = { }
Radar.Running = false
Radar.Collector = Collector()
Radar.LocalData = Infinity.D3.GetLocalData()

Radar.TTSBlackList = {}

Radar.Settings = Settings()

Radar.SkillTextures = {}
Radar.BuffTextures = {}

Radar.PlayerMarkerLabel = TextLabelAnimation:new()
Radar.PlayerMarkerCircle = CircleAnimation:new()

function Radar.Start()
  Radar.Running = true

  RadarSettings.LoadSettings()    
end

function Radar.Stop()
  Radar.Running = false

  RadarSettings.SaveSettings()
end

function Radar.TTS()
  for k,v in pairs(Radar.Collector.Actors.Item.Ground) do
    local Id = math.floor(v:GetPosition().X) + Radar.Collector.WorldId

    if AttributeHelper.IsAncientLegendaryItem(v) and not table.find(Radar.TTSBlackList, Id) then
    TTSHelper.Speak("Ancient " .. AttributeHelper.GetItemName(v))
    table.insert(Radar.TTSBlackList, Id)
    elseif AttributeHelper.IsPrimalLegendaryItem(v) and not table.find(Radar.TTSBlackList, Id) then
    TTSHelper.Speak("Primal " .. AttributeHelper.GetItemName(v))
    table.insert(Radar.TTSBlackList, Id)
  end
end

for k,v in pairs(Radar.Collector.Actors.Pylon.Power) do
  if AttributeHelper.IsPowerPylon(v) then

    local Id = math.floor(v:GetPosition().X) + Radar.Collector.WorldId

    if not table.find(Radar.TTSBlackList, Id) and not AttributeHelper.IsOperated(v) then
      TTSHelper.Speak("Power Pylon")      
      table.insert(Radar.TTSBlackList, Id)
    end
  end
end

for k,v in pairs(Radar.Collector.Actors.Pylon.Conduit) do
  if AttributeHelper.IsConduitPylon(v) then

    local Id = math.floor(v:GetPosition().X) + Radar.Collector.WorldId

    if not table.find(Radar.TTSBlackList, Id) and not AttributeHelper.IsOperated(v) then
      TTSHelper.Speak("Conduit Pylon")
      table.insert(Radar.TTSBlackList, Id)
    end
  end
end

for k,v in pairs(Radar.Collector.Actors.Pylon.Channeling) do
  if AttributeHelper.IsChannelingPylon(v) then

    local Id = math.floor(v:GetPosition().X) + Radar.Collector.WorldId

    if not table.find(Radar.TTSBlackList, Id) and not AttributeHelper.IsOperated(v) then
      TTSHelper.Speak("Channeling Pylon")
      table.insert(Radar.TTSBlackList, Id)
    end
  end
end

for k,v in pairs(Radar.Collector.Actors.Pylon.Shield) do
  if AttributeHelper.IsShieldPylon(v) then

    local Id = math.floor(v:GetPosition().X) + Radar.Collector.WorldId

    if not table.find(Radar.TTSBlackList, Id) and not AttributeHelper.IsOperated(v) then
      TTSHelper.Speak("Shield Pylon")
      table.insert(Radar.TTSBlackList, Id)
    end
  end
end

for k,v in pairs(Radar.Collector.Actors.Pylon.Speed) do
  if AttributeHelper.IsSpeedPylon(v) then

    local Id = math.floor(v:GetPosition().X) + Radar.Collector.WorldId

    if not table.find(Radar.TTSBlackList, Id) and not AttributeHelper.IsOperated(v) then
      TTSHelper.Speak("Speed Pylon")
      table.insert(Radar.TTSBlackList, Id)
    end
  end
end

for k,v in pairs(Radar.Collector.Actors.PoolOfReflection) do
  if AttributeHelper.IsPoolOfReflection(v) then

    local Id = math.floor(v:GetPosition().X) + Radar.Collector.WorldId
    
    if not table.find(Radar.TTSBlackList, Id) and not AttributeHelper.IsOperated(v) then
      TTSHelper.Speak("Pool of Reflection")
      table.insert(Radar.TTSBlackList, Id)
    end
  end
end
end

function Radar.OnPulse()
  if Radar.Running == false then
    return
  end   
    
  Radar.Collector:Collect(false, true, true, 10)

  if not Radar.LocalData:GetIsPlayerValid() or Radar.LocalData:GetIsStartUpGame() then
    return
  end

  if Radar.Settings.MapReveal == true then
    LevelAreaHelper.RevealAllScenes()
  end

  Radar.TTS()    
end

function Radar.RenderMonstersNormal()
for k,v in pairs(Radar.Collector.Actors.Monster.Normal) do      
  local radius =  1

  if Radar.Settings.Monsters.Normal.CustomRadius then
    radius = Radar.Settings.Monsters.Normal.CustomRadiusValue
  else
    radius =  v:GetRadius()
  end

  if Radar.Settings.Monsters.Normal.Enabled == true then
    if Radar.Settings.Monsters.Normal.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.Monsters.Normal.ColorOutline, Radar.Settings.Monsters.Normal.Thickness, Radar.Settings.Monsters.Normal.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.Monsters.Normal.ColorOutline, Radar.Settings.Monsters.Normal.ColorFill, Radar.Settings.Monsters.Normal.Thickness) 
    end
  end

  if Radar.Settings.Monsters.Normal.Minimap == true then
    Radar.RenderACDOnMinimap("Circle", v, Radar.Settings.Monsters.Normal.MinimapRadius, Radar.Settings.Monsters.Normal.ColorMinimap, Radar.Settings.Monsters.Normal.Thickness, true)
  end  
end
end

function Radar.RenderAffixLabels(acd)
if Radar.Settings.Affixes.Enabled == false then
  return
end

  local labels = {}
  
  if Radar.Settings.Affixes.Molten and AttributeHelper.HasMolten(acd) then
    table.insert(labels, Radar.Settings.Affixes.Molten)
  end

  if Radar.Settings.Affixes.Arcane and AttributeHelper.HasArcane(acd) then
    table.insert(labels, Radar.Settings.Affixes.Arcane)
  end

  if Radar.Settings.Affixes.Avenger and AttributeHelper.HasAvenger(acd) then
    table.insert(labels, Radar.Settings.Affixes.Avenger)
  end

  if Radar.Settings.Affixes.Mortar and AttributeHelper.HasMortar(acd) then
    table.insert(labels, Radar.Settings.Affixes.Mortar)
  end
  
  if Radar.Settings.Affixes.Desecrator and AttributeHelper.HasDesecrator(acd) then
    table.insert(labels, Radar.Settings.Affixes.Desecrator)
  end

  if Radar.Settings.Affixes.Electrified and AttributeHelper.HasElectrified(acd) then
    table.insert(labels, Radar.Settings.Affixes.Electrified)
  end

  if Radar.Settings.Affixes.ExtraHealth and AttributeHelper.HasExtraHealth(acd) then
    table.insert(labels, Radar.Settings.Affixes.ExtraHealth)
  end
  
  if Radar.Settings.Affixes.Fast and AttributeHelper.HasFast(acd) then
    table.insert(labels, Radar.Settings.Affixes.Fast)
  end

  if Radar.Settings.Affixes.Frozen and AttributeHelper.HasFrozen(acd) then
    table.insert(labels, Radar.Settings.Affixes.Frozen)
  end

  if Radar.Settings.Affixes.Healthlink and AttributeHelper.HasHealthlink(acd) then
    table.insert(labels, Radar.Settings.Affixes.Healthlink)
  end

  if Radar.Settings.Affixes.Illusionist and AttributeHelper.HasIllusionist(acd) then
    table.insert(labels, Radar.Settings.Affixes.Illusionist)
  end

  if Radar.Settings.Affixes.Jailer and AttributeHelper.HasJailer(acd) then
    table.insert(labels, Radar.Settings.Affixes.Jailer)
  end

  if Radar.Settings.Affixes.Knockback and AttributeHelper.HasKnockback(acd) then
    table.insert(labels, Radar.Settings.Affixes.Knockback)
  end

  if Radar.Settings.Affixes.MissileDampening and AttributeHelper.HasMissileDampening(acd) then
    table.insert(labels, Radar.Settings.Affixes.MissileDampening)
  end

  if Radar.Settings.Affixes.Nightmarish and AttributeHelper.HasNightmarish(acd) then
    table.insert(labels, Radar.Settings.Affixes.Nightmarish)
  end

  if Radar.Settings.Affixes.Plagued and AttributeHelper.HasPlagued(acd) then
    table.insert(labels, Radar.Settings.Affixes.Plagued)
  end

  if Radar.Settings.Affixes.ReflectsDamage and AttributeHelper.HasReflectsDamage(acd) then
    table.insert(labels, Radar.Settings.Affixes.ReflectsDamage)
  end

  if Radar.Settings.Affixes.Shielding and AttributeHelper.HasShielding(acd) then
    table.insert(labels, Radar.Settings.Affixes.Shielding)
  end

  if Radar.Settings.Affixes.Teleporter and AttributeHelper.HasTeleporter(acd) then
    table.insert(labels, Radar.Settings.Affixes.Teleporter)
  end

  if Radar.Settings.Affixes.Thunderstorm and AttributeHelper.HasThunderstorm(acd) then
    table.insert(labels, Radar.Settings.Affixes.Thunderstorm)
  end

  if Radar.Settings.Affixes.Vortex and AttributeHelper.HasVortex(acd) then
    table.insert(labels, Radar.Settings.Affixes.Vortex)
  end

  if Radar.Settings.Affixes.Waller and AttributeHelper.HasWaller(acd) then
    table.insert(labels, Radar.Settings.Affixes.Waller)
  end

  if Radar.Settings.Affixes.Firechains and AttributeHelper.HasFirechains(acd) then
    table.insert(labels, Radar.Settings.Affixes.Firechains)
  end

  if Radar.Settings.Affixes.Orbiter and AttributeHelper.HasOrbiter(acd) then
    table.insert(labels, Radar.Settings.Affixes.Orbiter)
  end

  if Radar.Settings.Affixes.FrozenPulse and AttributeHelper.HasFrozenPulse(acd) then
    table.insert(labels, Radar.Settings.Affixes.FrozenPulse)
  end

  if Radar.Settings.Affixes.HasPoisonEnchanted and AttributeHelper.HasPoisonEnchanted(acd) then
    table.insert(labels, Radar.Settings.Affixes.HasPoisonEnchanted)
  end

  if Radar.Settings.Affixes.HasJuggernaut and AttributeHelper.HasJuggernaut(acd) then
    table.insert(labels, Radar.Settings.Affixes.HasJuggernaut)
  end

  if Radar.Settings.Affixes.HasWormhole and AttributeHelper.HasWormhole(acd) then
    table.insert(labels, Radar.Settings.Affixes.HasWormhole)
  end
    
  RenderHelper.DrawWorldTextLabels(labels, acd:GetPosition(), false)
end

function Radar.RenderMonstersElite()
if Radar.Settings.Monsters.Elite.Champion.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Monster.Champion) do
    if not AttributeHelper.IsIllusion(v) then
      local radius =  1

      if Radar.Settings.Monsters.Elite.Champion.CustomRadius then
        radius = Radar.Settings.Monsters.Elite.Champion.CustomRadiusValue
      else
        radius =  v:GetRadius()
      end

      if Radar.Settings.Monsters.Elite.Champion.ColorFill == nil then
        RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.Monsters.Elite.Champion.ColorOutline, Radar.Settings.Monsters.Elite.Champion.Thickness, Radar.Settings.Monsters.Elite.Champion.Fill) 
      else
        RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.Monsters.Elite.Champion.ColorOutline, Radar.Settings.Monsters.Elite.Champion.ColorFill, Radar.Settings.Monsters.Elite.Champion.Thickness) 
      end

      if Radar.Settings.Monsters.Elite.Champion.Minimap == true then
        local minimapColor = Radar.Settings.Monsters.Elite.Champion.ColorMinimap

        if AttributeHelper.HasJuggernaut(v) then
          minimapColor = "FFFF0000"
        end

        Radar.RenderACDOnMinimap("Circle", v, Radar.Settings.Monsters.Elite.Champion.MinimapRadius, minimapColor, Radar.Settings.Monsters.Elite.Champion.Thickness, true)
      end

      Radar.RenderAffixLabels(v)      
    end
  end
end

if Radar.Settings.Monsters.Elite.Rare.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Monster.Rare) do
    if not AttributeHelper.IsIllusion(v) then  
      local radius =  1

      if Radar.Settings.Monsters.Elite.Rare.CustomRadius then
        radius = Radar.Settings.Monsters.Elite.Rare.CustomRadiusValue
      else
        radius =  v:GetRadius()
      end

      if Radar.Settings.Monsters.Elite.Rare.ColorFill == nil then
        RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.Monsters.Elite.Rare.ColorOutline, Radar.Settings.Monsters.Elite.Rare.Thickness, Radar.Settings.Monsters.Elite.Rare.Fill) 
      else
        RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.Monsters.Elite.Rare.ColorOutline, Radar.Settings.Monsters.Elite.Rare.ColorFill, Radar.Settings.Monsters.Elite.Rare.Thickness) 
      end

      if Radar.Settings.Monsters.Elite.Rare.Minimap == true then
        local minimapColor = Radar.Settings.Monsters.Elite.Rare.ColorMinimap

        if AttributeHelper.HasJuggernaut(v) then
          minimapColor = "FFFF0000"
        end
        
        Radar.RenderACDOnMinimap("Circle", v, Radar.Settings.Monsters.Elite.Rare.MinimapRadius, minimapColor, Radar.Settings.Monsters.Elite.Rare.Thickness, true)
      end

      Radar.RenderAffixLabels(v)
    end
  end
end

if Radar.Settings.Monsters.Elite.Minion.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Monster.Minion) do
    local radius =  1

    if Radar.Settings.Monsters.Elite.Minion.CustomRadius then
      radius = Radar.Settings.Monsters.Elite.Minion.CustomRadiusValue
    else
      radius =  v:GetRadius()
    end

    if Radar.Settings.Monsters.Elite.Minion.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.Monsters.Elite.Minion.ColorOutline, Radar.Settings.Monsters.Elite.Minion.Thickness, Radar.Settings.Monsters.Elite.Minion.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.Monsters.Elite.Minion.ColorOutline, Radar.Settings.Monsters.Elite.Minion.ColorFill, Radar.Settings.Monsters.Elite.Minion.Thickness) 
    end

    if Radar.Settings.Monsters.Elite.Minion.Minimap == true then
      Radar.RenderACDOnMinimap("Circle", v, Radar.Settings.Monsters.Elite.Minion.MinimapRadius, Radar.Settings.Monsters.Elite.Minion.ColorMinimap, Radar.Settings.Monsters.Elite.Minion.Thickness, true)
    end

    Radar.RenderAffixLabels(v)
  end
end

if Radar.Settings.Monsters.Elite.Unique.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Monster.Unique) do
    if not AttributeHelper.IsIllusion(v) then
      local radius =  1

      if Radar.Settings.Monsters.Elite.Unique.CustomRadius then
        radius = Radar.Settings.Monsters.Elite.Unique.CustomRadiusValue
      else
        radius =  v:GetRadius()
      end

      if Radar.Settings.Monsters.Elite.Unique.ColorFill == nil then
        RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.Monsters.Elite.Unique.ColorOutline, Radar.Settings.Monsters.Elite.Unique.Thickness, Radar.Settings.Monsters.Elite.Unique.Fill) 
      else
        RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.Monsters.Elite.Unique.ColorOutline, Radar.Settings.Monsters.Elite.Unique.ColorFill, Radar.Settings.Monsters.Elite.Unique.Thickness) 
      end

      if Radar.Settings.Monsters.Elite.Unique.Minimap == true then
        Radar.RenderACDOnMinimap("Circle", v, Radar.Settings.Monsters.Elite.Unique.MinimapRadius, Radar.Settings.Monsters.Elite.Unique.ColorMinimap, Radar.Settings.Monsters.Elite.Unique.Thickness, true)
      end

      Radar.RenderAffixLabels(v)
    end
  end
end
end

function Radar.RenderMonstersBoss()
for k,v in pairs(Radar.Collector.Actors.Monster.Boss) do  
  if not AttributeHelper.IsIllusion(v) then    
    local radius =  1

    if Radar.Settings.Monsters.Boss.CustomRadius then
      radius = Radar.Settings.Monsters.Boss.CustomRadiusValue
    else
      radius =  v:GetRadius()
    end

    if Radar.Settings.Monsters.Boss.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.Monsters.Boss.ColorOutline, Radar.Settings.Monsters.Boss.Thickness, Radar.Settings.Monsters.Boss.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.Monsters.Boss.ColorOutline, Radar.Settings.Monsters.Boss.ColorFill, Radar.Settings.Monsters.Boss.Thickness) 
    end 

    if Radar.Settings.Monsters.Boss.Minimap == true then
      Radar.RenderACDOnMinimap("Circle", v, Radar.Settings.Monsters.Boss.MinimapRadius, Radar.Settings.Monsters.Boss.ColorMinimap, Radar.Settings.Monsters.Boss.Thickness, true)
    end
  end
end
end

function Radar.RenderMonsters()
  Radar.RenderMonstersNormal()

if Radar.Settings.Monsters.Elite.Enabled then
  Radar.RenderMonstersElite()
end

if Radar.Settings.Monsters.Boss.Enabled then
  Radar.RenderMonstersBoss()
end
end

function Radar.RenderPlayers()
for k,v in pairs(Radar.Collector.PlayerData.Others) do
  local acd = Infinity.D3.GetACDbyACDId(v:GetACDId())

  if acd ~= nil and acd.Address ~= 0 and acd:GetActorId() ~= -1 then
    local radius =  1

    if Radar.Settings.Players.CustomRadius then
      radius = Radar.Settings.Players.CustomRadiusValue
    else
      radius =  acd:GetRadius()
    end

    color = "FFFFFF"

    if v:GetHeroClass() == 0 then --DemonHunter
      color = "0000C8"
    elseif v:GetHeroClass() == 1 then --Barbarian
      color = "FA0A0A"
    elseif v:GetHeroClass() == 2 then --Wizard
      color = "FA32B4"
    elseif v:GetHeroClass() == 3 then --Witchdoctor
      color = "009B7D"
    elseif v:GetHeroClass() == 4 then --Monk
      color = "7800C8"
    elseif v:GetHeroClass() == 5 then --Crusader
      color = "00C8FA"
    elseif v:GetHeroClass() == 6 then --Necromancer
      color = "AFEEEE"
    end

      Radar.PlayerMarkerLabel:DrawPulse(acd:GetPosition(), v:GetHeroName(), 16, color, "FFFFFFFF", false)
    

    if Radar.Settings.Players.Minimap == true then
      Radar.PlayerMarkerCircle:DrawPulse(acd:GetPosition(), 6, color, true)
    end         
  end
end
end

function Radar.RenderGroundEffects()
if Radar.Settings.GroundEffects.Plagued.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.Plagued) do     
    local radius =  1

    if Radar.Settings.GroundEffects.Plagued.CustomRadius then
      radius = Radar.Settings.GroundEffects.Plagued.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.Plagued.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.Plagued.ColorOutline, Radar.Settings.GroundEffects.Plagued.Thickness, Radar.Settings.GroundEffects.Plagued.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.Plagued.ColorOutline, Radar.Settings.GroundEffects.Plagued.ColorFill, Radar.Settings.GroundEffects.Plagued.Thickness) 
    end
  end
end

if Radar.Settings.GroundEffects.Desecrator.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.Desecrator) do  
    local radius =  1

    if Radar.Settings.GroundEffects.Desecrator.CustomRadius then
      radius = Radar.Settings.GroundEffects.Desecrator.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.Desecrator.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.Desecrator.ColorOutline, Radar.Settings.GroundEffects.Desecrator.Thickness, Radar.Settings.GroundEffects.Desecrator.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.Desecrator.ColorOutline, Radar.Settings.GroundEffects.Desecrator.ColorFill, Radar.Settings.GroundEffects.Desecrator.Thickness) 
    end  
  end  
end

if Radar.Settings.GroundEffects.PoisonEnchanted.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.PoisonEnchanted) do 
    local radius =  1

    if Radar.Settings.GroundEffects.PoisonEnchanted.CustomRadius then
      radius = Radar.Settings.GroundEffects.PoisonEnchanted.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.PoisonEnchanted.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.PoisonEnchanted.ColorOutline, Radar.Settings.GroundEffects.PoisonEnchanted.Thickness, Radar.Settings.GroundEffects.PoisonEnchanted.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.PoisonEnchanted.ColorOutline, Radar.Settings.GroundEffects.PoisonEnchanted.ColorFill, Radar.Settings.GroundEffects.PoisonEnchanted.Thickness) 
    end   
  end
end

if Radar.Settings.GroundEffects.Molten.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.Molten) do 
    local radius =  1

    if Radar.Settings.GroundEffects.Molten.CustomRadius then
      radius = Radar.Settings.GroundEffects.Molten.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.Molten.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.Molten.ColorOutline, Radar.Settings.GroundEffects.Molten.Thickness, Radar.Settings.GroundEffects.Molten.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.Molten.ColorOutline, Radar.Settings.GroundEffects.Molten.ColorFill, Radar.Settings.GroundEffects.Molten.Thickness) 
    end 
  end
end

if Radar.Settings.GroundEffects.Mortar.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.Mortar) do 
    local radius =  1

    if Radar.Settings.GroundEffects.Mortar.CustomRadius then
      radius = Radar.Settings.GroundEffects.Mortar.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.Mortar.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.Mortar.ColorOutline, Radar.Settings.GroundEffects.Mortar.Thickness, Radar.Settings.GroundEffects.Mortar.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.Mortar.ColorOutline, Radar.Settings.GroundEffects.Mortar.ColorFill, Radar.Settings.GroundEffects.Mortar.Thickness) 
    end     
  end
end

if Radar.Settings.GroundEffects.OccuCircle.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.OccuCircle) do
    local radius =  1

    if Radar.Settings.GroundEffects.OccuCircle.CustomRadius then
      radius = Radar.Settings.GroundEffects.OccuCircle.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.OccuCircle.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.OccuCircle.ColorOutline, Radar.Settings.GroundEffects.OccuCircle.Thickness, Radar.Settings.GroundEffects.OccuCircle.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.OccuCircle.ColorOutline, Radar.Settings.GroundEffects.OccuCircle.ColorFill, Radar.Settings.GroundEffects.OccuCircle.Thickness) 
    end
  end
end

if Radar.Settings.GroundEffects.Frozen.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.Frozen) do
    local radius =  1

    if Radar.Settings.GroundEffects.Frozen.CustomRadius then
      radius = Radar.Settings.GroundEffects.Frozen.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.Frozen.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.Frozen.ColorOutline, Radar.Settings.GroundEffects.Frozen.Thickness, Radar.Settings.GroundEffects.Frozen.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.Frozen.ColorOutline, Radar.Settings.GroundEffects.Frozen.ColorFill, Radar.Settings.GroundEffects.Frozen.Thickness) 
    end
  end
end

if Radar.Settings.GroundEffects.Wormwhole.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.Wormwhole) do
    local radius =  1

    if Radar.Settings.GroundEffects.Wormwhole.CustomRadius then
      radius = Radar.Settings.GroundEffects.Wormwhole.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.Wormwhole.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.Wormwhole.ColorOutline, Radar.Settings.GroundEffects.Wormwhole.Thickness, Radar.Settings.GroundEffects.Wormwhole.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.Wormwhole.ColorOutline, Radar.Settings.GroundEffects.Wormwhole.ColorFill, Radar.Settings.GroundEffects.Wormwhole.Thickness) 
    end 
  end
end

if Radar.Settings.GroundEffects.Arcane.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.Arcane) do
    local radius =  1

    if Radar.Settings.GroundEffects.Arcane.CustomRadius then
      radius = Radar.Settings.GroundEffects.Arcane.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.Arcane.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.Arcane.ColorOutline, Radar.Settings.GroundEffects.Arcane.Thickness, Radar.Settings.GroundEffects.Arcane.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.Arcane.ColorOutline, Radar.Settings.GroundEffects.Arcane.ColorFill, Radar.Settings.GroundEffects.Arcane.Thickness) 
    end
  end
end

if Radar.Settings.GroundEffects.FrozenPulse.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.FrozenPulse) do
    local radius =  1

    if Radar.Settings.GroundEffects.FrozenPulse.CustomRadius then
      radius = Radar.Settings.GroundEffects.FrozenPulse.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.FrozenPulse.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.FrozenPulse.ColorOutline, Radar.Settings.GroundEffects.FrozenPulse.Thickness, Radar.Settings.GroundEffects.FrozenPulse.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.FrozenPulse.ColorOutline, Radar.Settings.GroundEffects.FrozenPulse.ColorFill, Radar.Settings.GroundEffects.FrozenPulse.Thickness) 
    end
  end
end

if Radar.Settings.GroundEffects.Orbiter.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.Orbiter) do
    local radius =  1

    if Radar.Settings.GroundEffects.Orbiter.CustomRadius then
      radius = Radar.Settings.GroundEffects.Orbiter.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.Orbiter.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.Orbiter.ColorOutline, Radar.Settings.GroundEffects.Orbiter.Thickness, Radar.Settings.GroundEffects.Orbiter.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.Orbiter.ColorOutline, Radar.Settings.GroundEffects.Orbiter.ColorFill, Radar.Settings.GroundEffects.Orbiter.Thickness) 
    end
  end
end

if Radar.Settings.GroundEffects.Thunderstorm.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.Thunderstorm) do
    local radius =  1

    if Radar.Settings.GroundEffects.Thunderstorm.CustomRadius then
      radius = Radar.Settings.GroundEffects.Thunderstorm.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.Thunderstorm.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.Thunderstorm.ColorOutline, Radar.Settings.GroundEffects.Thunderstorm.Thickness, Radar.Settings.GroundEffects.Thunderstorm.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.Thunderstorm.ColorOutline, Radar.Settings.GroundEffects.Thunderstorm.ColorFill, Radar.Settings.GroundEffects.Thunderstorm.Thickness) 
    end 
  end    
end

if Radar.Settings.GroundEffects.GrotesqueExplosion.Enabled then
  for k,v in pairs(Radar.Collector.Actors.GroundEffect.GrotesqueExplosion) do
    local radius =  1

    if Radar.Settings.GroundEffects.GrotesqueExplosion.CustomRadius then
      radius = Radar.Settings.GroundEffects.GrotesqueExplosion.CustomRadiusValue
    else
      radius =  v:GetCollisionRadius()
    end

    if Radar.Settings.GroundEffects.GrotesqueExplosion.ColorFill == nil then
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.GroundEffects.GrotesqueExplosion.ColorOutline, Radar.Settings.GroundEffects.GrotesqueExplosion.Thickness, Radar.Settings.GroundEffects.GrotesqueExplosion.Fill) 
    else
      RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.GroundEffects.GrotesqueExplosion.ColorOutline, Radar.Settings.GroundEffects.GrotesqueExplosion.ColorFill, Radar.Settings.GroundEffects.GrotesqueExplosion.Thickness) 
    end 
  end    
end
end

function Radar.RenderRiftProgressOrbItems()
  for k,v in pairs(Radar.Collector.Actors.Item.RiftProgress) do
    Radar.RenderACDOnMinimap("Circle", v, 6, "FF7F3FBF", 1, true)
  end
end

function Radar.RenderGroundItems()
  for k,v in pairs(Radar.Collector.Actors.Item.Ground) do
    local labels = {}

    if AttributeHelper.IsLegendaryItem(v) and Radar.Settings.Items.Legendary.Enabled then      
      if AttributeHelper.IsAncientLegendaryItem(v) and Radar.Settings.Items.Legendary.Ancient.Enabled then
        local radius =  1

        if Radar.Settings.Items.Legendary.Ancient.CustomRadius then
          radius = Radar.Settings.Items.Legendary.Ancient.CustomRadiusValue
        else
          radius =  v:GetRadius()
        end

        if Radar.Settings.Items.Legendary.Ancient.ColorFill == nil then
          RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.Items.Legendary.Ancient.ColorOutline, Radar.Settings.Items.Legendary.Ancient.Thickness, Radar.Settings.Items.Legendary.Ancient.Fill) 
        else
          RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.Items.Legendary.Ancient.ColorOutline, Radar.Settings.Items.Legendary.Ancient.ColorFill, Radar.Settings.Items.Legendary.Ancient.Thickness) 
        end

        table.insert(labels, {Text = "[A] " .. AttributeHelper.GetItemName(v), Size = 16, LabelColor = Radar.Settings.Items.Legendary.Ancient.ColorOutline, LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 2})
      elseif AttributeHelper.IsPrimalLegendaryItem(v) and Radar.Settings.Items.Legendary.Primal.Enabled then
        local radius =  1

        if Radar.Settings.Items.Legendary.Primal.CustomRadius then
          radius = Radar.Settings.Items.Legendary.Primal.CustomRadiusValue
        else
          radius =  v:GetRadius()
        end

        if Radar.Settings.Items.Legendary.Primal.ColorFill == nil then
          RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.Items.Legendary.Primal.ColorOutline, Radar.Settings.Items.Legendary.Primal.Thickness, Radar.Settings.Items.Legendary.Primal.Fill) 
        else
          RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.Items.Legendary.Primal.ColorOutline, Radar.Settings.Items.Legendary.Primal.ColorFill, Radar.Settings.Items.Legendary.Primal.Thickness) 
        end

        table.insert(labels, {Text = "[P] " .. AttributeHelper.GetItemName(v), Size = 16, LabelColor = Radar.Settings.Items.Legendary.Primal.ColorOutline, LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 3})
      else
        local radius =  1

        if Radar.Settings.Items.Legendary.Normal.CustomRadius then
          radius = Radar.Settings.Items.Legendary.Normal.CustomRadiusValue
        else
          radius =  v:GetRadius()
        end

        if Radar.Settings.Items.Legendary.Normal.ColorFill == nil then
          RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.Items.Legendary.Normal.ColorOutline, Radar.Settings.Items.Legendary.Normal.Thickness, Radar.Settings.Items.Legendary.Normal.Fill) 
        else
          RenderHelper.DrawWorldCircleFilledMulticolor(v:GetPosition(), radius, Radar.Settings.Items.Legendary.Normal.ColorOutline, Radar.Settings.Items.Legendary.Normal.ColorFill, Radar.Settings.Items.Legendary.Normal.Thickness) 
        end

        table.insert(labels, {Text = AttributeHelper.GetItemName(v), Size = 16, LabelColor = Radar.Settings.Items.Legendary.Normal.ColorOutline, LabelBorderColor = "FF000000", TextColor = "FFFFFFFF", Filled = true, Border = true, BorderThickness = 1})
      end
    end

    RenderHelper.DrawWorldTextLabels(labels, v:GetPosition(), false)
  end
end

function Radar.RenderPylonSpawnMarker()
  for k,v in pairs(Radar.Collector.Actors.Pylon.SpawnMarker) do  
    Radar.RenderACDOnMinimapAsText(v, "?", 16, "FFFFFFFF")
  end
end

function Radar.RenderPylons()
if Radar.Settings.Pylons.Power.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Pylon.Power) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Pylons.Power.ColorOutline, Radar.Settings.Pylons.Power.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Pylons.Power.Text, Radar.Settings.Pylons.Power.TextSize, Radar.Settings.Pylons.Power.ColorText, v:GetPosition(), 0, -10)
    end
  end
end

if Radar.Settings.Pylons.Conduit.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Pylon.Conduit) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Pylons.Conduit.ColorOutline, Radar.Settings.Pylons.Conduit.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Pylons.Conduit.Text, Radar.Settings.Pylons.Conduit.TextSize, Radar.Settings.Pylons.Conduit.ColorText, v:GetPosition(), 0, -10)
    end
  end
end

if Radar.Settings.Pylons.Channeling.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Pylon.Channeling) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Pylons.Channeling.ColorOutline, Radar.Settings.Pylons.Channeling.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Pylons.Channeling.Text, Radar.Settings.Pylons.Channeling.TextSize, Radar.Settings.Pylons.Channeling.ColorText, v:GetPosition(), 0, -10)
    end
  end
end

if Radar.Settings.Pylons.Shield.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Pylon.Shield) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Pylons.Shield.ColorOutline, Radar.Settings.Pylons.Shield.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Pylons.Shield.Text, Radar.Settings.Pylons.Shield.TextSize, Radar.Settings.Pylons.Shield.ColorText, v:GetPosition(), 0, -10)
    end
  end
end

if Radar.Settings.Pylons.Speed.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Pylon.Speed) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Pylons.Speed.ColorOutline, Radar.Settings.Pylons.Speed.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Pylons.Speed.Text, Radar.Settings.Pylons.Speed.TextSize, Radar.Settings.Pylons.Speed.ColorText, v:GetPosition(), 0, -10)
    end
  end
end
end

function Radar.RenderShrines()
if Radar.Settings.Shrines.Protection.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Shrine.Protection) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Shrines.Protection.ColorOutline, Radar.Settings.Shrines.Protection.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Shrines.Protection.Text, Radar.Settings.Shrines.Protection.TextSize, Radar.Settings.Shrines.Protection.ColorText, v:GetPosition(), 0, -10)
    end
  end
end

if Radar.Settings.Shrines.Enlightened.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Shrine.Enlightened) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Shrines.Enlightened.ColorOutline, Radar.Settings.Shrines.Enlightened.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Shrines.Enlightened.Text, Radar.Settings.Shrines.Enlightened.TextSize, Radar.Settings.Shrines.Enlightened.ColorText, v:GetPosition(), 0, -10) 
    end
  end
end

if Radar.Settings.Shrines.Fortune.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Shrine.Fortune) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Shrines.Fortune.ColorOutline, Radar.Settings.Shrines.Fortune.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Shrines.Fortune.Text, Radar.Settings.Shrines.Fortune.TextSize, Radar.Settings.Shrines.Fortune.ColorText, v:GetPosition(), 0, -10)
    end
  end
end

if Radar.Settings.Shrines.Frenzied.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Shrine.Frenzied) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Shrines.Frenzied.ColorOutline, Radar.Settings.Shrines.Frenzied.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Shrines.Frenzied.Text, Radar.Settings.Shrines.Frenzied.TextSize, Radar.Settings.Shrines.Frenzied.ColorText, v:GetPosition(), 0, -10)
    end
  end
end

if Radar.Settings.Shrines.Fleeting.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Shrine.Fleeting) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Shrines.Fleeting.ColorOutline, Radar.Settings.Shrines.Fleeting.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Shrines.Fleeting.Text, Radar.Settings.Shrines.Fleeting.TextSize, Radar.Settings.Shrines.Fleeting.ColorText, v:GetPosition(), 0, -10)
    end
  end
end

if Radar.Settings.Shrines.Empowered.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Shrine.Empowered) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Shrines.Empowered.ColorOutline, Radar.Settings.Shrines.Empowered.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Shrines.Empowered.Text, Radar.Settings.Shrines.Empowered.TextSize, Radar.Settings.Shrines.Empowered.ColorText, v:GetPosition(), 0, -10)
    end
  end
end

if Radar.Settings.Shrines.Bandit.Enabled then
  for k,v in pairs(Radar.Collector.Actors.Shrine.Bandit) do  
    if not AttributeHelper.IsOperated(v) then
      RenderHelper.DrawWorldTriangleFilledMulticolor(v:GetPosition(), 4, Radar.Settings.Shrines.Bandit.ColorOutline, Radar.Settings.Shrines.Bandit.ColorFill, 3)
      RenderHelper.DrawWorldText(Radar.Settings.Shrines.Bandit.Text, Radar.Settings.Shrines.Bandit.TextSize, Radar.Settings.Shrines.Bandit.ColorText, v:GetPosition(), 0, -10) 
    end
  end
end
end

function Radar.RenderGoblins()
  for k,v in pairs(Radar.Collector.Actors.Monster.Goblin) do  
    RenderHelper.DrawWorldSquareFilledMulticolor(v:GetPosition(), Radar.Settings.Goblins.CustomRadiusValue, Radar.Settings.Goblins.ColorOutline, Radar.Settings.Goblins.ColorFill, Radar.Settings.Goblins.Thickness)

    if Radar.Settings.Goblins.Minimap == true then
      Radar.RenderACDOnMinimap("Square", v, Radar.Settings.Goblins.MinimapRadius, Radar.Settings.Goblins.ColorMinimap, Radar.Settings.Goblins.Thickness, true)
    end
  end  
end

function Radar.RenderACDOnMinimap(geometry, acd, size, color, thickness, filled)
  if geometry == "Circle" then
    RenderHelper.DrawCircle(RenderHelper.ToMinimap(acd:GetPosition()), size, color, thickness, filled)
  elseif geometry == "Square" then
    RenderHelper.DrawSquare(RenderHelper.ToMinimap(acd:GetPosition()), size, color, thickness, filled)
  end
end

function Radar.RenderACDOnMinimapAsText(acd, text, size, color)
  RenderHelper.DrawText(text, size, color, RenderHelper.ToMinimap(acd:GetPosition()))
end

function Radar.RenderOnScreenRiftProgressAtCursor()
  if AttributeHelper.IsInGreaterRift(Radar.Collector.LocalACD) == false then
    return
  end

  local cursor = Infinity.Win32.GetCursorPos()
  local tProgress = SNOGroups.GetRiftProgressPercentByPoints(Radar.Collector.MonsterRiftProgress)

  if tProgress > 0.00 then
    RenderHelper.DrawText(string.format("%.2f", tProgress) .. "%", 25, "FFFFFFFF", Vector2(cursor.x, cursor.y), -20, -20)
  end
end

function Radar.MarkEquippedItems()
  local inventoryMainPage = UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage")

  if inventoryMainPage == nil or not inventoryMainPage:GetIsVisible() then
    return
  end

  for k,v in pairs(Radar.Collector.Actors.Item.Equip) do
    local isAncient = AttributeHelper.IsAncientLegendaryItem(v)
    local isPrimal = AttributeHelper.IsPrimalLegendaryItem(v)

      if isAncient or isPrimal then
        local control = UIControlHelper.GetUIControlByItemLocation(v:GetItemLocation())

        if control ~= nil then
          local uirect = RenderHelper.TransformUIRectToClientRect(control:GetUIRect())
          local color = "FF8F4509"
          local text = "A"

          if isPrimal then
            color = "FFFF0000"
            text = "P"
          end

          RenderHelper.DrawRectFromAB(Vector2(math.floor(uirect.Left), math.floor(uirect.Top)), Vector2(math.floor(uirect.Right), math.floor(uirect.Bottom)), color, 2, 5, false)
          RenderHelper.DrawText(text, 16, color, Vector2(math.floor(uirect.Left), math.floor(uirect.Top)), 10)
        end
      end
  end
end

function Radar.MarkBackpackItems()
  local inventoryMainPage = UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage")

  if inventoryMainPage == nil or not inventoryMainPage:GetIsVisible() then
    return
  end

  local control = UIControlHelper.GetUIControlByName("Root.NormalLayer.inventory_dialog_mainPage.inventory_button_backpack")

  if control == nil then
    return
  end

  local uirect = RenderHelper.TransformUIRectToClientRect(control:GetUIRect())

  for k,v in pairs(Radar.Collector.Actors.Item.Backpack) do
    local isAncient = AttributeHelper.IsAncientLegendaryItem(v)
    local isPrimal = AttributeHelper.IsPrimalLegendaryItem(v)

      if isAncient or isPrimal then
          local color = "FF8F4509"
          local text = "A"

          if isPrimal then
            color = "FFFF0000"
            text = "P"
          end
          
          RenderHelper.DrawText(text, 16, color, Vector2(math.floor(uirect.Left + ((uirect.Width/10) * v:GetItemSlotX())), math.floor(uirect.Top + ((uirect.Height / 6) * v:GetItemSlotY()) )), 10, 2)
        
      end
  end
end

function Radar.MarkStashItems()
  local stashMainPage = UIControlHelper.GetUIControlByName("Root.NormalLayer.stash_dialog_mainPage")

  if stashMainPage == nil or not stashMainPage:GetIsVisible() then
    return
  end

  local control = UIControlHelper.GetUIControlByName("Root.NormalLayer.stash_dialog_mainPage.button_stash")

  if control == nil then
    return
  end

  local playerStash = Infinity.D3.PlayerStash()

  local stashIndex = playerStash:GetStashIndex()

  local tabIndex = 0
  
  if stashIndex == 0 then
    tabIndex = playerStash:GetStash0TabIndex()
  elseif stashIndex == 1 then
    tabIndex = playerStash:GetStash1TabIndex() + 5
  elseif stashIndex == 2 then
    tabIndex = playerStash:GetStash2TabIndex() + 10
  end
  
  local minY = tabIndex * 10
  local maxY = minY + 10

  local uirect = RenderHelper.TransformUIRectToClientRect(control:GetUIRect())
  
  for k,v in pairs(Radar.Collector.Actors.Item.Stash) do
    if v:GetItemSlotY() >= minY and v:GetItemSlotY() < maxY then 

    local isAncient = AttributeHelper.IsAncientLegendaryItem(v)
    local isPrimal = AttributeHelper.IsPrimalLegendaryItem(v)

      if isAncient or isPrimal then
          local color = "FF8F4509"
          local text = "A"

          if isPrimal then
            color = "FFFF0000"
            text = "P"
          end
          
          RenderHelper.DrawText(text, 16, color, Vector2(math.floor(uirect.Left + ((uirect.Width/7) * v:GetItemSlotX())), math.floor(uirect.Top + ((uirect.Height / 10) * (v:GetItemSlotY() - minY) ) )), 10, 2)
        
      end
    end
  end
end

function Radar.RenderLevelExit()
    if Radar.Collector.ExitScene ~= nil then
      
        for k,points in pairs(Radar.Collector.ExitScene.CellPoints) do
                      
            local sA = RenderHelper.ToMinimap(points[1])
            local sB = RenderHelper.ToMinimap(points[2])
            local sC = RenderHelper.ToMinimap(points[3])
            local sD = RenderHelper.ToMinimap(points[4])


            RenderHelper.DrawQuad(sA, sB, sC, sD, "30FF0000", 1, true)
          
        end
      
    end   
end

function Radar.RenderActorsAll()
for k,v in pairs(Radar.Collector.Actors.All) do      
  local radius =  1

  
      RenderHelper.DrawWorldCircle(v:GetPosition(), radius, Radar.Settings.Monsters.Normal.ColorOutline, Radar.Settings.Monsters.Normal.Thickness, Radar.Settings.Monsters.Normal.Fill) 
    
  end
end

function Radar.OnRenderD2D()
  if not Radar.LocalData:GetIsPlayerValid() or Radar.LocalData:GetIsStartUpGame() then
    return
  end

if Radar.Settings.Monsters.Enabled then
  Radar.RenderMonsters()
end

if Radar.Settings.Players.Enabled then
  Radar.RenderPlayers()
end

if Radar.Settings.GroundEffects.Enabled then
  Radar.RenderGroundEffects()
end

if Radar.Settings.Items.Enabled then
  Radar.RenderGroundItems()

  if Radar.Settings.Items.RiftProgressOrb.Enabled then
    Radar.RenderRiftProgressOrbItems()
  end
end

if Radar.Settings.Pylons.Enabled then
  Radar.RenderPylons()

  if Radar.Settings.Pylons.SpawnMarker.Enabled then
    Radar.RenderPylonSpawnMarker()
  end
end

if Radar.Settings.Shrines.Enabled then
  Radar.RenderShrines()
end

if Radar.Settings.Goblins.Enabled then
  Radar.RenderGoblins()
end

Radar.RenderLevelExit()

Radar.MarkEquippedItems()
Radar.MarkBackpackItems()
Radar.MarkStashItems()

Radar.RenderOnScreenRiftProgressAtCursor()

--Radar.RenderActorsAll()
end