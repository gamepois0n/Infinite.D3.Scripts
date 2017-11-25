LevelAreaHelper = {}
LevelAreaHelper.RevealedScenes = Infinity.D3.GetRevealedScenes()

function LevelAreaHelper.SetAllFullyVisible()
	for k,v in pairs(LevelAreaHelper.RevealedScenes) do
		v:SetIsFullyVisible()
	end
end

--LevelAreaHelper.SetAllFullyVisible()