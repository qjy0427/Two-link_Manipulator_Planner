%function [dPointsSphere,pointsSphere]=sphere_distance(sphere,points)
%Computes the distance between points and the sphere, as well as the point on the
%sphere that realizes that distance, while taking into account if it is hollow or
%filled in.

function [dPointsSphere,pointsSphere]=sphere_distance(sphere,points)

[~, nPoints] = size(points);
dPointsSphere = zeros(1, nPoints);
pointsSphere = zeros(2, nPoints);

for iPoint = 1:nPoints
    
    dPointsSphere(iPoint) = sqrt((sphere.xCenter(1,1) - points(1,iPoint))^2 ...
        + (sphere.xCenter(2,1) - points(2,iPoint))^2) - sphere.radius;
    
    if sphere.radius < 0
        dPointsSphere(iPoint) = -sqrt((sphere.xCenter(1,1) - points(1,iPoint))^2 ...
        + (sphere.xCenter(2,1) - points(2,iPoint))^2) - sphere.radius;    
    end

    phi = atan((sphere.xCenter(2,1) - points(2,iPoint)) / ...
        (sphere.xCenter(1,1) - points(1,iPoint)));
    
    pointsSphere(1,iPoint) = sphere.radius * cos(phi) + sphere.xCenter(1,1);
    pointsSphere(2,iPoint) = sphere.radius * sin(phi) + sphere.xCenter(2,1);
    
    if points(1,iPoint) - sphere.xCenter(1,1) > 0
        pointsSphere(1,iPoint) = abs(pointsSphere(1,iPoint));
    else
        pointsSphere(1,iPoint) = - abs(pointsSphere(1,iPoint));
    end
    
    if points(2,iPoint) - sphere.xCenter(2,1) > 0
        pointsSphere(2,iPoint) = abs(pointsSphere(2,iPoint));
    else
        pointsSphere(2,iPoint) = - abs(pointsSphere(2,iPoint));
    end
    
end

%Remember that the radius of the sphere is negative for hollow spheres.
