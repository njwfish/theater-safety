function M=animateState(people_h, barriers, exits, terrors, height, width) 
figure;
hold on;
daspect([1 1 1])
plot([0,width],[0,0],'LineWidth',5,'Color','black');
plot([0,0],[0,height],'LineWidth',5,'Color','black');
plot([0,width],[height,height],'LineWidth',5,'Color','black');
plot([width,width],[0,height],'LineWidth',5,'Color','black');

for i = 1:size(barriers,1)
    plot(barriers(i,1:2), barriers(i,3:4),'LineWidth',3,'Color','black');
end
for i = 1:size(exits,1)
    plot(exits(i,1:2), exits(i,3:4),'LineWidth',10,'Color','blue');
end
for j=1:size(people_h,3)
    fleeing = people_h(:,:,j);
    fleeing(people_h(:,1,j)==0,:) = [];
    plot_fleeing = viscircles(fleeing, zeros(size(fleeing,1),1) + 0.4,'Color','black');
    plot_terrors = viscircles(terrors, zeros(size(terrors,1),1) + 0.5);
    drawnow limitrate
    axis([0 width 0 height])
    M(j) = getframe;
    delete(plot_fleeing);
    delete(plot_terrors);
end

end