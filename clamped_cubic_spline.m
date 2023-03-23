function [a,b,c,d] = clamped_cubic_spline(x, y, y_prime)
% input vectors for data nodes and function values x and y
% x and y each have n values for the n data points
% also input y_prime, a 2-element vector of slope values at first and last nodes

% output vectors of spline coefficients a, b, c, d
% where a(j), b(j), c(j), d(j) correspond to the jth spline piece
% for j = 1, 2, ... , n-1 pieces

% see BF algo 3.5

n = length(x);
a = y(:);

for j = 1:n-1
    h(j) = x(j+1) - x(j);
end

b_RHS(1,1) = 3/h(1)*(a(2) - a(1)) - 3*y_prime(1);
b_RHS(n,1) = 3*y_prime(2) - 3/h(n-1)*(a(n) - a(n-1));
for j = 2:n-1
    b_RHS(j,1) = 3/h(j)*(a(j+1) - a(j)) - 3/h(j-1)*(a(j) - a(j-1));
end

main_diag(1) = 2*h(1);  
main_diag(n) = 2*h(n-1);
upper_diag(1) = h(1);
lower_diag(n-1) = h(n-1);

for j = 2:n-1
    main_diag(j) = 2*(h(j-1) + h(j));
    upper_diag(j) = h(j);
    lower_diag(j-1) = h(j-1);
end

A = diag(upper_diag,1) + diag(main_diag,0) + diag(lower_diag,-1);

c = A\b_RHS;

for j = 1:n-1
    b(j,1) = 1/h(j)*(a(j+1) - a(j)) - h(j)/3*(2*c(j) + c(j+1));
end

for j = 1:n-1
    d(j,1) = (c(j+1) - c(j)) / 3 / h(j);
end

a = a(1:end-1);  c = c(1:end-1);
b
c
d