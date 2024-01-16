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

        ori_angles = 180/pi * inversekinefun_rot(R);
        

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