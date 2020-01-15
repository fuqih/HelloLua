local size = cc.Director:getInstance():getWinSize()
local sprite
local gridNodeTarget
--[[
	
	动作具体效果可以参考p129
--]]
local MyActionScene = class("MyActionScene", function()
    return cc.Scene:create()
end)

function MyActionScene.create()
    local scene = MyActionScene.new()
    scene:addChild(scene:createLayer())
	return scene
end

function MyActionScene:ctor()
end

--创建层
function MyActionScene:createLayer()
    cclog("MyActionScene actionFlag = %d", actionFlag)
    local layer = cc.Layer:create()

    gridNodeTarget = cc.NodeGrid:create()
    layer:addChild(gridNodeTarget)
	
    local bg = cc.Sprite:create("actions/Background.png")
    bg:setPosition(cc.p(size.width/2, size.height/2))
	bg:setContentSize(size.width,size.height)
    gridNodeTarget:addChild(bg)

    sprite = cc.Sprite:create("actions/hero.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    gridNodeTarget:addChild(sprite)

    local backMenuItem = cc.MenuItemImage:create("actions/Back-up.png","actions/Back-down.png")
    backMenuItem:setPosition(cc.Director:getInstance():convertToGL(cc.p(140, 65)))

    local goMenuItem = cc.MenuItemImage:create("actions/Go-up.png","actions/Go-down.png")
    goMenuItem:setPosition(cc.Director:getInstance():convertToGL(cc.p(820, 540)))

    local mn = cc.Menu:create(backMenuItem, goMenuItem)	

    mn:setPosition(cc.p(0, 0))
    layer:addChild(mn)

    local function backMenu(pSender)
        cclog("MyActionScene backMenu")
        cc.Director:getInstance():popScene()
    end

    local function goMenu(pSender)
        cclog("MyActionScene goMenu")
        local ac1 = cc.MoveBy:create(2, cc.p(200, 0))
        local ac2 = ac1:reverse()
        local ac = cc.Sequence:create(ac1, ac2)

        if actionFlag == kFlipX3D then
            gridNodeTarget:runAction(cc.FlipX3D:create(3.0))--x轴3D翻转，参数是持续时间
        elseif actionFlag == kPageTurn3D then
            gridNodeTarget:runAction(cc.PageTurn3D:create(3.0, cc.size(15,10)))--翻页特效，参数1持续时间，参数2网格大小
        elseif actionFlag == kLens3D then
            gridNodeTarget:runAction(cc.Lens3D:create(3.0, cc.size(15,10), cc.p(size.width/2,size.height/2), 240))--凸透镜特效
        elseif actionFlag == kShaky3D then
            gridNodeTarget:runAction(cc.Shaky3D:create(3.0, cc.size(15,10), 5, false))--晃动特效
        elseif actionFlag == kWaves3D then
            gridNodeTarget:runAction(cc.Waves3D:create(3.0, cc.size(15,10), 5, 40))--波动特效
        elseif actionFlag == kJumpTiles3D then
            gridNodeTarget:runAction(cc.JumpTiles3D:create(3.0, cc.size(15,10), 2, 30))--3D瓦片跳动特效
        elseif actionFlag == kShakyTiles3D then
            gridNodeTarget:runAction(cc.ShakyTiles3D:create(3.0, cc.size(16,12), 5, false))--瓦片晃动特效
        elseif actionFlag == kWavesTiles3D then
            gridNodeTarget:runAction(cc.WavesTiles3D:create(3.0, cc.size(15,10), 4, 120))--瓦片波动特效
        end
    end

    backMenuItem:registerScriptTapHandler(backMenu)
    goMenuItem:registerScriptTapHandler(goMenu)

    return layer
end

return MyActionScene