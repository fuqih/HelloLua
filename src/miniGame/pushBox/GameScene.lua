local size = cc.Director:getInstance():getWinSize()

local GameScene = class("GameScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)
function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	local ts=cc.TransitionFade:create(1,scene,cc.c3b(0xcc,0xcc,0xcc))
	return ts
end
function GameScene:ctor()
	
end
function GameScene:createLayer()
	
	cclog("推箱子游戏界面初始化")
	local layer = cc.Layer:create()
	
	local bg = cc.Sprite:create("actions/Background.png")
    bg:setPosition(cc.p(size.width/2, size.height/2))
	bg:setContentSize(size.width,size.height)
    layer:addChild(bg)
	
	local levelDate=self:initLevelDate()
	
	return layer
end

--获得关卡数据
function GameScene:initLevelDate()
	local level=requirePushBox("Level")
	local levelDate=level:getLevelDate()
	return levelDate
end

return GameScene