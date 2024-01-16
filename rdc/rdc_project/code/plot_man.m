function plot_man(T,fig)

figure(fig);
ax = axes;
origin = zeros(1, 3);
x_s = [1, 0, 0];
y_s = [0, 1, 0];
z_s = [0, 0, 1];
origins = zeros(7,3);

quiver3(ax, origin(1), origin(2), origin(3), x_s(1), x_s(2), x_s(3), 'r');
hold on;
quiver3(ax, origin(1), origin(2), origin(3), y_s(1), y_s(2), y_s(3), 'g');
quiver3(ax, origin(1), origin(2), origin(3), z_s(1), z_s(2), z_s(3), 'b');
scatter3(ax, origin(1), origin(2), origin(3));

T_mat = eye(4,4);
mul = 1;

for i = 1:6
    T_mat = squeeze(T_mat)*squeeze(T(i,:,:));
    R = T_mat(1:3, 1:3);
    origin = T_mat(1:3, 4);
    origins(i+1,:) = origin';

    x_b = R(:, 1);
    y_b = R(:, 2);
    z_b = R(:, 3);


    if(mul)
        quiver3(ax, origin(1), origin(2), origin(3), x_b(1), x_b(2), x_b(3), 'r');
        quiver3(ax, origin(1), origin(2), origin(3), y_b(1), y_b(2), y_b(3), 'g');
        quiver3(ax, origin(1), origin(2), origin(3), z_b(1), z_b(2), z_b(3), 'b');
        mul = -1;
    else
        quiver3(ax, origin(1), origin(2), origin(3), x_b(1), x_b(2), x_b(3), 'c');
        quiver3(ax, origin(1), origin(2), origin(3), y_b(1), y_b(2), y_b(3), 'm');
        quiver3(ax, origin(1), origin(2), origin(3), z_b(1), z_b(2), z_b(3), 'y');
        mul = 1;
    end

end

scatter3(ax, origins(:, 1), origins(:, 2), origins(:, 3));
plot3(ax, origins(:, 1), origins(:, 2), origins(:, 3), 'black', 'LineWidth', 3.0);



% for ws
% Define the radii of the circles
radius1 = 1.5 + 1;
radius2 = 1.5 - 1;

% % Plot the first circle
% rectangle('Position', [-radius1, -radius1, 2*radius1, 2*radius1],...
%     'Curvature', [1, 1], 'EdgeColor', 'b');
% 
% hold on;
% 
% % Plot the second circle
% rectangle('Position', [-radius2, -radius2, 2*radius2, 2*radius2],...
%     'Curvature', [1, 1], 'EdgeColor', 'r');



% Plot the first sphere
[x1, y1, z1] = sphere;
h1 = surf(radius1*x1, radius1*y1, radius1*z1);
set(h1, 'EdgeColor', 'none', 'FaceColor', 'green','FaceAlpha' , 0.2);

hold on;

% Plot the second sphere
[x2, y2, z2] = sphere;
h2 = surf(radius2*x2, radius2*y2, radius2*z2);
set(h2, 'EdgeColor', 'none', 'FaceColor', 'white');




view(ax, 3);  
set(ax, 'XLim', [-5, 5]);
set(ax, 'YLim', [-5, 5]);
set(ax, 'ZLim', [-5, 5]);

hold off;
end