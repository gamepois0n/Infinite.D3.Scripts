Combat = { }
Combat.Running = false
Combat.Settings = Settings()
Combat.CombatScript = nil
Combat.Collector = Collector()

function Combat.Start()
  Combat.Running = true

  CombatSettings.LoadSettings()
  Combat.LoadCombatScripts()
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

    if not Combat.CombatScript.Init then
        print("Combat script doesn't have .Init function !")
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

function Combat.OnPulse()
  if Combat.Running == false then
    return
  end

  Combat.Collector:Collect()

  if Combat.CombatScript ~= nil then
    local monsterTarget = TargetHelper.GetMonsterTargetACD()    
    local player = Infinity.D3.GetLocalACD()
    
    --[[if not Combat.CombatScript.InitDone then
      Combat.CombatScript:Init(player)
    end]]--

    if Combat.Settings.Defend.Enabled then
      Combat.CombatScript:Defend(player, monsterTarget)
    end

    if Combat.Settings.Buff.Enabled then
      Combat.CombatScript:Buff(player, monsterTarget)
    end

    if Combat.Settings.Attack.Enabled then
      Combat.CombatScript:Attack(player, monsterTarget)
    end
  end    
end

function Combat.OnRenderD2D()
end