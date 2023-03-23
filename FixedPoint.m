f = @(x) x;
g = @(x) x + f(x);
x0 = 2; % initial guess
Nmax = 25; tol = 1e-10; % max iterations and stopping tolerance
clear x % delete whatever x may have been to avoid possible issues between runs
x(1) = x0; % first element of approx. solution vector x is the initial guess
 
for i=2:Nmax % loop from i = 2 in increments of 1 until i equals Nmax
    
    x(i) = g( x(i-1) ); % the definition of fixed point iteration:  new value = g(old value) or p_n = g( p_(n-1) )
    
    if abs( ( x(i) - x(i-1) ) / x(i) ) < tol % if abs. relative difference between last two approx. solutions is less than tolerance,
        break % exit loop
    end
end
 
format long % display a lot of digits
[(1:length(x))', x']