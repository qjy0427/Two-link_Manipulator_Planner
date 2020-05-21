%function polygon_plot(vertices,style)
%Draws a closed polygon described by  vertices using the style (e.g., color)
%given by  style.

function polygon_plot(vertices, style)

    [~, nbColumns] = size(vertices);
    
    for iVertex = 1 : (nbColumns - 1)
        xPoint = vertices(1, iVertex);
        yPoint = vertices(2, iVertex);
        deltaX = vertices(1, iVertex + 1) - xPoint;
        deltaY = vertices(2, iVertex + 1) - yPoint;
        quiver(xPoint, yPoint, deltaX, deltaY, style, 'lineWidth', 2, 'AutoScale', 'OFF')
        
        hold on
    end
    
    %Draw the last arrow
    xPoint = vertices(1, nbColumns);
    yPoint = vertices(2, nbColumns);
    deltaX = vertices(1, 1) - xPoint;
    deltaY = vertices(2, 1) - yPoint;
    quiver(xPoint, yPoint, deltaX, deltaY, style, 'lineWidth', 2, 'AutoScale', 'OFF')
    
    hold off

end

%Each edge in the polygon must be an arrow pointing from one vertex to the next.
%In Matlab, use the fuction quiver to actually perform the drawing. The function
%should  not create a new figure.