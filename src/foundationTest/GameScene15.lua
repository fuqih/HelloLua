local size = cc.Director:getInstance():getWinSize()

local GameScene = class("GameScene",function()
	return cc.Scene:create()--�²�Ӧ���Ǽ̳���Scene��
end)
function GameScene:create()
	--@��֪�������ʲô
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