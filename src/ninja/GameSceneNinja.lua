local size = cc.Director:getInstance():getWinSize()
--[[
	这章需要用到地图编辑器tiled，暂时不深入

--]]
local GameScene = class("GameScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)

local _tileMap			--地图
local _player			--玩家
local _layer			--当前层
local _collidable		--是否可碰撞
function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function GameScene:ctor()
	
end
local function tileCoordFromPosition(pos)
    local x = pos.x / _tileMap:getTileSize().width
    local y = ((_tileMap:getMapSize().height * _tileMap:getTileSize().height) - pos.y) / _tileMap:getTileSize().height
    return cc.p(x,y)
end

local function setPlayerPosition(position)
    --从像素点坐标转化为瓦片坐标
    local tileCoord = tileCoordFromPosition(position)

    --获得瓦片的GID math.floor取小于该数的最大整数
    local intX = math.floor(tileCoord.x)
    local intY = math.floor(tileCoord.y)

    local tileGid = _collidable:getTileGIDAt(cc.p(intX, intY))
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
            _player:runAction(cc.FlipX:create(false))
        else
            playerPosX = playerPosX - _tileMap:getTileSize().width
            _player:runAction(cc.FlipX:create(true))
        end
    else
        if diff.y > 0 then
            playerPosY = playerPosY + _tileMap:getTileSize().height
        else
            playerPosY = playerPosY - _tileMap:getTileSize().height
        end
    end
    cclog("playerPos (%f ,%f) ", playerPosX, playerPosY)
--    _player:setPosition(cc.p(playerPosX, playerPosY))
	setPlayerPosition(cc.p(playerPosX,playerPosY))
end
function GameScene:createLayer()
	cclog("GameSceneNinja init")

    local layer = cc.Layer:create()
	_layer=layer
    _tileMap = cc.TMXTiledMap:create("Ninja/map/MiddleMap.tmx")
    layer:addChild(_tileMap,0,100)

    local group = _tileMap:getObjectGroup("objects")
    local spawnPoint = group:getObject("ninja")

    local x = spawnPoint["x"]
    local y = spawnPoint["y"]

    _player = cc.Sprite:create("Ninja/ninja.png")
    _player:setPosition(cc.p(x,y))
    layer:addChild(_player, 2, 200)

	local touchListen = cc.EventListenerTouchOneByOne:create()
	touchListen:setSwallowTouches(true)
	touchListen:registerScriptHandler(onMyTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	touchListen:registerScriptHandler(onMyTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
	touchListen:registerScriptHandler(onMyTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
	touchListen:registerScriptHandler(onMyTouchEnded,cc.Handler.EVENT_TOUCH_CANCELLED)
	
	local eventDispatcher = self:getEventDispatcher()--难道每个节点都有分发事件的能力？？？
	eventDispatcher:addEventListenerWithSceneGraphPriority(touchListen, layer)
	
	_collidable = _tileMap:getLayer("collidable")
    _collidable:setVisible(false)
	
    return layer
end

return GameScene