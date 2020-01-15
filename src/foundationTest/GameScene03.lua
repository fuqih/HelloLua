local size = cc.Director:getInstance():getWinSize()
--[[
	字体篇:创建自己的主要三种方式，自行思考其效率
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
	cclog("GameScene3 init")
	local layer = cc.Layer:create()
	
	local gap=120

	--创建系统字体，不需要准备什么资源（需要确定当前操作系统拥有此字体）
	local label1=cc.Label:createWithSystemFont("hello world1!!!","Arial",36)
	label1:setPosition(cc.p(size.width / 2,size.height - gap ))
	layer:addChild(label1)
	
	--创建ttf字体,需要准备一个TTF文件(还有通过传入设置属性的方式来创建字体，详看电子书p94)
	local Label2=cc.Label:createWithTTF("hello world2!!!","fonts/testTTF/STLITI.ttf",36)
	Label2:setPosition(cc.p(size.width / 2,size.height - gap*2 ))
	layer:addChild(Label2)
	
	--创建BMFont字体，需要准备两个文件，一个图片集，一个字体坐标文件，（经测试字体不存在则忽略）
	--俩文件需要同名且处于同一个目录下，这个可以用工具生成
	local Label3=cc.Label:createWithBMFont("fonts/testFNT/bitmapFontChinese.fnt","中国中国")
	Label3:setPosition(cc.p(size.width / 2,size.height - gap*3 ))
	layer:addChild(Label3)
	local Label4=cc.Label:createWithBMFont("fonts/testFNT/BMFont.fnt","hello world")
	Label4:setPosition(cc.p(size.width / 2,size.height - gap*4 ))
	layer:addChild(Label4)
	
	--创建LabelAtals字，只需要准备一张图，但需要设置每个字符截取对应图片的宽高，并且字符排列顺序按照ASCII字符集的顺序来
	local Label5=cc.LabelAtlas:create(	"hello world!",
										"fonts/testAtlas/tuffy_bold_italic-charmap.png",48,66,string.byte(" "))
	Label5:setPosition(cc.p(size.width / 2,size.height - gap*5 ))
	Label5:setAnchorPoint(0.5,0.5)
	layer:addChild(Label5)
	
	
--[[	local sprite = cc.Sprite:create("HelloWorld.png")
    sprite:setPosition(cc.p(size.width/2, size.height/2))
    layer:addChild(sprite)--]]
	
	return layer
end

return GameScene


--[[
创建Label类静态create函数常用的有如下几个:
label:createWithSystemFont(	text,							--是要显示的文字
							font,							--系统字体名
							fontsize,						--字体的大小
							dimensions	= size(0,0)			--可省略，参考 LabetTTF定义
							aLignment	= TEXT_ALIGNMENT_LEFT，			--可省略，参考LabetTTF定义
							vAlignment	= VERTICAL_TEXT_ALIGNMENT_TOP	--可省略，参考LabetTTF定义
)
Label:createWithTTF(const std:string&text，
							fontFile--字体文件
							fontsize，
							dimensions= size（0， 0）
							hAlignment= TEXT_ALIGNMENT_LEFT，
							vAlignment= VERTICAL_TEXT_ALIGNMENT_TOP
)
Label:createWithTTF(	ttfConfig,							--字体配置信息
						text,								
						hAlignment= TEXT ALIGNMENT LEFT,	--可省略，标签的最大宽度
						int maxLineWidth =0
)
Label:createWithBMFont(	const std: string& bmfontFilePath,	--位图字体文件
						text,
						hAlignment= TEXT ALIGNMENT LEFT,
						int maxLineWidth 0,
						imageOffset p(0, 0)					--可省略，在位图中的偏移量
)
cocos2d中提供了三种文字显示方式，分别是CCLabelTTF，CCLabelBMFont和CCLabelAtlas，三种方式的效率由低到高
--]]