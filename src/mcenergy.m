function [en_n, cells] = mcenergy(people, r, room, cells)
en_n = 0;

%For all people in perimeter cells, if any people are out of the bounds of
%the simulation, then potential is infinite.

perimeter_people = any(cells.people(:,cells.perimeter),2);
if any(perimeter_people)
    if any(circle_out(r, people(perimeter_people,:), room.height, room.width))
        en_n = Inf;
        return
    end
end

for i = 1:size(people,1)
    %Get all cells that a given person in the room could move to; this is 
    %any cells they currently occupy, plus the neighbors of any cells they
    %currnetly occupy.
    possible = any(cells.neighbors(cells.people(i,:)==1,:),1);
    %Check which cells the person is occupying after their displacement,
    %and update their position in the cell list.
    new = cirlce_rect_overlap(r, people(i,:), cells.cells(possible,:));
    cells.people(i,possible) = new;
end

for i = 1:cells.n
    cell_p = people(cells.people(:,i),:);
    for j = 1:size(cell_p,1)
        if any(circle_line_overlap(r, cell_p(j,:), room.barriers(cells.barriers(:,i),:)))
            en_n = Inf;
            return
        end
        if size(cell_p,1) > 1 && any(circle_circle_overlap(r, cell_p(j,:), cell_p(j+1:end,:)))
            en_n = Inf;
            return
        end
    end
end
en_n = en_n + sum(sum(1./pdist2(people,room.terrors,'euclidean')));
en_n = en_n - 3*sum(1./min(pdist2(people,(room.exits(:,[2 4]) + room.exits(:,[1 3]))/2,'euclidean'),[],2));
end