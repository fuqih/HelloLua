local size = cc.Director:getInstance():getWinSize()
--[[
	精灵对象类
	cc.Sprite:create([filename [,rect] ])
	--1.不传参则需要创建对象之后设置纹理等属性
	--2.可以只传一个文件路径
	--3.可以传文件路径和裁剪区域
	cc.Sprite:createWithTexture(texture)--指定纹理创建精灵，不知道纹理是什么概念，怎么创建纹理
	cc.Sprite:createWithTexture(texture,rect,rotated=false)--如上，多了个设置，是否旋转。
	--
	cc.Sprite:createWithSpriteFrame(spritframe)--通过一个精灵帧对象创建另一个精灵对象
	--cc.Sprite:createWithSpriteFrameName(spriteframename)--通过指定缓存中精灵帧名创建精灵帧名
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
	cclog("GameScene5 init")
	local layer = cc.Layer:create()
	--背景
	local sprite = cc.Sprite:create("texture2D/background.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
--layer:addChild(sprite)
	
	--可以在图片里只截取一部分【cc.rect(x,y,width,height)使用的是UI坐标】
	local tree1 = cc.Sprite:create("texture2D/tree1.png",cc.rect(604, 38, 302, 295))
    tree1:setPosition(cc.p(200,230))
--layer:addChild(tree1,0)
	
--可以在图片里只截取一部分
	local tree1 = cc.Sprite:create("texture2D/tree1.png",cc.rect(604, 38, 302, 295))
    tree1:setPosition(cc.p(200,230))
--layer:addChild(tree1,0)
	
--通过纹理缓存创建纹理对象
	local cache = cc.Director:getInstance():getTextureCache():addImage("tree1.png")
    local tree2 = cc.Sprite:create()
    tree2:setTexture(cache)--设置纹理
    tree2:setTextureRect(cc.rect(73, 72,182,270))--设置裁剪区域
    tree2:setPosition(cc.p(500,200))
--layer:addChild(tree2,0)
--使用纹理图集或通过精灵帧缓存来提升性能，因为读取一个大文件比读取一堆小文件节省性能
--然后可以从一个大文件中截取区域来获取小图

	local sprite = cc.Sprite:create("texture2D/background.png")
	sprite:setPosition(cc.p(size.width/2, size.height/2))
	layer:addChild(sprite)

	--帧缓存的使用,暂时理解为游戏引擎提供的精灵池吧，
	--对于那些需要频繁创建的精灵来说，放在精灵池里明显可以提升性能
	local frameCache = cc.SpriteFrameCache:getInstance()
	frameCache:addSpriteFrames("texture2D/SpirteSheet.plist")

	local mountain1 = cc.Sprite:createWithSpriteFrameName("mountain1.png")
    mountain1:setAnchorPoint(cc.p(0, 0))
    mountain1:setPosition(cc.p(-200,80))
    layer:addChild(mountain1,0)
	
	local heroSpriteFrame = frameCache:getSpriteFrameByName("hero1.png")
    local hero1 = cc.Sprite:createWithSpriteFrame(heroSpriteFrame)
    hero1:setPosition(cc.p(800,200))
    layer:addChild(hero1,0)
	
	--突然想知道layer的大小,生成的1280宽，0高是怎么回事
	local layerSize=layer:getContentSize()
	local layerScale=layer:getScale()
	local layerAnchor=layer:getAnchorPoint()
--	cclog(layerSize.width,layerSize.height)
--	cclog(layerScale)
--	cclog(layerAnchor.x,layerAnchor.y)
	
	return layer
	
end

return GameScene