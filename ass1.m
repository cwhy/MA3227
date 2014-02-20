clear; close all;
range = [10,20,40,80];
colors = ['r','g','b','k']
err = zeros(length(range),2);
error_plot = figure(1);
hold on;
I = 1;
for n = range
    m = n - 1;
	h = 1/n;

    d = 2 * ones(1,m);
    p = -ones(1,m-1);
    q = p;
    i = [1:m, 1:m-1, 2:m];
    j = [1:m, 2:m, 1:m-1];
    s = [  d,   p,   q];
    S = sparse(i,j,s);
    
	mesh = linspace(0,1,m)'
    f = (pi^2)*sin(pi*mesh)*h*h;

    x_bar = S\f
    err(I,1) = h;
    err(I,2) = max(abs(x_bar - sin(pi*mesh)));
    plot(mesh', x_bar, [colors(I),'-+'],'LineWidth',1,'MarkerSize',2)
	I = I+1;
end

plot(mesh',sin(pi*mesh),'r')
hold off;
print(error_plot,'error_plot.tex','-S900,450','-dtex')

error_n_plot = figure(2)
loglog(err(:,1),err(:,2),'-d','LineWidth',1,'MarkerSize',2)
hold on; 
loglog(err(:,1),h.^2);
legend('|u-u_{ex}|_{\infty}','h v.s. h^2');
xlabel('h');
print(error_n_plot,'error_n_plot.tex','-S900,450','-dtex')

