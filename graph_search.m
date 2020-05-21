%function [xPath,graphVector]=graph_search(graphVector,idxStart,idxGoal)
%Implements the  @x   A* algorithm, as described by the pseudo-code in Algorithm 
%alg:astar.
function [xPath,graphVector]=graph_search(graphVector,idxStart,idxGoal)
pqOpen = priority_prepare;
pqOpen = priority_insert(pqOpen,idxStart,0);
graphVector(idxStart).g = 0;
idxClosed = [];
while ~isempty(pqOpen)
    [pqOpen,idxNBest,~] = priority_minExtract(pqOpen);
    idxClosed = [idxClosed, idxNBest];
    
    if isempty(pqOpen)
        pqOpen = [];
    end
    
    if idxNBest == idxGoal
        break
    end
    idxExpand = graph_getExpandList(graphVector, idxNBest, idxClosed);
    nExpand = length(idxExpand);
    for iExpand = 1:nExpand
        [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxExpand(iExpand),idxGoal,pqOpen);
        %{
        idxNeighbor = find(graphVector(idxNBest).neighbors == idxExpand(iExpand)); % the index of that neighbor of the nBest
        if ~ismember(idxExpand(iExpand), [pQueue.key])
            graphVector(idxExpand(iExpand)).g = graphVector(idxNBest).g + ...
                graphVector(idxNBest).neighborsCost(idxNeighbor);
            graphVector(idxExpand(iExpand)).backpointer = idxNBest;
            func = graphVector(idxExpand(iExpand)).g + ...
                graph_heuristic(graphVector, idxExpand(iExpand), idxGoal);
            pQueue = priority_insert(pQueue,idxExpand(iExpand),func);
        elseif graphVector(idxExpand(iExpand)).g > graphVector(idxNBest).g + ...
                graphVector(idxNBest).neighborsCost(idxNeighbor)
            graphVector(idxExpand(iExpand)).g = graphVector(idxNBest) + ...
                graphVector(idxNBest).neighborsCost(idxNeighbor);
            graphVector(idxExpand(iExpand)).backpointer = idxNBest;
        end
        %}
    end
end
xPath = graph_path(graphVector,idxStart,idxGoal);


% Set a maximum limit of iterations in the main  @x   A* loop on line 
%it:astar-main-loop of Algorithm  alg:astar. This will prevent the algorithm from
%remaining stuck on malformed graphs (e.g., graphs containing a node as a
%neighbor of itself), or if you make some mistake during development.
