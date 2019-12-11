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
	cclog("GameScene2 init")
	local layer = cc.Layer:create()
	
	local sprite = cc.Sprite:create("HelloWorld.png")
--    sprite:setPosition(cc.p(size.width/2, size.height/2))
	sprite:setPosition(cc.p(0,0))--默认左下角是00
    layer:addChild(sprite)
	return layer
end

return GameScene