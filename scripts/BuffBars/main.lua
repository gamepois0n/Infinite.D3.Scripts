Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStart", function() 
    BuffBars.Start()
    end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStop", function() 
    BuffBars.Stop()
    end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
    BuffBars.OnPulse()
  end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
    BuffBarsSettings.DrawMainWindow()

    TextureViewer.DrawMainWindow()     
  end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnRenderD2D", function()
    BuffBars.OnRenderD2D()
  end)