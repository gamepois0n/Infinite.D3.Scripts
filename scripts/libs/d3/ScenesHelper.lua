ScenesHelper = {}
ScenesHelper.SceneData = Infinity.D3.GetSceneData()

function ScenesHelper.GetCurrentScenes()
	return Infinity.D3.GetScenes()
end

function ScenesHelper.GetSceneData(sceneSnoId)
	return ScenesHelper.SceneData[sceneSnoId]
end