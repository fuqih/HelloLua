--lua对象深度拷贝
function DeepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end
--这个函数用来不重复加载模块
function requireEx(fileName)
	if package.loaded[fileName] then
		cclog(fileName..">>>文件重新加载")
		package.loaded[fileName]=nil
	end
	return require(fileName)
end