local size = cc.Director:getInstance():getWinSize()

local GameScene = class("GameScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)
--[[
	在这里实现了点击物体移动的效果，但是有个问题是，
	为什么事件没有传到精灵身上。点击层，两个精灵都得到了事件
	事件处理机制，包括，事件，事件源，事件处理者三个角色，事件源即事件发生的场所，一般认为是视图或者组件。
	事件处理者是接收事件，并对其处理的角色。
--]]
function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
--	local ts = cc.TransitionFade:create(1.0,scene)
	return scene
end
function GameScene:ctor()
	
end
function GameScene:createLayer()
	cclog("GameScene init")
	local layer = cc.Layer:create()
	
	local bg = cc.Sprite:create("actions/Background.png")
	bg:setContentSize(size)
	bg:setPosition(size.width/2,size.height/2)
    layer:addChild(bg)
	
	local spriteHero=cc.Sprite:create("actions/hero.png")
	spriteHero:setPosition(size.width/2+200,size.height/2)
    layer:addChild(spriteHero)
	
	local posOffsetHero={offsetX=0,offsetY=0}
	local function onMyTouchBegan(touch,event)
		local target = event:getCurrentTarget()--target是事件源
		local posSprite=cc.p(target:getPosition())
		local posEvent=touch:getLocation()
		local posOffset={offsetX=posEvent.x-posSprite.x,offsetY=posEvent.y-posSprite.y}
		local function checkPos()
			--检查事件是不是在精灵范围内
			local spriteContentSize=target:getContentSize()
			local spriteScale=target:getScale()
			local spriteSize={width=spriteContentSize.width*spriteScale,height=spriteContentSize.height*spriteScale}
			if math.abs(posOffset.offsetX)>spriteSize.width/2 or math.abs(posOffset.offsetY)>spriteSize.height/2 then
				return false
			end
			return true
		end
		if target~=spriteHero or not checkPos() then--如果不是英雄精灵发生事件(搞不懂为什么不在英雄身上的事件也会传到英雄身上)
			return false
		end
		
		posOffsetHero=posOffset
		cclog("英雄移动开始")
		return true
	end
	local function onMyTouchMoved(touch,event)
		local target = event:getCurrentTarget()--target是事件源
		if target~=spriteHero then
			return false
		end
		local posEvent=touch:getLocation()
		target:setPosition(cc.p(posEvent.x-posOffsetHero.offsetX,posEvent.y-posOffsetHero.offsetY))
		cclog("英雄移动中")
		return true
	end
	local function onMyTouchEnded(touch,event)
		cclog("英雄移动完成")
	end
	local function onMyTouchCancelled(touch,event)
		cclog("英雄移动取消")
	end
	--[[
		明明事件只放在这个图片上，但是为什么点击其他区域也会触发事件？？？
	--]]
	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	if spriteHero.touchListen then
		eventDispatcher:removeEventListener(spriteHero.touchListen)
		spriteHero.touchListen = nil
	end
	--事件监听器类。
	local touchListen = cc.EventListenerTouchOneByOne:create()
	touchListen:registerScriptHandler(onMyTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	touchListen:registerScriptHandler(onMyTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
	touchListen:registerScriptHandler(onMyTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
	touchListen:registerScriptHandler(onMyTouchCancelled,cc.Handler.EVENT_TOUCH_CANCELLED)
	touchListen:setSwallowTouches(true)
	spriteHero.touchListen = touchListen
	eventDispatcher:addEventListenerWithSceneGraphPriority(touchListen, spriteHero)
	
	local spritePlane=cc.Sprite:create("actions/Plane.png")
	spritePlane:setPosition(size.width/2-200,size.height/2)
    layer:addChild(spritePlane)
	local posOffsetPlane={offsetX=0,offsetY=0}
	local function onMyTouchBegan2(touch,event)
		local target = event:getCurrentTarget()--target是事件源
		local posSprite=cc.p(target:getPosition())
		local posEvent=touch:getLocation()
		local posOffset={offsetX=posEvent.x-posSprite.x,offsetY=posEvent.y-posSprite.y}
		local function checkPos()
			--检查事件是不是在精灵图片范围内（仅限于锚点中心）
			local spriteContentSize=target:getContentSize()
			local spriteScale=target:getScale()
			local spriteSize={width=spriteContentSize.width*spriteScale,height=spriteContentSize.height*spriteScale}
			if math.abs(posOffset.offsetX)>spriteSize.width/2 or math.abs(posOffset.offsetY)>spriteSize.height/2 then
				return false
			end
			return true
		end
		if target~=spritePlane or not checkPos() then
			return false
		end
		
		posOffsetPlane=posOffset
		cclog("飞机移动开始")
		return true
	end
	local function onMyTouchMoved2(touch,event)
		local target = event:getCurrentTarget()--target是事件源
		if target~=spritePlane then
			return false
		end
		local posEvent=touch:getLocation()
		target:setPosition(cc.p(posEvent.x-posOffsetPlane.offsetX,posEvent.y-posOffsetPlane.offsetY))
		cclog("飞机移动中")
		return true
	end
	local function onMyTouchEnded2(touch,event)
		cclog("飞机移动完成")
	end
	local function onMyTouchCancelled2(touch,event)
		cclog("飞机移动取消")
	end
	--[[
		明明事件只放在这个图片上，但是为什么点击其他区域也会触发事件？？？
	--]]
	local eventDispatcher2 = cc.Director:getInstance():getEventDispatcher()
	if spritePlane.touchListen then
		eventDispatcher2:removeEventListener(spritePlane.touchListen)
		spritePlane.touchListen = nil
	end
	local touchListen2 = cc.EventListenerTouchOneByOne:create()
	touchListen2:registerScriptHandler(onMyTouchBegan2,cc.Handler.EVENT_TOUCH_BEGAN)
	touchListen2:registerScriptHandler(onMyTouchMoved2,cc.Handler.EVENT_TOUCH_MOVED)
	touchListen2:registerScriptHandler(onMyTouchEnded2,cc.Handler.EVENT_TOUCH_ENDED)
	touchListen2:registerScriptHandler(onMyTouchCancelled2,cc.Handler.EVENT_TOUCH_CANCELLED)
	touchListen2:setSwallowTouches(true)
	spritePlane.touchListen = touchListen2
	eventDispatcher2:addEventListenerWithSceneGraphPriority(touchListen2, spritePlane)
	
	return layer
end

return GameScene