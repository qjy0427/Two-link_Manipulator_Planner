%function [idxExpand]=graph_getExpandList(graphVector,idxNBest,idxClosed)
%Finds the neighbors of element  @x   idxNBest that are not in  @x   idxClosed
%(line  it:expansion in Algorithm  alg:astar).
function [idxExpand]=graph_getExpandList(graphVector,idxNBest,idxClosed)
sizeOfGV = size(graphVector);
if sizeOfGV(1) < sizeOfGV(2)
    graphVector = graphVector';
end
nBest = length(graphVector(idxNBest).neighbors);
idxExpand = [];
for iBest = 1:nBest
   if graphVector(idxNBest).neighbors(iBest) == idxNBest
       continue
   end
   if ~ismember(graphVector(idxNBest).neighbors(iBest), idxClosed)
       idxExpand = [idxExpand; graphVector(idxNBest).neighbors(iBest)];
   end
end
%Ensure that the vector  @x   idxBest is not included in the list of neighbors
%(i.e., avoid self-loop edges in the graph).
