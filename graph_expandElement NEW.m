%function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)
%This function expands the vertex with index  @x   idxX (which is a neighbor of
%the one with index  @x   idxNBest) and returns the updated versions of  @x  
%graphVector and  @x   pqOpen.
function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)

%This function corresponds to lines  it:expansion-start-- it:expansion-end in
%Algorithm  alg:astar.
    idxNBestneighbors=graphVector(idxNBest).neighbors;
    idxXin_neighbors=find(idxNBestneighbors==idxX);
    % get the cost from idx to idxNbest
    c_nbbest_x=graphVector(idxNBest).neighborsCost(idxXin_neighbors);
   
    
    % if x ?/ O then
    if priority_isMember(pqOpen,idxX)==0
        % Set the value of g(x) to g(nbest) + c(nbest, x).   
        graphVector(idxX).g = graphVector(idxNBest).g + c_nbbest_x;
        % Set the backpointer of x to nbest.   
        graphVector(idxX).backpointer = idxNBest;
        % Add x to O with value f(x) = g(x) + heuristic(x).
        heuristic=graph_heuristic(graphVector,idxX,idxGoal);
        fidxX = graphVector(idxX).g + heuristic ;
        pqOpen = priority_insert(pqOpen,idxX,fidxX);
        % else if g(nbest) + c(nbest, x) < g(x) then
    else
        if graphVector(idxNBest).g + c_nbbest_x < graphVector(idxX).g
        % Update the value of g(x) to g(nbest) + c(nbest, x).
        graphVector(idxX).g = graphVector(idxNBest).g + c_nbbest_x;
        % Update the backpointer of x to nbest.
        graphVector(idxX).backpointer = idxNBest;
        % end if
        end
    end
end