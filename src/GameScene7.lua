local size = cc.Director:getInstance():getWinSize()
--[[
	动作特效和动画
	动作分为三种，1受时间限制的动作，2跟随动作，3可在运行时改变速率的动作
	受时间限制的动作又分为瞬时动作和间隔动作
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
	cclog("GameScene7 init")
	local layer = cc.Layer:create()
	

	
	local sprite = cc.Sprite:create("HelloWorld.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)
	return layer
end

return GameScene