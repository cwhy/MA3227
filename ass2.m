clear;
close all;
function I = repI(i)
	I = [];
	for j = 1:i
			I = [I,'I'];
	end
end

nTrials=2.^(1:20); m=length(nTrials);

vEst = cell(3,1);
for i = 1:3
	vEst{i} = zeros(1,m);
end

rand('state',0);
for i=1:m
	n=nTrials(i);
	x = rand(1,n);
	vEst{1}(i) = sum(4*sqrt(1-x.^2))/n;
	x = -sqrt(4 - 3*rand(1,n)) + 2;
	vEst{2}(i) = sum(12*sqrt(1-x.^2)./(4-2*x))/n;
	x = -sqrt(1 - rand(1,n)) + 1;
	vEst{3}(i) = sum(4*sqrt(1-x.^2)./(2-2*x))/n;
end

err = cell(3,1);
for i = 1:3
	err{i} = abs(vEst{i} - pi);
end

equation = cell(3,1);
equation{1} = '1$';
equation{2} = '\frac{4-2x}{3}$';
equation{3} = '2-2x$';

for i = 1:3
	the_plot = figure(i);
	subplot(2,1,1);
	semilogx(nTrials,vEst{i}, 'LineWidth', 2);
	title(['Method ',repI(i),': $g(x) =', equation{i}]);

	subplot(2,1,2);
	hold on;
	loglog(nTrials, err{i}, 'LineWidth', 2);
	loglog(nTrials, 1./sqrt(nTrials),'r:','LineWidth', 2);
	title(['Method ', repI(i)])
	legend('$\abs{err}$ vs number of trials','$\frac{1}{\sqrt{number of trials}}$');

	print(the_plot,['Method_',repI(i),'.tex'],'-S500,450','-dtex')
end

err_plot = figure(4);
marker = cell(3,1);
titles = cell(3,1);
marker{1} = 'k:';
marker{2} = 'g-';
marker{3} = 'r--';
for i = 1:3
	titles{i} = ['Method ',repI(i),': $g(x) =', equation{i}]
	plot(err{i}.*sqrt(nTrials), 'LineWidth', 2, marker{i});
	hold on;
end
legend(titles{1}, titles{2}, titles{3});
