CombatSettings = { }
CombatSettings.AvailablesCombats = {}
CombatSettings.CombatsComboBoxSelected = 0

CombatSettings.Hotkeys = {}
CombatSettings.SelectedHotkeyIndex = 0

function CombatSettings.AddNewParagonPointSet()
    table.insert(Combat.Settings.ParagonPoints, {Mainstat = "0", Vitality = "0", MovementSpeed = "0", MaxResource = "0", Hotkey = -1})
end

function CombatSettings.DrawMainWindow()
	local valueChanged = false
	
  	ImGui.Begin("Combat Settings", true)    
   
    if ImGui.CollapsingHeader("Combat Script", "id_combat_script", true, false) then
      valueChanged, CombatSettings.CombatsComboBoxSelected = ImGui.Combo("Combat script##id_gui_combat_script", table.findIndex(CombatSettings.AvailablesCombats, Combat.Settings.LastCombatScript), CombatSettings.AvailablesCombats)

        if valueChanged then
            Combat.Settings.LastCombatScript = CombatSettings.AvailablesCombats[CombatSettings.CombatsComboBoxSelected]
            print("Combat script selected : " .. Combat.Settings.LastCombatScript)
            Combat.LoadCombatScripts()
        end

        _, Combat.Settings.Defend.Enabled = ImGui.Checkbox("Defend Callback##defend", Combat.Settings.Defend.Enabled)
        _, Combat.Settings.Buff.Enabled = ImGui.Checkbox("Buff Callback##buff", Combat.Settings.Buff.Enabled)
        _, Combat.Settings.Attack.Enabled = ImGui.Checkbox("Attack Callback##attack", Combat.Settings.Attack.Enabled)  
    end

    if ImGui.CollapsingHeader("ParagonPoint Sets", "id_paragonpoint_sets", true, false) then
        if ImGui.Button("Add##id_paragonpoint_set_add") then
            CombatSettings.AddNewParagonPointSet()
        end

        for k,v in pairs(Combat.Settings.ParagonPoints) do
            if ImGui.Button("X##id_paragonpoint_set_remove_" .. k) then
                table.remove(Combat.Settings.ParagonPoints, k)
            end

            ImGui.SameLine()

            if ImGui.CollapsingHeader("Set " .. k, "id_paragonpoint_set" .. k, true, false) then
                _, Combat.Settings.ParagonPoints[k].Mainstat = ImGui.InputText("Mainstat##id_set_mainstat_" .. k, Combat.Settings.ParagonPoints[k].Mainstat)                
                _, Combat.Settings.ParagonPoints[k].Vitality = ImGui.InputText("Vitality##id_set_vitality_" .. k, Combat.Settings.ParagonPoints[k].Vitality)
                _, Combat.Settings.ParagonPoints[k].MovementSpeed = ImGui.InputText("MovementSpeed##id_set_movementspeed_" .. k, Combat.Settings.ParagonPoints[k].MovementSpeed)
                _, Combat.Settings.ParagonPoints[k].MaxResource = ImGui.InputText("MaxResource##id_set_maxresource_" .. k, Combat.Settings.ParagonPoints[k].MaxResource)

                valueChanged, CombatSettings.SelectedHotkeyIndex = ImGui.Combo("Hotkey##id_set_hotkey_" .. k, Combat.Settings.ParagonPoints[k].Hotkey + 2, CombatSettings.Hotkeys) 

                if valueChanged then
                    Combat.Settings.ParagonPoints[k].Hotkey = CombatSettings.SelectedHotkeyIndex - 2
                end            
            end
        end
    end

  ImGui.End()
end

function CombatSettings.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(Combat.Settings))
end

function CombatSettings.LoadSettings()
    local json = JSON:new()
    Combat.Settings = Settings()
    
    table.merge(Combat.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end

function CombatSettings.RefreshAvailableCombatScripts()
    CombatSettings.AvailablesCombats = { }
    for k, v in pairs(Infinity.FileSystem.GetFiles("CombatScripts\\*.lua")) do
        table.insert(CombatSettings.AvailablesCombats, v)

    end
end

function CombatSettings.GetHotkeys()
    for k,v in pairs(Combat.Hotkeys) do
        table.insert(CombatSettings.Hotkeys, v.Name)
    end
end

CombatSettings.RefreshAvailableCombatScripts()