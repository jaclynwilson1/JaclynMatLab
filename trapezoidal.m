function [integral] = trapezoidal(f, a, b, n)
% uses Composite Trapezoidal Rule (BF Theorem 4.5) to approximate 
% the integral of f(x) from x = a to x = b using
% n subintervals.  Input f as a function handle, 
% e.g. f = @(x) cos(x)

h = (b-a)/n;

sum1 = 0;
for j = 1:n-1
    x_j = a + j*h;
    sum1 = sum1 + f(x_j);
end

integral = h/2*( f(a) + 2*sum1 + f(b) );