function T = DH_matrices_syms(parameters)
    a = parameters(:, 1);
    alpha = parameters(:, 2);
    d = parameters(:, 3);
    theta = parameters(:, 4);
    
    T = sym(zeros(size(parameters, 1), 4, 4));
    for i = 1:size(parameters, 1)
        T(i, :, :) = [cos(theta(i)), -sin(theta(i)), 0, a(i);
                      sin(theta(i)) * cos(alpha(i)), cos(theta(i)) * cos(alpha(i)), -sin(alpha(i)), -d(i) * sin(alpha(i));
                      sin(theta(i)) * sin(alpha(i)), cos(theta(i)) * sin(alpha(i)), cos(alpha(i)), d(i) * cos(alpha(i));
                      0, 0, 0, 1];
    end
end
