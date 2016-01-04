import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import scipy.ndimage

#Source: http://stackoverflow.com/questions/12201577/how-can-i-convert-an-rgb-image-into-grayscale-in-python
def rgb2gray(rgb):
    return np.dot(rgb[...,:3], [.33,.33,.33])

def importImage(path, plot = False):
    im = mpimg.imread(path)
    gray = rgb2gray(im)

    ny, nx = len(im[:,0]), len(im[0,:])
    x = range(nx)
    y = range(ny)
    X, Y = np.meshgrid(x, y)

    out = scipy.ndimage.filters.gaussian_filter(gray,3)
    out = np.gradient(out)
    out = sp.stats.threshold(out,None,mean(out),1);
    out = sp.stats.threshold(out,mean(out),None,0);

    if plot:
        f = plt.figure()
        s = f.add_subplot(111,projection='3d')
        s.plot_surface(X,Y,out)
        plt.show()

    return out.tolist()

def writeImages(lst, n = 0):
    out = "images = %s" % str(lst)
    with open("render%d.png" % n, "w+") as f:
        f.write(out)


