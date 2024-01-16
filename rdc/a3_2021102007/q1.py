import numpy as np

# DH parameters will be given as a 4x4 matrix - for a 3R manipulator
#parameters matrix will have a as col1, alpha as col2, d as col3 and theta as col4

#link lengths
L1 = 1
L2 = 1
L3 = 1


def DH_matrices(parameters):
    a = np.array(parameters[:,0])
    alpha = np.array(parameters[:,1])
    d = np.array(parameters[:,2])
    theta = np.array(parameters[:,3])
    
    T = np.empty((parameters.shape[0], 4, 4))
    for i in range(parameters.shape[0]):
        T[i] = np.array([[np.cos(theta[i]), -np.sin(theta[i]), 0, a[i]],
                         [np.sin(theta[i]) * np.cos(alpha[i]), np.cos(theta[i]) * np.cos(alpha[i]), -np.sin(alpha[i]), -d[i] * np.sin(alpha[i])],
                         [np.sin(theta[i]) * np.sin(alpha[i]), np.cos(theta[i]) * np.sin(alpha[i]), np.cos(alpha[i]), d[i] * np.cos(alpha[i])],
                         [0, 0, 0, 1]])

    return T


def forward_kinematics(joint_angles):
    parameters = np.array([[0,-np.pi/2,0,joint_angles[0]],
                           [2,0,2,joint_angles[1]],
                           [1,np.pi/2,1,joint_angles[2]]])
    T = DH_matrices(parameters)
    ee_pose = np.matmul(T[1],T[0])
    ee_pose = np.matmul(T[2],ee_pose)
    return [T,ee_pose]


# FOR THE GIVEN 3R SPATIAL MANIPULATOR
joint_angles = [0,0,0]
[T,result] = forward_kinematics(joint_angles)
for i in range(3):
    print("Transformation matrix: \n")
    print(T[i])
    print("\n")
print(result)

