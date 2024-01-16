from typing import List
import numpy as np
from util import Manipulator, Color


'''Use (UP, DOWN, LEFT, RIGHT, W, S) keys to play around'''
class Manip1R(Manipulator):
    """Example class that extends the Manipulator base class to handle 
       the FK logic for a 1R manipulator
    """
    def __init__(self, link_lengths: List[float]):
        """Initialize the class with link lengths

        :param link_lengths: length of each link (less than 100 pixels)
        :type link_lengths: float
        """
        super().__init__(link_lengths=link_lengths)


    def forward_kinematics(self, angles: List[float]) -> None:
        """Method for applying FK and simulate the result

        :param angles: Joint angles (in degrees)
        :type link_lengths: floats
        """
        self.screen.fill(Color.BLACK.value)

        # Robot Base
        x1 = self.args.W // 2 + self.args.Rad // 2
        y1 = self.args.H // 2 + self.args.Rad // 2
        self.draw_joint(point=(x1, y1), color=Color.RED)  # Place a Joint
        
        x2 = x1 + self.link_lengths[0] * np.cos(angles[0])
        y2 = y1 - self.link_lengths[0] * np.sin(angles[0])
        self.draw_line(start=(x1, y1), end=(x2, y2), color=Color.RED) # Draw link from (x1, y1) -> (x2, y2)


if __name__ == '__main__':
    M = Manip1R(link_lengths=[100., 100., 100.])
    M.run()
