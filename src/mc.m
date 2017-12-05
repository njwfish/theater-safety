function [people_h, en_h, sims] = mc(n, c, people, r, room, kT, sigma_x)
people_h = people;
cells = gen_cells(c, people, r, room.height, room.width, room.barriers);
population = size(people,1);
safe = 0;
en_h = 0;
en = 100000;
sims = 0;
for i = 1:n
    [people, cells, en, accept, removed] = mcmove(en, people, r, cells, room, kT, sigma_x);
    if accept
        safe = safe + removed;
        people_h(:,:,end+1) = [people; zeros(safe, 2)];
        en_h(end+1) = en;
        if safe == population
            return
        end
    end
    sims = sims + 1;
end
end