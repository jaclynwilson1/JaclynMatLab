function R = romberg(f, a, b, n)
% Computes approximation to integral of f from a to b using
% n levels of the Romberg method (using Richardson extrapolation
% applied to the Composite Trapezoidal rule).
% Outputs R, an n x n table / matrix of approximations to the 
% integral with the most accurate approximation in the lower right corner,
% R(end, end).

R = NaN(n, n);

h(1) = b - a;
R(1,1) = h(1)/2 * (f(a) + f(b));

for i = 2:n
    h(i) = h(i-1)/2;
    
    sum = 0;
    for k = 1:2^(i-2)
        sum = sum + f(a+(2*k - 1)*h(i));
        
    end
    
    R(i,1) = 1/2 * ( R(i-1,1) + h(i-1)*sum);
    
    for j = 2:i
        R(i,j) = R(i,j-1) + ( R(i,j-1) - R(i-1,j-1)) / (4^(j-1) - 1);
    end
    
end

