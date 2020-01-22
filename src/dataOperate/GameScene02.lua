local size = cc.Director:getInstance():getWinSize()
--[[
	数据持久化一般有四种，
	1.文本文件，这个不考虑
	2.userdefault,建议存少量数据，实质是xml格式的文件，引擎支持bool,string,int,float,double五种数据
	（数据格式还是偏少比如table就不支持）
	3.plist文件，但是为什么只有读取，没有写入...
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
local function OnClickMenu1(tag, menuItemSender)
	local sharedFileUtils = cc.FileUtils:getInstance()
	local fullPathForFilename = sharedFileUtils:fullPathForFilename("NotesList.plist")
	local dict = sharedFileUtils:getValueMapFromFile(fullPathForFilename)--用这个方法读取根为字典结构的文件

	for key, value in pairs(dict) do
		for i=1, table.getn(value) do
			cclog("----------[%d]-----------", i)
			local row = value[i]
			local date = row["date"]
			local content = row["content"]
			cclog("date :  %s", date)
			cclog("content : %s", content)
		end
		break
	end
end
function GameScene:createLayer()
	cclog("GameSceneTemplate init")
	local layer = cc.Layer:create()
	
	local userDate = cc.UserDefault:getInstance()
	--设置的时候不区分key值，所以需要注意,取值的时候则跟是否字符串有关
--	userDate:setStringForKey("stringKey1","我的数据")
	userDate:setBoolForKey("stringKey1",true)
	
	local str = userDate:getStringForKey("stringKey1")
	local boolean = userDate:getBoolForKey("stringKey1")
	
	OnClickMenu1()
	
	local sprite = cc.Sprite:create("HelloWorld.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)
	return layer
end

return GameScene