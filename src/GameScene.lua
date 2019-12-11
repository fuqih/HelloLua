local size = cc.Director:getInstance():getWinSize()

local GameScene = class("GameScene",function()
	return cc.Scene:create()--�²�Ӧ���Ǽ̳���Scene��
end)
function GameScene:create()
	--@��֪�������ʲô
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function GameScene:ctor()
	
end
function GameScene:createLayer()
	cclog("GameScene init")
	local layer = cc.Layer:create()
	

	
	local sprite = cc.Sprite:create("HelloWorld.png")
	local ContentSize=sprite:getContentSize()
	local scale=size.width/ContentSize.width < size.height/ContentSize.height and size.width/ContentSize.width or size.height/ContentSize.height
--	sprite:setScale(scale)
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)
	local function onMyTouchBegan(touch,event)
		local target = event:getCurrentTarget()--target���¼�Դ
		
		local UIposition=touch:getLocationInView()--������õ���UI���꣬��������Ϊԭ�㣬��ΪxΪ������ΪyΪ��
		cclog("touchInView_x:"..UIposition.x)
		cclog("touchInView_Y:"..UIposition.y)
		if target==sprite then
--			cclog("target==sprite")
		else
--			cclog("target~=sprite")
		end
--		cclog("onMyTouchBeganGetLocation--------------->")
--		cclog(touch:getLocation().x)
--		cclog(touch:getLocation().y)
--		cclog("onMyTouchBeganGetLocationInView--------------->")
--		cclog(touch:getLocationInView().x)
--		cclog(touch:getLocationInView().y)
		return false
--		local locationInNode = target:convertToNodeSpace(touch:getLocation())
	end
	local function onMyTouchMoved(touch,event)
		
		
		local target = event:getCurrentTarget()
		cclog("onMyTouchMoved--------------->")
		cclog(touch:getLocation().x)
		cclog(touch:getLocation().y)
	end
	local function onMyTouchEnded(touch,event)
		local target = event:getCurrentTarget()
		cclog("onMyTouchEnded--------------->")
		cclog(touch:getLocation().x)
		cclog(touch:getLocation().y)
	end
	local function onMyTouchCancelled(touch,event)
		local target = event:getCurrentTarget()
		cclog("onMyTouchCancelled--------------->")
		cclog(touch:getLocation().x)
		cclog(touch:getLocation().y)
	end
	--[[
		�����¼�ֻ�������ͼƬ�ϣ�����Ϊʲô�����������Ҳ�ᴥ���¼�������
	--]]
	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	if sprite.touchListen then eventDispatcher:removeEventListener(sprite.touchListen) end
	local touchListen = cc.EventListenerTouchOneByOne:create()
	touchListen:registerScriptHandler(onMyTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	touchListen:registerScriptHandler(onMyTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
	touchListen:registerScriptHandler(onMyTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
	touchListen:registerScriptHandler(onMyTouchCancelled,cc.Handler.EVENT_TOUCH_CANCELLED)
	sprite.touchListen = touchListen
	eventDispatcher:addEventListenerWithSceneGraphPriority(touchListen, sprite)
	
	local label=cc.Label:createWithSystemFont("hello world","arial",36)
	label:setAnchorPoint(cc.p(0,0))
	label:setPosition(cc.p(size.width/2,size.height-100))
	layer:addChild(label)
	
    local function update(delta)
        local x,y = label:getPosition()
        label:setPosition(cc.p(x + 2, y - 2))
    end
	--�ڵ������ÿһ֡��������һ������
	--��ʼ��Ϸ����
--    layer:scheduleUpdateWithPriorityLua(update, 0)
    local function onNodeEvent(tag)
        if tag == "exit" then--�жϴ����Ƿ����˳����¼�
            --��ʼ��Ϸ����
            layer:unscheduleUpdate()
        end
    end
    layer:registerScriptHandler(onNodeEvent)--ע����¼�������
	return layer
end

return GameScene