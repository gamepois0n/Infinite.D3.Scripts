Combat = { }
Combat.Running = false
Combat.Settings = Settings()
Combat.CombatScript = nil
Combat.Collector = Collector()
Combat.LocalData = Infinity.D3.GetLocalData()

Combat.Hotkeys = {
{Name = "None", Function = (function() return false end), LastInput = 0},
{Name = "Numpad0", Function = (function() return InputHelper.IsNumpad0Pressed() end), LastInput = 0},
{Name = "Numpad1", Function = (function() return InputHelper.IsNumpad1Pressed() end), LastInput = 0},
{Name = "Numpad2", Function = (function() return InputHelper.IsNumpad2Pressed() end), LastInput = 0},
{Name = "Numpad3", Function = (function() return InputHelper.IsNumpad3Pressed() end), LastInput = 0},
{Name = "Numpad4", Function = (function() return InputHelper.IsNumpad4Pressed() end), LastInput = 0},
{Name = "Numpad5", Function = (function() return InputHelper.IsNumpad5Pressed() end), LastInput = 0},
{Name = "Numpad6", Function = (function() return InputHelper.IsNumpad6Pressed() end), LastInput = 0},
{Name = "Numpad7", Function = (function() return InputHelper.IsNumpad7Pressed() end), LastInput = 0},
{Name = "Numpad8", Function = (function() return InputHelper.IsNumpad8Pressed() end), LastInput = 0},
{Name = "Numpad9", Function = (function() return InputHelper.IsNumpad9Pressed() end), LastInput = 0},
}

Combat.ApplySet = false
Combat.ApplySetIndex = 0
Combat.OldAvailablePoints = 0

function Combat.Start()
  Combat.Running = true

  CombatSettings.LoadSettings()
  Combat.LoadCombatScripts()
  CombatSettings.GetHotkeys()
end

function Combat.LoadCombatScripts()
    local combatScriptFile = Combat.Settings.LastCombatScript
    local code = Infinity.FileSystem.ReadFile("CombatScripts/" .. combatScriptFile)
    combatScriptFunc, combatScriptError = load(code)
    if combatScriptFunc == nil then
        print(string.format("Unable to load combat script: func %s err %s", tostring(combatScriptFunc), tostring(combatScriptError)))
        return
    end

    Combat.CombatScript = combatScriptFunc()

    if not Combat.CombatScript then
        print("Unable to load combat script !")
        Combat.CombatScript = nil
        return
    end
    
    if not Combat.CombatScript.Attack then
        print("Combat script doesn't have .Attack function !")
        Combat.CombatScript = nil
        return
    end   

    if not Combat.CombatScript.Defend then
        print("Combat script doesn't have .Defend function !")
        Combat.CombatScript = nil
        return
    end 

    if not Combat.CombatScript.Buff then
        print("Combat script doesn't have .Buff function !")
        Combat.CombatScript = nil
        return
    end     
end

function Combat.Stop()
  Combat.Running = false

  CombatSettings.SaveSettings()
end

