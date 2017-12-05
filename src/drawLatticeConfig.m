function drawLatticeConfig(coords,nPart,L,newFig)
    
    % Set default
    if (nargin < 4) newFig = 1; end
    
    % Set the figure
    if (newFig) clf;    end
    hold on;
    
    % Draw the attice
    for ls = 0:L
        % Draw horizontal lines
        plotX = [0.5 L+0.5];
        plotY = [ls+0.5 ls+0.5];
        plot(plotX,plotY)
    end
    
    for ls =0:L
        % Draw vertical lines
        plotX = [ls+0.5 ls+0.5];
        plotY = [0.5 L+0.5];
        plot(plotX,plotY)
    end
    
    % Draw the particles
    radius = 0.4;
    
    for part = 1:nPart
            plotCircle(coords(:,part),radius)
    end
    
    
    % Set the figure 
    axis equal;
    if (newFig) hold off; end