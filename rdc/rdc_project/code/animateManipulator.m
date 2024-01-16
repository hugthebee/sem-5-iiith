function animateManipulator(joint_angles,L0,L1,L2,x_ball,y_ball,z_ball)
   
    f = figure;

    f.Position(3:4) = [680 420];

    

    n = length(x_ball);

    % trajectory = animatedline('LineWidth', 2);

    for i = 1:n
      
        % plotManipulatorConfiguration(jointAngles);
        [T, result] = forward_kinematics(joint_angles(i,:),L0,L1,L2);
        plot_man(T,gcf)
        % view(0,90)
        hold on;
        % plot3(x_ball, y_ball, z_ball);
        if ( (sqrt(x_ball(i)^2 + y_ball(i)^2 + z_ball(i)^2) <= 2.5)  && (sqrt(x_ball(i)^2 + y_ball(i)^2 + z_ball(i)^2) >= 0.5))
            scatter3(x_ball(i), y_ball(i), z_ball(i), 'b', 'filled');
        else
            scatter3(x_ball(i), y_ball(i), z_ball(i), 'r', 'filled');
        end
        

        
        % addpoints(trajectory, x_ball(i), y_ball(i), z_ball(i));
        % drawnow;
      
   
        

        hold off;


        pause(1/n)
        
    end
end