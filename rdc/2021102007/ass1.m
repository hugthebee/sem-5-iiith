% -- part a -- %
RA = rotationMatrix(pi/4,"y")

% -- part b -- %
RB = rotationMatrix(pi/2,"x")

% -- part c -- %
RC = rotationMatrix(pi/6,"z")

% -- part d -- %
RD = rotationMatrix(pi/3,"x")

% -- part e -- %
RE = rotationMatrix(pi/3,"y")


%final rotation matrix
R = (RD*((RB*RA)*RC))*RE
% Final position of P will be pre/post multiply with rotation matrix

P = [2;3;4];
Pfinal = R*P



