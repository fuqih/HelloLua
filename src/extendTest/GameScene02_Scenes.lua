local size = cc.Director:getInstance():getWinSize()

local pLabel	--标签看当前是什么效果
local system	--粒子效果

local MyActionScene = class("MyActionScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)
function MyActionScene:create()
	--@不知道这个是什么
	local scene = MyActionScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function MyActionScene:ctor()
	--场景生命周期事件处理
    local function onNodeEvent(event)
        if event == "enterTransitionFinish" then
            self:onEnterTransitionFinish()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end
function MyActionScene:createLayer()
	cclog("MyActionScene actionFlag = %d", actionFlag)
    local layer = cc.Layer:create()

	local bg = cc.Sprite:create("actions/Background.png")
	bg:setAnchorPoint(0.5,0.5)
	bg:setContentSize(size.width,size.height)
    bg:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(bg)
	
    pLabel =  cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "")
    pLabel:setPosition(cc.p(size.width/2, size.height - 50))
    layer:addChild(pLabel, 3)

    local pItmLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt", "<Back")
    local backMenuItem = cc.MenuItemLabel:create(pItmLabel)
    backMenuItem:setPosition(cc.p(size.width - 100, 100))
    local mn = cc.Menu:create(backMenuItem)
    mn:setPosition(cc.p(0, 0))
    layer:addChild(mn)

    local function backMenu(pSender)
        cclog("MyActionScene backMenu")
        cc.Director:getInstance():popScene()
    end
    backMenuItem:registerScriptTapHandler(backMenu)

    return layer
end

function MyActionScene:onEnterTransitionFinish()
    cclog("MyActionScene onEnterTransitionFinish")

    if actionFlag == kExplosion then
        system = cc.ParticleExplosion:create()
        pLabel:setString("Explosion")
    elseif actionFlag == kFire then
        system = cc.ParticleFire:create()
        pLabel:setString("Fire")
    elseif actionFlag == kFireworks then
        system = cc.ParticleFireworks:create()
        pLabel:setString("Fireworks")
    elseif actionFlag == kFlower then
        system = cc.ParticleFlower:create()
        pLabel:setString("Flower")
    elseif actionFlag == kGalaxy then
        system = cc.ParticleGalaxy:create()
        pLabel:setString("Galaxy")
    elseif actionFlag == kMeteor then
        system = cc.ParticleMeteor:create()
        pLabel:setString("Meteor")
    elseif actionFlag == kRain then
        system = cc.ParticleRain:create()
        pLabel:setString("Rain")
    elseif actionFlag == kSmoke then
        system = cc.ParticleSmoke:create()
        pLabel:setString("Smoke")
    elseif actionFlag == kSnow then
        system = cc.ParticleSnow:create()
        pLabel:setString("Snow")
    elseif actionFlag == kSpiral then
        system = cc.ParticleSpiral:create()
        pLabel:setString("Spiral")
    elseif actionFlag == kSun then
        system = cc.ParticleSun:create()
        pLabel:setString("Sun")
    end

    system:setPosition(cc.p(size.width / 2, size.height / 2))
    self:addChild(system)
end
return MyActionScene