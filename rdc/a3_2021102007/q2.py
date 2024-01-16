import numpy as np

def inverse_kinematics(x,y,z,l1,l2,l3):
    t1 = np.arctan2(y,x)
    
    x0 = x/np.cos(t1)
    z0 = z - l1
    
    t3 = np.arccos(((x0*x0) + (z0*z0) - (l1*l1 + l2*l2))/(2*l1*l2))
    
    t2 = (np.arctan2(z0,x0) - np.arctan2(l3*np.sin(t3),l1 + l2*np.cos(t3))).item()
    t = [t1, t2, t3]
    return t
        
# given our spatial manipulator
x = -6.123234e-17
y = 6.123234e-17
z = 2

angles = inverse_kinematics(x,y,z,1,1,1)
print(angles)