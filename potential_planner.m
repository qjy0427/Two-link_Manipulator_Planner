%function [xPath,UPath]=potential_planner(xStart,world,potential,epsilon,gradHandle)
%This function uses potential_totalGrad to implement the gradient-descent-based
%planner with step size  @x   epsilon, and evaluates the cost along the returned
%path. The planner must stop either after  @x   NSteps=1000 steps or when $ 
%U<10^-3$.
function [xPath,UPath]=potential_planner(xStart,world,potential,epsilon,gradHandle)

NSteps = 1000;
xPath = NaN(2, NSteps);
xPath(:, 1) = xStart;
UPath = NaN(1, NSteps);
UPath(1) = potential_total(xPath(:, 1),world,potential);

for iStep = 1:NSteps-1
    gradU = potential_totalGrad(xPath(:,iStep),world,potential);
    if norm(gradU) < 1e-3 || UPath(iStep) < 0.05
        break
    end
    xPath(:,iStep+1)=xPath(:,iStep)-epsilon*gradU;
    UPath(iStep + 1) = potential_total(xPath(:, iStep + 1),world,potential);
end