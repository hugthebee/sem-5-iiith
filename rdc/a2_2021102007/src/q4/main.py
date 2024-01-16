import numpy as np
from answer import DenavitHartenberg
import matplotlib.pyplot as plt


def main():
    J = 7  # No. of Joints
    param = np.zeros((J, 4))
    
    # Keep the below lines unchanged
    DH = DenavitHartenberg(num_joints=J, home_config=True)
    DH.build_transformation_mat(params=param)
    DH.plot_config()
    
    #DH params of the 7R robot
    l = 2
    pi = np.pi

    params = [[0, 0, l, pi/4],
              [0, pi/2, 0, pi + pi/2],
              [0, pi/2, l, pi + pi],
              [0, pi/2, 0, pi],
              [0, pi/2, l, pi + pi/6],
              [0, pi/2, 0, pi + pi/3],
              [0, pi/2, l, pi/5]]

    t1 = DH.home_position_verification(params[0])
    t2 = DH.home_position_verification(params[1])
    t3 = DH.home_position_verification(params[2])
    t4 = DH.home_position_verification(params[3])
    t5 = DH.home_position_verification(params[4])
    t6 = DH.home_position_verification(params[5])
    t7 = DH.home_position_verification(params[6])
    
    transform = [t1, t2, t3, t4, t5, t6, t7]
    final_position = DH.build_transformation_mat(transform)
    print(final_position)
    print("\n")
    
    # home position verification -> t7 matrix when joint angles are zero
    params = [[0, 0, l, 0],
              [0, pi/2, 0, 0],
              [0, pi/2, l, 0],
              [0, pi/2, 0, 0],
              [0, pi/2, l, 0],
              [0, pi/2, 0, 0],
              [0, pi/2, 0, 0]]
    
    t1 = DH.home_position_verification(params[0])
    t2 = DH.home_position_verification(params[1])
    t3 = DH.home_position_verification(params[2])
    t4 = DH.home_position_verification(params[3])
    t5 = DH.home_position_verification(params[4])
    t6 = DH.home_position_verification(params[5])
    t7 = DH.home_position_verification(params[6])
    
    transform = [t1, t2, t3, t4, t5, t6, t7]
    home_position = DH.build_transformation_mat(transform)
    print(home_position)
    
    fig = plt.figure()
    axis = fig.add_subplot(111, projection='3d')
    frame = np.eye(4)
    
    for i in range(7):
        frame = np.dot(frame,transform[i])
        print(frame)
        print("\n")
        axis.quiver(frame[0][2],frame[1][2], frame[2][2], frame[0, 0], frame[1, 0],frame[2, 0], color='red', label=f'Link {i+1} X')
        axis.quiver(frame[0][2],frame[1][2], frame[2][2], frame[0, 1], frame[1, 1], frame[2, 1], color='green', label=f'Link {i+1} Y')
        axis.quiver(frame[0][2],frame[1][2], frame[2][2], frame[0, 2], frame[1, 2], frame[2, 2], color='blue', label=f'Link {i+1} Z')
    
    plt.title('Configuartion of the end effector of the robot')
    plt.grid(True)
    axis.set_xlabel("X")
    axis.set_ylabel("Y")
    plt.xlim([-1,1])
    axis.set_zlabel("Z")
    plt.show()
    
if __name__ == '__main__':
    main()

