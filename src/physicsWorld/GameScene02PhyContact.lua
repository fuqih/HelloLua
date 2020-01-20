local size = cc.Director:getInstance():getWinSize()
local m_layer
--[[
	物理引擎模仿物理现象而成，，需要首先创建一个物理场景，然后划定边界，精灵本身需要和形状绑定在一起，
	物体之间也能产生事件，事件产生需要在layer里监听
--]]
local GameScene = class("GameScene",function()
	local scene = cc.Scene:createWithPhysics()--猜测应该是继承了Scene类,创建一个物理场景
	scene:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)--设置调试遮罩，可以将物体的形状绘制出来（物体没有和精灵绑定则不会显示）
	return scene
end)
function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function GameScene:ctor()
	
end
--测试接触检测掩码1和2的物体为什么也发生了碰撞，难以理解
--[[
function GameScene:addNewSpriteAtPosition(pos)
	local sp=cc.Sprite:create("physicsWorld/Ball.png")
	local size=sp:getContentSize()
	local font=cc.Label:createWithSystemFont("start","Arial",18)
	local fontBody=cc.PhysicsBody:createBox(font:getContentSize())
	font:setPhysicsBody(fontBody)
	font:setPosition(cc.p(size.width/2,size.height/2))
	sp:addChild(font)
    sp:setTag(1)
    local body = cc.PhysicsBody:createCircle(sp:getContentSize().width / 2)
	body:setContactTestBitmask(0x1)
    sp:setPhysicsBody(body)
    sp:setPosition(pos)
    self:addChild(sp)	--加入到场景里和加入到Layer里为什么显示效果不一样，为什么在Layer里定义边界，可以在场景里添加物体
end
--]]
function GameScene:addNewSpriteAtPosition(pos)
	local boxA=cc.Sprite:create("physicsWorld/BoxA2.png")
	boxA:setPosition(pos)
    local bodyBoxA = cc.PhysicsBody:createBox(boxA:getContentSize())
    boxA:setPhysicsBody(bodyBoxA)
	self:addChild(boxA,10,100)
	
	local boxB=cc.Sprite:create("physicsWorld/BoxB2.png")
	boxB:setPosition(pos.x+100,pos.y-120)
    local bodyBoxB = cc.PhysicsBody:createBox(boxB:getContentSize())
    boxB:setPhysicsBody(bodyBoxB)
	self:addChild(boxB,20,101)
	
	local world = cc.Director:getInstance():getRunningScene():getPhysicsWorld()
	
	local joint = cc.PhysicsJointDistance:construct(bodyBoxA,bodyBoxB,cc.p(0,0),cc.p(0,boxB:getContentSize().width / 2))
	world:addJoint(joint)
	
end
function GameScene:addNewSpriteAtPosition2(pos)
	local sp=cc.Sprite:create("physicsWorld/Ball.png")
	local size=sp:getContentSize()
	local font=cc.Label:createWithSystemFont("end","Arial",18)
	local fontBody=cc.PhysicsBody:createBox(font:getContentSize())
	font:setPhysicsBody(fontBody)
	font:setPosition(cc.p(size.width/2,size.height/2))
	sp:addChild(font)
    sp:setTag(2)    
    local body = cc.PhysicsBody:createCircle(sp:getContentSize().width / 2)
	body:setContactTestBitmask(0x2)
    sp:setPhysicsBody(body)
    sp:setPosition(pos)
    self:addChild(sp)	--加入到场景里和加入到Layer里为什么显示效果不一样，为什么在Layer里定义边界，可以在场景里添加物体
end
function GameScene:createLayer()

    local layer = cc.Layer:create()
	m_layer=layer
    --定义世界的边界
    local body = cc.PhysicsBody:createEdgeBox(size, cc.PHYSICSBODY_MATERIAL_DEFAULT, 1.0)--第三个参数是边框大小
    local edgeNode = cc.Node:create()
    edgeNode:setPosition(cc.p(size.width/2,size.height/2))
    edgeNode:setPhysicsBody(body)--将节点和物体关联起来
    layer:addChild(edgeNode)

    local function touchBegan(touch, event)
        local location = touch:getLocation()
        self:addNewSpriteAtPosition(location)
        return true
    end
	local function touchEnd(touch, event)
        local location = touch:getLocation()
        self:addNewSpriteAtPosition2(location)
    end
    local function onContactBegin(contact)
        local spriteA = contact:getShapeA():getBody():getNode()
        local spriteB = contact:getShapeB():getBody():getNode()

        if spriteA and spriteA:getTag() == 1 and spriteB and spriteB:getTag() == 2 then
			local spriteAMask=spriteA:getPhysicsBody():getContactTestBitmask()
			local spriteBMask=spriteB:getPhysicsBody():getContactTestBitmask()
            spriteA:setColor(cc.c3b(255, 255, 0))
            spriteB:setColor(cc.c3b(255, 255, 0))
        end
        cclog("onContactBegin")
        return true
    end
    local function onContactPreSolve(contact)
        cclog("onContactPreSolve")
        return true
    end

    local function onContactPostSolve(contact)
        cclog("onContactPostSolve")
    end

    local function onContactSeparate(contact)
        local spriteA = contact:getShapeA():getBody():getNode()
        local spriteB = contact:getShapeB():getBody():getNode()

        if spriteA and spriteA:getTag() == 1 and spriteB and spriteB:getTag() == 1 then
            spriteA:setColor(cc.c3b(255, 255, 255))
            spriteB:setColor(cc.c3b(255, 255, 255))
        end
        cclog("onContactSeparate")
    end
	
    -- 创建一个事件监听器 OneByOne 为单点触摸
    local listener = cc.EventListenerTouchOneByOne:create()
    -- 设置是否吞没事件，在 onTouchBegan 方法返回 true 时吞没
    listener:setSwallowTouches(true)
    -- onTouchBegan 事件回调函数
	listener:registerScriptHandler(touchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(touchEnd,cc.Handler.EVENT_TOUCH_ENDED )
	
	local contactListener=cc.EventListenerPhysicsContact:create()
	contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    contactListener:registerScriptHandler(onContactPreSolve, cc.Handler.EVENT_PHYSICS_CONTACT_PRESOLVE)
    contactListener:registerScriptHandler(onContactPostSolve, cc.Handler.EVENT_PHYSICS_CONTACT_POSTSOLVE)
    contactListener:registerScriptHandler(onContactSeparate, cc.Handler.EVENT_PHYSICS_CONTACT_SEPARATE)
	
	
    local eventDispatcher = self:getEventDispatcher()
    -- 添加监听器
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
	eventDispatcher:addEventListenerWithSceneGraphPriority(contactListener, layer)
    return layer
end

return GameScene