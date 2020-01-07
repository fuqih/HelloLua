requireMiniGame=function(packagename)
	return require("miniGame."..packagename)
end


local miniGameInit={}

function miniGameInit:create()
	local pushBox=require("miniGame.pushBox.menuScene")
	return pushBox
end

return miniGameInit