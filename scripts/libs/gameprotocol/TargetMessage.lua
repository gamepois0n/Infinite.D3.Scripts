TargetMessage = { }
TargetMessage.__index = TargetMessage

setmetatable(TargetMessage, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function TargetMessage:new(field0, targetAnnId, targetPos, worldId, powerSno)
	local self = setmetatable({}, TargetMessage)

	self.Id = 84
	self.Length = 35

	self.GameBitBuffer = Infinity.D3.Net.GameBitBuffer(self.Length)

	self.GameBitBuffer:WriteInt32(32, self.Length);
	self.GameBitBuffer:WriteInt32(10, self.Id);
	self.GameBitBuffer:WriteInt32(3, field0);
	self.GameBitBuffer:WriteInt32(32, targetAnnId);
	self.GameBitBuffer:WriteFloat(targetPos.X);
	self.GameBitBuffer:WriteFloat(targetPos.Y);
	self.GameBitBuffer:WriteFloat(targetPos.Z);
	self.GameBitBuffer:WriteInt32(32, worldId);
	self.GameBitBuffer:WriteInt32(32, powerSno);
	self.GameBitBuffer:WriteInt32(32, -1);
	self.GameBitBuffer:WriteInt32(2, 0);
	self.GameBitBuffer:WriteInt32(1, 0);

	self.GameBitBuffer:WriteBufferByte(self.Length - 1, 0x20);

	return self  
end

function TargetMessage:Send()
	self.GameBitBuffer:Send(self.Length)
end