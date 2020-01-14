local size = cc.Director:getInstance():getWinSize()
--[[
	动画分为场景过渡动画和帧动画，帧动画就是按照一定的时间间隔和顺序一帧帧显示的图片。
	创建动画需要做两个对象，一个animation对象，在这里把一帧帧动画存进去，再用animate对象根据animation创建动作
--]]


local GameScene = class("GameScene",function()
    return cc.Scene:create()
end)

--状态标识
local isPlaying = false

function GameScene.create()
    local scene = GameScene.new()
    scene:addChild(scene:createLayer())
    return scene
end

function GameScene:ctor()
    --self.visibleSize = cc.Director:getInstance():getVisibleSize()
end

-- create layer
function GameScene:createLayer()

    local layer = cc.Layer:create()
	
	--精灵帧缓存
    local spriteFrame  = cc.SpriteFrameCache:getInstance()
    spriteFrame:addSpriteFrames("actions/animation/run.plist")
	
    local bg = cc.Sprite:createWithSpriteFrameName("background.png")
    bg:setPosition(cc.p(size.width/2, size.height/2))
	bg:setContentSize(size.width,size.height)
    layer:addChild(bg)

    local sprite = cc.Sprite:createWithSpriteFrameName("h1.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)
	
    --toggle菜单
    local goSprite = cc.Sprite:createWithSpriteFrameName("go.png")
    local stopSprite = cc.Sprite:createWithSpriteFrameName("stop.png")

    local goToggleMenuItem = cc.MenuItemSprite:create(goSprite, goSprite)
    local stopToggleMenuItem = cc.MenuItemSprite:create(stopSprite, stopSprite)
    local toggleMenuItem = cc.MenuItemToggle:create(goToggleMenuItem, stopToggleMenuItem)
    toggleMenuItem:setPosition(cc.Director:getInstance():convertToGL(cc.p(930, 540)))

    local mn = cc.Menu:create(toggleMenuItem)
    mn:setPosition(cc.p(0, 0))
    layer:addChild(mn)
	
    local function OnAction(menuItemSender)

        if not isPlaying then

            --///////////////动画开始//////////////////////
            local animation = cc.Animation:create()
            for i=1,4 do
                local frameName = string.format("h%d.png",i)
                cclog("frameName = %s",frameName)
                local spriteFrame = spriteFrame:getSpriteFrameByName(frameName)
                animation:addSpriteFrame(spriteFrame)
            end

            animation:setDelayPerUnit(0.15)           --设置两个帧播放时间
            animation:setRestoreOriginalFrame(true)    --动画执行后还原初始状态

            local action = cc.Animate:create(animation)
            sprite:runAction(cc.RepeatForever:create(action))
            --//////////////////动画结束///////////////////
            isPlaying = true
        else
            sprite:stopAllActions()
            isPlaying = false
        end
    end

	toggleMenuItem:registerScriptTapHandler(OnAction)
	
    return layer
end


return GameScene


