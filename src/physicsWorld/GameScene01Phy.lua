local size = cc.Director:getInstance():getWinSize()
local m_layer
local GameScene = class("GameScene",function()
	local scene = cc.Scene:createWithPhysics()--猜测应该是继承了Scene类,创建一个物理场景
--	scene:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)--设置调试遮罩，可以将物体的形状绘制出来（物体没有和精灵绑定则不会显示）
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
function GameScene:addNewSpriteAtPosition(pos)
	local sp=cc.Sprite:create("physicsWorld/Ball.png")
    sp:setTag(1)    
    local body = cc.PhysicsBody:createCircle(sp:getContentSize().width / 2)
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
    
    -- 创建一个事件监听器 OneByOne 为单点触摸
    local listener = cc.EventListenerTouchOneByOne:create()
    -- 设置是否吞没事件，在 onTouchBegan 方法返回 true 时吞没
    listener:setSwallowTouches(true)
    -- onTouchBegan 事件回调函数
	listener:registerScriptHandler(touchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(touchBegan,cc.Handler.EVENT_TOUCH_MOVED )
    local eventDispatcher = self:getEventDispatcher()
    -- 添加监听器
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

    return layer
end

return GameScene