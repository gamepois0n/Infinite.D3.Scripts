CombatSettings = { }
CombatSettings.AvailablesCombats = {}
CombatSettings.CombatsComboBoxSelected = 0

function CombatSettings.DrawMainWindow()
	local valueChanged = false
	
  	ImGui.Begin("Combat Settings", true)    
    if ImGui.Button("Save settings", ImVec2(ImGui.GetContentRegionAvailWidth() / 2, 20)) then
		CombatSettings.SaveSettings()
		print("Settings saved")
	end
	
    valueChanged, CombatSettings.CombatsComboBoxSelected = ImGui.Combo("Combat script##id_gui_combat_script", table.findIndex(CombatSettings.AvailablesCombats, Combat.Settings.LastCombatScript), CombatSettings.AvailablesCombats)
    if valueChanged then
    	Combat.Settings.LastCombatScript = CombatSettings.AvailablesCombats[CombatSettings.CombatsComboBoxSelected]
        print("Combat script selected : " .. Combat.Settings.LastCombatScript)
        Combat.LoadCombatScripts()
    end

    _, Combat.Settings.Defend.Enabled = ImGui.Checkbox("Defend Callback##defend", Combat.Settings.Defend.Enabled)
    _, Combat.Settings.Buff.Enabled = ImGui.Checkbox("Buff Callback##buff", Combat.Settings.Buff.Enabled)
    _, Combat.Settings.Attack.Enabled = ImGui.Checkbox("Attack Callback##attack", Combat.Settings.Attack.Enabled)

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

CombatSettings.RefreshAvailableCombatScripts()