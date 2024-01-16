from answer import Kinematic3R
import matplotlib.pyplot as plt

def main():
    lengths = [0.5, 1, 1.5]


    # Keep the following lines unchanged
    angles = list(map(float, input(
        'Enter Joint Angles (in degrees):\n').split(',')))

    Manip = Kinematic3R(link_length=lengths)
    
    tooltip_pose = Manip.compute_fk(joint_angles=angles)
    print(tooltip_pose)
    
    Manip.plot_fk(goal=tooltip_pose)
    Manip.plot_workspace()


if __name__ == "__main__":
    main()