% Rejection sampling. Be(2,3)=12 x(1-x)^2 
% M = 16/9. 

nn=1e5; nb=50; M=16/9;
rand('state',0);

u=rand(nn,1);
h=(1/M)*12.*u.*(1-u).^2;
v=rand(nn,1);
r=u(v<h);

figure; 
hist(r,nb); 
dx=1/nb;
x=linspace(0,1,1e3);
pdf=12.*x.*(1-x).^2;
hold on; plot(x,length(r)*pdf*dx,'r:');
title(['We need',num2str(length(u)/length(r)),...
       ' g-sampling to get a desired X; M=',num2str(M)]);
