%function [xPath]=graph_path(graphVector,idxStart,idxGoal)
%This function follows the backpointers from the node with index  @x   idxGoal in
% @x   graphVector to the one with index  @x   idxStart node, and returns the 
%coordinates (not indexes) of the sequence of traversed elements.
function [xPath]=graph_path(graphVector,idxStart,idxGoal)
xPath = [];
temp = idxGoal;
if idxStart == idxGoal
    xPath = [graphVector(temp).x, graphVector(temp).x];
    return
end

while 1
    if temp==idxStart
        xPath = [graphVector(temp).x, xPath];
        return
    end
    xPath = [graphVector(temp).x, xPath];
    temp = graphVector(temp).backpointer;
end
