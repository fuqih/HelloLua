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

-- create layer
function MyActionScene:createLayer()
    cclog("MyActionScene actionFlag = %d", actionFlag)
    local layer = cc.Layer:create()
	
	--背景精灵
    local bg = cc.Sprite:create("actions/Background.png")
	bg:setAnchorPoint(0.5,0.5)
	bg:setContentSize(size.width,size.height)
    bg:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(bg)

	--马匹精灵，间隔动作的主要执行者
    local sprite = cc.Sprite:create("actions/hero.png")
    sprite:setPosition(cc.p(size.width / 2, size.height / 2))
    layer:addChild(sprite)

	--返回菜单按钮
    local backMenuItem = cc.MenuItemImage:create("actions/Back-up.png", "actions/Back-down.png")
    backMenuItem:setPosition(cc.Director:getInstance():convertToGL(cc.p(100, 60)))

	--动作按钮（点击这个按钮就会让马匹执行动作）
    local goMenuItem = cc.MenuItemImage:create("actions/Go-up.png", "actions/Go-down.png")
    goMenuItem:setPosition(size.width / 2, 100)

    local mn = cc.Menu:create(backMenuItem, goMenuItem)

    mn:setPosition(cc.p(0, 0))
    layer:addChild(mn)
	--返回按钮，利用出栈实现
    local function backMenu(pSender)
        cclog("IntervalActions backMenu")
        cc.Director:getInstance():popScene()
    end

	local function goMenu(pSender)
        cclog("IntervalActions goMenu")
        local p = cc.p(math.random() * size.width, math.random() * size.height)
        if actionFlag == kMoveTo then
            sprite:runAction(cc.MoveTo:create(2,cc.p(size.width - 50, size.height - 50)))
        elseif actionFlag == kMoveBy then
            sprite:runAction(cc.MoveBy:create(2,cc.p(-50, -50)))
        elseif actionFlag == kJumpTo then
            sprite:runAction(cc.JumpTo:create(2,cc.p(150, 50),30,5))
        elseif actionFlag == kJumpBy then
            sprite:runAction(cc.JumpBy:create(2,cc.p(100, 100),30,5))
        elseif actionFlag == kBezierBy then
            local bezier = {
                cc.p(0, size.height / 2),
                cc.p(300, - size.height / 2),
                cc.p(100, 100)
            }
            sprite:runAction(cc.BezierBy:create(3,bezier))
        elseif actionFlag == kScaleTo then
            sprite:runAction(cc.ScaleTo:create(2, 4))
        elseif actionFlag == kScaleBy then
            sprite:runAction(cc.ScaleBy:create(2, 0.5))
        elseif actionFlag == kRotateTo then
            sprite:runAction(cc.RotateTo:create(2,180))
        elseif actionFlag == kRotateBy then
            sprite:runAction(cc.RotateBy:create(2,-180))
        elseif actionFlag == kBlink then
            sprite:runAction(cc.Blink:create(3, 5))
        elseif actionFlag == kTintTo then
            sprite:runAction(cc.TintTo:create(2, 255, 0, 0))
        elseif actionFlag == kTintBy then
            sprite:runAction(cc.TintBy:create(0.5,0, 255, 255))
        elseif actionFlag == kFadeTo then
            sprite:runAction(cc.FadeTo:create(1, 80))
        elseif actionFlag == kFadeIn then
            sprite:setOpacity(10)
            sprite:runAction(cc.FadeIn:create(5))
        elseif actionFlag == kFadeOut then
            sprite:runAction(cc.FadeOut:create(5))
        end
    end

    backMenuItem:registerScriptTapHandler(backMenu)
    goMenuItem:registerScriptTapHandler(goMenu)

    return layer
end

return MyActionScene