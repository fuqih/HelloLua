local size = cc.Director:getInstance():getWinSize()
--[[
	动作特效和动画
	动作分为三种，1受时间限制的动作，2跟随动作，3可在运行时改变速率的动作
	受时间限制的动作又分为瞬时动作和间隔动作
	
	动作还可以组合进行，可以顺序执行，或者同时执行，
	或者重复，无限或者有限重复，或者反向重复等等
	而且这些动作是以匀速线性进行的
--]]
local GameScene = class("GameScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)
--定义常量
kSequence	=102
kSpawn	=103
kRepeate	=104
kRepeatForever1	=105
kReverse		=106
--操作标识
actionFlag		=-1

function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function GameScene:ctor()

end
function GameScene:createLayer()
	cclog("GameScene9 init")
	local layer = cc.Layer:create()
	
	local bg = cc.Sprite:create("actions/Background.png")
    bg:setPosition(cc.p(size.width/2, size.height/2))
	bg:setContentSize(size.width,size.height)
    layer:addChild(bg)
	--点击事件，打开一个新的场景
	local function OnclickMenu(tag,menuItemSender)
		cclog("tag = %d",tag)
		actionFlag=menuItemSender:getTag()
		--组合动作
		local scene = require("GameScene9_sequenceActionScene")
		local nextScene=scene:create()
		ts=cc.TransitionJumpZoom:create(1,nextScene)
		cc.Director:getInstance():pushScene(ts)
	end
	--各项菜单项
	local placeLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","Sequence")
	local placeMenu	= cc.MenuItemLabel:create(placeLabel)
	placeMenu:setTag(kSequence)
	placeMenu:registerScriptTapHandler(OnclickMenu)
	
	local flipXLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","Spawn")
	local flipXMenu	= cc.MenuItemLabel:create(flipXLabel)
	flipXMenu:setTag(kSpawn)
	flipXMenu:registerScriptTapHandler(OnclickMenu)
	
	local flipYLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","Repeate")
	local flipYMenu	= cc.MenuItemLabel:create(flipYLabel)
	flipYMenu:setTag(kRepeate)
	flipYMenu:registerScriptTapHandler(OnclickMenu)
	
	local hideLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","RepeatForever")
	local hideMenu	= cc.MenuItemLabel:create(hideLabel)
	hideMenu:setTag(kRepeatForever1)
	hideMenu:registerScriptTapHandler(OnclickMenu)
	
	local toggleLabel = cc.Label:createWithBMFont("actions/fonts/fnt2.fnt","Reverse")
	local toggleMenu	= cc.MenuItemLabel:create(toggleLabel)
	toggleMenu:setTag(kReverse)
	toggleMenu:registerScriptTapHandler(OnclickMenu)
	
	local mn = cc.Menu:create(placeMenu,flipXMenu,flipYMenu,hideMenu,toggleMenu)
	mn:alignItemsVertically()
	layer:addChild(mn)
	
	return layer
end

return GameScene