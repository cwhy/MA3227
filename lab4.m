VOL = (1-cos(1))^2;
max = 25;
err = ones(max,1);
parfor i = 1:max
    ntrials = 2^i;
    x = rand(1,ntrials);
    y = rand(1,ntrials);
    z = rand(1,ntrials);
    hits = (z < sin(x).*sin(y));
    err(i) = abs(sum(hits)/ntrials - VOL);
    % hist(rand(1,ntrials));
end
semilogy(1:max,err);