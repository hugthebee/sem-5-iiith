function [T, ee_pose] = forward_kinematics_syms(joint_angles,L1,L2)
%     joint_angles = deg2rad(joint_angles);
 parameters = [0, 0, 0, joint_angles(1);
               0, pi/2, 0, joint_angles(2);
               L1, 0, 0, joint_angles(3) + pi/2;
               0, pi/2, L2, joint_angles(4) + pi;
               0, pi/2, 0, joint_angles(5) + pi;
               0, pi/2, 0, joint_angles(6)];

    T = DH_matrices_syms(parameters);
    
    ee_pose = T(1, :, :);
    for i = 2:size(T, 1)
        ee_pose = squeeze(ee_pose) * squeeze(T(i, :, :));
    end
end