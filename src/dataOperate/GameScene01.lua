local size = cc.Director:getInstance():getWinSize()
--[[
	文件访问，文件分为资源目录和可读写目录，资源目录只读,在移动平台，程序采用沙箱设计，数据只能被自己的应用访问
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
	cclog("GameSceneTemplate init")
	local layer = cc.Layer:create()
	
	local sprite = cc.Sprite:create("HelloWorld.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)
	
	local fileUtils = cc.FileUtils:getInstance()
	local wirtablePath = fileUtils:getSearchPaths()
--	local button = ccui.Button:create("")
	return layer
end

return GameScene