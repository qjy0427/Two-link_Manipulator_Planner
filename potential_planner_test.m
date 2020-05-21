%function potential_planner_test(shape,repulsiveWeight,epsilon)
%This function performs the following steps: enumerate  the problem data from the
%file  sphereworld.mat.  each goal location in  world.xGoal: enumerate  the
%function sphereworld_plot to plot the world in a first figure.  the structure 
%potential.  the function potential_planner with the problem data and the input
%arguments. The function needs to be called five times, using each one of the
%initial locations given in  xStart (also provided in  sphereworld.mat).  each
%call, plot the resulting trajectory superimposed to the world in the first
%window; in a second window, plot  UPath (using the same color). enumerate
%enumerate To avoid too much clutter, use separate pairs of figures for different
%goal locations (but keep all the different paths from the different starting
%points to the same goal location in the same pair of figures).
function potential_planner_test(shape,repulsiveWeight,epsilon)
%styles used for each line
styles={'r','g','b','c','m'};
%load world data
problemData=load('sphereworld.mat');
%shorthand for variables
xGoal=problemData.xGoal;
xStart=problemData.xStart;
world=problemData.world;
%setup potential struct (exept goal)
potential.shape = shape;
potential.world = problemData.world;
potential.repulsiveWeight = repulsiveWeight;
%setup fHandles struct
fHandles.U=@potential_total;
fHandles.gradU=@potential_totalGrad;

nbStarts=size(xStart,2);
%iterate over goals
for iGoal=1:size(xGoal,2)
    %finish setup of potential struct
    potential.xGoal = xGoal(:,iGoal);
    %figure number depends on goal
    iFig=(iGoal-1)*nbStarts+1;
    figure(iFig)
    subplot(1,2,1)
    sphereworld_plot(world, xGoal(:,iGoal));
    %iterate over starts
    for iStart=1:nbStarts
        [xPath, UPath] = potential_planner(xStart(:,iStart), world, potential, epsilon, fHandles);
        subplot(1,2,1)
        hold on
        plot(xPath(1,:), xPath(2,:), styles{iStart});
        hold off
        subplot(1,2,2)
        hold on
        plot(1:size(UPath,2), UPath, styles{iStart});
        hold off
    end
end
