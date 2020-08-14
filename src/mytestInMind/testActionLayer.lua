local Layer=cc.Layer:create()
local size = cc.Director:getInstance():getWinSize()
local actSeq={}
--向动作队列里添加一个动作,返回一个数值，这个数值是添加完之后，队列里剩下的动作数量
local function pushAction(act)
	table.insert(actSeq,act)
end
--向动作队列里删除n动作,n不传则默认为1，若需要删除的动作数大于队列里已有的动作数则清空动作，并且打印日志
local function popAction(n)
	if n and n>#actSeq then
		actSeq={}
	elseif n and n<=#actSeq then
--		for i=#actSeq
	elseif #actSeq>1 then
		actSeq[#actSeq]=nil
	end
end

function Layer:onCreate(param)
	--背景精灵
    local bg = cc.Sprite:create("mytestInMind/Background.png")
	bg:setAnchorPoint(0.5,0.5)
	bg:setContentSize(size.width,size.height)
    bg:setPosition(cc.p(size.width/2, size.height/2))
	
	
	local label1=cc.Label:createWithSystemFont("first","Arial",24)
	label1:setPosition(cc.p(300,300))
	local ac1=cc.MoveBy:create(2,cc.p(200,0))
--	local ac2=cc.MoveBy:create(2,cc.p(0,200))
	local ac3=cc.MoveBy:create(2,cc.p(-200,0))
--	local ac4=cc.MoveBy:create(2,cc.p(0,-200))
	local seq=cc.Sequence:create(ac1,ac2,ac3,ac4)
	local rept=cc.RepeatForever:create(seq)
	label1:runAction(rept)
	
	local label2=cc.Label:createWithSystemFont("follow1","Arial",24)
	local flw=cc.Follow:create(label1)
	label2:runAction(flw)
	
	local label3=cc.Label:createWithSystemFont("follow2","Arial",24)
	local flw2=cc.Follow:create(label1)
	label3:runAction(flw2)
	
	self:addChild(bg)
	self:addChild(label2)
    label2:addChild(label1)
--	label2:addChild(label3)
	self:initActionWidgt()
	
end
function Layer:initActionWidgt()
	local path="mytestInMind/btn_sure.png"
	local buttonEnsure=ccui.Button:create(path,path,path)
	buttonEnsure:setAnchorPoint(0.5,0.5)
	buttonEnsure:setPosition(cc.p(size.width/2,100))
	buttonEnsure:addTouchEventListener(function(sender, state)
        if state == 2 then
			self:onClickeSure(sender)
        end
    end)
	
	self:addChild(buttonEnsure)
	self.buttonEnsure=buttonEnsure
	
	
	local clock=ccui.ImageView:create("mytestInMind/clock.png")
	clock:setAnchorPoint(0.5,0.5)
	clock:setPosition(cc.p(size.width/2,size.height/2))
	self:addChild(clock)
	self.clock=clock
end

function Layer:onClickeSure(event)
	cclog(string.format("在%s点击了一次按钮",os.date()))
	local act=cc.MoveBy:create(1,cc.p(10,10))
	local act2=cc.CallFunc:create(function()
		local pos=cc.p(self.clock:getPosition())
		cclog(string.format("pos:x=%s,y=%s",pos.x,pos.y))
	end)
	local seq=cc.Sequence:create(act,act2)
	self.clock:runAction(seq)
end
return Layer