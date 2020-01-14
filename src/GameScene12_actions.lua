local size = cc.Director:getInstance():getWinSize()
--[[
	特效其实是间隔动作，也可以称之为网格动作，比起动作而言，特效看起来更具有震撼感
--]]


local GameScene = class("GameScene",function()
    return cc.Scene:create()
end)
-- 定义常量
kFlipX3D            = 1
kPageTurn3D         = 2
kLens3D             = 3
kShaky3D            = 4
kWaves3D            = 5
kJumpTiles3D        = 6
kShakyTiles3D       = 7
kWavesTiles3D       = 8

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

        local scene = require("GameScene12_gridActionScene")
        local nextScene = scene.create()
        local ts = cc.TransitionJumpZoom:create(1, nextScene)
        cc.Director:getInstance():pushScene(ts)
    end
	
	local pItmLabelFlipX3D =  cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","FlipX3D")
    local pItmMenupFlipX3D = cc.MenuItemLabel:create(pItmLabelFlipX3D)
    pItmMenupFlipX3D:setTag(kFlipX3D)
    pItmMenupFlipX3D:registerScriptTapHandler(OnClickMenu)

    local pItmLabelPageTurn3D = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "PageTurn3D")
    local pItmMenuPageTurn3D = cc.MenuItemLabel:create(pItmLabelPageTurn3D)
    pItmMenuPageTurn3D:setTag(kPageTurn3D)
    pItmMenuPageTurn3D:registerScriptTapHandler(OnClickMenu)

    local pItmLabelLens3D = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "Lens3D")
    local pItmMenuLens3D = cc.MenuItemLabel:create(pItmLabelLens3D)
    pItmMenuLens3D:setTag(kLens3D)
    pItmMenuLens3D:registerScriptTapHandler(OnClickMenu)

    local pItmLabelShaky3D = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "Shaky3D")
    local pItmMenuShaky3D = cc.MenuItemLabel:create(pItmLabelShaky3D)
    pItmMenuShaky3D:setTag(kShaky3D)
    pItmMenuShaky3D:registerScriptTapHandler(OnClickMenu)

    local pItmLabelWaves3D = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "Waves3D")
    local pItmMenuWaves3D = cc.MenuItemLabel:create(pItmLabelWaves3D)
    pItmMenuWaves3D:setTag(kWaves3D)
    pItmMenuWaves3D:registerScriptTapHandler(OnClickMenu)

    local pItmLabelJumpTiles3D = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "JumpTiles3D")
    local pItmMenuJumpTiles3D = cc.MenuItemLabel:create(pItmLabelJumpTiles3D)
    pItmMenuJumpTiles3D:setTag(kJumpTiles3D)
    pItmMenuJumpTiles3D:registerScriptTapHandler(OnClickMenu)

    local pItmLabelShakyTiles3D = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "ShakyTiles3D")
    local pItmMenuShakyTiles3D = cc.MenuItemLabel:create(pItmLabelShakyTiles3D)
    pItmMenuShakyTiles3D:setTag(kShakyTiles3D)
    pItmMenuShakyTiles3D:registerScriptTapHandler(OnClickMenu)

    local pItmLabelWavesTiles3D = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "WavesTiles3D")
    local pItmMenuWavesTiles3D = cc.MenuItemLabel:create(pItmLabelWavesTiles3D)
    pItmMenuWavesTiles3D:setTag(kWavesTiles3D)
    pItmMenuWavesTiles3D:registerScriptTapHandler(OnClickMenu)

    local mn = cc.Menu:create(pItmMenupFlipX3D,pItmMenuPageTurn3D,
        pItmMenuLens3D, pItmMenuShaky3D,
        pItmMenuWaves3D, pItmMenuJumpTiles3D,
        pItmMenuShakyTiles3D, pItmMenuWavesTiles3D)
    mn:alignItemsVertically()
    layer:addChild(mn)
	
    return layer
end


return GameScene


