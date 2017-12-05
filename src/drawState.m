function drawState(people, r, barriers, exits, terrors, height, width) 
    hold on;
    
    plot([0,width],[0,0],'LineWidth',5,'Color','black');
    plot([0,0],[0,height],'LineWidth',5,'Color','black');
    plot([0,width],[height,height],'LineWidth',5,'Color','black');
    plot([width,width],[0,height],'LineWidth',5,'Color','black');
    
    viscircles(people, zeros(size(people,1),1) + r,'Color','black');
    viscircles(terrors, zeros(size(terrors,1),1) + 0.5);
    
    for i = 1:size(barriers,1)
        plot(barriers(i,1:2), barriers(i,3:4),'LineWidth',3,'Color','black');
    end
    
    for i = 1:size(exits,1)
        plot(exits(i,1:2), exits(i,3:4),'LineWidth',12,'Color','blue');
    end
end