function [a,b,c,d] = natural_cubic_spline(x, y)
% input vectors for data nodes and function values x and y
% x and y each have n values for the n data poin

% output vectors of spline coefficients a, b, c, d
% where a(j), b(j), c(j), d(j) correspond to the jth spline piece
% for j = 1, 2, ... , n-1 pieces

% see BF algo 3.4, but we differ from around their Step 3 onward

n = length(x);
a = y(:); % the a spline coeffs are easily obtained from the function values
% (:) makes it into a column vector if it's not already

for j = 1:n-1
    h(j) = x(j+1) - x(j); % spacing between input nodes
end

b_RHS = zeros(n,1); % initialize vector of RHS values in Ax = b
for j = 2:n-1
    b_RHS(j,1) = 3/h(j)*(a(j+1) - a(j)) - 3/h(j-1)*(a(j) - a(j-1));
    % see BF Theorem 3.11 or algo 3.4 Step 2 (they call our b_RHS alpha)
end

% next we'll define 3 vectors for the diagonals of A
% the first values of the main and upper, and last values of the main and lower,
% correspond to our natural boundary conditions,
% S''(x(1)) = 0 and S''(x(n)) = 0
% See BF Theorem 3.11; note some of this code is not needed but might help with understanding)
% first initialize them
main_diag = zeros(n, 1);  upper_diag = zeros(n-1, 1);  lower_diag = zeros(n-1, 1);
% then update values at beginning and end
main_diag(1) = 1;  
main_diag(n) = 1; 
upper_diag(1) = 0;
lower_diag(n-1) = 0;
% then fill in interior values, being careful with BF vs MATLAB indexing
for j = 2:n-1
    main_diag(j) = 2*(h(j-1) + h(j));
    upper_diag(j) = h(j);
    lower_diag(j-1) = h(j-1);
end

% finally, make a diagonal matrix from each vector and simply add them together for the final A
A = diag(upper_diag,1) + diag(main_diag,0) + diag(lower_diag,-1);

c = A \ b_RHS; % the deceptively simple command to solve the linear system for the c spline coeffs

% now just plug into BF 3.20 to get all the b spline coeffs
for j = 1:n-1
    b(j,1) = 1/h(j)*(a(j+1) - a(j)) - h(j)/3*(2*c(j) + c(j+1));
end
% and plug into BF 3.17 for all the d spline coeffs
for j = 1:n-1
    d(j,1) = (c(j+1) - c(j)) / 3 / h(j);
end
% finally, note that the final a and c values don't actually get used directly to define a spline piece
% since there are only n-1 pieces for n data nodes.  (They did get used above to compute the prior coeffs though.)
a = a(1:end-1);  c = c(1:end-1);
end

