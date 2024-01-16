import numpy as np


class Rotation:
    def __init__(self) -> None:
        pass


    def from_euler(self, theta: float, order: str='ZYX') -> np.ndarray:
        """Converts Euler angles to Rotation Matrix based on the sequence

        :param theta: Angle (in degrees)
        :type theta: float
        :param order: sequence, defaults to 'ZYX'
        :type order: str, 
        :return: Rotation Matrix (3-by-3)
        :rtype: np.ndarray
        """
        ...
        R_mat = np.array(np.eye(3))
        
        #angles are input in reverse order eg if ZYX then theta[0] is angle for x rotation
        
        for i in range(3):
            if(order[2 - i]=='X'):
                #angles are input in reverse order eg if ZYX then theta[0] is angle for x rotation
                c = np.cos(np.radians(theta[i]))
                s = np.sin(np.radians(theta[i]))
                R = np.array([[1 ,0, 0],[0, c, -s], [0, s, c]],dtype=float)
                R_mat = np.dot(R_mat, R)
                
            elif(order[2 - i]=='Y'):
                c = np.cos(np.radians(theta[i]))
                s = np.sin(np.radians(theta[i]))
                R = np.array([[c ,0 ,s], [0, 1 ,0], [-s, 0 ,c]],dtype=float)
                R_mat = np.dot(R_mat, R)
                
            elif(order[2 - i]=='Z'):
                c = np.cos(np.radians(theta[i]))
                s = np.sin(np.radians(theta[i]))
                R = np.array([[c, -s, 0],[s, c, 0],[0, 0, 1]],dtype=float)
                R_mat = np.dot(R_mat, R)

        ...
        return R_mat


    def to_euler(self, matrix: np.ndarray, degrees: bool=True) -> np.ndarray:
        """Represents Rotation Matrix as Euler Angles in 'XYZ' order

        :param matrix: rotation matrix (3-by-3)
        :type matrix: np.ndarray
        :param degrees: return angles in degrees
        :type degrees: bool, defaults to True
        :type matrix: np.ndarray
        :rtype: np.ndarray
        """
        ...
        angles = np.zeros(3)
        pi = np.pi
        if(matrix[0][0] == 0):
            ay = pi/2
            az = 0
            ax = np.arctan2(matrix[0][1],matrix[1][1])
            
        else:
            temp = (matrix[0][0]**2) + (matrix[1][0]**2)
            ay = np.arctan2(-matrix[2][0],np.sqrt(temp))
            az = np.arctan2(matrix[1][0],matrix[0][0])
            ax = np.arctan2(matrix[2][1],matrix[2][2])
            
        if degrees==False:
            #in radians
            angles[0] = ax
            angles[1] = ay
            angles[2] = az
            
        else: 
            angles[0] = np.degrees(ax)
            angles[1] = np.degrees(ay)
            angles[2] = np.degrees(az)
            
        ...

        return angles
    