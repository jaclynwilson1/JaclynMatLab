f = @(x) x.^5 - 2;
f_prime = @(x) 5.*x.^4;
x0 = 1; 
N = 1E5;  tol = 1E-6;
clear x 


x(1) = x0; 

for i = 2:N 
    x(i) = x(i-1) -f(x(i-1))./f_prime(x(i-1));
    
    if abs( ( x(i) - x(i-1) )  ) < tol
        break 
    end
end
x