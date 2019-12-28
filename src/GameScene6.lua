local size = cc.Director:getInstance():getWinSize()
--[[
	在这里学习场景与层，似乎有点像进程与线程的关系，一个进程必须有一个线程，而线程才是执行代码的基本条件
	而在这里，一个场景至少要有一个层，也可以堆多个层
	导演层常用的几个执行方法。
	runWithScene(scene)--第一次载入场景时使用
	replaceScene(scene)--替代场景并删除
	pushScene(scene)--压入新一个场景，原场景会入栈
	popScene()--释放当前场景，返回上一个场景
	popToRootScene()--返回根场景
--]]
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
	cclog("GameScene6 init")
	local layer = cc.Layer:create()
	

	
	local sprite = cc.Sprite:create("HelloWorld.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)
	return layer
end

return GameScene