local TexBase = class("TexBase")

TEX_DIAMETER = 76

CASTLE_DIAMETER = TEX_DIAMETER * 3

TexBase.TEX_TYPE_ROOM = 1
TexBase.TEX_TYPE_KING = 2
TexBase.TEX_TYPE_SOLDIER = 3

function TexBase:ctor()

    self.position_ = cc.p(0, 0)
    self.rotation_ = 0

    self.touchRange_ = TEX_DIAMETER * 0.43
    
    self.type_ = 0
    
end

function TexBase:getPosition()
    return self.position_.x, self.position_.y
end

function TexBase:getRotation()
    return self.rotation_
end

function TexBase:setRotation(x, y)

    local curRotation = - math.deg(math.atan2(self.position_.y - y,self.position_.x - x)) - 180
        
    self.rotation_ = curRotation - curRotation % 60 + 120
    
end

function TexBase:setInitPosition(castleId, roomId)

    if (castleId < 1 or castleId > 7) or (roomId < 1 or roomId > 7) then
        print("error castleId or roomId")
        return
    end
    
    -- 1 TOP
    -- 2 TOP_RIGHT
    -- 3 BOTTOM_RIGHT
    -- 4 BOTTOM
    -- 5 BOTTOM_LEFT
    -- 6 TOP_LEFT
    -- 7 CENTER
    
    local pRoomDiff = {
                cc.p(0,TEX_DIAMETER),
                cc.p(TEX_DIAMETER * math.sin(math.pi/3), TEX_DIAMETER * 0.5),
                cc.p(TEX_DIAMETER * math.sin(math.pi/3), -TEX_DIAMETER * 0.5),
                cc.p(0, -TEX_DIAMETER),
                cc.p(-TEX_DIAMETER * math.sin(math.pi/3), -TEX_DIAMETER * 0.5),
                cc.p(-TEX_DIAMETER * math.sin(math.pi/3), TEX_DIAMETER * 0.5),
                cc.p(0,0)
            }
            
    local pCastleDiff = {
                cc.p(0,CASTLE_DIAMETER),
                cc.p(CASTLE_DIAMETER * math.sin(math.pi/3), CASTLE_DIAMETER * 0.5),
                cc.p(CASTLE_DIAMETER * math.sin(math.pi/3), -CASTLE_DIAMETER * 0.5),
                cc.p(0, -CASTLE_DIAMETER),
                cc.p(-CASTLE_DIAMETER * math.sin(math.pi/3), -CASTLE_DIAMETER * 0.5),
                cc.p(-CASTLE_DIAMETER * math.sin(math.pi/3), CASTLE_DIAMETER * 0.5),
                cc.p(0,0)
    
            }

    self.position_ = cc.pAdd(cc.pAdd(cc.p(display.cx, display.cy),pCastleDiff[castleId]), pRoomDiff[roomId])

end

function TexBase:checkTouch(x, y)
    local dx, dy = x - self.position_.x, y - self.position_.y
    local offset = math.sqrt(dx * dx + dy * dy)
    return offset <= self.touchRange_
end

return TexBase