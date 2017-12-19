Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)

  self.BuffBars = {{Enabled = true, Name = "Default", ContainerTextureFile = "Images\\2DUI_Skills_Barbarian_All.dds", ContainerImageAtlasIndex = 3, ContainerSize = 50, IconSize = 40, ScreenX = 0.5, ScreenY = 0.5, LimitX = 10, LimitY = 3, Powers = {{TextureFile = "Images\\2DUI_Skills_Barbarian_All.dds", AtlasIndex = 35, PowerSNO = 375483, Layer = 0}}}}

  self.PartyMemberBuffBar = {IconSize = 40, OffsetX = 30, OffsetY = 50, Powers = {{TextureFile = "Images\\2DUIBuffIcons_p2.dds", AtlasIndex = 3, PowerSNO = 430674, Layer = 1}, {TextureFile = "Images\\2DUIBuffIcons_p2.dds", AtlasIndex = 4, PowerSNO = 430674, Layer = 3}, {TextureFile = "Images\\2DUIBuffIcons_p2.dds", AtlasIndex = 5, PowerSNO = 430674, Layer = 2}, {TextureFile = "Images\\2DUIBuffIcons_p2.dds", AtlasIndex = 6, PowerSNO = 430674, Layer = 4}, {TextureFile = "Images\\2DUIBuffIcons_p2.dds", AtlasIndex = 7, PowerSNO = 430674, Layer = 5}, {TextureFile = "Images\\2DUIBuffIcons_p2.dds", AtlasIndex = 8, PowerSNO = 430674, Layer = 6}, {TextureFile = "Images\\2DUIBuffIcons_p2.dds", AtlasIndex = 9, PowerSNO = 430674, Layer = 7}}}

  return self
end
