local size = cc.Director:getInstance():getWinSize()
--[[
	hold不住，需要了解三维知识再看这些。相机应该是指观测点，
	3D粒子特效也明显更好看
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
	local sprite3D = cc.Sprite3D:create("3D/ship.c3b","3D/ship.png")
	sprite3D:setPosition(cc.p(size.width/2,size.height/2))
	sprite3D:setScale(10)
	sprite3D:setCameraMask(cc.CameraFlag.USER1)
	layer:addChild(sprite3D)

	-- 创建Camera对象
	local camera = cc.Camera:createPerspective(60, size.width / size.height, 1, 1000)
	-- 设置相机位置
	local spritePos = sprite3D:getPosition3D()
	spritePos.y = spritePos.y + 200
	spritePos.z = spritePos.z + 600
	camera:setPosition3D(spritePos)
	-- 设置相机朝向和竖直方向向量
	camera:lookAt(spritePos)
	-- 设置相机CameraFlag属性
	camera:setCameraFlag(cc.CameraFlag.USER1)
	layer:addChild(camera)
	
	local rootps = cc.PUParticleSystem3D:create("Particle3D/scripts/example_010.pu")
	rootps:setCameraMask(cc.CameraFlag.USER1)
	rootps:setScale(5)
	rootps:startParticleSystem()--开始粒子系统
	sprite3D:addChild(rootps)
	
	-- 游戏循环调度函数
	local function update(delta)
		local rotation3D = sprite3D:getRotation3D()
		rotation3D.y = rotation3D.y + 3
		sprite3D:setRotation3D(rotation3D)
	end

	local function touchBegan(touch, event)
		cclog("touchBegan")
		layer:scheduleUpdateWithPriorityLua(update, 0)
		return true
	end

	local function touchEnded(touch, event)
		cclog("touchEnded")
		layer:unscheduleUpdate()
	end

	-- 创建一个事件监听器 OneByOne 为单点触摸
	local listener = cc.EventListenerTouchOneByOne:create()
	-- 设置是否吞没事件，在 EVENT_TOUCH_BEGAN事件返回 true 时吞没
	listener:setSwallowTouches(true)
	-- EVENT_TOUCH_BEGAN事件回调函数
	listener:registerScriptHandler(touchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	-- EVENT_TOUCH_ENDED事件回调函数
	listener:registerScriptHandler(touchEnded, cc.Handler.EVENT_TOUCH_ENDED)

	local eventDispatcher = self:getEventDispatcher()
	-- 添加监听器
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
	return layer
end

return GameScene