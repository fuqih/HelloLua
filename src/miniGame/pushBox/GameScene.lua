local size = cc.Director:getInstance():getWinSize()
--关卡地图信息,包括五类数据，空地，墙，箱子，目的，玩家
local m_levelData=nil
local this=nil
local m_layer=nil

local m_mapData=nil--将数据整合成一张二维表，也就是当前各个格子状态
local m_mapSpr={}

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
	m_layer=layer
	local bg = cc.Sprite:create("actions/Background.png")
    bg:setPosition(cc.p(size.width/2, size.height/2))
	bg:setContentSize(size.width,size.height)
    layer:addChild(bg)

	--初始化一些东西
--	self:initSpriteFrameCache()
	--获得关卡所有数据
	this=self
	local levelData=self:initLevelDate()
	m_levelData=levelData
	--转化成一张二维表
	local data2D=self:construct2DimensionData(levelData)
	m_mapData=data2D
	--根据关卡数据初始化游戏界面
	self:initMap(data2D)
	
	local function onMyKeyPressed(keyCode, event)
	end
	local function onMyKeyReleased(keyCode, event)
		local buf = string.format("释放了%d 键!",keyCode)
		cclog(buf)
		if keyCode==28 then
			self:moveOperate("up")
		elseif keyCode==29 then
			self:moveOperate("down")
		elseif keyCode==26 then
			self:moveOperate("left")
		elseif keyCode==27 then
			self:moveOperate("right")
		end
	end
    -- 创建一个键盘监听器
    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onMyKeyPressed, cc.Handler.EVENT_KEYBOARD_PRESSED )
    listener:registerScriptHandler(onMyKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED )
    local eventDispatcher = self:getEventDispatcher()
    -- 添加监听器
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
	
	return layer
end



local function showI(data)
	for i=#data,1,-1 do
	local col=""
	for j=1,#data[i] do
			col=col..","..data[i][j]
		end
		cclog(col)
	end
	cclog("_______________________________________________")
end
--获得关卡数据(深复制一份)
function GameScene:initLevelDate()
	local level=requirePushBox("Level")
	local levelData=level:getLevelDate()
	return DeepCopy(levelData)
end
--将关卡数据构造成一张二维表
function GameScene:construct2DimensionData(Data)
	local data2D={}
	local floor=Data.mapFloor
	local wall=Data.mapWall
	local mapTarget=Data.mapTarget
	local mapBox=Data.mapBox
	local mapPlayerLocation=Data.mapPlayerLocation
	--地面都是0
	for k,v in ipairs(floor) do
		data2D[k]={}
		for kk,vv in ipairs(v) do
			data2D[k][kk]=0
		end
	end
	--墙壁表示1
	for k,v in ipairs(wall) do
		for kk,vv in ipairs(v) do
			if vv==1 then
				data2D[k][kk]=1
			end
		end
	end
	--目的地表示2
	for i=1,#mapTarget do
		local x,y=mapTarget[i][1],mapTarget[i][2]
		data2D[y][x]=2
	end
	--箱子表示3
	for i=1,#mapBox do
		local x,y=mapBox[i][1],mapBox[i][2]
		data2D[y][x]=3
	end
	--人物表示4
	do
		local x,y=mapPlayerLocation[1],mapPlayerLocation[2]
		data2D[y][x]=4
	end
	return data2D
end

--渲染关卡地图,传入地图数据
function GameScene:initMap(Data)

	self:initFloor(Data)

    local buttonBack = cc.MenuItemImage:create(
        "miniGame/pushBox/Back-up.png",
        "miniGame/pushBox/Back-down.png")
    buttonBack:registerScriptTapHandler(self.backMenu)
	
	local menu=cc.Menu:create(buttonBack)
	menu:setPosition(cc.p(1150, 650))
	m_layer:addChild(menu)
end
function GameScene:initFloor(floorData)
	--清空数据
	if next(m_mapSpr) then
		for k,v in ipairs(m_mapSpr) do
			for kk,vv in ipairs(v) do
				vv:removeFromParent()
			end
		end
	end
	m_mapSpr={}
	for k,v in ipairs(floorData) do
		m_mapSpr[k]={}
		for kk,vv in ipairs(v) do
			local floorSpr={}
			if vv==4 then
				floorSpr=cc.Sprite:create("miniGame/pushBox/player/Character4.png")
			elseif vv==3 then
				floorSpr=cc.Sprite:create("miniGame/pushBox/box/CrateDark_Beige.png")
			elseif vv==2 then
				floorSpr=cc.Sprite:create("miniGame/pushBox/target/EndPoint_Gray.png")
			elseif vv==1 then
				floorSpr=cc.Sprite:create("miniGame/pushBox/wall/WallRound_Gray.png")
			else
				floorSpr=cc.Sprite:create("miniGame/pushBox/floor/GroundGravel_Sand.png")
			end

			floorSpr:setAnchorPoint(cc.p(0,0))
			floorSpr:setContentSize(60,60)
			floorSpr:setPosition(cc.p((kk-1)*60,(k-1)*60))
			m_layer:addChild(floorSpr)
			m_mapSpr[k][kk]=floorSpr
		end
	end
end

local opCode={up="up",down="down",left="left",right="right"}
function GameScene:moveOperate(key)
	if key==opCode.up then
		if self:operateUp() then
			--转化成一张二维表
			local data2D=self:construct2DimensionData(m_levelData)
			m_mapData=data2D
			--根据关卡数据初始化游戏界面
			self:initMap(data2D)
		end
	elseif key==opCode.down then
	elseif key==opCode.left then
	elseif key==opCode.right then
	end
end
function GameScene:operateUp()
	local nowPos={x=m_levelData.mapPlayerLocation[1],y=m_levelData.mapPlayerLocation[2]}
	local newPos={x=nowPos.x,y=nowPos.y+1}
	--如果越界，返回false
	if not m_mapData[newPos.x][newPos.y] then
		return false
	end
	--如果是墙，返回false
	if m_mapData[newPos.x][newPos.y]==1 then
		return false
	end
	--如果是箱子
	if m_mapData[newPos.x][newPos.y]==3 then
		--则箱子之上一格
		local newPos2={x=newPos.x,y=newPos.y+1}
		--如果越界，返回false
		if not m_mapData[newPos2.x][newPos2.y] then
			return false
		end
		--如果是墙，返回false
		if m_mapData[newPos2.x][newPos2.y]==1 then
			return false
		end
		--如果是箱子，返回false
		if m_mapData[newPos2.x][newPos2.y]==3 then
			return false
		end
		--则玩家可以向上移动，箱子可以向上移动，在此更新关卡地图数据,刷新界面不在此处
		m_levelData.mapPlayerLocation={newPos.y,newPos.x}
		local boxPosList=m_levelData.mapBox
		for k,v in ipairs(boxPosList) do
			if v[1]==newPos.x and v[2]==newPos.y then
				v={newPos2.x,newPos2.y}
				break
			end
		end
		return true
	end
	--上面可以移动
	m_levelData.mapPlayerLocation={newPos.y,newPos.x}
	return true
end
function GameScene:backMenu(pSender)
	cclog("IntervalActions backMenu")
	cc.Director:getInstance():popScene()
end
--渲染关卡地图,传入地图数据
function GameScene:initSpriteFrameCache()
	cc.SpriteFrameCache:getInstance():addSpriteFrames("miniGame/pushBox/floor/GroundGravel_Sand.png")
	cc.SpriteFrameCache:getInstance():addSpriteFrames("miniGame/pushBox/wall/WallRound_Brown.png")
end

return GameScene