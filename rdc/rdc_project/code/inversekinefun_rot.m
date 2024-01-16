function Output = inversekinefun_rot(R)
    syms theta4
    syms theta5
    syms theta6
 

    r11 = R(1,1);
    r12 = R(1,2);
    r13 = R(1,3);
    r21 = R(2,1);
    r22 = R(2,2);
    r23 = R(2,3);
    r31 = R(3,1);
    r32 = R(3,2);
    r33 = R(3,3);

    if ((r33 ~= 1) && (r33 ~= (-1)))
        theta5 = atan2(sqrt(r31^2 + r32^2),r33);
        theta4 = atan2(r23/sin(theta5),r13/sin(theta5));
        theta6 = atan2(r32/sin(theta5),-r31/sin(theta5));
        % disp('hi')
    end
    if (r33 == 1)
        theta4 = 0;
        theta5 = 0;
        theta6 = atan2(r32/sin(theta5),-r31/sin(theta5));
        % disp('no')
    end
    if (r33 == -1)
        theta4 = 0;
        theta5 = pi;
        theta6 = atan2(r12,-r11);
        % disp('helejaknkn')
        
    end
    %{
    r11 = (cos(theta4)*cos(theta5)*cos(theta6)) - (sin(theta4)*sin(theta6));
    r12 = (-1*cos(theta4)*cos(theta5)*sin(theta6)) - (sin(theta4)*cos(theta6));
    r13 = cos(theta4)*sin(theta5);
    r21 = (sin(theta4)*cos(theta5)*cos(theta6))+(cos(theta4)*sin(theta6));
    r22 = (-1*sin(theta4)*cos(theta5)*sin(theta6))+(cos(theta4)*cos(theta6));
    r23 = sin(theta4)*sin(theta5);
    r31 = -1*sin(theta5)*cos(theta6);
    r32 = sin(theta5)*sin(theta6);
    r33 = cos(theta5);

    eqn1 = r11 == R(1,1);
    eqn2 = r12 == R(1,2);
    eqn3 = r13 == R(1,3);
    eqn4 = r21 == R(2,1);
    eqn5 = r22 == R(2,2);
    eqn6 = r23 == R(2,3);
    eqn7 = r31 == R(3,1);
    eqn8 = r32 == R(3,2);
    eqn9 = r33 == R(3,3);

    try
        sol = solve([eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8, eqn9], [theta4, theta5, theta6]);
        xSol = sol.theta4;
        ySol = sol.theta5;
        zSol = sol.theta6;
    catch
        disp("No Solution")
    end
    
    Output = [xSol, ySol, zSol];
    %}

    xSol = theta4;
    ySol = theta5;
    zSol = theta6;

    Output = [xSol,ySol,zSol];


    
end