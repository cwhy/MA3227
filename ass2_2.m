clear; close all;
graphics_toolkit("gnuplot");

N_bins = 101;

function M = Metro_Ising(mu, N_steps, sample_rate, N)
	x = ones(N, 1);
	M = zeros(0, N_steps/sample_rate);
	for i = 1:N_steps
		j = ceil(N*rand);
		if j == 1
			h = exp(-2*mu*x(1)*(x(2)));
		elseif j == N
			h = exp(-2*mu*x(N)*(x(N-1)));
		else
			h = exp(-2*mu*x(j)*(x(j-1)+x(j+1)));
		end
		U = rand;
		if U <= h
			x(j) = -x(j);
		end
		if mod(i, 50) == 0
			M(i/50) = sum(x);
		end
	end
end

N_steps = 1e6;
sample_rate = 50;
N = 50;
%mesh = -N:floor(2*N/(N_bins - 1)):N;
%[n, h] = hist(M, mesh);
the_plot = figure();
M_h = Metro_Ising(1, N_steps, sample_rate, N);
M_l = Metro_Ising(2, N_steps, sample_rate, N);

h_plot = subplot(2,1,1);
hist(M_h, 101);
title(['Histogram of sum of states of high temperature ($\mu = 1$)',
       '1D Ising model with $20,000$ from $1,000,000$ states']);
xlabel('Sum of states');
ylabel('Number of samples');

l_plot = subplot(2,1,2);
hist(M_l, 101);
title(['Histogram of sum of states of low temperature ($\mu = 2$)',
       '1D Ising model with $20,000$ from $1,000,000$ states']);
xlabel('Sum of states');
ylabel('Number of samples');

print(the_plot, ['MetropolisIsing','.tex'],'-S520,400','-dtex')
