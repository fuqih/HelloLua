local size = cc.Director:getInstance():getWinSize()
--[[
	������Ч�Ͷ���
	������Ϊ���֣�1��ʱ�����ƵĶ�����2���涯����3��������ʱ�ı����ʵĶ���
	��ʱ�����ƵĶ����ַ�Ϊ˲ʱ�����ͼ������
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
	cclog("GameScene7 init")
	local layer = cc.Layer:create()
	

	
	local sprite = cc.Sprite:create("HelloWorld.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)
	return layer
end

return GameScene