import numpy as np
from matplotlib import patches as patch
import matplotlib.pyplot as plt


class Kinematic3R:
    def __init__(self, link_length: list) -> None:
        """Initialize class with link lengths of the manipulator

        :param link_length: length of each link (in meters)
        :type link_length: list
        """
        self.link1, self.link2, self.link3 = link_length


    def compute_fk(self, joint_angles: list) -> np.ndarray:
        """Function to find the end-effector pose for the
        given the link lengths and joint angles

        :param joint_angles: angle of each joint (in degrees)
        :type joint_angles: list
        :return: end-effector pose (in meters)
        :rtype: np.ndarray
        """
        ...
        ee_pose = np.zeros(2)
        
        l1 = self.link1
        l2 = self.link2
        l3 = self.link3
        
        self.a1 = joint_angles[0]
        self.a2 = joint_angles[1]
        self.a3 = joint_angles[2]
        
        a1 = np.radians(joint_angles[0])
        a2 = np.radians(joint_angles[1])
        a3 = np.radians(joint_angles[2])
        
        position = [(l1*np.cos(a1) + l2*np.cos(a1+a2) + l3*np.cos(a1+a2+a3)),
                    (l1*np.sin(a1) + l2*np.sin(a1+a2) + l3*np.sin(a1+a2+a3))]
        
        angle = a1+a2+a3
        
        ee_pose = position
        ...
        return ee_pose


    def plot_fk(self, goal: np.ndarray) -> None:
        """Plots the final configuration of the manipulator given the goal"""
        t1 = self.a1
        t2 = self.a2
        t3 = self.a3
        
        l1 = self.link1
        l2 = self.link2
        l3 = self.link3
        
        j2 = np.array([l1*np.cos(t1), l1*np.sin(t1), t1+t2])
        
        j3 = np.array([
        l1*np.cos(t1) + l2*np.cos(t1+t2),
        l1*np.sin(t1) + l2*np.sin(t1+t2),
        t1+t2+t3])
        
        x = [goal[0], j2[0], j3[0]]
        y = [goal[1], j2[1], j3[1]]
        
        plt.figure()
        plt.scatter(x, y)
        plt.xlabel('X Position')
        plt.ylabel('Y Position')
        plt.title('Forward Kinematics plot of the 3R manipulator')
        plt.grid(True)
        plt.show()
        ...


    def plot_workspace(self) -> None:
        """Plots the Dextereous Workspace for defined link lengths"""
        ...
        fig, axis= plt.subplots()
        
        l1 = self.link1
        l2 = self.link2
        l3 = self.link3
        
        if l1 < l2 and l1 < l3 :
            smallest = l1
        if l2 < l1 and l2 < l3 :
            smallest = l2
        if l3 < l2 and l3 < l1 :
            smallest = l3
        
        ws_out = l1 + l2 + l3
        ws1 = plt.Circle((0, 0), ws_out, fill=False, linewidth=1.0, color = "green")
        axis.add_patch(ws1)
        ws_in = smallest
        ws2 = plt.Circle((0, 0), ws_in, fill=False, linewidth=1.0, color = "green",label="Robot worksapce")
        axis.add_patch(ws2)
        
        dws_out = l2 + l3 - l1
        dws_in = l1 + l3 - l2
        dws1 = plt.Circle((0, 0), dws_out, fill=False, linewidth=1.0, color = "red",label="Dexterous workspace")
        axis.add_patch(dws1)
        dws2 = plt.Circle((0, 0), dws_in, fill=False, linewidth=1.0, color = "red")
        axis.add_patch(dws2)
        
        axis.set_xlim(-1*ws_out, ws_out)
        axis.set_ylim(-1*ws_out, ws_out)
        axis.set_aspect('equal')
        plt.legend()
        ...

