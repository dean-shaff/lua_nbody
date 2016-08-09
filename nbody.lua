require "array2d"

G = 1
masses = {1,500,1,1}
nBodies = #masses

local function rungekuttastep(h,fprime,x,y)
	-- Assumes x and y are instances of the Array2D class
	local k1 = h*fprime(x,y)
	local k2 = h*fprime(x + 0.5*h, y + 0.5*k1)
	local k3 = h*fprime(x + 0.5*h, y + 0.5*k2)
	local k4 = h*fprime(x + h, y + k3)
	local y_np1 = y + (1./6.)*k1 + (1./3.)*k2 + (1./3.)*k3 + (1./6.)*k4
	return y_np1
end

local function squared_part_fn(i,j,y)
	-- Just the squared part of the 
	local x1 = y.vals[i][1] 
	local x2 = y.vals[j][1]
	local y1 = y.vals[i][3]
	local y2 = y.vals[j][3]
	return math.pow((math.pow((x1-x2),2.) + math.pow((y1-y2),2.)),1.5)
end

local function fprimeNbody(x,y)
	-- yPrime for 2 body problem
	local yPrime = Array2D().zeros({nBodies,4})

	for i=1,nBodies do
		yPrimeX = 0.0 
		yPrimeY = 0.0 
		for j=1,nBodies do 
			if (j ~= i) then
				local squared_part = squared_part_fn(i,j,y)
				yPrimeX = yPrimeX - G*masses[j]*(y.vals[i][1] - y.vals[j][1])/squared_part
				yPrimeY = yPrimeY - G*masses[j]*(y.vals[i][3] - y.vals[j][3])/squared_part
			end
		yPrime.vals[i][1] = y.vals[i][2] -- new x value 
		yPrime.vals[i][3] = y.vals[i][4] -- new y value 
		yPrime.vals[i][2] = yPrimeX -- new x velocity value 
		yPrime.vals[i][4] = yPrimeY -- new y velocity value 
		end
	end	
	return yPrime 
end 

function runSimulation(filename)
	y = Array2D({{10,0,0,7},{0,0,0,0},{-15,0,0,-5},{30,0,0,2}})
	x = Array2D().zeros({nBodies,4})
	-- local f = function(x,y) return y end 
	ys = {}
	-- file = io.open(filename, 'w')
	for i=1,20000 do 
		y = rungekuttastep(0.001,fprimeNbody,x,y)
		-- for i=1,y.shape[1] do
		-- 	val_str = ""
		-- 	for j=1,y.shape[2] do 
		-- 		if j ~= y.shape[2] then
		-- 			val_str = val_str .. y.vals[i][j] .. ","
		-- 		elseif j == y.shape[2] then 
		-- 			val_str = val_str .. y.vals[i][j]
		-- 		end
		-- 	end
		-- 	val_str = val_str .. '\n'
		-- 	file:write(val_str)
		-- end
		-- ys[i] = y.vals
	end
	-- file.close()
	-- y:printArr()
end

runSimulation("results.txt")

