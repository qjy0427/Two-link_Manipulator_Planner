%function [U]=potential_total(xEval,world,potential)
%Compute the function $U=U_ attr+  @ @ _iU_ rep,i$, where $ $ is given by the
%variable  potential.repulsiveWeight
function [U]=potential_total(xEval,world,potential)
len = length(world);
repSum = 0;
for iRep = 1:len
    repSum = repSum + potential.repulsiveWeight * potential_repulsiveSphere(xEval,world(iRep));
end
U = potential_attractive(xEval,potential) + repSum;