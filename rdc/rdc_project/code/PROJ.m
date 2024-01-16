%% Q1 
clc;close all;clear;

L0 = 0;
L1 = 1;
L2 = 1.5; 
% Input joint angles in degrees
% joint_angles = [90, 90, 60, 90, 90, 60];
joint_angles = [0,0,0,0,0,0];
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
%% IK vis
clear;clc;close all;
L1 = 1.5;
L2 = 1;
x = input("Enter X: ");
y = input("Enter Y: ");
z = input("Enter Z: ");

pp = [x, y, z];
Output = inversekinefun_all(pp, L1, L2);


valid_solution = false;
for i = 1:size(Output, 1)
    disp("Inverse Kinematic Solution ")
    disp(Output(i, 1))
    disp(Output(i, 2))
    disp(Output(i, 3))
    disp("==============================")
    figure('Name', "Possible Configurations")
    if isreal(double(Output(i, 1))) && isreal(double(Output(i, 2))) && isreal(double(Output(i, 3)))
        % Create a row vector with joint angles for the current solution
        joint_angles_solution = [double(Output(i, 1)), double(Output(i, 2)), double(Output(i, 3)), 0, 0, 0];
        % Plot the robot for the current joint angles
        [T, result] = forward_kinematics(joint_angles_solution,0,L1,L2);
        plot_man(T,gcf);
        disp("Verification with fk")
        disp(result(1:3,4))
        valid_solution = true;
    end
end

if ~valid_solution
    disp("No possible configuration")
end


%% Ball trajectory
clc;close all;clear;

initial_position = [5, 0, 0];
initial_velocity = 8;
launch_angle = 135;

launch_angle_rad = deg2rad(launch_angle);

t_div = 100;
t = linspace(0, 3, t_div);

% Parametric equations for projectile motion
x = initial_position(1) + initial_velocity * cos(launch_angle_rad) * t;
y = initial_position(2) + initial_velocity * sin(launch_angle_rad) * t - 0.5 * 9.81 * t.^2;
z = initial_position(3); % g = 9.81 m/s^2

figure;
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('Projectile Motion Trajectory');
grid on;
axis equal;

% Mark the starting point and ending point
hold on;
scatter3(initial_position(1), initial_position(2), initial_position(3), 'r', 'filled');
text(initial_position(1), initial_position(2), initial_position(3), '  Start', 'Color', 'r');

scatter3(x(end), y(end), z(end), 'r', 'filled');
text(x(end), y(end), z(end), '  END', 'Color', 'r');

trajectory = animatedline('LineWidth', 2);

view(3);

for i = 1:length(t)
    x_current = initial_position(1) + initial_velocity * cos(launch_angle_rad) * t(i);
    y_current = initial_position(2) + initial_velocity * sin(launch_angle_rad) * t(i) - 0.5 * 9.81 * t(i)^2;
    z_current = initial_position(3); % g = 9.81 m/s^2
    
    
    addpoints(trajectory, x_current, y_current, z_current);
    scatter3(x_current, y_current, z_current, 'b', 'filled');
    
    pause(1/t_div);
   
    drawnow;
end

hold off;

%% Tracking the ball + Workspace (= Dex WS)
clc;clear;close all;

t_div = 40;
tsteps = linspace(0,2,t_div);
L0 = 0;
L1 = 1.5;
L2 = 1;

initial_position = [5, 0, 0];
initial_velocity = 8;
launch_angle = 135;
launch_angle_rad = deg2rad(launch_angle);

ja = [0,pi/4,pi/4,pi/4,0,0];
jj = [pi/4,pi/2,pi];

joint_angles = zeros(t_div , 6);

x_ball = zeros(t_div);
y_ball = zeros(t_div);
z_ball = zeros(t_div);


% workspace is l1+l2 , l1-l2

