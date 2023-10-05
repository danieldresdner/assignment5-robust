function [xPoints, yPoints] = GetLinePoints(equilibrium, eigenVector, xMin, xMax, yMin, yMax)
    % Calculate points for plotting eigenVector at an equilibrium
    % -----------------------------------------------------------
    % Get k, m from equation y = kx + m
    k = eigenVector(2)/eigenVector(1);
    m = equilibrium(2) - k*equilibrium(1);

    % Calculate points
    y1 = max(yMin, k*xMin + m);
    y2 = min(yMax, k*xMax + m);

    if y1 > yMin 
        x1 = xMin;
    else
        x1 = (y1 - m)/k;
    end

    if y2 < yMax
        x2 = xMax;
    else
        x2 = (y2 - m)/k;
    end

    if y1 > yMax
        x1 = (yMax - m)/k;
        y1 = yMax;
    end

    if y2 < yMin
        x2 = (yMin - m)/k;
        y2 = yMin;
    end

    xPoints = [x1, x2];
    yPoints = [y1, y2];
end