import numpy as np

G = 1 
masses = np.array([1,500,1,1])
nBodies = masses.shape[0]

def rungekuttastep(h,fprime,x,y):
	k1 = h*fprime(x,y)
	k2 = h*fprime(x + 0.5*h, y + 0.5*k1)
	k3 = h*fprime(x + 0.5*h, y + 0.5*k2)
	k4 = h*fprime(x + h, y + k3)
	y_np1 = y + (1./6.)*k1 + (1./3.)*k2 + (1./3.)*k3 + (1./6.)*k4
	return y_np1

def squared_part_fn(i,j,y):
	x1 = y[i][0] 
	x2 = y[j][0]
	y1 = y[i][2]
	y2 = y[j][2]
	return ((x1-x2)**2 + (y1-y2)**2)**1.5

def fprimeNbody(x,y):
	yPrime = np.zeros((nBodies,4))
	for i in xrange(nBodies):
		yPrimeX = 0.0 
		yPrimeY = 0.0 
		for j in xrange(nBodies): 
			if (j != i):
				squared_part = squared_part_fn(i,j,y)
				yPrimeX -=  G*masses[j]*(y[i][0] - y[j][0])/squared_part
				yPrimeY -=  G*masses[j]*(y[i][2] - y[j][2])/squared_part
		yPrime[i][0] = y[i][1] # new x value 
		yPrime[i][2] = y[i][3] # new y value 
		yPrime[i][1] = yPrimeX # new x velocity value 
		yPrime[i][3] = yPrimeY # new y velocity value 
	return yPrime 

def runSimulation(filename):
	y = np.array([[10,0,0,7],[0,0,0,0],[-15,0,0,-5],[30,0,0,2]])
	x = np.zeros((nBodies,4))
	# x = Array2D().zeros({nBodies,4})
	ys = []
	for i in xrange(20000): 
		y = rungekuttastep(0.001,fprimeNbody,x,y)

runSimulation("results.txt")

