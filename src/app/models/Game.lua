local Room = import(".Room")

local Game = class("Game")

function Game:ctor(stage)
    
    self.stage_ = stage

    self.texes_ = {}
    self.texSprites_ = {}
    
    self.pTouchBegin_ = cc.p(0,0)
    
    self.curTex_ = nil
    self.curTexSprites_ =nil
    
end

function Game:addTex(castleId, roomId)

    local Tex = Room.new()

    self.texes_[#self.texes_ + 1] = Tex

    Tex:setInitPosition(castleId, roomId)

    local TexSprite = display.newSprite(Tex:getSpriteName())
        :pos(Tex:getPosition())
        :zorder(2)
        :rotation(Tex:getRotation())
        :addTo(self.stage_)

    self.texSprites_[#self.texSprites_ + 1] = TexSprite

end

function Game:onTouch(event)


    if event.name == "began" then
    
        self.pTouchBegin_.x, self.pTouchBegin_.y = event.x, event.y

        for i = #self.texes_, 1, -1 do
            local tex = self.texes_[i]
            local texSprite = self.texSprites_[i]
            if tex:checkTouch(event.x, event.y) then
                self.curTex_ = tex
                self.curTexSprites_ = texSprite
                self.curIndex_ = i
            end
        end
        
        self:deployKing_()
        
        return true
    end
    
    if event.name == "moved" then
    
        if self.curTex_ == nil then
            return
        end
        
        if self.curTexSprites_ == nil then
            return
        end

        if self.curIndex_ == 0 then
            return
        end        
        
        
        if self.curTex_:checkTouch(event.x, event.y) then
            print("2")
        end
        
        print("3")
        self:deploySoldier_()
        self.curTex_:setRotation(event.x, event.y)
        self.curTexSprites_:rotation(self.curTex_:getRotation())
        
    
    end
    
    if event.name == "ended" then
        print("4")
        self.curTex_ = nil
        self.curTexSprites_ = nil
        self.curIndex_ = 0
    end

    return false
end

function Game:deployKing_()

    if self.curTex_ == nil then
        return
    end

    if self.curTexSprites_ == nil then
        return
    end

    if self.curIndex_ == 0 then
        return
    end  

    local Tex = self.curTex_
    
    self.curTexSprites_:removeSelf()
    
    self.curTexSprites_ = display.newSprite("img/king.png")
        :pos(Tex:getPosition())
        :addTo(self.stage_)
        
        
    self.texes_[self.curIndex_] = Tex
    self.texSprites_[self.curIndex_] = self.curTexSprites_

	
end

function Game:deploySoldier_()
    
    local Tex = self.curTex_

    self.curTexSprites_:removeSelf()

    self.curTexSprites_ = display.newSprite("img/soldier.png")
        :pos(Tex:getPosition())
        :addTo(self.stage_)


    self.texes_[self.curIndex_] = Tex
    self.texSprites_[self.curIndex_] = self.curTexSprites_
    
end

return Game