% solving -u''=f on [0,1] by backslash

function err=Lab1_2()
N=[10,20,40,80,160];
drawStr={'r','b-.','g--','y:','k'};
legendStr=cell(1,length(N));
figure(1);
err=zeros(length(N),1);
h=zeros(length(N),1);
for i=1:length(N)
    h(i)=1/N(i);
    x=linspace(0,1,N(i)+1)';
    b=fcn(x);
    u=[0;GE(b(2:end-1),h(i));0];
    e=myerror(u,x);
    hold on;
    plot(x,e,drawStr{i});
    err(i)=max(abs(e));
    legendStr{i}=['N=',num2str(N(i))];
end
legend(legendStr);
xlabel('x');
ylabel('error at grid points: u_i-u_{ex}(x_i)')

figure(2)
loglog(h,err,'-*');
hold on; 
loglog(h,h.^2);
legend('|u-u_{ex}|_{\infty}','h v.s. h^2');
xlabel('h');

%--------------------------------------------------------------------------
function f=fcn(x)
f=pi^2*sin(pi*x);

function u=uex(x)
u=sin(pi*x);

function u=GE(b,h)
% use Gauss elimimation A\b 
m=size(b,1);
A=sparse(1:m,1:m,2,m,m)+sparse(2:m,1:m-1,-1,m,m)+sparse(1:m-1,2:m,-1,m,m);

u=A\(b*h^2);

function e=myerror(u,x)
e=u-uex(x);