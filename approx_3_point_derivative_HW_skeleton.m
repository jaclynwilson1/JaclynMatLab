f = @(x) cos(x);
% define the anonymous function using @(x)
% plot exact derivative (make sure it looks smooth, may want to create a densely sampled x_interp for this)
f_prime = @(x) -1.*sin(x);
x1 = linspace(0, 3.*pi);
figure(1)
plot(x1, f_prime(x1))
grid on
hold on
% define # nodes
nodes = 9;
% create x vector of nodes with linspace
x = linspace(0, 3.*pi, nodes);

plot(x,f_prime(x),'ko','markerfacecolor','k','markersize',8); % sampled nodes

% define h, the spacing between x nodes
%h = x(2)-x(1);
h = (3.*pi)./8;


f_prime_approx = NaN(1,length(x)); % often good idea to initialize variables as NaNs or zeros

f_prime_approx(1) =  (-3.*f(x(1))+4.*f(x(2))-f(x(3)))./(2.*h);% the approx derivative at the first point using 3 pt endpoint formula

for i = 2 : length(x) - 1 % only loop over interior nodes

    f_prime_approx(i) = (f(x(i+1))-f(x(i-1)))./(2.*h);% define approx derivative at interior nodes using 3 pt midpoint formula

end

f_prime_approx(end) = (f(x(end-2))-4.*f(x(end-1))+3.*f(x(end)))./(2.*h);% define approx derivative at last point using 3 pt endpoint formula 

% and also plot approx derivative values as individual markers (e.g. circles) on the same plot

plot(x, f_prime_approx,'linewidth',2);

legend('-sin(x)','nodes','Approximation','Location','NorthEast','fontsize',18);

f_prime((3.*pi)./2)

f_prime_approx(5)
