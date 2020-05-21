%function twolink_planner_test(shape,repulsiveWeight,epsilon)
%This function performs the same steps as potential_planner_test in Questino 
%q:potentialPlannerTest, except for the following: itemize  step  it:grad-handle:
% @x   gradHandle should be set to  @x   @twolink_totalGrad.  step 
%it:grad-handle: Use the contents of the variable  @x   thetaStart instead of  @x
%  xStart to initialize the planner.  step  it:plot-plan: Use twolink_plot to
%plot the results of the planner (since the output  @x   xPath from
%potential_planner will really contain a sequence of join angles, rather than a
%sequence of 2-D points). itemize
function twolink_planner_test(shape,repulsiveWeight,epsilon)

%styles used for each line
styles={'r','g','b','c','m'};
%load world data
problemData=load('sphereworld.mat');
%shorthand for variables
xGoal=problemData.xGoal;
xStart=problemData.thetaStart;
world=problemData.world;
%setup potential struct (exept goal)
potential.shape = shape;
potential.world = problemData.world;
potential.repulsiveWeight = repulsiveWeight;
%setup fHandles struct
%fHandles.U=@potential_total;
%fHandles.gradU=@potential_totalGrad;

nbStarts=size(xStart,2);
%iterate over goals
for iGoal=1:size(xGoal,2)
    %finish setup of potential struct
    potential.xGoal = xGoal(:,iGoal);
    
    %iterate over starts
    for iStart=1:nbStarts
        
        figure((iGoal-1)*5+iStart)
        subplot(1,2,1)
        sphereworld_plot(world, xGoal(:,iGoal));
        
        [xPath, UPath] = twolink_potential_planner(xStart(:,iStart), world, potential, epsilon);
        thetaPath = zeros(2, 1000);
        for iTheta = 1:1000
            rotation1 = rot2d(xPath(1, iTheta));
            rotation2 = rot2d(xPath(2, iTheta));
            vertexEffectorTransf = rotation1 * (rotation2 * [4.5; 0] + [5; 0]);
            thetaPath(:, iTheta) = vertexEffectorTransf;
        end
        
        subplot(1,2,1)
        hold on
        plot(thetaPath(1,:), thetaPath(2,:), styles{iStart});
        
        toPlot = xPath(:, 1:20:end);
        [~, nbToPlot] = size(toPlot);
        
        for iPlot = 1:nbToPlot
            twolink_plot(toPlot(:, iPlot), styles{iStart})
        end
        
        hold off
        subplot(1,2,2)
        hold on
        plot(1:size(UPath,2), UPath, styles{iStart});
        hold off
    end
end