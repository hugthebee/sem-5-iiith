import numpy as np


class DenavitHartenberg:
    def __init__(self, num_joints: int, home_config: bool=True) -> None:
        """Class for DH representation of an N-dof manipulator

        :param num_joints: No. of joints
        :type num_joints: int
        :param home_config: initialize with HOME configuration, defaults to True
        :type home_config: bool
        """
        self.N = num_joints
        self.home = home_config

    
    def build_transformation_mat(self, params: np.ndarray) -> np.ndarray:
        """Get transformation  matrix from DH table

        :param params: DH parameters (N-by-4)
        :type params: np.ndarray
        :return: Transformation matrix (4-by-4)
        :rtype: np.ndarray
        """
        ...
        T_mat = np.eye(4)
        
        t1 = params[0]
        t2 = params[1]
        t3 = params[2]
        t4 = params[3]
        t5 = params[4]
        t6 = params[5]
        t7 = params[6]
        
        T_mat = np.dot(t1,t2)
        T_mat = np.dot(T_mat,t3)
        T_mat = np.dot(T_mat, t4)
        T_mat = np.dot(T_mat,t5)
        T_mat = np.dot(T_mat,t6)
        T_mat = np.dot(T_mat,t7)
            
        ...
        return T_mat
    
    def home_position_verification(self, params: np.ndarray) -> np.ndarray:
        ...
        
        #each joint will have 4 params - a (link length), alpha(link twist), d (joint offset), theta(joint angle)
        a = params[0]
        alpha = params[1]
        d = params[2]
        theta = params[3]
        T_joint = np.array([[np.cos(theta), -np.sin(theta), 0, a],
                   [np.sin(theta)*np.cos(alpha), np.cos(theta)*np.cos(alpha), -np.sin(alpha), -d*np.sin(alpha)],
                   [np.sin(theta)*np.sin(alpha), np.cos(theta) * np.sin(alpha), np.cos(alpha), d*np.cos(alpha)],
                   [0, 0, 0, 1]])
        ...
        return T_joint
    

    def plot_config(self) -> None:
        """Function to plot the robot configuration graphically. Use 3D plot"""
    