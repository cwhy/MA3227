% Part I:
% Plot the surface $z=\sin(x)\sin(y)$ and then estimate the volume of the
% body below this surface but above $A=\{(x,y): 0\le x\le 1, 0\le y\le 1\}$.
% The exact value is $\int_A z dxdy =(1-\cos(1))^2$.
% We will use two different methods:
% (1) The hit-or-miss explained in page 37
% (2) write integral of f(x) as expectation of f(U) with U ~ U([0,1]X[0,1])

x=linspace(0,1,100);
y=linspace(0,1,100);
[x,y]=meshgrid(x,y);
figure; mesh(x,y,sin(x).*sin(y)); view(75,15);

% Method I
nTrials=2.^(1:20); m=length(nTrials);
vEst=zeros(1,m);
rand('state',0);
for i=1:m
    n=nTrials(i);
    x=rand(1,n);
    y=rand(1,n);
    z=rand(1,n);
    hits=sum(sin(x).*sin(y)>=z);
    vEst(i)=hits/n;
end

err=vEst-(1-cos(1))^2;

figure;
subplot(2,2,1);
semilogx(nTrials,vEst);
title('method I: Estimation vs number of trials');

subplot(2,2,3);
loglog(nTrials,abs(err)); hold on;
loglog(nTrials,1./sqrt(nTrials),'r:'); title('method I')
legend('abs(err) vs number of trials','1/sqrt(number of trials)');

% Method II
rand('state',0);
for i=1:m
    n=nTrials(i);
    x=rand(1,n);
    y=rand(1,n);
    vEst(i)=sum(sin(x).*sin(y))/n;
end

err=vEst-(1-cos(1))^2;

subplot(2,2,2);
semilogx(nTrials,vEst);
title('method II: Estimation vs number of trials');

subplot(2,2,4);
loglog(nTrials,abs(err));
hold on;
loglog(nTrials,1./sqrt(nTrials),'r:'); title('method II')
legend('abs(err) vs number of trials','1/sqrt(number of trials)');

% Part II: histogram
% note that " pdf dx = # of r.v. in dx / total # of r.v.'s "
% dx cab be the size of the bin

% (1) r.v. with uniform distribution
nn=1e5; nb=50;
r=rand(1,nn);
figure; hist(r,nb); 
x=linspace(0,1,1e3);
dx=1/nb;
pdf=1;
hold on; plot(x,nn*pdf*dx,'r:');

% (2) r.v. with normal distribution
nn=1e5;
r=randn(1,nn);
figure; [N,xout]=hist(r,nb); bar(xout,N); 
dx=xout(2)-xout(1);
x=linspace(xout(1)-dx,xout(end)+dx,1e3);
pdf=exp(-x.^2/2)/(sqrt(2*pi));
hold on; plot(x,nn*pdf*dx,'r:');