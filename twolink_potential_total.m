%function [UTheta]=twolink_potential_total(thetaEval,world,potential)
%Compute the potential $U$ pulled back through the kinematic map of the two-link
%manipulator, i.e., $U(  Wp_ eff(vec17E ))$, where $U$ is defined as in Question 
%q:total-potential, and $  Wp_ eff( )$ is the position of the end effector in the
%world frame as a function of the joint angles $vec17E = _1\\ _2$.
function [UTheta]=twolink_potential_total(thetaEval,world,potential)

rotation1 = rot2d(thetaEval(1));
rotation2 = rot2d(thetaEval(2));

vertexEffectorTransf = rotation1 * (rotation2 * [4.5; 0] + [5; 0]);

UTheta=potential_total(vertexEffectorTransf,world,potential);