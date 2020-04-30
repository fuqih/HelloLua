local size = cc.Director:getInstance():getWinSize()
local layer
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
	layer = requireEx("mytestInMind.testActionLayer")
	layer:onCreate()
	self.layer=layer
	return layer
end

return GameScene