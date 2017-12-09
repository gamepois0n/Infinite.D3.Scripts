Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)

  self.BuffBars = {{Name = "Default", ContainerTextureFile = "Images\\2DUI_Skills_Barbarian_All.dds", ContainerImageAtlasIndex = 3, ContainerSize = 50, IconSize = 40, ScreenX = 0.5, ScreenY = 0.5, LimitX = 10, LimitY = 3, Powers = {{TextureFile = "Images\\2DUI_Skills_Barbarian_All.dds", AtlasIndex = 35, PowerSNO = 375483, Layer = 0}}}}

  return self
end
