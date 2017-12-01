LevelAreaHelper = {}
LevelAreaHelper.RevealedScenes = Infinity.D3.GetRevealedScenes()

function LevelAreaHelper.RevealAllScenes()
	for k,v in pairs(Infinity.D3.GetRevealedScenes()) do
		if v:GetIsFullyVisible() == 0 then
			v:Reveal()
			v:SetTextureSnoId1(-1)
			v:SetIsFullyVisible()		
		end
	end
end

function LevelAreaHelper.DumpAllScenes()
	local t = {}

	for k,v in pairs(Infinity.D3.GetRevealedScenes()) do		
		table.insert(t, {Address = v.Address, TextureSnoId0 = v:GetTextureSnoId0(), TextureSnoId1 = v:GetTextureSnoId1()})
	end

	local json = JSON:new()
    Infinity.FileSystem.WriteFile("Dump_AllScenes.txt", json:encode_pretty(t))
end
