local size = cc.Director:getInstance():getWinSize()

local GameScene = class("GameScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)
--[[
	这里展示了一些GUI控件，包括图片按钮文本（富文本），单选按钮按钮组等


--]]
function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	return scene
end
function GameScene:ctor()
	
end
local _text
local num=0
local slider
--Button对象事件处理
local function menuCloseCallback(sender, eventType)
	cclog("Call menuCloseCallback...")
	if eventType == ccui.TouchEventType.began then --手指触碰屏幕
		cclog("Touch Down")
	elseif eventType == ccui.TouchEventType.moved then --手指在屏幕上移动
		cclog("Touch Move")
	elseif eventType == ccui.TouchEventType.ended then --手指离开屏幕
		cclog("Touch Up")
--		num=num+1
--		_text:setString("第"..num.."次")
	else
		cclog("Touch Cancelled")
	end
end
function GameScene:createLayer()
	cclog("GameSceneTemplate init")
	local layer = cc.Layer:create()
	
	--imageView不可以接收事件处理
	local imageView = ccui.ImageView:create("actions/Background.png")
	imageView:setPosition(cc.p(size.width/2,size.height/2))
	imageView:setContentSize(size.width,size.height)
	layer:addChild(imageView)
	--button可以接收事件处理
	local button = ccui.Button:create("GUI/CloseNormal.png","GUI/CloseSelected.png","GUI/CloseSelected.png")
	button:setPosition(size.width - button:getContentSize().width / 2 , button:getContentSize().height / 2)
	button:addTouchEventListener(menuCloseCallback)--GUI控件有这个函数，精灵没有
	button:setPressedActionEnabled(true)
	layer:addChild(button)
	--据说文本不能修改,实际上改起来毫无压力（文本包括text,textBMFont,textAtlas,richText）
	local text=ccui.Text:create("hello world","",36)
	_text=text
	text:setPosition(size.width/2,size.height/2+150)
--	layer:addChild(text)
	--富文本可以显示超文本，及对文本字体颜色链接等进行设置，
	--还可以自定义控件的内容,这就是一个容器吧,可以用来添加富文本元素控件，富文本感觉很像一个数组容器,这个容器会自适应换行
	local richText = ccui.RichText:create()
	--设置是否忽略用户定义的内容大小
	richText:ignoreContentAdaptWithSize(false)
	--设置内容大小
	richText:setContentSize(cc.size(200, 200))

	--创建文本类型的RichElement对象
	local re1 = ccui.RichElementText:create(1, cc.c3b(0, 255, 0), 255, "Hello World", "GUI/fonts/Marker Felt.ttf", 20)
	local re2 = ccui.RichElementText:create(2, cc.c3b(255, 0, 0), 255, "Last one is red ", "Helvetica", 20)
	--创建图片类型的RichElement对象
	local re3 = ccui.RichElementImage:create(3, cc.c3b(255, 0, 0), 255, "GUI/CloseSelected.png")
	--创建换行RichElement对象
	local newLine = ccui.RichElementNewLine:create(77, cc.c3b(255, 255, 255), 255)

	richText:pushBackElement(re1)
	richText:pushBackElement(newLine)
	richText:pushBackElement(re2)	
	richText:pushBackElement(re3)
	richText:insertElement(newLine, 3)
	richText:setPosition(size.width / 2, size.height / 2)
--	layer:addChild(richText)
	--单选按钮及按钮组,按钮组更像是一个管理者而不是一个容器，这些按钮最后还是要添加到Layer中，而且按钮组也需要添加进来
	-- RadioButton单击事件回调函数
    local function onChangedRadioButtonGroup(sender, index, eventType)
        cclog("RadioButton " .. index .. " Clicked")
    end
	local radioButtonGroup = ccui.RadioButtonGroup:create()
--	layer:addChild(radioButtonGroup)
	
	local NUMBER_BUTTONS  = 5
	local BUTTON_WIDTH	  = 60
	local startPosX=size.width/2 - ((NUMBER_BUTTONS-1)/2)*BUTTON_WIDTH
	for i=0,NUMBER_BUTTONS-1 do
		local radioButton = ccui.RadioButton:create("GUI/icon/btn_radio_off_holo.png", "GUI/icon/btn_radio_on_holo.png")
		local posX=startPosX+i*BUTTON_WIDTH
		radioButton:setPosition(posX,size.height/2+10)
		radioButtonGroup:addRadioButton(radioButton)
		radioButtonGroup:addEventListener(onChangedRadioButtonGroup)
--		layer:addChild(radioButton)
	end
	--创建CheckBox对象
	local function onChangedCheckBox(sender, eventType)
        cclog(eventType)
        if eventType == ccui.CheckBoxEventType.selected then
            cclog("CheckBox Selected")
        elseif eventType == ccui.CheckBoxEventType.unselected then
            cclog("CheckBox Unselected")
        end
    end
    local ckb = ccui.CheckBox:create("GUI/icon/btn_check_off_holo.png", "GUI/icon/btn_check_on_holo.png")
    --设置CheckBox位置
    ckb:setPosition(cc.p(size.width/2,size.height/2))
    --添加事件监听器
    ckb:addEventListener(onChangedCheckBox)
--	layer:addChild(ckb)
	
	--创建LoadingBar
	--感觉就是一点点把图片显示出来
	loadingBar = ccui.LoadingBar:create("GUI/progressbar.png")
	loadingBar:setPosition(size.width / 2, size.height / 2 + loadingBar:getContentSize().height / 2.0)
	loadingBar:setDirection(ccui.LoadingBarDirection.LEFT)--加载的方向，默认为左，可选左右

--	layer:addChild(loadingBar)
	local count = 0

	local function update(dt)        
		count = count + 1
		if count > 100 then 
			count = 0
		end
		loadingBar:setPercent(count)
	end
--	layer:scheduleUpdateWithPriorityLua(update,0)

	--滑块控件，包括一个滑杆和一个滑块，可以按住滑块拖拽
	-- Slider滑动事件回调函数
	local function onChangedSlider(sender, eventType)
		--为什么事件响应不会把组件传过来，而是要这种变量作用域的原始方式
		if eventType == ccui.SliderEventType.percentChanged then 
			local percent = slider:getPercent()
			cclog("进度条: "..percent)
		end
	end
	--创建滑块控件
	slider = ccui.Slider:create()
	--加载滑杆纹理(感觉这是背景)
	slider:loadBarTexture("GUI/sliderTrack.png")
	--加载滑块按钮纹理（这是按钮）
	slider:loadSlidBallTextures("GUI/sliderThumb.png", "GUI/sliderThumb.png", "")--三个参数，参考按钮，正常按下不可用
	--加载滑块进度栏纹理（这是进度条）
	slider:loadProgressBarTexture("GUI/sliderProgress.png")
	slider:setMaxPercent(1000)
	slider:setPosition(size.width / 2.0, size.height / 2.0)
	slider:addEventListener(onChangedSlider)
	layer:addChild(slider)
	
	return layer
end

return GameScene