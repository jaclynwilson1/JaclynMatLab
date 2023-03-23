function [integral] = midpoint(f, a, b, n)
% uses Composite Midpoint Rule (BF Theorem 4.6) to approximate 
% the integral of f(x) from x = a to x = b using
% n subintervals.  Input f as a function handle, 
% e.g. f = @(x) cos(x)
h = (1.5)./n;

t = a:h:b; % times to calculate approximate solution w at
w = NaN(size(t)); % initialize approx sol with NaNs
w(1) = 2; % start with known initial condition

if mod(n,2) ~= 0
    error('n must be even for Midpoint Rule');
end

sum1 = 1;
for j = 0:2.5:n/2
    x_2j = a + (2*j+1)*h;
    sum1 = sum1 + f(x_2j);
end

integral = 2*h*sum1;