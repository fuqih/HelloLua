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
--	local layer = cc.LayerColor:create(ccc3(0xcc,0xcc,0xcc))
	local layer = cc.Layer:create()
	local sprite3D = cc.Sprite3D:create("3D/ship.c3b","3D/ship.png")
	sprite3D:setPosition(cc.p(size.width/2,size.height/2))
	sprite3D:setScale(10)
	layer:addChild(sprite3D)
	return layer
end

return GameScene