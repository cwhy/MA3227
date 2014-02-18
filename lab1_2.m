range = 20:500;
err = zeros(length(range),2);

for n = range
    m = n - 1;
    
    d = 2 * ones(1,m);
    p = -ones(1,m-1);
    q = p;
    i = [1:m, 1:m-1, 2:m];
    j = [1:m, 2:m, 1:m-1];
    s = [  d,   p,   q];
    S = sparse(i,j,s);
    
    mesh = linspace(0,1,m)';
    f = (pi^2)*sin(pi*mesh)*(1/n)^2;

    x_bar = S\f;
    err(n-min(range)+1,1) = 1/n;
    err(n-min(range)+1,2) = max(abs(x_bar - sin(pi*mesh)));
%     figure();
%     plot(x_bar,'r')
%     figure();
%     plot(sin(pi*mesh),'g')
end

plot(err(:,1),err(:,2))

