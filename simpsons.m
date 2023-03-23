function [integral] = simpsons(f, a, b, n)
% uses Composite Simpson's Rule (BF Theorem 4.4) to approximate 
% the integral of f(x) from x = a to x = b using
% n subintervals.  Input f as a function handle, 
% e.g. f = @(x) cos(x)

if mod(n,2) ~= 0
    error('n must be even for Simpson''s Rule');
end

h = (b-a)/n;

sum1 = 0;
for j = 1:(n/2)-1
    x_eval = a + (2*j)*h;
    sum1 = sum1 + f(x_eval);
 
end

sum2 = 0;
for j = 1:n/2
    x_eval = a + (2*j-1)*h;
    sum2 = sum2 + f(x_eval);
    
end

integral = h/3*( f(a) + 2*sum1 + 4*sum2 + f(b) );
