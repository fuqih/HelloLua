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
    local sprite = cc.Sprite:create("actions/Background.png")
    sprite:setPosition(cc.p(size.width / 2,
        size.height / 2))
    layer:addChild(sprite)

	--飞机精灵，动作的主要执行者
    local sprite = cc.Sprite:create("actions/Plane.png")
    sprite:setPosition(cc.p(size.width / 2, size.height / 2))
    layer:addChild(sprite)

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

        if actionFlag == PLACE_TAG then
            sprite:runAction(cc.Place:create(p))
        elseif actionFlag == FLIPX_TAG then
            sprite:runAction(cc.FlipX:create(true))
        elseif actionFlag == FLIPY_TAG then
            sprite:runAction(cc.FlipY:create(true))
        elseif actionFlag == HIDE_SHOW_TAG then
            if hiddenFlag then
                sprite:runAction(cc.Hide:create())
                hiddenFlag = false
            else
                sprite:runAction(cc.Show:create())
                hiddenFlag = true
            end
        else
            sprite:runAction(cc.ToggleVisibility:create())
        end
    end

    backMenuItem:registerScriptTapHandler(backMenu)
    goMenuItem:registerScriptTapHandler(goMenu)

    return layer
end

return MyActionScene