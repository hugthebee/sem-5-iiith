function [Jv,Jw] = vel_kin(joint_angles,t_dot,L1,L2)
[T, ee_pose] = forward_kinematics_syms(joint_angles,L1,L2);


% ee_pose =
% 
% L2*(cos(t1)*cos(t2)*sin(t3 + pi/2) + cos(t1)*cos(t3 + pi/2)*sin(t2)) + L1*cos(t1)*cos(t2)
% L2*(cos(t2)*sin(t1)*sin(t3 + pi/2) + cos(t3 + pi/2)*sin(t1)*sin(t2)) + L1*cos(t2)*sin(t1)
%                         L1*sin(t2) - L2*(cos(t2)*cos(t3 + pi/2) - sin(t2)*sin(t3 + pi/2))
% 

ee_pos = ee_pose(1:3,4);


Jv = jacobian(ee_pos,joint_angles);  % diffrentiation
Jv = simplify(Jv);



% checking with diffrentiation of ee_pos... using jac to make it modulae 
% [-(sin(t1)*(2*cos(t2 + t3) + 3*cos(t2)))/2, -(cos(t1)*(2*sin(t2 + t3) + 3*sin(t2)))/2, -sin(t2 + t3)*cos(t1), 0, 0, 0]
% [ (cos(t1)*(2*cos(t2 + t3) + 3*cos(t2)))/2, -(sin(t1)*(2*sin(t2 + t3) + 3*sin(t2)))/2, -sin(t2 + t3)*sin(t1), 0, 0, 0]
% [                                        0,              cos(t2 + t3) + (3*cos(t2))/2,          cos(t2 + t3), 0, 0, 0]
% hand calculated jv doenst include t4 t5 t6 as they're not required



w = sym(zeros(3,6));

for i = 1:6
    if i == 1
        w(:,1) = [0,0,t_dot(1)];
        continue
    end

    R = squeeze(T(i-1,1:3,1:3));
    w(:,i) = R * w(:,i-1)  + [0;0;t_dot(i)];
    
end


shit = w(:,6); % ee w 
Jw = jacobian(shit,t_dot);
Jw = simplify(Jw);





