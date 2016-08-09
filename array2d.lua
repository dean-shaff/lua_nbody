function Array2D(...)
	
	local args = {...}
	if #args == 0 then 
		args = {{{}}}
	end
	local array2d = {
		__index = self,
		vals = args[1],
		shape = {#args[1], #args[1][1]},
		zeros = function(shape)
			local zeroArray = {} 
			for i=1,shape[1] do
				zeroArray[i] = {}
				for j=1,shape[2] do 
					zeroArray[i][j] = 0.0
				end
			end
			return Array2D(zeroArray)
		end,

		processArgs = function(arr1, arr2)
			local getVal1 
			local getVal2
			local shape
			if type(arr1) == 'number' then
				function getVal1(i,j) return arr1 end 
				function getVal2(i,j) return arr2.vals[i][j] end 
				shape = arr2.shape
			elseif type(arr2) == 'number' then 
				function getVal1(i,j) return arr1.vals[i][j] end 
				function getVal2(i,j) return arr2 end 
				shape = arr1.shape
			elseif type(arr1) == 'table' and type(arr2) == 'table' then 
				function getVal1(i,j) return arr1.vals[i][j] end 
				function getVal2(i,j) return arr2.vals[i][j] end 
				shape = arr1.shape
			end
			return {getVal1, getVal2, shape} 
		end,

		printArr = function(self)
			val_str = ""
			for i=1,self.shape[1] do 
				for j=1,self.shape[2] do 
					val_str = val_str .. self.vals[i][j] .. " "
				end
				if i ~= self.shape[1] then
					val_str = val_str .. '\n'
				end				
			end
			print(val_str)
		end, 

	}

	local arithmetic = {

		__add = function(arr1, arr2)
			local returnVal = array2d.processArgs(arr1, arr2)
			local getVal1 = returnVal[1]
			local getVal2 = returnVal[2]
			local shape = returnVal[3]

			local new = {}
			for i=1,shape[1] do 
				new[i] = {}
				for j=1,shape[2] do 
					new[i][j] = getVal1(i,j) + getVal2(i,j)
				end
			end
			return Array2D(new) 
		end,

		__sub = function(arr1, arr2)
			local returnVal = array2d.processArgs(arr1, arr2)
			local getVal1 = returnVal[1]
			local getVal2 = returnVal[2]
			local shape = returnVal[3]

			local new = {}
			for i=1,shape[1] do 
				new[i] = {}
				for j=1,shape[2] do 
					new[i][j] = getVal1(i,j) - getVal2(i,j)
				end
			end
			return new 
		end,

		__mul = function(arr1, arr2)
			local new = {}
			local returnVal = array2d.processArgs(arr1, arr2)
			local getVal1 = returnVal[1]
			local getVal2 = returnVal[2]
			local shape = returnVal[3]
			-- local getVal1, local getVal2, local shape = self:processArgs(arr1, arr2)
			for i=1,shape[1] do 
				new[i] = {}
				for j=1,shape[2] do 
					new[i][j] = getVal1(i,j) * getVal2(i,j)
				end
			end
			return Array2D(new) 
		end,

		__div = function(arr1, arr2)
			local new = {}
			local returnVal = array2d.processArgs(arr1, arr2)
			local getVal1 = returnVal[1]
			local getVal2 = returnVal[2]
			local shape = returnVal[3]
			for i=1,shape[1] do 
				new[i] = {}
				for j=1,shape[2] do 
					new[i][j] = getVal1(i,j) / getVal2(i,j)
				end
			end
			return new 
		end,
	}	
	setmetatable(array2d, arithmetic)
	return array2d 
end

