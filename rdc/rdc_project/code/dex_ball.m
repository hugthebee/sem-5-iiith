t_div = 20;
t = linspace(0,1,t_div);
L0 = 0.5;
L1 = 1.0;
L2 = 1.5;

initial_position = [5, 0, 0];
initial_velocity = 8;
launch_angle = 135;
launch_angle_rad = deg2rad(launch_angle);

    

ja = [0,pi/4,pi/4,pi/4,0,0];

joint_angles = zeros(t_div , 6);
x_ball = zeros(t_div);
y_ball = zeros(t_div);
z_ball = zeros(t_div);
for i = 1 : t_div
    x_ball(i) = initial_position(1) + initial_velocity * cos(launch_angle_rad) * t(i);
    y_ball(i) = initial_position(2) + initial_velocity * sin(launch_angle_rad) * t(i);
    z_ball(i) = initial_position(3) - 0.5 * 9.81 * t(i)^2; % g = 9.81 m/s^2

    
  
    
    % Output = inversekinefun(x_ball(i),y_ball(i),z_ball(i));  
    % if(isempty(Output))
    %     continue
    % end
    % joint_angles(1:3) = Output(1);
    joint_angles(i,:) = ja * t(i);

end


animateManipulator(joint_angles,L0,L1,L2,x_ball,y_ball,z_ball);