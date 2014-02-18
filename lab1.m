range = 2:1000;
cond_n = zeros(length(2:100),2);

for n = range
    m = n - 1;
    
    d = 2 * ones(1,m);
    p = -ones(1,m-1);
    q = p;
    i = [1:m, 1:m-1, 2:m];
    j = [1:m, 2:m, 1:m-1];
    s = [  d,   p,   q];
    S = sparse(i,j,s);
    cond_n(n-min(range)+1,1) = n;
    cond_n(n-min(range)+1,2) = condest(S);
end

plot(cond_n(:,1),cond_n(:,2));