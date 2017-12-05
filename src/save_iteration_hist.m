function stop = save_iteration_hist(results,state)
stop=false;
s = load('iteration_hist');
iteration_hist = s.iteration_hist;
iteration_hist{end+1} = results;
save('iteration_hist', 'iteration_hist');
end