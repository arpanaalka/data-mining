
"""gradient.py#################################################################
1.read data
2.normalize data using min,max formula
3.apply hold on for fetting tranining and validation data
4.apply gradient to find omega"""

import numpy as np
import csv
#from numpy import linalg as LA
import matplotlib.pyplot as plt
#from mpl_toolkits.mplot3d import Axes3D


data = open('Data1.csv')
data = csv.reader(data)
data = list(data)
def  plotdata(data) :
    m, n = data.shape
    datax = []
    datay = []
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    datax = data[:, 0]
    datay = data[:, 1]
    dataz = data[:, 2]
    ax.scatter(datax, datay, dataz)
    x, y = np.meshgrid(datax, datay)
    ax.plot_surface(x, y, data[:, 2], 'b*')
    plt.show()


def  gradient(tdata, vdata, ty, vy, alpha, omega, numiter):
    tlen = len(ty)
    vlen = len(vy)
    w = omega
    w = np.matrix(omega)
    tdata = np.matrix(tdata)
    vdata = np.matrix(vdata)
    vy = (np.matrix(vy)).transpose()
    ty = (np.matrix(ty)).transpose()
    #setting w
    fx = np.dot(tdata, (omega))
    difft = fx - ty
    deltaj = np.dot(difft.transpose(), (tdata))
    deltaj = deltaj.transpose()
    tempw = w - alpha * deltaj
    w = np.c_[w, tempw]
    #checking error wrt validation data
    new_fxv = np.dot(vdata, w[:, 0])
    diff = new_fxv - vy
    error = np.dot(diff.transpose(), diff) / vlen
    #w and error for more iteration
    for i in range(1, numiter):
        print i
        print w[:, 1]
        b = w[:, i]
        new_fx = np.dot(tdata, b)
        deltaj = ((new_fx - ty).transpose()) * tdata
        deltaj = deltaj.transpose()
        w[:, i] = w[:, i - 1] - alpha * deltaj
        #new_fxv = vdata * w[:, 0]

        new_fxv = np.dot(vdata, w[:, 0])
        diff = new_fxv - vy
        errori = np.dot(diff.transpose(), diff) / vlen
        error = np.c_[error, errori]

    min_omega_arg = np.argmin(error)
    print error
    print min_omega_arg
    return w[:, min_omega_arg]
    print error

if __name__ == '__main__':

    numiter = 100
    data = np.loadtxt("Data1.csv", delimiter=",")
    (m, n) = data.shape
    #plotdata(data)
    #normalization
    allx = data[:, 0:2]
    minx = allx.min(axis=0)
    maxx = allx.max(axis=0)
    allx = (allx - minx) / (maxx - allx)
    	
    #holdon
    b = np.floor(0.7 * m)
    tdata = np.zeros((b, 3), int)
    vdata = np.zeros((m - b, 3), int)
    tdata[:, 1:] = allx[:b, :]
    vdata[:, 1:] = allx[b:, :]
    #gradient
    ty = data[:b, 2]
    vy = data[b:, 2]
    omega = np.zeros((3, 1), int)
    alpha = 0.1
    omega = gradient(tdata, vdata, ty, vy, alpha, omega, numiter)
    print omega
