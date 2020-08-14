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
	local layer = cc.LayerColor:create(cc.c4b(255,100,100,128))
	
	local size=layer:getContentSize()
	cclog(size.width,size.height)
	return layer
end

return GameScene