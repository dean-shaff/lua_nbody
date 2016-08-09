Array1D = {vals = {},
			shape = 0}

-- Array1D.__index = Array1D -- this is necessary so lua will find the methods.

function Array1D:new(...)
	obj = {}
	setmetatable(obj, self)
	self.__index = self
	local args = {...}
	obj.vals = args[1]
	obj.shape = #obj.vals
	return obj
end 

function Array1D:printArr()
	val_str = ""
	for i=1,self.shape do
		val_str = val_str .. self.vals[i] .. " "
	end 
	print(val_str)
end 

function Array1D:__add(arr)
	if arr.shape ~= self.shape then
		print("array dimensions not the same")
	else
		local result = {}
		for i=1, arr.shape do 
			result[i] = arr.vals[i] + self.vals[i]
		end
		return self:new(result)
	end
end

function Array1D:__sub(arr)
	if arr.shape ~= self.shape then
		print("array dimensions not the same")
	else
		local result = {}
		for i=1, arr.shape do 
			result[i] = self.vals[i] - arr.vals[i]
		end
		return Array1D:new(result)
	end
end

function Array1D:__mul(arr)
	if arr.shape ~= self.shape then
		print("array dimensions not the same")
	else
		local result = {}
		for i=1, arr.shape do 
			result[i] = self.vals[i] * arr.vals[i]
		end
		return Array1D:new(result)
	end
end

function Array1D:__div(arr)
	if arr.shape ~= self.shape then
		print("array dimensions not the same")
	else
		local result = {}
		for i=1, arr.shape do 
			result[i] = self.vals[i] * arr.vals[i]
		end
		return Array1D:new(result)
	end
end

-- return Array1D