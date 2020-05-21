%function [vertexEffectorTransf,vertices1Transf,vertices2Transf]=twolink_kinematicMap(theta)
%The function returns the coordinate of the end effector, plus the vertices of
%the links, all transformed according to $ _1, _2$.

function [vertexEffectorTransf,vertices1Transf,vertices2Transf]=twolink_kinematicMap(theta)

[vertices1,vertices2] = twolink_polygons;

rotation1 = rot2d(theta(1));
rotation2 = rot2d(theta(2));

vertexEffectorTransf = rotation1 * (rotation2 * [4.5; 0] + [5; 0]);

vertices1Transf = rotation1 * vertices1;

vertices2Transf = rotation1 * (rotation2 * vertices2 + [5; 0]);

end

%Use the results from Question  q:kinematicMapDerivation to guide your
%implementation. This function must use twolink_polygons to obtain the vertices
%of the polygons of the matrix, and it must use rot2d from Question  q:rot2d.
%Note that here we are simply computing the vertices of the transformed polygons,
%without plotting them. The next function will be used to plot the transformed
%vertices.
