import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import scipy.ndimage

#Source: http://stackoverflow.com/questions/12201577/how-can-i-convert-an-rgb-image-into-grayscale-in-python
def rgb2gray(rgb):
    return np.dot(rgb[...,:3], [.33,.33,.33])

im = mpimg.imread("img.png")
gray = rgb2gray(im)

ny, nx = len(im[:,0]), len(im[0,:])
x = range(nx)
y = range(ny)
X, Y = np.meshgrid(x, y)

scipy.ndimage.filters.gaussian_filter(gray,.01*nx*ny)

with open("img.dat", "w") as f:
    f.write(str(gray.tolist()))

f = plt.figure()
s = f.add_subplot(111,projection='3d')
s.plot_surface(X,Y,gray)

plt.show()


