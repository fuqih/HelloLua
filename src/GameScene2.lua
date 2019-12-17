local size = cc.Director:getInstance():getWinSize()
--[[
游戏开发中，知道自己的坐标是一件很重要的事情，例如UI坐标系，原点在左上，openGL坐标系，原点在左下角
touch对象	cc.p	touchLocation=touch:getLocationInView()获得UI坐标
			cc.p	touchLocation=touch:getLocation()获得OpenGL坐标，默认左下角为原点，Z轴作为层级,指向屏幕外是正
			当需要转换时可用cc.p touchLocation2=cc Director:getInstance():convertToGL(touchLocation)转换
同样的世界坐标和模型坐标经常需要转换，例如移动一个图片到另一个图片上，如果它们不在同一个父节点，这时就需要通过转换坐标
node:convertToNodeSpace(worldPoint):将世界坐标转换到相对于当前节点的模型坐标
node:convertToNodespaceAR(worldPoint):将世界坐标转换为模型坐标，AR表示相对于锚点。
node:convertTouchToNodeSpace(touch):将世界坐标中触摸点转换为模型坐标。
node:convertTouchToNodeSpaceAR(touch):将世界坐标中触摸点转换为模型坐标，AR表示相对于锚点。
node:convertToWorldSpace(nodepoint):将模型坐标转换为世界坐标。
node:convertToworldspaceAR(nodePoint):将模型坐标转换为世界坐标，AR表示相对锚点
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
	cclog("GameScene2 init")
	local layer = cc.Layer:create()
	
	local sprite = cc.Sprite:create("HelloWorld.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
--	sprite:setPosition(cc.p(0,0))--默认左下角是00
    layer:addChild(sprite)
	return layer
end


return GameScene