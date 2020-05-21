%function sphereworld_search(NCells)
%enumerate  the variables  @x   xStart,  @x   xGoal from      Marker
%file_provided [sphereworld.mat]  @x   sphereworld.mat  each of the three values
%for  @x   NCells: enumerate  the function sphereworld_freeSpace_graph for the
%given value of  @x   NCell.  each goal in  @x   xGoal: enumerate 
%graph_search_startGoal from every starting location in  @x   xStart to that
%goal.  the world using sphereworld_plot, together with the resulting
%trajectories. enumerate enumerate enumerate
function sphereworld_search(NCells)

problemData = load('sphereworld.mat');
xGoal=problemData.xGoal;
xStart=problemData.xStart;
world=problemData.world;

graphVector = sphereworld_freeSpace_graph(NCells);

for iGoal = 1:2
    figure(iGoal)
    sphereworld_plot(world, xGoal(:, iGoal))
    for iStart = 1:5
        xPath=graph_search_startGoal(graphVector,xStart(:, iStart),xGoal(:, iGoal));
        plot(xPath(1, :), xPath(2, :), '-')
        hold on
    end
    hold off
end

%In total, this function should produce six different images (three choices for 
%@x   NCell times two goals).
