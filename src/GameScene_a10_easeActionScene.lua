local size = cc.Director:getInstance():getWinSize()
local sprite
--[[
	这里是一些执行非线性速度间隔动作的方式
	主要有倍速慢至快，快至慢，慢至快至慢
	正弦速慢至快，快至慢，慢至快至慢
	指数速慢至快，快至慢，慢至快至慢
	还有一个随机速度
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

    local bg = cc.Sprite:create("actions/Background.png")
    bg:setPosition(cc.p(size.width/2, size.height/2))
	bg:setContentSize(size.width,size.height)
    layer:addChild(bg)

    sprite = cc.Sprite:create("actions/hero.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)

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
		sprite:setPosition(cc.p(size.width/2, size.height/2))
        if actionFlag == kEaseIn then
            sprite:runAction(cc.EaseIn:create(ac, 3))--3倍速度由慢至快
        elseif actionFlag == kEaseOut then
            sprite:runAction(cc.EaseOut:create(ac, 3))--3倍速度由快至慢
        elseif actionFlag == kEaseInOut then
            sprite:runAction(cc.EaseInOut:create(ac, 3))--3倍速度由慢至快至慢
        elseif actionFlag == kEaseSineIn then
            sprite:runAction(cc.EaseSineIn:create(ac))--正弦变换慢至快
        elseif actionFlag == kEaseSineOut then
            sprite:runAction(cc.EaseSineOut:create(ac))--正弦变换快至慢
        elseif actionFlag == kEaseSineInOut then
            sprite:runAction(cc.EaseSineInOut:create(ac))--正弦变换慢至快至慢
        elseif actionFlag == kEaseExponentialIn then
            sprite:runAction(cc.EaseExponentialIn:create(ac))--指数变换慢至快
        elseif actionFlag == kEaseExponentialOut then
            sprite:runAction(cc.EaseExponentialOut:create(ac))--指数变换快至慢
        elseif actionFlag == kEaseExponentialInOut then
            sprite:runAction(cc.EaseExponentialInOut:create(ac))--指数变换慢至快至慢
        elseif actionFlag == kSpeed then
            sprite:runAction(cc.Speed:create(ac, (math.random() * 5)))--随机设置变换速度
        end
    end

    backMenuItem:registerScriptTapHandler(backMenu)
    goMenuItem:registerScriptTapHandler(goMenu)

    return layer
end

return MyActionScene