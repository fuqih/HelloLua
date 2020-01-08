local level={}
function level:init()
	
end
--在这里构造关卡数据，返回一个包含地图数据的表,在这里只静态地产生一组数据
--表中有五组数据
function level:getLevelDate(param)
	local map={}
	local mapFloor={}
	for height=1,12 do
		mapFloor[height]={}
		for width=1,15 do
			mapFloor[height][width]=1
		end
	end
	local mapWall={
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,1,1,1,1,0,0,0,0,0,0},
	{0,0,0,0,0,1,0,0,1,0,0,0,0,0,0},
	{0,0,0,0,1,1,0,0,1,1,1,0,0,0,0},
	{0,0,0,1,1,0,0,0,0,0,1,0,0,0,0},
	{0,0,0,1,0,0,0,0,0,0,1,0,0,0,0},
	{0,0,0,1,0,0,0,0,0,0,1,0,0,0,0},
	{0,0,0,1,0,0,1,1,1,1,1,0,0,0,0},
	{0,0,0,1,1,1,1,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	}
	local mapBox={{6,7},{7,7},{8,7},{9,6},{9,8}}
	local mapTarget={{6,7},{7,7},{8,7},{9,7},{10,7}}
	local mapPlayerLocation={7,5}
	
	map.mapFloor=mapFloor
	map.mapWall=mapWall
	map.mapBox=mapBox
	map.mapTarget=mapTarget
	map.mapPlayerLocation=mapPlayerLocation
	
	return map
end

level:init()
return level