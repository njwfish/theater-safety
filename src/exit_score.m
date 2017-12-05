function expectation = exit_score(theta)
exits=theta;%table2array(theta);
t = load('t.mat');
t.room.exits = map_exits(exits, t.fraction_exits, t.room.height, t.room.width);
frames = [];
i_fails = 0;
%In the worst case, return that the number of frames is equal to the number
%of iterations; this means the simulation fails to complete too often.
expectation = t.n_iter;
while size(frames) < 10^7
    [people_h, ~] = mc(t.n_iter, t.c, t.people, t.r, t.room, t.kT, t.sigma_x);
    if nnz(people_h(:,:,end)) == 0
        frames(end+1) = size(people_h,3)
    else
        i_fails = i_fails + 1;
        if i_fails > t.max_fails
            return
        end
    end
end
mu_e = mean(log(frames));
sigma2_e = var(log(frames));
expectation = exp(mu_e + sigma2_e/2);
end