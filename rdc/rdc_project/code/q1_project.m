L0 = 0.5;
L1 = 1;
L2 = 1.5; 
% Input joint angles in degrees
% joint_angles = [90, 90, 60, 90, 90, 60];
joint_angles = [0,pi/4,-pi/4,pi/4,0,0];
figure;
[T, result] = forward_kinematics(joint_angles,L0,L1,L2);
plot_man(T,gcf);

% dh = [joint_angles(1), L0, 0, -pi/2 ;
%       joint_angles(2) - pi/2, 0, L1, 0 ;
%       joint_angles(3) + pi/2, 0, L2, 0;
%       joint_angles(4) + pi, 0 , 0, 0;
%       joint_angles(5) + pi, 0 , L4, 0 ;
%       joint_angles(6), 0, L5, 0;];
for i = 1:6
    fprintf('Transformation matrix: \n');
    disp(squeeze(T(i, :, :)));
    fprintf('\n');
end

disp(result);


