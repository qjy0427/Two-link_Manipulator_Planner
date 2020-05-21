%function [pQueue,key,cost]=priority_minExtract(pQueue)
%Extract the element with minimum cost from the queue.
function [pQueue,key,cost]=priority_minExtract(pQueue)

    [~,index] = min([pQueue.cost]);
    key = pQueue(index).key;
    cost = pQueue(index).cost;
    pQueue(index) = [];
