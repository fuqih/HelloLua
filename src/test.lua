local function fbnq(n)
	if n>2 then
		return fbnq(n-1) + fbnq(n-2)
	else
		return 1
	end
end
for i=1,10 do
	print(fbnq(i))
end
