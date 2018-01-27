TryWaypointMessage = { }
TryWaypointMessage.__index = TryWaypointMessage 

setmetatable(TryWaypointMessage , {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function TryWaypointMessage:new(WaypointAnnId, WaypointId)
	local self = setmetatable({}, TryWaypointMessage)

	self.Id = 162
	self.Length = 11
	
	self.GameBitBuffer = Infinity.D3.Net.GameBitBuffer(self.Length)

	self.GameBitBuffer:WriteInt32(32, self.Length);
	self.GameBitBuffer:WriteInt32(10, self.Id);

	self.GameBitBuffer:WriteInt32(32, WaypointAnnId);
	self.GameBitBuffer:WriteInt32(7, WaypointId);

	return self  
end

function TryWaypointMessage:Send()
	self.GameBitBuffer:Send(self.Length)
end