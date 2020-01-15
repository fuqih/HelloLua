require "cocos.cocos2d.Cocos2d"
require "cocos.cocos2d.Cocos2dConstants"--常数，常量

local size = cc.Director:getInstance():getWinSize()
--[[
	测试场景切换，场景可以添加过渡动画
	
	测试场景(以及任何节点)生命周期
	生命周期有五个
	1.enter,进入场景时触发。
	2.enterTransitionFinish，进入场景且过渡动画结束之后触发。
	4.exit。退出场景时触发。(实测退出场景的开始过渡动画居然比退出场景还早出现)
	3.exitTranisionStart。退出场景并且开始过渡动画时触发。
	5.cleanup。场景对象被清除时触发。
	--使用方法为，在ctor里构建处理函数，并设置回调函数
	--多场景下切换，场景的生命周期更复杂，两种场景先后逐步处于各种情况
	详情可以看p104页
	一般来说利用在生命周期这些时间做一些资源的创建和销毁事情
--]]
local MUSIC_FILE = "sound/arena.mp3"
local GameScene = class("GameScene",function()
	return cc.Scene:create()--猜测应该是继承了Scene类
end)
function GameScene:create()
	--@不知道这个是什么
	local scene = GameScene.new()
	scene:addChild(scene:createLayer())
	local ts = cc.TransitionFade:create(1.0,scene)
	return ts
end
function GameScene:ctor()
	cclog("GameScene6_settingScenector init")
    --场景生命周期事件处理
    local function onNodeEvent(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "enterTransitionFinish" then
            self:onEnterTransitionFinish()
        elseif event == "exit" then
            self:onExit()
        elseif event == "exitTransitionStart" then
            self:onExitTransitionStart()
        elseif event == "cleanup" then
            self:cleanup()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end
--[[
registerScriptTouchHandler             注册触屏事件
registerScriptTapHandler               注册点击事件
registerScriptHandler                  注册基本事件 包括触屏，层的进入、退出、事件
registerScriptKeypadHandler            注册键盘事件
registerScriptAccelerateHandler        注册加速事件
--]]
function GameScene:onEnter()
    cclog("settingScene onEnter")
end

function GameScene:onEnterTransitionFinish()
    cclog("settingScene onEnterTransitionFinish")
	--初始化场景播放背景音乐
	AudioEngine.playMusic(MUSIC_FILE, true)
end

function GameScene:onExit()
    cclog("settingScene onExit")
end

function GameScene:onExitTransitionStart()
    cclog("settingScene onExitTransitionStart")
end

function GameScene:cleanup()
    cclog("settingScene cleanup")
end

function GameScene:createLayer()
	cclog("GameScene6_settingScene init")
	local layer = cc.Layer:create()
	local director =cc.Director:getInstance()
	local bg=cc.Sprite:create("menu/background3.png")
	bg:setPosition(cc.p(size.width/2, size.height/2))
	layer:addChild(bg)
	
    -- 音效
    local soundOnMenuItem = cc.MenuItemImage:create("menu/toggle/on.png", "menu/toggle/on.png")
    local soundOffMenuItem = cc.MenuItemImage:create("menu/toggle/off.png", "menu/toggle/off.png")
    local soundToggleMenuItem = cc.MenuItemToggle:create(soundOnMenuItem, soundOffMenuItem)
	soundToggleMenuItem:setScale(0.8)
    soundToggleMenuItem:setPosition(director:convertToGL(cc.p(900, 260)))  
    local function menuSoundToggleCallback(sender)
        cclog("Sound Toggle.")
    end
    soundToggleMenuItem:registerScriptTapHandler(menuSoundToggleCallback)

    -- 背景音
    local musicOnMenuItem = cc.MenuItemImage:create("menu/toggle/on.png", "menu/toggle/on.png")
    local musicOffMenuItem = cc.MenuItemImage:create("menu/toggle/off.png", "menu/toggle/off.png")
    local musicToggleMenuItem = cc.MenuItemToggle:create(musicOnMenuItem, musicOffMenuItem)
    musicToggleMenuItem:setPosition(director:convertToGL(cc.p(900, 400)))
	musicToggleMenuItem:setScale(0.8)
	--背景音乐回调
    local function menuMusicToggleCallback(sender)
        cclog("Music Toggle.")
		cclog(musicToggleMenuItem:getSelectedIndex())
		if musicToggleMenuItem:getSelectedIndex() == 1 then --选中状态Off -> On
			AudioEngine.pauseMusic()--暂停
        else
            AudioEngine.resumeMusic()--继续
        end
    end
    musicToggleMenuItem:registerScriptTapHandler(menuMusicToggleCallback)
    
    -- Ok按钮
	--点击OK按钮，场景出栈
    local okMenuItem = cc.MenuItemImage:create(
        "menu/toggle/ok-down.png",
        "menu/toggle/ok-up.png")
    okMenuItem:setPosition(director:convertToGL(cc.p(700, 510)))
	local function menuOKCallback(sender)
		cclog("OK Menu tap.")--tap 轻点
		director:popScene()
	end
	okMenuItem:registerScriptTapHandler(menuOKCallback)
	
    local mn3 = cc.Menu:create(soundToggleMenuItem, musicToggleMenuItem,okMenuItem)
    mn3:setPosition(cc.p(0, 0))
    layer:addChild(mn3)
--	AudioEngine.playMusic("sound/Synth.mp3", true)
	return layer
end

return GameScene
--[[
Cocos2d-x LuaAPl提供了一个音频 AudioEngine引擎,
AudioEngine引擎可以独立于Cocos2d-x LuaAPl单独使用，它本质上封装了OpenAl音频处理库.
	Audio Engine引擎有以下常用的函数
（1）  preloadMusic(pszFilePath).预处理背景音乐文件，将压缩格式的文件进行解压处理，如MP3解压为WAV
（2）  playMusic(pszFilePath,bloop= false).播放背景音乐，参数 bLoop控制是否循环播放，默认情况下为 false
（3）  stopMusic().停止播放背景音乐
（4）  pauseMusic()，暂停播放背景音乐
（5）  resumeMusic().继续播放背景音乐
（6）  isMusicPlaying()，判断背景音乐是否正在播放

（7）  playEffect(pszFilePath)，播放音效。
（8）  pauseEffect(nSoundId).暂停播放音效，参数 nSoundId是 play Effect函数返回ID
（9）  pauseAllEffects()，暂停所有播放音效。
（10） resumeEffect(nSoundld).继续播放音效，参数 nSoundId是 playEffect函数返回ID
（11） resumeAllEffects().继续播放所有音效
（12） stopEffect(nSoundld).停止播放音效，参数 nSoundId是 play Effect函数返回ID
（13） stopAllEffects().停止所有播放音效
（14） preloadEffect(pszFilePath).预处理音效音频文件，将压缩格式的文件进行解压处理，如MP3解压为WAV
	在这里需要注意一下，大音频文件，例如背景音乐是，第一次加载是比较慢的，
	所以，可以在场景的进入的生命周期里预加载或者退出等，当然需要考虑到多场景的生命周期，可以参考p156及7.3章节
--]]