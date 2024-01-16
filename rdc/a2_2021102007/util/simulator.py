from dataclasses import dataclass
from enum import Enum
from typing import Tuple
import pygame

@dataclass
class VizArgs:
    W: int = 800
    H: int = 800
    Rad: int = 10
    dphi: float = 0.001

class Color(Enum):
    """Available colors :
        White, Black, Red, Green, Blue
    """
    WHITE = (255, 255, 255)
    BLACK = (0, 0, 0)
    RED = (255, 0, 0)
    GREEN = (0, 255, 0)
    BLUE = (0, 0, 255)

class Manipulator:
    def __init__(self, link_lengths):
        pygame.init()
        self.args = VizArgs()

        self.screen = pygame.display.set_mode((self.args.W, self.args.H))
        pygame.display.set_caption('Manipulator')

        self.loop = True
        self.link_lengths = link_lengths

    def draw_joint(self, point: Tuple[float, float], color: Color):
        pygame.draw.circle(
            surface=self.screen,
            color=color.value,
            center=point,
            radius=self.args.Rad
        )

    def draw_line(self, start: Tuple[float, float], end: Tuple[float, float], color: Color):
        pygame.draw.line(
            self.screen,
            color=color.value,
            start_pos=start,
            end_pos=end, 
            width=5
        )

    def run(self):
        thetas = [0.] * len(self.link_lengths)

        while self.loop:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    self.loop = False

            keys = pygame.key.get_pressed()
            
            if keys[pygame.K_LEFT]:
                thetas[0] += self.args.dphi
            if keys[pygame.K_RIGHT]:
                thetas[0] -= self.args.dphi
            if keys[pygame.K_UP]:
                thetas[1] += self.args.dphi
            if keys[pygame.K_DOWN]:
                thetas[1] -= self.args.dphi
            if keys[pygame.K_w]:
                thetas[2] += self.args.dphi
            if keys[pygame.K_s]:
                thetas[2] -= self.args.dphi
            
            self.forward_kinematics(thetas)
            pygame.display.flip()

        pygame.quit()

