
local TexBase = import(".TexBase")

local Room = class("Room",TexBase)

function Room:ctor()
    Room.super.ctor(self)
    
    self.type_ = TexBase.TEX_TYPE_ROOM
    
end

function Room:getSpriteName()
	return "img/room.png"
end




return Room