for i = 1 : t_div
    x_ball(i) = initial_position(1) + initial_velocity * cos(launch_angle_rad) * tsteps(i);
    y_ball(i) = initial_position(2) + initial_velocity * sin(launch_angle_rad) * tsteps(i) - 0.5 * 9.81 * tsteps(i)^2;
    z_ball(i) = initial_position(3); 
  
    % disp([x_ball(i),y_ball(i),z_ball(i)]) ... also ws = D ws
    if ( (sqrt(x_ball(i)^2 + y_ball(i)^2 + z_ball(i)^2) <= 2.5)  && (sqrt(x_ball(i)^2 + y_ball(i)^2 + z_ball(i)^2) >= 0.5))
        posi_angles = inversekinefun([x_ball(i),y_ball(i),z_ball(i)],L1,L2);  
        if(isempty(posi_angles))
            disp(i)
            if(i > 1)
                joint_angles(i,1:3) = joint_angles(i-1,1:3);
            end
            continue
        end

        % for positioning perp to ball inside D ws
        dx = (initial_velocity * cos(launch_angle_rad));
        dy = (initial_velocity * sin(launch_angle_rad) - 9.81 * tsteps(i));
        theta = atan(-dx/dy); % perp = t1 * t2 = -1

        R = eul2rotm([theta,0,0],"ZYX");

        ori_angles =  inversekinefun_rot(R);
        

    else
        if(i > 1)
                joint_angles(i,:) = joint_angles(i-1,:);
        end
        continue
    end
    joint_angles(i,1:3) = posi_angles;
    joint_angles(i,4:6) = ori_angles;

end


animateManipulator(joint_angles,L0,L1,L2,x_ball,y_ball,z_ball);

%% Velocity calculations

L0 = 0;L1 = 1.5; L2 = 1;
initial_position = [5, 0, 0];
initial_velocity = 8;
launch_angle = 135;
launch_angle_rad = deg2rad(launch_angle);
syms t;

syms t1 t2 t3 t4 t5 t6 t_dot1 t_dot2 t_dot3 t_dot4 t_dot5 t_dot6; 
joint_angles = [t1,t2,t3,t4,t5,t6];
t_dot = [t_dot1 ; t_dot2 ; t_dot3 ; t_dot4 ; t_dot5 ; t_dot6];

[jv, jw] = vel_kin(joint_angles,t_dot,L1,L2);


% tt posi = ball posi
x_ball_sym = initial_position(1) + initial_velocity * cos(launch_angle_rad) * t;
y_ball_sym = initial_position(2) + initial_velocity * sin(launch_angle_rad) * t - 0.5 * 9.81 * t^2;
z_ball_sym = initial_position(3); 

tt_velx = diff(x_ball_sym);
tt_vely = diff(y_ball_sym);
tt_velz = diff(z_ball_sym);

if(tt_velz)
    tt_vel = [ tt_velx ; tt_vely ; tt_velz ]; 
else
    tt_vel = [ tt_velx ; tt_vely ; sym(0) ]; 

end
 

jv_req = jv(1:3,1:3);


t_dot(1:3) = simplify(jv_req^-1 * tt_vel)





% %% ik fun
% function Output = inversekinefun_all(pp, l1, l2)
%     x = pp(1);
%     y = pp(2);
%     z = pp(3);
% 
%     % Initialize an empty array to store valid solutions
%     Output = [];
% 
%     % First possible solution
%     p = sqrt(x^2 + y^2);
%     q = z;
%     theta3 = -acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2) / (2 * l1 * l2));
%     theta1 = atan2(y, x);
%     gamma = atan2(q, p);
%     phi = atan2(l2 * sin(theta3), l1 + l2 * cos(theta3));
%     theta2 = gamma - phi;
%     Output = [Output; theta1, theta2, theta3];
% 
%     % Second possible solution
%     p = sqrt(x^2 + y^2);
%     q = z;
%     theta3 = acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2) / (2 * l1 * l2));
%     theta1 = atan2(y, x);
%     gamma = atan2(q, p);
%     phi = atan2(l2 * sin(theta3), l1 + l2 * cos(theta3));
%     theta2 = gamma + phi;
%     Output = [Output; theta1, theta2, theta3];
% 
%     % Third possible solution
%     p = sqrt(x^2 + y^2);
%     q = z;
%     theta3 = -acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2) / (2 * l1 * l2));
%     theta1 = atan2(y, x);
%     gamma = atan2(q, p);
%     phi = atan2(l2 * sin(theta3), l1 + l2 * cos(theta3));
%     theta2 = gamma + phi;
%     Output = [Output; theta1, theta2, theta3];
% 
%     % Fourth possible solution
%     p = sqrt(x^2 + y^2);
%     q = z;
%     theta3 = acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2) / (2 * l1 * l2));
%     theta1 = atan2(y, x);
%     gamma = atan2(q, p);
%     phi = atan2(l2 * sin(theta3), l1 + l2 * cos(theta3));
%     theta2 = gamma - phi;
%     Output = [Output; theta1, theta2, theta3];
% 
%     % Return the collected solutions
%     % Output = unique(Output, 'rows'); % Ensure unique solutions are stored
% end
 
