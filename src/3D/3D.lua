local size = cc.Director:getInstance():getWinSize()

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
--	local layer = cc.LayerColor:create(ccc3(0xcc,0xcc,0xcc))
	local layer = cc.Layer:create()
	local sprite3D = cc.Sprite3D:create("3D/ship.c3b","3D/ship.png")
	sprite3D:setPosition(cc.p(size.width/2,size.height/2))
	sprite3D:setScale(10)
	layer:addChild(sprite3D)
	local flag="Y"
	local function update()
		local rotation3D = sprite3D:getRotation3D()
		if rotation3D.y>360 then
			rotation3D.y=0
			flag="X"
		elseif rotation3D.x>360 then
			rotation3D.x=0
			flag="Z"
		elseif rotation3D.z>360 then
			rotation3D.z=0
			flag="Y"
		end
		if flag=="X" then
			rotation3D.x=rotation3D.x+3
		elseif flag=="Z" then
			rotation3D.z=rotation3D.z+3
		elseif flag=="Y" then
			rotation3D.y=rotation3D.y+3
		end
		cclog("flag="..flag)
		sprite3D:setRotation3D(rotation3D)
	end
--	layer:scheduleUpdateWithPriorityLua(update,0)
	local originRotation3D
	local originPos={x=0,y=0}
	local function touchBeginCallback(touch,event)
		--记录下当前旋转量
		originRotation3D = sprite3D:getRotation3D()
		originPos=touch:getLocation()
		return true
	end
	local function touchMoveCallback(touch,event)
		local nowPos=touch:getLocation()
		local scale=0.5
		local offset = {x=(nowPos.x-originPos.x)*scale,y=(nowPos.y-originPos.y)*scale}
		local rotation3={y=originRotation3D.y+offset.x,x=originRotation3D.x+offset.y,z=originRotation3D.z}
		sprite3D:setRotation3D(rotation3)
	end
	local function touchEndCallback(touch,event)
		local Rotation3D = sprite3D:getRotation3D()
		local str="x="..Rotation3D.x..";y="..Rotation3D.y..";z="..Rotation3D.y
		cclog(str)
	end
	local eventListener = cc.EventListenerTouchOneByOne:create()
	eventListener:registerScriptHandler(touchBeginCallback,cc.Handler.EVENT_TOUCH_BEGAN)
	eventListener:registerScriptHandler(touchMoveCallback,cc.Handler.EVENT_TOUCH_MOVED)
	eventListener:registerScriptHandler(touchEndCallback,cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(eventListener, layer)
	return layer
end

return GameScene