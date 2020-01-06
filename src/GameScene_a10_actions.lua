local size = cc.Director:getInstance():getWinSize()
--[[
	间隔动作都是线性匀速执行的，在这里可以使用非线性速度执行
--]]


local GameScene = class("GameScene",function()
    return cc.Scene:create()
end)
-- 定义常量
kEaseIn                 = 1
kEaseOut                = 2
kEaseInOut              = 3
kEaseSineIn             = 4
kEaseSineOut            = 5
kEaseSineInOut          = 6
kEaseExponentialIn      = 7
kEaseExponentialOut     = 8
kEaseExponentialInOut   = 9
kSpeed                   = 10

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

        local scene = require("GameScene_a10_easeActionScene")
        local nextScene = scene.create()
        local ts = cc.TransitionJumpZoom:create(1, nextScene)
        cc.Director:getInstance():pushScene(ts)
    end

    local pItmLabel1 =  cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","EaseIn")
    local pItmMenu1 = cc.MenuItemLabel:create(pItmLabel1)
    pItmMenu1:setTag(kEaseIn)
    pItmMenu1:registerScriptTapHandler(OnClickMenu)

    local pItmLabel2 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "EaseOut")
    local pItmMenu2 = cc.MenuItemLabel:create(pItmLabel2)
    pItmMenu2:setTag(kEaseOut)
    pItmMenu2:registerScriptTapHandler(OnClickMenu)

    local pItmLabel3 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "EaseInOut")
    local pItmMenu3 = cc.MenuItemLabel:create(pItmLabel3)
    pItmMenu3:setTag(kEaseInOut)
    pItmMenu3:registerScriptTapHandler(OnClickMenu)

    local pItmLabel4 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "EaseSineIn")
    local pItmMenu4 = cc.MenuItemLabel:create(pItmLabel4)
    pItmMenu4:setTag(kEaseSineIn)
    pItmMenu4:registerScriptTapHandler(OnClickMenu)

    local pItmLabel5 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "EaseSineOut")
    local pItmMenu5 = cc.MenuItemLabel:create(pItmLabel5)
    pItmMenu5:setTag(kEaseSineOut)
    pItmMenu5:registerScriptTapHandler(OnClickMenu)

    local pItmLabel6 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "EaseSineInOut")
    local pItmMenu6 = cc.MenuItemLabel:create(pItmLabel6)
    pItmMenu6:setTag(kEaseSineInOut)
    pItmMenu6:registerScriptTapHandler(OnClickMenu)

    local pItmLabel7 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "EaseExponentialIn")
    local pItmMenu7 = cc.MenuItemLabel:create(pItmLabel7)
    pItmMenu7:setTag(kEaseExponentialIn)
    pItmMenu7:registerScriptTapHandler(OnClickMenu)

    local pItmLabel8 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "EaseExponentialOut")
    local pItmMenu8 = cc.MenuItemLabel:create(pItmLabel8)
    pItmMenu8:setTag(kEaseExponentialOut)
    pItmMenu8:registerScriptTapHandler(OnClickMenu)

    local pItmLabel9 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "EaseExponentialInOut")
    local pItmMenu9 = cc.MenuItemLabel:create(pItmLabel9)
    pItmMenu9:setTag(kEaseExponentialInOut)
    pItmMenu9:registerScriptTapHandler(OnClickMenu)

    local pItmLabel10 = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "Speed")
    local pItmMenu10 = cc.MenuItemLabel:create(pItmLabel10)
    pItmMenu10:setTag(kSpeed)
    pItmMenu10:registerScriptTapHandler(OnClickMenu)

    local mn = cc.Menu:create(pItmMenu1,pItmMenu2,pItmMenu3,pItmMenu4,pItmMenu5,
        pItmMenu6,pItmMenu7,pItmMenu8,pItmMenu9, pItmMenu10)
    mn:alignItemsInColumns(2, 2, 2, 2, 2)
    layer:addChild(mn)

    return layer
end


return GameScene


