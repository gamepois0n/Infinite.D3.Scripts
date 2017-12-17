Inspector = { }
Inspector.Running = false
Inspector.AllAttributes = {}
Inspector.NoModAttributes = {}
Inspector.ModAttributes = {}
Inspector.Collector = Collector()

function Inspector.Start()
  Inspector.Running = true
end

function Inspector.Stop()
  Inspector.Running = false
end

function Inspector.OnPulse()
  if Inspector.Running == false then
    return
  end     

  Inspector.Collector:Collect(false, false)
end

function Inspector.OnRenderD2D()
	if MainWindow.RenderSelectedUIControl and MainWindow.SelectedUIControl ~= nil then
		local uirect = MainWindow.SelectedUIControl:GetUIRect()
		
		local center = Vector2(math.floor(uirect.Left + (uirect.Width / 2)), math.floor(uirect.Top + (uirect.Height / 2)))

		--print(MainWindow.SelectedUIControl:GetUIRect().Left .. " , " .. MainWindow.SelectedUIControl:GetUIRect().Top .. " , " .. MainWindow.SelectedUIControl:GetUIRect().Right .. " , " .. MainWindow.SelectedUIControl:GetUIRect().Bottom)

		RenderHelper.DrawRect(center, uirect.Width, uirect.Height, "FFFFFFFF", 2)
	end
end