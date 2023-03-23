function [alpha, lambda] = estimate_convergence(p_approx)
% input vector of estimated values (that should converge to exact solution p) from consecutive iterations of an algorithm
% outputs estimated order of convergence alpha and asymptotic error constant lambda based on a linear fit to log-transformed data
% if there are very few data points shown on the graph (and used in the linear fit), try reducing the tolerance of your algorithm or choosing a worse initial 
% guess to generate a longer sequence of p_approx

% first check for and deal with roundoff error problems due to machine precision
abs_diffs = abs(diff(p_approx));  % absolute differences between consecutive values
ind = find(abs_diffs < eps,1,'first');  % find first place (if any) that two consecutive p_approx values are basically the same
p_approx(ind + 1 : end) = [];  % take all p_approx values starting from where they were basically the same to the last value, and delete these
% (otherwise they would appear to have zero error in the below calculations, but this is actually due to roundoff)

most_accurate_p = p_approx(end);  % often we don't know the exact solution (hence we're doing all this....) so use last iteration as our best estimate of p

error_n = abs( p_approx(1:end-2) - most_accurate_p ); % absolute differences based on nth iteration
error_n_plus_1 = abs( p_approx(2:end-1) - most_accurate_p ); % absolute differences based on (n+1)th iteration
% note above, we didn't calc error for p_approx(end) because we're calling that "exact" and we can't calculate a decent error estimate for it

log_error_n = log10(error_n);   log_error_n_plus_1 = log10(error_n_plus_1);  % take log of both

linear_coeffs = polyfit(log_error_n,log_error_n_plus_1,1); % fits a polynomial of order 1, so just a line with slope and intercept that are output
alpha = linear_coeffs(1); % slope is alpha
lambda = 10^linear_coeffs(2);  % 10^intercept is lambda
%% plotting

fontsize = 12; 
figure(45); clf % 45 is a completely arbitrary figure index (can choose any integer), clf resets the figure deleting all previous plots
plot(log_error_n,log_error_n_plus_1,'o','markerfacecolor','b'); % log-log plot because we expect log(error_n_plus_1) = alpha*log(error_n) + log(lambda)

hold on
p_vec = linspace( log_error_n_plus_1(end-1), log_error_n(1), 500); % make refined vector of x values to plot best fit line
plot(p_vec, polyval(linear_coeffs, p_vec),'k--','LineWidth',3); % plot best fit line (polyval evaluates the result of polyfit over p_vec)
hold off

xlims = xlim;  ylims = ylim; % store default x and y axes limits
text(xlims(1)+diff(xlims)*0.1, ylims(2)-diff(ylims)*0.15,{['order of convergence \alpha = ',num2str(alpha)],[],...
    ['error constant \lambda = ',num2str(lambda)]},'FontSize',fontsize); % create a text annotation in the plot to display alpha, lambda

xlabel('log_{10}(error_{n})');      ylabel('log_{10}(error_{n+1})'); % labels for axes
set(gca,'fontsize',fontsize); % sets fontsize for several parts of a plot