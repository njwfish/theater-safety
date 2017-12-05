function expectation = runtime_score(theta)
t = load('t.mat');
runtime = zeros(t.min_samples,1);
for i = 1:t.min_samples
    tic;
    mc(100000, t.c, t.people, t.r, t.room, theta(1), theta(2));
    runtime(i) = toc;
end
mu_e = mean(log(runtime));
sigma2_e = var(log(runtime));
expectation = exp(mu_e + sigma2_e/2);
end