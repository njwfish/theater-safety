function M = animateOptimization(iteration_hist, people_hist, room_hist)
main=figure('pos',[0 0 160*7 90*7]);
h(1)=subplot(1,16,[1:4]);
h(2)=subplot(1,16,[6:16]);
set(h(1).Title,'String','Objective Function','FontSize',24,'Color','blue');
for c = 1:length(iteration_hist)
    %Plot Objectice Function
    cla(h(1));
    plot(iteration_hist{c},@plotObjectiveModel);
    pom=gcf;
    copyobj(allchild(get(pom,'CurrentAxes')),h(1));
    h(1).View = [-45    15];
    close(pom);
    
    cla(h(2));
    people_h = people_hist{c};
    room = room_hist{c};
    sim_title = sprintf('Simulation %d',c);
    set(h(2).Title,'String',sim_title,'FontSize',24,'Color','blue');
    set(h(2),'xtick',[],'ytick',[]);
    set(h(2),'DataAspectRatio', [1 1 1]);
    hold(h(2), 'on');
    plot(h(2),[0,room.width],[0,0],'LineWidth',5,'Color','black');
    plot(h(2),[0,0],[0,room.height],'LineWidth',5,'Color','black');
    plot(h(2),[0,room.width],[room.height,room.height],'LineWidth',5,'Color','black');
    plot(h(2),[room.width,room.width],[0,room.height],'LineWidth',5,'Color','black');

    for i = 1:size(room.barriers,1)
        plot(h(2),room.barriers(i,1:2), room.barriers(i,3:4),'LineWidth',3,'Color','black');
    end
    for i = 1:size(room.exits,1)
        plot(h(2),room.exits(i,1:2), room.exits(i,3:4),'LineWidth',10,'Color','blue');
    end
    M=struct('cdata',[],'colormap',[]);
    for j=1:min(size(people_h,3),2250)
        fleeing = people_h(:,:,j);
        fleeing(people_h(:,1,j)==0,:) = [];
        plot_fleeing = viscircles(h(2),fleeing, zeros(size(fleeing,1),1) + 0.4,'Color','black');
        plot_terrors = viscircles(h(2),room.terrors, zeros(size(room.terrors,1),1) + 0.5);
        drawnow
        axis([0 room.width 0 room.height])
        M(j) = getframe(main);
        set(plot_fleeing,'Visible','off')
        set(plot_terrors,'Visible','off')
    end
    movie_title = sprintf('sim_%d',c);
    save(movie_title,'M','-v7.3');
    
end
end