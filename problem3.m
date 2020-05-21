data = load('twolink_freeSpace_graph.mat');
graphVector = data.graphVector;
[xPath]=graph_search_startGoal(graphVector,[0.76;0.12],[0.76;6]);
plot(xPath(1, :), xPath(2, :), '-','lineWidth', 5)
hold on
graph_plot(graphVector)
axis equal