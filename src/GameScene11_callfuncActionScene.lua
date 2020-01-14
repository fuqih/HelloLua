local size = cc.Director:getInstance():getWinSize()
local sprite
--[[
	演示在执行某些动作之后的回调函数，回调函数可以将精灵本身传过去，
	还可以顺带传其他参数，也可以自己选择不传。
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

    sprite = cc.Sprite:create("actions/Plane.png")
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
        if actionFlag == func then
            self:OnCallFunc()--无参函数调用
        elseif actionFlag == funcN then
            self:OnCallFuncN()--将自己作为参数进行函数调用
        else
            self:OnCallFuncND()--有参数的函数调用
        end
    end

    backMenuItem:registerScriptTapHandler(backMenu)
    goMenuItem:registerScriptTapHandler(goMenu)

    return layer
end
local function CallBack1()
    sprite:runAction(cc.TintBy:create(0.5, 255, 0, 255))
end

function MyActionScene:OnCallFunc()
    cclog("MyActionScene OnCallFunc")
    local ac1 = cc.MoveBy:create(2, cc.p(100, 100))
    local ac2 = ac1:reverse()

    local acf = cc.CallFunc:create(CallBack1)
    local seq = cc.Sequence:create(ac1, acf, ac2)
    sprite:runAction(cc.Sequence:create(seq))
end

local function CallBack2(pSender)
    local sp = pSender
    sp:runAction(cc.TintBy:create(1, 255, 0, 255))
end

function MyActionScene:OnCallFuncN()
    cclog("MyActionScene OnCallFuncN")
    local ac1 = cc.MoveBy:create(2, cc.p(100, 100))
    local ac2 = ac1:reverse()

    local acf = cc.CallFunc:create(CallBack2)
    local seq = cc.Sequence:create(ac1, acf, ac2)
    sprite:runAction(cc.Sequence:create(seq))
end

local function CallBack3(pSender, table)
    local sp = pSender
    cclog("CallBack3 %d", table[1])
    sp:runAction(cc.TintBy:create(table[1], table[2], table[3], table[4]))
end

function MyActionScene:OnCallFuncND()
    cclog("MyActionScene OnCallFuncND")
    local ac1 = cc.MoveBy:create(2, cc.p(100, 100))
    local ac2 = ac1:reverse()

    local acf = cc.CallFunc:create(CallBack3, { 1, 255, 0, 255 })
    local seq = cc.Sequence:create(ac1, acf, ac2)
    sprite:runAction(cc.Sequence:create(seq))
end

return MyActionScene