clear; close all;
function f = F(x)
	f=pi^2*sin(pi*x);
end % function
%-----------------------------------
function u = U(x)
	u=sin(pi*x);
end % function
%-----------------------------------
function upp = A(u)
	m=size(u,1);
	DD=sparse(1:m,1:m,2,m,m)+sparse(2:m,1:m-1,-1,m,m)+sparse(1:m-1,2:m,-1,m,m);
	upp = DD*u;
end % function
%-----------------------------------
function x_bar=rgd_solve(A,f,h)
	m=size(f,1);
	DD=sparse(1:m,1:m,2,m,m)+sparse(2:m,1:m-1,-1,m,m)+sparse(1:m-1,2:m,-1,m,m);
	x_bar = DD\(f*h^2);
end % function
%-----------------------------------------------------
function x_bar=cgd_solve(A,f,h,iter_max = 100)
	b = f*h^2;
	k = 0;
	x = zeros(size(b));
	r = b - A(x);
	p = r;
	
	while(k < iter_max && max(abs(r))>=0.000000001)
		k = k + 1
		a = r'*p./(p'*(A(p)));
		x = x + a*p;
		r_old = r;
		r = r - a*(A(p));
		b = r'*r./(r_old'*r_old);
		p = r + b*p;
	end %while
	x_bar = x;

end % function
%-----------------------------------------------------
N=[10,20,40,80];
drawStr={'k.-','g-.','b--','r:'};
maxerr = zeros(length(N),1);

error_plot = figure(1);
hold on;
grid on;
legendStr=cell(1,length(N));
I = 1;
for n = N
	h = 1/n;
	mesh = linspace(0,1,n+1)';
    Au = F(mesh);

	x_bar = [0;cgd_solve(@A, Au(2:end-1),h);0];
	err = x_bar - U(mesh);
    plot(mesh, err, drawStr(I),'LineWidth',3,'MarkerSize',4)
    maxerr(I) = max(abs(err));
	clear("err")
	legendStr{I}=['n=',num2str(n)];
	I = I+1;
end

legend(legendStr);
xlabel('x');
ylabel('Error at grid points: u_i-u_{ex}(x_i)')
print(error_plot,'error_plot.tex','-S900,450','-dtex')
hold off;

error_n_plot = figure(2);
loglog(1./N,maxerr,'d-b','LineWidth',3,'MarkerSize',5)
set(gca,'XDir','reverse');
grid on;
hold on; 
loglog(1./N,(1./N).^2,'.-r','LineWidth',2);
legend('|u-u_{ex}|_{\infty}','h v.s. h^2');
xlabel('h');
ylabel('Error at grid points: u_i-u_{ex}(x_i)')
print(error_n_plot,'error_n_plot.tex','-S900,450','-dtex')
hold off;
