function y = rotationMatrix(theeta, axis)
   if(axis == "y")
       y = [cos(theeta) 0 sin(theeta);
           0 1 0;
           -sin(theeta) 0 cos(theeta)];
   elseif(axis == "x")
       y = [1 0 0;
           0 cos(theeta) -sin(theeta);
           0 sin(theeta) cos(theeta)];
   elseif(axis=="z")
       y = [cos(theeta) -sin(theeta) 0;
           sin(theeta) cos(theeta) 0;
           0 0 1];
end