require "cocos.init"

--cclog
--[[
...�ǿɱ䳤���ʽ�������ں������崦��Ϊ�β��б���ղ�����
��Ȼ��ǰ��Ҳ���������������̶����������ǿɱ䳤����������ں��棬���и�ȱ�ݣ���������nil��ʱ�����Ϳ��ܲ����Ǹ���Ч�����У��ڴ˿���ʹ��table.pack��
�����������lua������Ƶ��İ棬p62��
--]]
cclog = function(...)
	print(string.format(...))
end
local function main()
	--�������պ���
	collectgarbage("collect")--��һ����������������ѭ��
	collectgarbage("setpause",100)--���ü�Ъ�ʣ����ؼ�Ъ�ʵ�ǰһ��ֵ
	collectgarbage("setstepmul",5000)--���ز������ʵ�ǰһ��ֵ
	
	--��������·��
	cc.FileUtils:getInstance():addSearchPath("src")
	cc.FileUtils:getInstance():addSearchPath("res")
	
	local director = cc.Director:getInstance()
	director:getOpenGLView():setDesignResolutionSize(1280,720,0)
	director:setDisplayStats(true)
	--����֡��
	director:setAnimationInterval(1.0/60)
	
	local scene = require("GameScene2")
	local gameScene = scene:create()
	if cc.Director:getInstance():getRunningScene() then
		cc.Director:getInstance():replaceScene(gameScene)
	else
		cc.Director:getInstance():runWithScene(gameScene)
	end
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end