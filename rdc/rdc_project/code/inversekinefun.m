function Output = inversekinefun(pp,l1,l2)
    % syms theta1
    % syms theta2
    % syms theta3
    x = pp(1);
    y = pp(2);
    z = pp(3) ;
    
    try
        p = sqrt(x^2 + y^2);
        q = z;
        
        theta3 = -acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2)/(2*l1*l2));
        theta1 = atan2(y,x);
    
        gamma = atan2(q,p);
    
        phi = atan2(l2*sin(theta3),l1+l2*cos(theta3));
        theta2 = gamma - phi;
    catch
        try
            p = sqrt(x^2 + y^2);
            q = z;
        
            theta3 = acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2)/(2*l1*l2));
            theta1 = atan2(y,x);
    
            gamma = atan2(q,p);
    
            phi = atan2(l2*sin(theta3),l1+l2*cos(theta3));
            theta2 = gamma + phi;
        catch
             try
                p = sqrt(x^2 + y^2);
                q = z;
        
                theta3 = -acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2)/(2*l1*l2));
                theta1 = atan2(y,x);
    
                gamma = atan2(q,p);
    
                phi = atan2(l2*sin(theta3),l1+l2*cos(theta3));
                theta2 = gamma + phi;

             catch
                try
                    p = sqrt(x^2 + y^2);
                    q = z;
            
                    theta3 = acos((x^2 + y^2 + z^2 - (l1)^2 - (l2)^2)/(2*l1*l2));
                    theta1 = atan2(y,x);
        
                    gamma = atan2(q,p);
        
                    phi = atan2(l2*sin(theta3),l1+l2*cos(theta3));
                    theta2 = gamma - phi;

                catch

                    Output = [];
                    return 

                end
             end

        end

    end


    
    %{
    
    alpha = l1 + l2*cos(theta3);
    beta = l2*sin(theta3);

    theta2 = asin((p*alpha + q*beta)/(sqrt((alpha)^4)+(beta)^4)) + asin((alpha^2)/(sqrt((alpha)^4)+(beta)^4));
    %}
    
    %{
    
    X = cos(theta1)*((cos(theta2)*1.5)+(cos(theta2 + theta3)*1));
    Y = sin(theta1)*((cos(theta2)*1.5)+(cos(theta2 + theta3)*1));
    Z = (sin(theta2)*1.5) + (sin(theta2 + theta3)*1);

    eqn1 = X == x;
    eqn2 = Y == y;
    eqn3 = Z == z;

    try
        sol = solve([eqn1, eqn2, eqn3], [theta1, theta2, theta3]);
        xSol = sol.theta1;
        ySol = sol.theta2;
        zSol = sol.theta3;
    catch
        disp("No Solution")
    end
    
    %}
    xSol = theta1;
    ySol = theta2;
    zSol = theta3;

    Output = [xSol, ySol, zSol];
    
end
 