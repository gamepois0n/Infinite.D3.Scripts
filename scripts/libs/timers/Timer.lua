Timer = {}
Timer.__index = Timer

function Timer:New(seconds)

  local o = {
    _expireSeconds = seconds,
    _startTime = nil,
    _stopTime = nil,

  }
  setmetatable(o, self)
  return o
end


Timer.Start = function(self)
  self._startTime = os.clock()
  self._stopTime = nil
end

Timer.Stop = function(self)

  self._stopTime = os.clock ()
end

Timer.Reset = function(self)
  if self._stopTime == nil then
    self._startTime = os.clock ()
  else
    self._startTime = nil
    self._stopTime = nil
  end
end

Timer.IsRunning = function(self)
  if self._startTime ~= nil and self._stopTime == nil then
    return true
  end
  return false
end

Timer.Expired = function(self)

  if self._startTime ~= nil and self._stopTime == nil and self._expireSeconds + self._startTime <= os.clock ()
    or self._startTime ~= nil and self._stopTime ~= nil and self._expireSeconds + self._startTime <= self._stopTime then
    return true
  end

  return false

end
