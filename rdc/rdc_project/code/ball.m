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
