MainWindow = { }
MainWindow.AttributeDescriptors = Infinity.D3.GetAttributeDescriptors()
MainWindow.PowerSNOs = Infinity.D3.GetPowerSNOs()
MainWindow.SNOFilter = ""
MainWindow.GBIdFilter = ""
MainWindow.NameFilter = ""

MainWindow.AttributeIdFilter = ""
MainWindow.AttributeNameFilter = ""
MainWindow.AttributePowerSNOFilter = ""
MainWindow.AttributePowerNameFilter = ""

MainWindow.UIControlNameFilter = ""
MainWindow.UIFunctionNameFilter = ""
MainWindow.SelectedUIControl = nil
MainWindow.RenderSelectedUIControl = false

function MainWindow.DrawMainWindow()   
  ImGui.Begin("Inspector")
    
  if ImGui.CollapsingHeader("Local Player", "id_localplayer", true, false) then  
    if ImGui.CollapsingHeader("Active Skills", "id_localplayer_activeskills", true, false) then
      for k,v in pairs(SkillHelper.GetActiveSkills()) do
        ImGui.Text(AttributeHelper.PowerSNOs[v.PowerSNO] .. "(" .. v.PowerSNO .. ") Rune: " .. v.Rune .. " IsOnCooldown: " .. tostring(SkillHelper.IsOnCooldown(v.PowerSNO)))
      end
    end

    if ImGui.CollapsingHeader("Passive Skills", "id_localplayer_passiveskills", true, false) then  
      for k,v in pairs(SkillHelper.GetPassiveSkills()) do
        ImGui.Text(AttributeHelper.PowerSNOs[v] .. "(" .. v .. ")")
      end
    end

    if ImGui.CollapsingHeader("All Attributes", "id_localplayer_all_attributes", true, false) then
      _, MainWindow.AttributeIdFilter = ImGui.InputText("Filter by AttributeId##attribid", MainWindow.AttributeIdFilter)
      _, MainWindow.AttributeNameFilter = ImGui.InputText("Filter by AttributeName##attribname", MainWindow.AttributeNameFilter)
      _, MainWindow.AttributePowerSNOFilter = ImGui.InputText("Filter by PowerSNO##attrib_powersno", MainWindow.AttributePowerSNOFilter)
      _, MainWindow.AttributePowerNameFilter = ImGui.InputText("Filter by PowerName##attrib_powername", MainWindow.AttributePowerNameFilter)

      ImGui.Columns(5)
      ImGui.Text("AttributeId")
      ImGui.NextColumn()
      ImGui.Text("AttributeName")
      ImGui.NextColumn()
      ImGui.Text("PowerSNO")
      ImGui.NextColumn()
      ImGui.Text("PowerName")
      ImGui.NextColumn()
      ImGui.Text("Value")      
      ImGui.NextColumn()
      
      for k,v in pairs(AttributeHelper.GetAllAttributes(Infinity.D3.GetLocalACD())) do
        local attrib = v

          if MainWindow.AttributeIdFilter ~= "" and string.find(tostring(v.AttributeId), MainWindow.AttributeIdFilter) == nil then
            attrib = nil
          end

          if MainWindow.AttributeNameFilter ~= "" and string.find(tostring(v.AttributeName), MainWindow.AttributeNameFilter) == nil then
            attrib = nil
          end

          if MainWindow.AttributePowerSNOFilter ~= "" and string.find(tostring(v.PowerSNO), MainWindow.AttributePowerSNOFilter) == nil then
            attrib = nil
          end

          if MainWindow.AttributePowerNameFilter ~= "" and string.find(tostring(v.PowerName), MainWindow.AttributePowerNameFilter) == nil then
            attrib = nil
          end

            if attrib ~= nil then 
            ImGui.Text(v.AttributeId)
            ImGui.NextColumn()
            ImGui.Text(v.AttributeName)
            ImGui.NextColumn()
            ImGui.Text(v.PowerSNO)
            ImGui.NextColumn()
            ImGui.Text(v.PowerName)
            ImGui.NextColumn()
            ImGui.Text(v.Value)
            ImGui.NextColumn()   
            end       
      end
    end    
  end

  if ImGui.CollapsingHeader("ACDs", "id_acds", true, false) then
    _, MainWindow.SNOFilter = ImGui.InputText("Filter by ActorSNO##acds_sno_filter", MainWindow.SNOFilter)
    _, MainWindow.GBIdFilter = ImGui.InputText("Filter by GameBalanceID##acds_gbid_filter", MainWindow.GBIdFilter)
    _, MainWindow.NameFilter = ImGui.InputText("Filter by Name##acds_name_filter", MainWindow.NameFilter)

    for k,v in pairs(Infinity.D3.GetACDList()) do
      local acd = v

      if MainWindow.SNOFilter ~= "" and string.find(tostring(v:GetActorSNO()), MainWindow.SNOFilter) == nil then
        acd = nil
      end

      if MainWindow.GBIdFilter ~= "" and string.find(tostring(v:GetGameBalanceID()), MainWindow.GBIdFilter) == nil then
        acd = nil
      end

      if MainWindow.NameFilter ~= "" and string.find(v:GetName(), MainWindow.NameFilter) == nil then
        acd = nil
      end

      if acd ~= nil then
        if ImGui.CollapsingHeader("Name(" ..v:GetName() .. ") ActorSNO(" .. v:GetActorSNO() .. ") ActorType(" .. v:GetActorType() .. ") ActorId(" .. v:GetActorId() .. ") GameBalanceType(" .. v:GetGameBalanceType() .. ") GizmoType(" .. v:GetGizmoType() .. ")", "id_acd_" .. v:GetActorId(), true, false) then
          if ImGui.CollapsingHeader("Attributes", "id_acd_attributes" .. v:GetActorId(), true, false) then
            ImGui.Columns(5)
            ImGui.Text("AttributeId")
            ImGui.NextColumn()
            ImGui.Text("AttributeName")
            ImGui.NextColumn()
            ImGui.Text("PowerSNO")
            ImGui.NextColumn()
            ImGui.Text("PowerName")
            ImGui.NextColumn()
            ImGui.Text("Value")      
            ImGui.NextColumn()
                        
            for k,v in pairs(AttributeHelper.GetAllAttributes(v)) do 
              ImGui.Text(v.AttributeId)
              ImGui.NextColumn()
              ImGui.Text(v.AttributeName)
              ImGui.NextColumn()
              ImGui.Text(v.PowerSNO)
              ImGui.NextColumn()
              ImGui.Text(v.PowerName)
              ImGui.NextColumn()
              ImGui.Text(v.Value)
              ImGui.NextColumn()          
            end
          end
        end
      end
    end
  end
  
  if ImGui.CollapsingHeader("RActors", "id_ractors", true, false) then
   
    for k,v in pairs(Infinity.D3.GetRActorList()) do
      local ractor = v
      
      if ractor ~= nil then
        if ImGui.CollapsingHeader("Name(" ..v:GetName() .. ") ActorSNO(" .. v:GetActorSNO() .. ") ActorId(" .. v:GetActorId() .. ")", "id_ractor_" .. v:GetActorId(), true, false) then
        end
      end
    end
  end
          

  if ImGui.CollapsingHeader("UIControls", "id_uicontrols", true, false) then
    _, MainWindow.UIControlNameFilter = ImGui.InputText("Filter by Name##acds_name_filter", MainWindow.UIControlNameFilter)

    ImGui.Text("Hovered UIControl: " .. Infinity.D3.GetHoveredUIControlName() .. " (" .. tostring(Infinity.D3.GetHoveredUIControlKey()) .. ")")

    if ImGui.Button("Search UIControl") then
      MainWindow.SelectedUIControl = MainWindow.GetUIControlByName(MainWindow.UIControlNameFilter)
    end

    if MainWindow.SelectedUIControl ~= nil then
      if ImGui.CollapsingHeader(MainWindow.SelectedUIControl:GetName(), "id_uicontrol_" .. MainWindow.SelectedUIControl:GetKey(), true, false) then
        _, MainWindow.RenderSelectedUIControl = ImGui.Checkbox("Draw##id_draw", MainWindow.RenderSelectedUIControl)
        local rect = MainWindow.SelectedUIControl:GetUIRect()
        ImGui.Text("UIRect: Left " .. rect.Left .. " Top " .. rect.Top .. " Right " .. rect.Right .. " Bottom " .. rect.Bottom .. " Width " .. rect.Width .. " Height " .. rect.Height)
      end
    end

    if ImGui.CollapsingHeader("UIFunctions", "id_uifunctions", true, false) then
      _, MainWindow.UIFunctionNameFilter = ImGui.InputText("Filter by Name##uifunctions_name_filter", MainWindow.UIFunctionNameFilter)

      for k,v in pairs(UIInteractionHelper.GetAllFunctions()) do
        local func = v

        if MainWindow.UIFunctionNameFilter ~= "" and string.find(v:GetName(), MainWindow.UIFunctionNameFilter) == nil then
          func = nil
        end

        if func ~= nil then
          ImGui.Text(v:GetName())
          ImGui.SameLine()
          if ImGui.Button("Call##id_uifunc_" .. v:GetName()) then
            v:Use()
          end
        end
      end
    end
  end
  ImGui.End()
end

function MainWindow.GetUIControlByName(name)
  for k,v in pairs(UIControlHelper.GetAllUIControls()) do
    if v:GetName() == name then
      return v
    end
  end

  return nil
end