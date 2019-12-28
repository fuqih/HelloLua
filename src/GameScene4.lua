local size = cc.Director:getInstance():getWinSize()
--[[
	Ϊʲô�о��ı��˵����ǰ�ť���ı��˵����ԱȽϷ���ظı���ʾЧ��
	�˵���Ͳ˵���ͨ���˵�����Է������ϲ˵���ť����
	����˵�������״̬��������Ҫ�����������
	ͼƬ�˵���Ҳ������״̬�����ǿ���ʡ�Ե����֣�������״̬���ٴ���һ��ͼ
	���ز˵�ֻ������״̬��������Ҫ�����������
--]]
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
	cclog("GameScene4 init")
	local layer = cc.Layer:create()
	
	local sprite = cc.Sprite:create("menu/background.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
--    layer:addChild(sprite)
	
	--�ƺ���ʹ��ϵͳ����
	cc.MenuItemFont:setFontName("Times New Roman")
    cc.MenuItemFont:setFontSize(86)
	
	local item1 = cc.MenuItemFont:create("Start")
    local function menuItem1Callback(sender)
        cclog("Touch Start Menu Item.")
    end
    item1:registerScriptTapHandler(menuItem1Callback)--�����¼��ص�����
	
	--3.10�汾MenuItemAtlasFontû����ֲ�ԣ�ʹ����ϵİ취ʵ��
	--ʹ��ͼƬ��ǩ������Ҫһ��ͼƬ��Դ
	local  labelAtlas = cc.LabelAtlas:create("Help",
        "menu/font/tuffy_bold_italic-charmap.png", 48, 65, string.byte(' '))
    local  item2 = cc.MenuItemLabel:create(labelAtlas)
	
    local function menuItem2Callback(sender)
        cclog("Touch Help Menu Item.")
    end
    item2:registerScriptTapHandler(menuItem2Callback)

    local mn = cc.Menu:create(item1, item2)--�����˵����󣬰�
    mn:alignItemsVertically()--���ô�ֱ����
--    layer:addChild(mn)
-----------------------------------------------
	local director = cc.Director:getInstance()
	local sprite2 = cc.Sprite:create("menu/background.png")
    sprite2:setPosition(cc.p(size.width/2, size.height/2))
--	layer:addChild(sprite2)
	
	-- ��ʼ����
	-- �����������飬�ٰѾ�����뵽�˵�����,����˵��������ͦ�鷳��
    local startlocalNormal = cc.Sprite:create("menu/sprite/start-up.png")
    local startlocalSelected = cc.Sprite:create("menu/sprite/start-down.png")
    local startMenuItem = cc.MenuItemSprite:create(startlocalNormal, startlocalSelected)
    startMenuItem:setPosition(director:convertToGL(cc.p(700, 170)))
    local function menuItemStartCallback(sender)
        cclog("Touch Start.")
    end
    startMenuItem:registerScriptTapHandler(menuItemStartCallback)
	
	-- ����ͼƬ�˵���ͼƬ�˵���������ȽϷ��㣬�����ȴ�������
    local settingMenuItem = cc.MenuItemImage:create(
        "menu/sprite/setting-up.png",
        "menu/sprite/setting-down.png")
    settingMenuItem:setPosition(director:convertToGL(cc.p(480, 400)))
    local function menuItemSettingCallback(sender)
        cclog("Touch Setting.")
    end
    settingMenuItem:registerScriptTapHandler(menuItemSettingCallback)
	
	   -- ����ͼƬ�˵�
    local helpMenuItem = cc.MenuItemImage:create(
        "menu/sprite/help-up.png",
        "menu/sprite/help-down.png")

    helpMenuItem:setPosition(director:convertToGL(cc.p(860, 480)))
    local function menuItemHelpCallback(sender)
        cclog("Touch Help.")
    end
    helpMenuItem:registerScriptTapHandler(menuItemHelpCallback)
	
	local mn2 = cc.Menu:create(startMenuItem, settingMenuItem, helpMenuItem)
    mn2:setPosition(cc.p(0, 0))
--    layer:addChild(mn2)
	----------------------------------------------------------------
	local sprite3=cc.Sprite:create("menu/background3.png")
	sprite3:setPosition(cc.p(size.width/2, size.height/2))
	layer:addChild(sprite3)
	
    -- ��Ч
    local soundOnMenuItem = cc.MenuItemImage:create("menu/toggle/on.png", "menu/toggle/on.png")
    local soundOffMenuItem = cc.MenuItemImage:create("menu/toggle/off.png", "menu/toggle/off.png")
    local soundToggleMenuItem = cc.MenuItemToggle:create(soundOnMenuItem, soundOffMenuItem)
	soundToggleMenuItem:setScale(0.8)
    soundToggleMenuItem:setPosition(director:convertToGL(cc.p(900, 260)))  
    local function menuSoundToggleCallback(sender)
        cclog("Sound Toggle.")
    end
    soundToggleMenuItem:registerScriptTapHandler(menuSoundToggleCallback)

    -- ����
    local musicOnMenuItem = cc.MenuItemImage:create("menu/toggle/on.png", "menu/toggle/on.png")
    local musicOffMenuItem = cc.MenuItemImage:create("menu/toggle/off.png", "menu/toggle/off.png")
    local musicToggleMenuItem = cc.MenuItemToggle:create(musicOnMenuItem, musicOffMenuItem)
    musicToggleMenuItem:setPosition(director:convertToGL(cc.p(900, 400)))
	musicToggleMenuItem:setScale(0.8)
    local function menuMusicToggleCallback(sender)
        cclog("Music Toggle.")
    end
    musicToggleMenuItem:registerScriptTapHandler(menuMusicToggleCallback)
    
    -- Ok��ť
    local okMenuItem = cc.MenuItemImage:create(
        "menu/toggle/ok-down.png",
        "menu/toggle/ok-up.png")
    okMenuItem:setPosition(director:convertToGL(cc.p(700, 510)))

    local mn3 = cc.Menu:create(soundToggleMenuItem, musicToggleMenuItem,okMenuItem)
    mn3:setPosition(cc.p(0, 0))
    layer:addChild(mn3)
	
	return layer
end

return GameScene