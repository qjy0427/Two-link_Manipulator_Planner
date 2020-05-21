%function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)
%This function expands the vertex with index  @x   idxX (which is a neighbor of
%the one with index  @x   idxNBest) and returns the updated versions of  @x  
%graphVector and  @x   pqOpen.
function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)
index = find(graphVector(idxNBest).neighbors == idxX);
computedG = graphVector(idxNBest).g + graphVector(idxNBest).neighborsCost(index);
if graphVector(idxX).g
    if graphVector(idxX).g > computedG
        graphVector(idxX).backpointer = idxNBest;
        graphVector(idxX).g = computedG;
    end
else
    graphVector(idxX).backpointer = idxNBest;
    graphVector(idxX).g = computedG;
    func = graphVector(idxX).g + graph_heuristic(graphVector,idxX,idxGoal);
    pqOpen = priority_insert(pqOpen, idxX, func);
end
%This function corresponds to lines  it:expansion-start-- it:expansion-end in
%Algorithm  alg:astar.
