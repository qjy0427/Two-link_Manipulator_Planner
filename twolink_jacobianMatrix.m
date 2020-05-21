%function [Jtheta]=twolink_jacobianMatrix(theta)
%Compute the matrix representation of the Jacobian of the position of the end
%effector with respect to the joint angles as derived in Question 
%q:jacobian-matrix.
function [Jtheta]=twolink_jacobianMatrix(theta)

Jtheta = [-5*sin(theta(1))-4.5*sin(theta(1)+theta(2)) -4.5*sin(theta(1)+theta(2));
          5*cos(theta(1))+4.5*cos(theta(1)+theta(2)) 4.5*cos(theta(1)+theta(2))];