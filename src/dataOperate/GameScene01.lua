local size = cc.Director:getInstance():getWinSize()
--[[
	�ļ����ʣ��ļ���Ϊ��ԴĿ¼�Ϳɶ�дĿ¼����ԴĿ¼ֻ��,���ƶ�ƽ̨���������ɳ����ƣ�����ֻ�ܱ��Լ���Ӧ�÷���
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
	cclog("GameSceneTemplate init")
	local layer = cc.Layer:create()
	
	local sprite = cc.Sprite:create("HelloWorld.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)
	
	local fileUtils = cc.FileUtils:getInstance()
	local wirtablePath = fileUtils:getSearchPaths()
--	local button = ccui.Button:create("")
	return layer
end

return GameScene