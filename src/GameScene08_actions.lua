local size = cc.Director:getInstance():getWinSize()
--[[
	动作特效和动画
	动作分为三种，1受时间限制的动作，2跟随动作，3可在运行时改变速率的动作
	受时间限制的动作又分为瞬时动作和间隔动作
--]]
local GameScene = class("GameScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)
-- 定义常量
kMoveTo             = 102
kMoveBy             = 103
kJumpTo             = 104
kJumpBy             = 105
kBezierBy           = 106
kScaleTo            = 107
kScaleBy            = 108
kRotateTo           = 109
kRotateBy           = 110
kBlink              = 111
kTintTo             = 112
kTintBy             = 113
kFadeTo             = 114
kFadeIn             = 115
kFadeOut            = 116
--操作标识
actionFlag = -1

function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function GameScene:ctor()

end
--菜单项的点击事件
local function OnclickMenu(tag,menuItemSender)
	cclog("tag = %d", tag)
	actionFlag = menuItemSender:getTag()

	local scene = require("GameScene08_IntervalActions")
	local nextScene = scene.create()
	local ts = cc.TransitionJumpZoom:create(1, nextScene)
	cc.Director:getInstance():pushScene(ts)
end

--传入一个tag值和需要显示出的文字，返回一个菜单项
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
	
	local menuItemsName={
						{102,"kMoveTo"},{103,"kMoveBy"},{104,"kJumpTo"},
						{105,"kJumpBy"},{106,"kBezierBy"},{107,"kScaleTo"},
						{108,"kScaleBy"},{109,"kRotateTo"},{110,"kRotateBy"},
						{111,"kBlink"},{112,"kTintTo"},{113,"kTintBy"},
						{114,"kFadeTo"},{115,"kFadeIn"},{116,"kFadeOut"}}
	local menuItems={}--菜单项表
	for i=1,#menuItemsName do
		local menuItem=self:createMenuItem(menuItemsName[i][1],menuItemsName[i][2])
		table.insert(menuItems,menuItem)
	end
	--有点操淡，不知道为什么table的pack,unpack不能用了
	local mn = cc.Menu:create(unpack(menuItems))
	mn:alignItemsInColumns(3,3,3,3,3)
	layer:addChild(mn)
	
	return layer
end

return GameScene