function theta = optimize_runtime(theta_i)
options = optimset('Display','iter','PlotFcns',@optimplotfval);
theta = fminsearch('runtime_score',theta_i,options);
end