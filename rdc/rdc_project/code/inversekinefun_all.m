function Output = inversekinefun_all(pp, l1, l2)
    x = pp(1);
    y = pp(2);
    z = pp(3);
    
    % Initialize an empty array to store valid solutions
    Output = [];
    
    % First possible solution
        p = sqrt(x^2 + y^2);
        q = z;
        
        theta3 = -acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2)/(2*l1*l2));
        theta1 = atan2(y,x);
    
        gamma = atan2(q,p);
    
        phi = atan2(l2*sin(theta3),l1+l2*cos(theta3));
        theta2 = gamma - phi;
        Output = [Output;theta1,theta2,theta3];
    % % Second possible solution
    %     p = sqrt(x^2 + y^2);
    %     q = z;
    % 
    %     theta3 = -acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2)/(2*l1*l2));
    %     theta1 = atan2(y,x);
    % 
    %     gamma = atan2(q,p);
    % 
    %     phi = atan2(l2*sin(theta3),l1+l2*cos(theta3));
    %     theta2 = gamma + phi;
    %     Output = [Output; theta1, theta2, theta3];
    % 
    % Third possible solution
        p = sqrt(x^2 + y^2);
        q = z;
        
        theta3 = acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2)/(2*l1*l2));
        theta1 = atan2(y,x);
    
        gamma = atan2(q,p);
    
        phi = atan2(l2*sin(theta3),l1+l2*cos(theta3));
        theta2 = gamma - phi;
        Output = [Output; theta1, theta2, theta3];
    
    % % Fourth possible solution
    %     p = sqrt(x^2 + y^2);
    %     q = z;
    % 
    %     theta3 = acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2)/(2*l1*l2));
    %     theta1 = atan2(y,x);
    % 
    %     gamma = atan2(q,p);
    % 
    %     phi = atan2(l2*sin(theta3),l1+l2*cos(theta3));
    %     theta2 = gamma + phi;
    %     Output = [Output; theta1, theta2, theta3];

end
 