
requirePushBox=function(packagename)
	return requireMiniGame("pushBox."..packagename)
end
local size = cc.Director:getInstance():getWinSize()
--[[
		推箱子菜单界面
		设计五个选项，分别是
		开始游戏，设置，选择关卡，自定义关卡，退出
--]]
local menuScene = class("menuScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)

function menuScene:create()
	--@不知道这个是什么
	local scene = menuScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function menuScene:ctor()

end
function menuScene:createLayer()
	cclog("推箱子菜单界面 init")
	local layer = cc.Layer:create()
	
	local bg = cc.Sprite:create("actions/Background.png")
    bg:setPosition(cc.p(size.width/2, size.height/2))
	bg:setContentSize(size.width,size.height)
    layer:addChild(bg)
	--点击事件，打开一个新的场景
	local function OnclickMenu(tag,menuItemSender)
		cclog("tag = %d",tag)
		actionFlag=menuItemSender:getTag()
		--瞬时动作
		local scene = require("menuScene7_instantActionScene")
		local nextScene=scene:create()
		ts=cc.TransitionJumpZoom:create(1,nextScene)
		cc.Director:getInstance():pushScene(ts)
	end
	--各项菜单项
	local startgameLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","start game")
	local startgameMenu	= cc.MenuItemLabel:create(startgameLabel)
	startgameMenu:registerScriptTapHandler(self.onClickStartGame)
	
	local settingLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","setting")
	local settingMenu	= cc.MenuItemLabel:create(settingLabel)
	settingMenu:registerScriptTapHandler(self.onClickSetting)
	
	local selectLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","selectlevel")
	local selectMenu	= cc.MenuItemLabel:create(selectLabel)
	selectMenu:registerScriptTapHandler(self.onClickSelectLevel)
	
	local customlevelLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","customlevel")
	local customlevelMenu	= cc.MenuItemLabel:create(customlevelLabel)
	customlevelMenu:registerScriptTapHandler(self.onClickCustomLevel)
	
	local leaveLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","leave")
	local leaveMenu	= cc.MenuItemLabel:create(leaveLabel)
	leaveMenu:registerScriptTapHandler(self.onClickLeave)
	
	local mn = cc.Menu:create(startgameMenu,settingMenu,selectMenu,customlevelMenu,leaveMenu)
	mn:alignItemsVertically()
	layer:addChild(mn)
	
	return layer
end
function menuScene:onClickStartGame()
	local scene=requirePushBox("GameScene")
	local gameScene=scene:create()
	cc.Director:getInstance():pushScene(gameScene)
end
function menuScene:onClickSetting()
	
end
function menuScene:onClickSelectLevel()
	
end
function menuScene:onClickCustomLevel()
	
end
function menuScene:onClickLeave()
	local Director=cc.Director:getInstance()
	Director:endToLua()
end
return menuScene