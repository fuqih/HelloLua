require "cocos.cocos2d.Cocos2d"
require "cocos.cocos2d.Cocos2dConstants"--常数，常量

local SettingScene = require("GameScene6_settingScene")


local size = cc.Director:getInstance():getWinSize()
--[[
	在这里学习场景与层，似乎有点像进程与线程的关系，一个进程必须有一个线程，而线程才是执行代码的基本条件
	而在这里，一个场景至少要有一个层，也可以堆多个层
	导演层常用的几个执行方法。
	runWithScene(scene)--第一次载入场景时使用
	replaceScene(scene)--替代场景并删除
	pushScene(scene)--压入新一个场景，原场景会入栈
	popScene()--释放当前场景，返回上一个场景
	popToRootScene()--返回根场景
	
	--场景可以添加过渡动画，具体步骤是，
	1.获得场景的实例，
	2.通过过渡动画类，根据场景实例，创建带过渡动画对象的场景，
	目测只在场景载入的时候有这个动画，pop的时候都没有这个动画
--]]
local GameScene = class("GameScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)
function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	--增加一个场景过渡动画
	local ts=cc.TransitionJumpZoom:create(1.0,scene)
--	cc.Director:getInstance():pushScene(ts)
	return ts
end
function GameScene:ctor()
	cclog("GameScene6ctor init")
    --场景生命周期事件处理
    local function onNodeEvent(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "enterTransitionFinish" then
            self:onEnterTransitionFinish()
        elseif event == "exit" then
            self:onExit()
        elseif event == "exitTransitionStart" then
            self:onExitTransitionStart()
        elseif event == "cleanup" then
            self:cleanup()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end
function GameScene:onEnter()
    cclog("GameScene6 onEnter")
end

function GameScene:onEnterTransitionFinish()
    cclog("GameScene6 onEnterTransitionFinish")
end

function GameScene:onExit()
    cclog("GameScene6 onExit")
end

function GameScene:onExitTransitionStart()
    cclog("GameScene6 onExitTransitionStart")
end

function GameScene:cleanup()
    cclog("GameScene6 cleanup")
end

function GameScene:createLayer()
	cclog("GameScene6 init")
	local layer = cc.Layer:create()
	local director=cc.Director:getInstance()
	--背景图
	local bg = cc.Sprite:create("menu/background2.png")
    bg:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(bg)
	--开始菜单
	local startlocalNormal = cc.Sprite:create("menu/sprite/start-up.png")
	local startlocalSelected = cc.Sprite:create("menu/sprite/start-down.png")
	local startMenuItem = cc.MenuItemSprite:create(startlocalNormal,startlocalSelected)
	startMenuItem:setPosition(director:convertToGL(cc.p(700,170)))
	    local function menuItemStartCallback(sender)
        cclog("Touch Start.")
    end
    startMenuItem:registerScriptTapHandler(menuItemStartCallback)
	--设置菜单
    local settingMenuItem = cc.MenuItemImage:create(
        "menu/sprite/setting-up.png",
        "menu/sprite/setting-down.png")
    settingMenuItem:setPosition(director:convertToGL(cc.p(480, 400)))
    local function menuItemSettingCallback(sender)
        cclog("Touch Setting.")
		local settingScene = SettingScene.create()
		director:pushScene(settingScene)
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
    layer:addChild(mn2)
	
	return layer
end

return GameScene