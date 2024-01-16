from answer import Rotation
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

def main():
    R = Rotation()
    pi = np.pi
    theta = [pi, pi/2, pi]
    
    Res = R.from_euler(theta)
    print(Res)
    
    ans = R.to_euler(Res)
    print(ans)
    
    
    #graphical visualisation of {b} and {s} frame
    origin = np.array([0,0,0])
    
    # s frame axes
    x_s = np.array([2,0,0])
    y_s = np.array([0,2,0])
    z_s = np.array([0,0,2])
    
    # forming b frame vectors
    x_b = np.dot(Res,x_s)
    y_b = np.dot(Res,y_s)
    z_b = np.dot(Res,z_s)
    
    # creating a 3d plot
    fig = plt.figure()
    axis = fig.add_subplot(111, projection='3d')
    
    axis.quiver(*origin, *x_s, color='r', label='x_s') # star symbol because we upack the vector and take each component individually
    axis.quiver(*origin, *y_s, color='g', label='y_s')
    axis.quiver(*origin, *z_s, color='b', label='z_s')

    # Plot the b frame
    axis.quiver(*origin, *x_b, color='r', linestyle='--', label='x_b')
    axis.quiver(*origin, *y_b, color='g', linestyle='--', label='y_b')
    axis.quiver(*origin, *z_b, color='b', linestyle='--', label='z_b')
    
    axis.legend()
    axis.set_xlabel("X")
    axis.set_ylabel("Y")
    axis.set_zlabel("Z")
    plt.show()

    
if __name__ == '__main__':
    main()
