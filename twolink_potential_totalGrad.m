%function [gradUTheta]=twolink_potential_totalGrad(thetaEval,world,potential)
%Compute the gradient of the potential $U$ pulled back through the kinematic map
%of the two-link manipulator, i.e., $ _vec17E  U(  Wp_ eff(vec17E ))$, where $U$
%is defined as in Question  q:total-potential, and $  Wp_ eff( )$ is the position
%of the end effector in the world frame as a function of the joint angles $vec17E
%= _1\\ _2$.
function [gradUTheta]=twolink_potential_totalGrad(thetaEval,world,potential)

Jtheta=twolink_jacobianMatrix(thetaEval);

rotation1 = rot2d(thetaEval(1));
rotation2 = rot2d(thetaEval(2));

vertexEffectorTransf = rotation1 * (rotation2 * [4.5; 0] + [5; 0]);

gradUTheta=Jtheta'*potential_totalGrad(vertexEffectorTransf,world,potential);