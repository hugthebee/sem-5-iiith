import numpy as np
from util import Manipulator, Color


class Manip3R(Manipulator):
    def __init__(self, link_lengths):
        super().__init__(link_lengths=link_lengths)


    def forward_kinematics(self, angles) -> None:
        """Write the FK for 3R Manipulator with proper drawing logic

        :param angles: Joint angles (in degrees)
        :type angles: floats
        """
        ...



if __name__ == '__main__':
    M = Manip3R(link_lengths=[0., 0., 0.])
    M.run()
