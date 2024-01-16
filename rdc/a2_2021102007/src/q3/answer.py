import numpy as np


class AxisAngle:
    def __init__(self) -> None:
        pass


    def from_rotation_mat(self, matrix: np.ndarray, degrees: bool=False) -> np.ndarray:
        """Convert the Rotation matrix to Axis-Angle format

        :param matrix: Rotation matrix (3-by-3)
        :type matrix: np.ndarray
        :param degrees: True, to return angle in degrees
        :type degrees: bool
        :return: Rotation vector (1-by-4)
        :rtype: np.ndarray
        """
        ...
        vec = np.zeros(4)
        
        trace = matrix[0][0] + matrix[1][1] + matrix[2][2]
        theta = np.arccos((trace - 1)/2)
        
        if(np.isclose(theta,0)):
            # then theta is 0 and n vector is arbitrary
            vec[0] = 1
            vec[1] = 1
            vec[2] = 0
            vec[3] = 0
            return vec
            
        den = 2*np.sin(theta)
        n1 = (matrix[2][1] - matrix[1][2])/den
        n2 = (matrix[0][2] - matrix[2][0])/den
        n3 = (matrix[1][0] - matrix[0][1])/den
        
        if(degrees == True):
            vec[3] = np.degrees(theta)
        
        else:
            vec[3] = theta
        
        vec[0] = n1
        vec[1] = n2
        vec[2] = n3
        ...
        return vec
    

    def to_rotation_mat(self, rot_vector: np.ndarray, degrees: bool=False) -> np.ndarray:
        """Function to get Rotation matrix from Axis-Angle representation

        :param rot_vector: Rotation Vector (1-by-3)
        :type rot_vector: np.ndarray
        :param degrees: True if angles passed in degrees, defaults to False
        :type degrees: bool, optional
        :return: Rotation matrix (3-by-3)
        :rtype: np.ndarray
        """
        ...
        rot_mat = np.eye(3)
        
        I = [[1,0,0],[0,1,0],[0,0,1]]
        nvec = rot_vector[0:3]/np.linalg.norm(rot_vector[0:3]) #calculates normalised vector
        n = np.array([[0, -nvec[2], nvec[1]], [nvec[2], 0, -nvec[0]], [-nvec[1], nvec[0], 0]])
        
        if(degrees == True):
            theta = np.radians(rot_vector[3])
        else: 
            theta = rot_vector[3]
            
        n2 = np.dot(n,n)
        rot_mat = I + n*np.sin(theta) + ((1 - np.cos(theta))*n2)
        
        ...
        return rot_mat

    
