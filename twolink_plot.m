%function twolink_plot(theta,color)
%This function should use twolink_kinematicMap from the previous question
%together with the function polygon_draw from Homework 1 to draw the manipulator.
function twolink_plot(theta,color,thetaDot)
flagPlotAngularVelocities=exist('thetaDot','var') && ~isempty(thetaDot);
%get transformed vertices
[vertexEffectorTransf,vertices1Transf,vertices2Transf]=twolink_kinematicMap(theta);
%remember if we are in figure hold or not
flagHold=ishold();
polygon_plot(vertices1Transf,color);
hold on
polygon_plot(vertices2Transf,color);
hold on
plot(vertexEffectorTransf(1),vertexEffectorTransf(2),'ko')
if flagPlotAngularVelocities
    plotAngularVelocity(vertices1Transf,thetaDot(1))
    plotAngularVelocity(vertices2Transf,thetaDot(2))
end
%restore figure hold (off) if necessary
if ~flagHold
    hold off
end

function plotAngularVelocity(verticesTransf,thetaDot)
nbVerticesHalfOffset=size(verticesTransf,2)/2-1;
gravCenter=mean(verticesTransf,2);
velCenter=verticesTransf*[...
    zeros(nbVerticesHalfOffset,1);-1;...
    1;zeros(nbVerticesHalfOffset,1)...
    ];
velCenter=velCenter/norm(velCenter)*thetaDot;
quiver(gravCenter(1),gravCenter(2),velCenter(1),velCenter(2),'k',...
    'AutoScale','off')
