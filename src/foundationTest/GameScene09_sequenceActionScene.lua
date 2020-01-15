local size = cc.Director:getInstance():getWinSize()

--精灵隐藏
local hiddenFlag = true

local MyActionScene = class("MyActionScene", function()
    return cc.Scene:create()
end)

function MyActionScene.create()
    local scene = MyActionScene.new()
    scene:addChild(scene:createLayer())
    return scene
end

function MyActionScene:ctor()
    --self.visibleSize = cc.Director:getInstance():getVisibleSize()
end
local sprite
-- create layer
function MyActionScene:createLayer()
    cclog("MyActionScene actionFlag = %d", actionFlag)
    local layer = cc.Layer:create()
	
	--背景精灵
    local bg = cc.Sprite:create("actions/Background.png")
    bg:setPosition(cc.p(size.width / 2,size.height / 2))
	bg:setContentSize(size.width,size.height)
    layer:addChild(bg)

	--飞机精灵，动作的主要执行者
    local hero = cc.Sprite:create("actions/hero.png")
    hero:setPosition(cc.p(size.width / 2, size.height / 2))
	sprite=hero
    layer:addChild(hero)

	--返回菜单按钮
    local backMenuItem = cc.MenuItemImage:create("actions/Back-up.png", "actions/Back-down.png")
    backMenuItem:setPosition(cc.Director:getInstance():convertToGL(cc.p(450, 60)))

	--飞机动作按钮（点击这个按钮就会让飞机执行动作）
    local goMenuItem = cc.MenuItemImage:create("actions/Go-up.png", "actions/Go-down.png")
    goMenuItem:setPosition(size.width / 2, 100)

    local mn = cc.Menu:create(backMenuItem, goMenuItem)

    mn:setPosition(cc.p(0, 0))
    layer:addChild(mn)
	--返回按钮，利用出栈实现
    local function backMenu(pSender)
        cclog("MyActionScene backMenu")
        cc.Director:getInstance():popScene()
    end

    local function goMenu(pSender)
        cclog("MyActionScene goMenu")
        local p = cc.p(math.random() * size.width, math.random() * size.height)

       if actionFlag == kSequence then
            self:OnSequence(pSender)
        elseif actionFlag == kSpawn then
            self:OnSpawn(pSender)
        elseif actionFlag == kRepeate then
            self:OnRepeat(pSender)
        elseif actionFlag == kRepeatForever1 then
            self:OnRepeatForever(pSender)
        elseif actionFlag == kReverse then
            self:OnReverse(pSender)
        end
    end

    backMenuItem:registerScriptTapHandler(backMenu)
    goMenuItem:registerScriptTapHandler(goMenu)

    return layer
end
--顺序依次执行动作动作序列
function MyActionScene:OnSequence(pSender)
    cclog("MyActionScene OnSequence")

    local p = cc.p(size.width/2, 200)

    local ac0 = sprite:runAction(cc.Place:create(p))
    local ac1 = sprite:runAction(cc.MoveTo:create(2,cc.p(size.width - 130, size.height - 200)))
    local ac2 = sprite:runAction(cc.JumpBy:create(2, cc.p(8, 8),6, 3))
    local ac3 = sprite:runAction(cc.Blink:create(2,3))
    local ac4 = sprite:runAction(cc.TintBy:create(0.5,0,255,255))

    sprite:runAction(cc.Sequence:create(ac0, ac1, ac2, ac3, ac4, ac0))

end
--同时执行动作序列
function MyActionScene:OnSpawn(pSender)
    cclog("MyActionScene OnSpawn")
    local p = cc.p(size.width/2, 200)

    sprite:setRotation(0)
    sprite:setPosition(p)

    local ac1 = sprite:runAction(cc.MoveTo:create(2,cc.p(size.width - 100, size.height - 100)))
    local ac2 = sprite:runAction(cc.RotateTo:create(2, 40))

    sprite:runAction(cc.Spawn:create(ac1,ac2))

end

function MyActionScene:OnRepeat(pSender)
    cclog("MyActionScene OnRepeat")
    local p = cc.p(size.width/2, 200)

    sprite:setRotation(0)
    sprite:setPosition(p)

    local ac1 = sprite:runAction(cc.MoveTo:create(2,cc.p(size.width - 100, size.height - 100)))
    local ac2 = sprite:runAction(cc.JumpBy:create(2,cc.p(10, 10), 20,5))
    local ac3 = sprite:runAction(cc.JumpBy:create(2,cc.p(-10, -10),20,3))

    local seq = cc.Sequence:create(ac1, ac2, ac3)

    sprite:runAction(cc.Repeat:create(seq,3))
end

function MyActionScene:OnRepeatForever(pSender)
    cclog("MyActionScene OnRepeatForever")
    local p = cc.p(size.width/2, 500)

    sprite:setRotation(0)
    sprite:setPosition(p)

    local bezier = {
        cc.p(0, size.height / 2),
        cc.p(10, - size.height / 2),
        cc.p(10,20)
    }
    local ac1 = sprite:runAction(cc.BezierBy:create(2,bezier))
    local ac2 = sprite:runAction(cc.TintBy:create(0.5, 0, 255, 255))
    local ac1Reverse = ac1:reverse()
    local ac2Repeat = sprite:runAction(cc.Repeat:create(ac2, 4))

    local ac3 = sprite:runAction(cc.Spawn:create(ac1,ac2Repeat))
    local ac4 = sprite:runAction(cc.Spawn:create(ac1Reverse,ac2Repeat))
    local seq = cc.Sequence:create(ac3, ac4)

    sprite:runAction(cc.RepeatForever:create(seq))
end

function MyActionScene:OnReverse(pSender)
    cclog("MyActionScene OnReverse")
    local p = cc.p(size.width/2, 300)

    sprite:setRotation(0)
    sprite:setPosition(p)

    local ac1 = sprite:runAction(cc.MoveBy:create(2,cc.p(40, 60)))
    local ac2 = ac1:reverse()
    local seq = cc.Sequence:create(ac1, ac2)

    sprite:runAction(cc.Repeat:create(seq,2))
end
return MyActionScene