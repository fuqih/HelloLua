local size = cc.Director:getInstance():getWinSize()
--关卡数据信息
local m_levelData=nil

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
	--获得关卡数据
	local levelData=self:initLevelDate()
	--根据关卡数据初始化游戏界面
	self:initMap(levelData)
	
	return layer
end

--获得关卡数据(深复制一份)
function GameScene:initLevelDate()
	local level=requirePushBox("Level")
	local levelData=level:getLevelDate()
	m_levelData=DeepCopy(levelData)
	return m_levelData
end
--渲染关卡地图
function GameScene:initMap(Data)
	local 
end

return GameScene