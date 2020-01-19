local size = cc.Director:getInstance():getWinSize()
--[[
	这章需要用到地图编辑器tiled，兼容生成的tiled文件（包括资源）
--]]
local GameScene = class("GameScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)

local _tileMap			--地图
local _player			--玩家
local _layer			--当前层
local _backGround		--背景层
local _collidable		--碰撞检测图层
local Directory			--移动的方向
function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function GameScene:ctor()
	
end

local function setViewpointCenter()

    cclog("setViewpointCenter")

    local playerPosX, playerPosY = _player:getPosition()

    --可以防止，视图左边超出屏幕之外。
    local x = math.max(playerPosX, size.width / 2)
    local y = math.max(playerPosY, size.height / 2)
    --可以防止，视图右边超出屏幕之外。
    x = math.min(x, (_tileMap:getMapSize().width * _tileMap:getTileSize().width)
            - size.width / 2)
    y = math.min(y, (_tileMap:getMapSize().height * _tileMap:getTileSize().height)
            - size.height / 2)

    --屏幕中心点
    local pointA = cc.p(size.width / 2, size.height / 2)
    --使精灵处于屏幕中心，移动地图目标位置
    local pointB = cc.p(x, y)
    cclog("目标位置 (%f ,%f) ", pointB.x, pointB.y)

    --地图移动偏移量
    local offset = cc.pSub(pointA, pointB)
    cclog("offset (%f ,%f) ", offset.x, offset.y)
    _layer:setPosition(offset)
	
end

--将像素点转换为瓦片坐标
local function tileCoordFromPosition(pos)
    local x = pos.x / _tileMap:getTileSize().width
	local temp	= _tileMap:getMapSize()
	local temp2 =  _tileMap:getTileSize()
    local y = ((_tileMap:getMapSize().height * _tileMap:getTileSize().height) - pos.y) / _tileMap:getTileSize().height
    return cc.p(x,y)
end

local function setPlayerPosition(position)
    --从像素点坐标转化为瓦片坐标
    local tileCoord = tileCoordFromPosition(position)
	cclog(Directory)
    --获得瓦片的GID math.floor取小于该数的最大整数
    local intX = math.floor(tileCoord.x)
    local intY = math.floor(tileCoord.y)

    local tileGid = _collidable:getTileGIDAt(cc.p(intX, intY))--gid值为0表示为空
	local bgGid	  = _backGround:getTileGIDAt(cc.p(intX, intY))--gid值为0表示为空
	
    cclog("(%f, %f) GID = %d",tileCoord.x , tileCoord.y, tileGid)
    cclog("(%f, %f) GID = %d",intX, intY, tileGid)

    if tileGid > 0 then
        local prop = _tileMap:getPropertiesForGID(tileGid)
        local collision = prop["Collidable"]

        if collision == "true" then --碰撞检测成功
        cclog("碰撞检测成功")
        AudioEngine.playEffect("empty.wav")
        return
        end
    end
    --移动精灵
    _player:setPosition(position)
	--滚动地图
    setViewpointCenter()
end

local function onMyTouchBegan(touch,event)
	cclog("ninja movebegin")
	return true
end
local function onMyTouchMoved(touch,event)
--	cclog("ninja touchMoved")
end
local function onMyTouchEnded(touch,event)
	cclog("ninja touchend")
	local touchLocation=touch:getLocation()
	--转换为当前层的模型坐标系
	touchLocation=_layer:convertToNodeSpace(touchLocation)

    local playerPosX, playerPosY = _player:getPosition()
    local diff = cc.pSub(touchLocation, cc.p(playerPosX, playerPosY))

    if math.abs(diff.x) > math.abs(diff.y) then
        if diff.x > 0 then
            playerPosX = playerPosX + _tileMap:getTileSize().width--获得瓦片的尺寸，单位是像素
			Directory="右"
            _player:runAction(cc.FlipX:create(false))
        else
            playerPosX = playerPosX - _tileMap:getTileSize().width
			Directory="左"
            _player:runAction(cc.FlipX:create(true))
        end
    else
        if diff.y > 0 then
            playerPosY = playerPosY + _tileMap:getTileSize().height
			Directory="上"
        else
            playerPosY = playerPosY - _tileMap:getTileSize().height
			Directory="下"
        end
    end
    cclog("忍者坐标 (%f ,%f) ", playerPosX, playerPosY)
--    _player:setPosition(cc.p(playerPosX, playerPosY))
	setPlayerPosition(cc.p(playerPosX,playerPosY))--碰撞检测不成功才真正移动位置
end
local function onKeyPressed(keyCode, event)

end
local function onMyKeyReleased(keyCode, event)
	local opFlag=false
	local playerPosX, playerPosY = _player:getPosition()
	if keyCode==28 then
		playerPosY = playerPosY + _tileMap:getTileSize().height
		Directory="上"
		opFlag=true
	elseif keyCode==29 then
		playerPosY = playerPosY - _tileMap:getTileSize().height
		opFlag=true
		Directory="下"
	elseif keyCode==26 then
		playerPosX = playerPosX - _tileMap:getTileSize().width
		opFlag=true
		Directory="左"
		_player:runAction(cc.FlipX:create(true))
	elseif keyCode==27 then
		playerPosX = playerPosX + _tileMap:getTileSize().width--获得瓦片的尺寸，单位是像素
		opFlag=true
		Directory="右"
		_player:runAction(cc.FlipX:create(false))
	end
	if opFlag then
		setPlayerPosition(cc.p(playerPosX,playerPosY))--碰撞检测不成功才真正移动位置
	end
end
function GameScene:createLayer()
	cclog("GameSceneNinja init")

    local layer = cc.Layer:create()
	_layer=layer
    _tileMap = cc.TMXTiledMap:create("Ninja/map/MiddleMap.tmx")--创建瓦片地图对象
    layer:addChild(_tileMap,0,100)

    local group = _tileMap:getObjectGroup("objects")--通过层名获得层中对象组集合（这个对象组不具有node的特性）
    local spawnPoint = group:getObject("ninja")	--这里已经坐标转换过了。（编辑器是UI坐标系）

    local x = spawnPoint["x"]
    local y = spawnPoint["y"]

    _player = cc.Sprite:create("Ninja/ninja.png")
--	local wapian=tileCoordFromPosition(cc.p(x,y))
	_player:setAnchorPoint(cc.p(0.5,0))
    _player:setPosition(cc.p(x,y))
    layer:addChild(_player, 2, 200)

	local touchListen = cc.EventListenerTouchOneByOne:create()
	touchListen:setSwallowTouches(true)
	touchListen:registerScriptHandler(onMyTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	touchListen:registerScriptHandler(onMyTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
	touchListen:registerScriptHandler(onMyTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
	touchListen:registerScriptHandler(onMyTouchEnded,cc.Handler.EVENT_TOUCH_CANCELLED)
	
	local keyboardListener = cc.EventListenerKeyboard:create()
	keyboardListener:registerScriptHandler(onKeyPressed, cc.Handler.EVENT_KEYBOARD_PRESSED )
    keyboardListener:registerScriptHandler(onMyKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED )
	
	local eventDispatcher = self:getEventDispatcher()--难道每个节点都有分发事件的能力？？？
	eventDispatcher:addEventListenerWithSceneGraphPriority(touchListen, layer)
	eventDispatcher:addEventListenerWithSceneGraphPriority(keyboardListener, layer)
	
	_collidable = _tileMap:getLayer("collidable")
	_backGround = _tileMap:getLayer("background")
    _collidable:setVisible(false)
	
    return layer
end

return GameScene