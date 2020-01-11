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
	--以左下角作为原点，所以需要转换一下
	local function reverseMap(map)
		for i=1,math.modf(#map/2) do
			local temp=map[i]
			map[i]=map[#map-i]
			map[#map-i]=temp
		end
	end
	local mapWall={
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,1,1,1,1,0,0,0,0,0,0,0,0},
	{0,0,0,1,0,0,1,1,1,1,1,0,0,0,0},
	{0,0,0,1,0,0,0,0,0,0,1,0,0,0,0},
	{0,0,0,1,0,0,0,0,0,0,1,0,0,0,0},
	{0,0,0,1,1,0,0,0,0,0,1,0,0,0,0},
	{0,0,0,0,1,1,0,0,1,1,1,0,0,0,0},
	{0,0,0,0,0,1,0,0,1,0,0,0,0,0,0},
	{0,0,0,0,0,1,1,1,1,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	}
--	reverseMap(mapWall)
	local mapBox={{6,6},{7,6},{8,6},{9,5},{9,7}}
	local mapTarget={{6,6},{7,6},{8,6},{9,6},{10,6}}
	local mapPlayerLocation={7,8}
	
	map.mapFloor=mapFloor
	map.mapWall=mapWall
	map.mapBox=mapBox
	map.mapTarget=mapTarget
	map.mapPlayerLocation=mapPlayerLocation
	
	return map
end

level:init()
return level