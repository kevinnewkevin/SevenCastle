
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.newColorLayer(cc.c4b(0xfa,0xf8,0xef,255))
        :addTo(self)        
        
    cc.ui.UIPushButton.new("img/play_button.png")
        :onButtonClicked(function()
            print("CLICK")
            app:enterScene("PlayScene", nil, "Random", 1.0)
        end)
        :pos(display.cx, display.cy)
        :addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
