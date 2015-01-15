

local PlayScene = class("PlayScene", function()
    return display.newScene("PlayScene")
end)

local Game = import("..models.Game")

function PlayScene:ctor()
        
    local stage = display.newColorLayer(cc.c4b(0xfa,0xf8,0xef,255))
        :addTo(self)
        
    self.game_ = Game.new(stage)
    self.stage_ = stage    

end

function PlayScene:onEnter()
           
    for i = 1 , 7 do
        for j = 1,7 do
            self.game_:addTex(i,j)
        end
    end
   
    self.stage_:setTouchEnabled(true)
    self.stage_:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return self.game_:onTouch(event)
    end)

end

function PlayScene:onExit()
end

return PlayScene
