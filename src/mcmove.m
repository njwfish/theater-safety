function [people, cells, en, accept, removed] = mcmove(en, people, r, cells, room, kT, sigma_x)


people_n = people + normrnd(0,sigma_x,size(people,1),size(people,2));

%Test the energy of the new state, and accept the new energy state
%according to the Maxwell Boltzmann distribution
[en_n, cells] = mcenergy(people_n, r, room, cells);
accept = min([1 exp(-(en_n-en)/kT)]) > rand;
removed = 0;

if accept
    for k = 1:size(people_n,1)
        i = k - removed;
        if any(rect_line_overlap([people_n(i,1)-r people_n(i,1)+r people_n(i,2)-r people_n(i,2)+r], room.exits))
            people_n(i,:) = [];
            cells.people(i,:) = [];
            removed = removed + 1;
        end
    end
    if removed > 0
        [en_n, cells] = mcenergy(people_n, r, room, cells);
    end
    people = people_n;   
    en = en_n;
end
end