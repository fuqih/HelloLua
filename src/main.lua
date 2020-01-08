require "cocos.init"
require "BaseFunctionLib"

--cclog
--[[
...是可变长表达式，可以在函数定义处作为形参列表接收参数，
当然，前面也可以有任意数量固定参数，但是可变长参数必须放在后面，这有个缺陷，参数包含nil的时候它就可能不再是个有效的序列，在此可以使用table.pack。
具体情况翻阅lua程序设计第四版，p62。
--]]
cclog = function(...)
	print(string.format(...))
end
--[[---print带特殊颜色的日志
function logc(...)
	cc.CGame:setPrintColor(0x000C)
	cclog(...)
	cc.CGame:setPrintColor(0x000F)
end--]]


local function main()
	--垃圾回收函数
	collectgarbage("collect")--做一个完整的垃圾回收循环
	collectgarbage("setpause",100)--设置间歇率，返回间歇率的前一个值
	collectgarbage("setstepmul",5000)--返回步进倍率的前一个值
	
	--加入搜索路径
	cc.FileUtils:getInstance():addSearchPath("src")
	cc.FileUtils:getInstance():addSearchPath("res")
	
	local director = cc.Director:getInstance()
--	director:getOpenGLView():setDesignResolutionSize(1280,720,0)--设置设计屏幕尺寸
--	cc.Director:getInstance():getOpenGLView():setFrameZoomFactor(0.7)--设置缩放
	director:setDisplayStats(true)
	--设置帧率
	director:setAnimationInterval(1.0/60)
	
	local miniGameInit = require("miniGame.miniGameInit")
	local scene	= miniGameInit:create()
--	local scene = require("GameScene_a10_actions")
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