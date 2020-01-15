local size = cc.Director:getInstance():getWinSize()
--[[
	在这里演示回调函数的用法，包括无参函数调用和有参数函数调用
--]]


local GameScene = class("GameScene",function()
    return cc.Scene:create()
end)
-- 定义常量
func = 1
funcN = 2
funcND = 3

--操作标识
actionFlag = -1

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

    local bg = cc.Sprite:create("actions/Background.png")
    bg:setPosition(cc.p(size.width/2, size.height/2))
	bg:setContentSize(size.width,size.height)
    layer:addChild(bg)

    local function OnClickMenu(tag, menuItemSender)
        cclog("tag = %d", tag)
        actionFlag = menuItemSender:getTag()

        local scene = require("GameScene11_callfuncActionScene")
        local nextScene = scene.create()
        local ts = cc.TransitionJumpZoom:create(1, nextScene)
        cc.Director:getInstance():pushScene(ts)
    end

    local pItmLabel1 =  cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","CallFunc")
    local pItmMenu1 = cc.MenuItemLabel:create(pItmLabel1)
    pItmMenu1:setTag(func)
    pItmMenu1:registerScriptTapHandler(OnClickMenu)

    local pItmLabel2 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "CallFuncN")
    local pItmMenu2 = cc.MenuItemLabel:create(pItmLabel2)
    pItmMenu2:setTag(funcN)
    pItmMenu2:registerScriptTapHandler(OnClickMenu)

    local pItmLabel3 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "CallFuncND")
    local pItmMenu3 = cc.MenuItemLabel:create(pItmLabel3)
    pItmMenu3:setTag(funcND)
    pItmMenu3:registerScriptTapHandler(OnClickMenu)


    local mn = cc.Menu:create(pItmMenu1,pItmMenu2,pItmMenu3)
    mn:alignItemsVertically()
    layer:addChild(mn)

    return layer
end


return GameScene


