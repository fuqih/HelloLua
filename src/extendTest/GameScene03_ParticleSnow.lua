local size = cc.Director:getInstance():getWinSize()

local GameScene = class("GameScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)
function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function GameScene:ctor()
	
end
function GameScene:createLayer()
	cclog("GameSceneTemplate init")
	local layer = cc.Layer:create()
	

	
	local sprite = cc.Sprite:create("particle/background-1.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)
	
	local particle=cc.ParticleSystemQuad:create("particle/snow.plist")
	particle:setPosition(cc.p(size.width/2, size.height))
	layer:addChild(particle)
	return layer
end

return GameScene