%how many samples are needed for the log normal distribution to give a 95%
%confidence that the estimated parameters give a LL 99% accurate to the 
%true LL of the data given the true parameters

k=100000;
b = 0.99;
K = 100000;
ibk = ones(K,1)+1;
for i = 1:K
    mu_t = rand*100;
    sigma_t = rand;
    Z = lognrnd(mu_t,sigma_t,k,1);
    ll_t = (-1/2*log(2*pi*sigma_t^2)-mu_t^2/(2*sigma_t^2)-mu_t-(mu_t^2+sigma_t^2)/(2*sigma_t^2)-mu_t^2/(sigma_t^2));
    ll_e = -Inf;
    while ll_t - ll_e > -log(b)
        Y = lognrnd(mu_t,sigma_t,ibk(i),1);
        mu_e = mean(log(Y));
        sigma_e = sqrt(var(log(Y)));
        
        ll_e = (-k/2*log(2*pi*sigma_e^2)-k*mu_e^2/(2*sigma_e^2)-sum(log(Z))-sum(log(Z).^2)/(2*sigma_e^2)-mu_e*sum(log(Z))/(sigma_e^2))/k;
        
        ibk(i) = ibk(i) + 1;
    end
end

%fit parameters to distribution of minimum number of samples, which appears
%geometric: MLE

p=1/mean(ibk-min(ibk));

%X~Geo(p)
%P(X>n)=0.95

n_c=-log(20)/log(1-p) + min(ibk);
n=ceil(n_c);



