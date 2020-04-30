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
		for i=#actSeq
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
    self:addChild(bg)
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