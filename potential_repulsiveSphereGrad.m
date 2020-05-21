%function [gradURep]=potential_repulsiveSphereGrad(xEval,sphere)
%Compute the gradient of $U_ rep$ for a single sphere, as given by    @  ( 
%eq:repulsive-gradient \@@italiccorr ).
function [gradURep]=potential_repulsiveSphereGrad(xEval,sphere)

nbXEval=size(xEval,2);
[dist, points]=sphere_distance(sphere,xEval);
%Initialize returned potential with a default value
gradURep=zeros(2,nbXEval);

for iXEval = 1:nbXEval
    if dist(iXEval) > 0 && dist(iXEval) < sphere.distInfluence
        if norm(xEval(:, iXEval) - sphere.xCenter) < norm(xEval(:, iXEval) ...
                - points(:, iXEval))
            
            gradURep(:, iXEval) = ...
            -(1/dist(iXEval) - 1/sphere.distInfluence)/(dist(iXEval)^2) .* ...
            (xEval(:, iXEval) - sphere.xCenter) ./ norm(xEval(:, iXEval)   ...
            - sphere.xCenter);
        else
            
            gradURep(:, iXEval) = ...
            -(1/dist(iXEval) - 1/sphere.distInfluence)/(dist(iXEval)^2) .* ...
            (xEval(:, iXEval) - points(:, iXEval)) ./ norm(xEval(:, iXEval)...
            - points(:, iXEval));
        end
    else
        gradURep(:, iXEval) = [0;0];
    end
end


%This function must use the outputs of sphere_distanceSphere.