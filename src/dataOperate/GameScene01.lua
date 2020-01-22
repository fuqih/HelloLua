local size = cc.Director:getInstance():getWinSize()
local fileUtils = cc.FileUtils:getInstance()--获取文件单元实例，这个实例采用单例设计模式
--[[
	文件访问，文件分为资源目录和可读写目录，资源目录只读,在移动平台，程序采用沙箱设计，数据只能被自己的应用访问
	游戏引擎有默认的搜索路径和可读路径，可以自己手动添加或者减少
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
	cclog("GameSceneTemplate init")
	local layer = cc.Layer:create()
	
	local sprite = cc.Sprite:create("HelloWorld.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
--    layer:addChild(sprite)
	
	--测试资源目录信息
	local function OnClickMenu1(menuItemSender)
		local fullPathForFilename = fileUtils:fullPathForFilename("test.txt")
		cclog("fullPathForFilename path = %s", fullPathForFilename)
		local isExist = fileUtils:isFileExist("test.txt")
		if isExist == true then
			cclog("test.txt exists")
		else
			cclog("test.txt doesn't exist")
		end
	end
	
	--读文件
	local function OnClickMenu2(menuItemSender)
		local fullPathForFilename = fileUtils:fullPathForFilename("test.txt")
		cclog("test.txt path = %s", fullPathForFilename)
		local content = fileUtils:getStringFromFile(fullPathForFilename)
		cclog("content : %s",content)
	end
	
	local label1=cc.Label:createWithSystemFont("test res dir","Arial",36)
	local menuItemLabel1 = cc.MenuItemLabel:create(label1)
	menuItemLabel1:registerScriptTapHandler(OnClickMenu1)
	
	local label2=cc.Label:createWithSystemFont("readFile","Arial",36)
	local menuItemLabel2 = cc.MenuItemLabel:create(label2)
	menuItemLabel2:registerScriptTapHandler(OnClickMenu2)
	
	local mn=cc.Menu:create(menuItemLabel1,menuItemLabel2)
	mn:alignItemsVertically()
--	layer:addChild(mn)

	local searchPaths = fileUtils:getSearchPaths()
	local writablePath = fileUtils:getWritablePath()
	local function onTouchEnded()
		fileUtils:purgeCachedEntries()--清理搜索文件缓存

		local searchPaths = fileUtils:getSearchPaths()
		local writablePath = fileUtils:getWritablePath()

		local resPrefix = "res/"

		table.insert(searchPaths, 1, resPrefix.."dir2")
		table.insert(searchPaths, 1, resPrefix.."dir1")
		table.insert(searchPaths, 1, writablePath)
		fileUtils:setSearchPaths(searchPaths)

		local fullPathForFilename = fileUtils:fullPathForFilename("test.txt")
		cclog("test.txt 's fullPathForFilename is : %s",fullPathForFilename)
		local content = fileUtils:getStringFromFile(fullPathForFilename)
		cclog("File content is : %s",content)
	end
	local spriteSearchpath = cc.Label:createWithSystemFont("Search Path","Arial",32)
	spriteSearchpath:setPosition(cc.p(size.width/2,size.height/2))
	layer:addChild(spriteSearchpath)
	local eventListener  = cc.EventListenerTouchOneByOne:create()
	eventListener:registerScriptHandler(function()return true end,cc.Handler.EVENT_TOUCH_BEGAN)
	eventListener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispacher = self:getEventDispatcher()
	eventDispacher:addEventListenerWithSceneGraphPriority(eventListener, spriteSearchpath)
	return layer
end

return GameScene