function Combat.ApplyParagonPointSet(index)
  local availablePoints0 = AttributeHelper.GetAttributeValue(Combat.Collector.LocalACD, Enums.AttributeId.Paragon_Bonus_Points_Available, 0)

  ParagonPointHelper.ResetCurrentTab()
  
  if Combat.OldAvailablePoints == availablePoints0 then
    return false
  end
  
  local set = Combat.Settings.ParagonPoints[index]

  if tonumber(set.Mainstat) == -1 then
    ParagonPointHelper.SetMaxResource(tonumber(set.MaxResource))
    availablePoints0 = availablePoints0 - tonumber(set.MaxResource)

    ParagonPointHelper.SetMovementSpeed(tonumber(set.MovementSpeed))
    availablePoints0 = availablePoints0 - tonumber(set.MovementSpeed)

    ParagonPointHelper.SetVitality(tonumber(set.Vitality))
    availablePoints0 = availablePoints0 - tonumber(set.Vitality)

    ParagonPointHelper.SetMainstat(availablePoints0)  
  elseif tonumber(set.Vitality) == -1 then
    ParagonPointHelper.SetMaxResource(tonumber(set.MaxResource))
    availablePoints0 = availablePoints0 - tonumber(set.MaxResource)

    ParagonPointHelper.SetMovementSpeed(tonumber(set.MovementSpeed))
    availablePoints0 = availablePoints0 - tonumber(set.MovementSpeed)

    ParagonPointHelper.SetMainstat(tonumber(set.Mainstat))
    availablePoints0 = availablePoints0 - tonumber(set.Mainstat)

    ParagonPointHelper.SetVitality(availablePoints0)
  else
    ParagonPointHelper.SetMaxResource(tonumber(set.MaxResource))

    ParagonPointHelper.SetMovementSpeed(tonumber(set.MovementSpeed))

    ParagonPointHelper.SetVitality(tonumber(set.Vitality))

    ParagonPointHelper.SetMainstat(tonumber(set.Mainstat))
  end  

  ParagonPointHelper.ApplyPoints()

  Combat.OldAvailablePoints = 0
  Combat.ApplySet = false

  return true
end

function Combat.EvaluateHotkeys()
  for k,v in pairs(Combat.Settings.ParagonPoints) do
    if v.Hotkey ~= -1 and Combat.Hotkeys[v.Hotkey + 2].LastInput + 500 <= Infinity.Win32.GetTickCount() and Combat.Hotkeys[v.Hotkey + 2].Function() == true then      
      Combat.ApplySetIndex = k
      Combat.ApplySet = true

      Combat.OldAvailablePoints = AttributeHelper.GetAttributeValue(Combat.Collector.LocalACD, Enums.AttributeId.Paragon_Bonus_Points_Available, 0)

      Combat.Hotkeys[v.Hotkey + 2].LastInput = Infinity.Win32.GetTickCount()
      return
    end
  end
end

function Combat.OnPulse()
  if Combat.Running == false then
    return
  end
  
  Combat.Collector:Collect(false, false, false, -1)
    
  if Infinity.D3.GetIsGamePaused() or not Combat.LocalData:GetIsPlayerValid() or Combat.Collector.LocalACD == nil or AttributeHelper.GetHitpointPercentage(Combat.Collector.LocalACD) < 0.00001 then
    return
  end
  
  if Infinity.D3.GetHoveredUIControlKey() ~= -1 or Infinity.D3.GetGrabbedItemACDIndex() ~= -1 then
    return
  end

  if not Combat.ApplySet then
    Combat.EvaluateHotkeys()    
  end

  if Combat.ApplySet then    
    Combat.ApplyParagonPointSet(Combat.ApplySetIndex)
  end

  if AttributeHelper.IsInTown(Combat.Collector.LocalACD) or AttributeHelper.IsTeleporting(Combat.Collector.LocalACD) or AttributeHelper.IsOperatingGizmo(Combat.Collector.LocalACD) then
    return
  end

  if AttributeHelper.GetAttributeValue(Combat.Collector.LocalACD, Enums.AttributeId.CantStartDisplayedPowers, -1) == 1 then
    return
  end

  if Combat.CombatScript ~= nil then
    local monsterTarget = TargetHelper.GetTargetACD(Combat.Collector.Actors.Monster.All)    
          
    local isMoving = RActorHelper.IsMoving(Combat.Collector.LocalACD)

    if Combat.Settings.Defend.Enabled then
      Combat.CombatScript:Defend(Combat.Collector.LocalACD, monsterTarget, isMoving)
    end

    if Combat.Settings.Buff.Enabled then
      Combat.CombatScript:Buff(Combat.Collector.LocalACD, monsterTarget, isMoving)
    end

    if Combat.Settings.Attack.Enabled then
      Combat.CombatScript:Attack(Combat.Collector.LocalACD, monsterTarget, isMoving)
    end
  end
end

function Combat.OnRenderD2D()
end