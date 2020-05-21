%function [xPath,UPath]=potential_planner(xStart,world,potential,epsilon,gradHandle)
%This function uses twolink_potential_totalGrad to implement the gradient-descent-based
%planner with step size  @x   epsilon, and evaluates the cost along the returned
%path. The planner must stop either after  @x   NSteps=1000 steps or when $ 
%U<10^-3$.
function [xPath,UPath]=twolink_potential_planner(thetaStart,world,potential,epsilon)

NSteps = 1000;
xPath = NaN(2, NSteps);
xPath(:, 1) = thetaStart;
UPath = NaN(1, NSteps);
UPath(1) = twolink_potential_total(xPath(:, 1),world,potential);

for iStep = 1:NSteps-1
    gradU = twolink_potential_totalGrad(xPath(:,iStep),world,potential);
    if norm(gradU) < 1e-3 || UPath(iStep) < 0.05
        break
    end
    xPath(:,iStep+1)=xPath(:,iStep)-epsilon*gradU;

    UPath(iStep + 1) = twolink_potential_total(xPath(:, iStep + 1),world,potential);
end