local size = cc.Director:getInstance():getWinSize()
--[[
	������Ч�Ͷ���
	������Ϊ���֣�1��ʱ�����ƵĶ�����2���涯����3��������ʱ�ı����ʵĶ���
	��ʱ�����ƵĶ����ַ�Ϊ˲ʱ�����ͼ������
--]]
local GameScene = class("GameScene",function()
	return cc.Scene:create()--�²�Ӧ���Ǽ̳���Scene��
end)
-- ���峣��
kExplosion  = 1
kFire       = 2
kFireworks  = 3
kFlower     = 4
kGalaxy     = 5
kMeteor     = 6
kRain       = 7
kSmoke      = 8
kSnow       = 9
kSpiral     = 10
kSun        = 11
--������ʶ
actionFlag = -1

function GameScene:create()
	--@��֪�������ʲô
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function GameScene:ctor()

end
--�˵���ĵ���¼�
local function OnclickMenu(tag,menuItemSender)
	cclog("tag = %d", tag)
	actionFlag = menuItemSender:getTag()

	local scene = require("extendTest.GameScene02_Scenes")
	local nextScene = scene.create()
	local ts = cc.TransitionJumpZoom:create(1, nextScene)
	cc.Director:getInstance():pushScene(ts)
end

--����һ��tagֵ����Ҫ��ʾ�������֣�����һ���˵���
function GameScene:createMenuItem(menuItemTag,menuItemName)
	local itemLabel=cc.Label:createWithBMFont("actions/fonts/fnt2.fnt",menuItemName)
	local menuItem=cc.MenuItemLabel:create(itemLabel)
	menuItem:setTag(menuItemTag)
	menuItem:registerScriptTapHandler(OnclickMenu)
	return menuItem
end

function GameScene:createLayer()
	cclog("GameScene8 init")
	local layer = cc.Layer:create()
	
	local bg = cc.Sprite:create("actions/Background.png")
	bg:setAnchorPoint(0.5,0.5)
	bg:setContentSize(size.width,size.height)
    bg:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(bg)
	
	local menuItemsName={{1,"Explosion"}	,{2,"Fire"}		,{3,"Fireworks"},
						{4,"Flower"}	,{5,"Galaxy"}	,{6,"Meteor"},
						{7,"Rain"}		,{8,"Smoke"}	,{9,"Snow"},
						{10,"Spiral"}	,{11,"Sun"}}
	local menuItems={}--�˵����
	for i=1,#menuItemsName do
		local menuItem=self:createMenuItem(menuItemsName[i][1],menuItemsName[i][2])
		table.insert(menuItems,menuItem)
	end
	local mn = cc.Menu:create(unpack(menuItems))
	mn:alignItemsInColumns(2, 2, 2, 2, 2, 1)
	layer:addChild(mn)
	
	return layer
end

return GameScene