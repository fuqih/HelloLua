local size = cc.Director:getInstance():getWinSize()
--[[
	为什么感觉文本菜单就是按钮，文本菜单可以比较方便地改变显示效果
	菜单项和菜单，通过菜单项可以方便地组合菜单按钮功能
	精灵菜单有三种状态，所以需要三个精灵对象
	图片菜单项也有三种状态，但是可以省略第三种，不可用状态，少传入一张图
	开关菜单只有两种状态，所以需要两个精灵对象
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
	cclog("GameScene4 init")
	local layer = cc.Layer:create()
	
	local sprite = cc.Sprite:create("menu/background.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
--    layer:addChild(sprite)
	
	--似乎是使用系统字体
	cc.MenuItemFont:setFontName("Times New Roman")
    cc.MenuItemFont:setFontSize(86)
	
	local item1 = cc.MenuItemFont:create("Start")
    local function menuItem1Callback(sender)
        cclog("Touch Start Menu Item.")
    end
    item1:registerScriptTapHandler(menuItem1Callback)--单击事件回调函数
	
	--3.10版本MenuItemAtlasFont没有移植性，使用组合的办法实现
	--使用图片标签集，需要一张图片资源
	local  labelAtlas = cc.LabelAtlas:create("Help",
        "menu/font/tuffy_bold_italic-charmap.png", 48, 65, string.byte(' '))
    local  item2 = cc.MenuItemLabel:create(labelAtlas)
	
    local function menuItem2Callback(sender)
        cclog("Touch Help Menu Item.")
    end
    item2:registerScriptTapHandler(menuItem2Callback)

    local mn = cc.Menu:create(item1, item2)--创建菜单对象，把
    mn:alignItemsVertically()--设置垂直对齐
--    layer:addChild(mn)
-----------------------------------------------
	local director = cc.Director:getInstance()
	local sprite2 = cc.Sprite:create("menu/background.png")
    sprite2:setPosition(cc.p(size.width/2, size.height/2))
--	layer:addChild(sprite2)
	
	-- 开始精灵
	-- 创建两个精灵，再把精灵加入到菜单项中,精灵菜单项创建起来挺麻烦地
    local startlocalNormal = cc.Sprite:create("menu/sprite/start-up.png")
    local startlocalSelected = cc.Sprite:create("menu/sprite/start-down.png")
    local startMenuItem = cc.MenuItemSprite:create(startlocalNormal, startlocalSelected)
    startMenuItem:setPosition(director:convertToGL(cc.p(700, 170)))
    local function menuItemStartCallback(sender)
        cclog("Touch Start.")
    end
    startMenuItem:registerScriptTapHandler(menuItemStartCallback)
	
	-- 设置图片菜单，图片菜单项创建起来比较方便，不用先创建精灵
    local settingMenuItem = cc.MenuItemImage:create(
        "menu/sprite/setting-up.png",
        "menu/sprite/setting-down.png")
    settingMenuItem:setPosition(director:convertToGL(cc.p(480, 400)))
    local function menuItemSettingCallback(sender)
        cclog("Touch Setting.")
    end
    settingMenuItem:registerScriptTapHandler(menuItemSettingCallback)
	
	   -- 帮助图片菜单
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
	
    -- 音效
    local soundOnMenuItem = cc.MenuItemImage:create("menu/toggle/on.png", "menu/toggle/on.png")
    local soundOffMenuItem = cc.MenuItemImage:create("menu/toggle/off.png", "menu/toggle/off.png")
    local soundToggleMenuItem = cc.MenuItemToggle:create(soundOnMenuItem, soundOffMenuItem)
	soundToggleMenuItem:setScale(0.8)
    soundToggleMenuItem:setPosition(director:convertToGL(cc.p(900, 260)))  
    local function menuSoundToggleCallback(sender)
        cclog("Sound Toggle.")
    end
    soundToggleMenuItem:registerScriptTapHandler(menuSoundToggleCallback)

    -- 音乐
    local musicOnMenuItem = cc.MenuItemImage:create("menu/toggle/on.png", "menu/toggle/on.png")
    local musicOffMenuItem = cc.MenuItemImage:create("menu/toggle/off.png", "menu/toggle/off.png")
    local musicToggleMenuItem = cc.MenuItemToggle:create(musicOnMenuItem, musicOffMenuItem)
    musicToggleMenuItem:setPosition(director:convertToGL(cc.p(900, 400)))
	musicToggleMenuItem:setScale(0.8)
    local function menuMusicToggleCallback(sender)
        cclog("Music Toggle.")
    end
    musicToggleMenuItem:registerScriptTapHandler(menuMusicToggleCallback)
    
    -- Ok按钮
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