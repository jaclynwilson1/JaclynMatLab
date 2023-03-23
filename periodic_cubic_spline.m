function [a,b,c,d] = periodic_cubic_spline(x, y)

n = length(x) - 1;
a = y(:);

for j = 1:n
    h(j) = x(j+1) - x(j);
end

b_RHS(1,1) = 3/h(1)*(a(2) - a(1)) - 3/h(n)*(a(1) - a(n));
b_RHS(n,1) = 3/h(n)*(a(1) - a(n)) - 3/h(n-1)*(a(n) - a(n-1));

for j = 2:n-1
b_RHS(j,1) = 3/h(j)*(a(j+1) - a(j)) - 3/h(j-1)*(a(j) - a(j-1));
end
  

main_diag(1) = 2*(h(1)+h(n));  
main_diag(n) = 2*(h(n-1)+h(n));
upper_diag(1) = h(1);
lower_diag(n-1) = h(n-1);
upper_right=h(n);
lower_left=h(n);

for j = 2:n-1
    main_diag(j) = 2*(h(j-1) + h(j));
    upper_diag(j) = h(j);
    lower_diag(j-1) = h(j-1);
end

A = diag(upper_diag,1) + diag(main_diag,0) + diag(lower_diag,-1);
A(1,n)=upper_right;
A(n,1)=lower_left;

c = A\b_RHS;
% unlike natural & clamped splines, here the linear system does not include c_n
% so we need to define it:
c(end+1) = c(1); % periodic BCs mean that S''(x_n) = S''(x_0) 
% which leads to c_0 = c_n, see BF Theorem 3.11 for where this comes from
% actually for us it is c_(n+1) due to MATLAB indexes starting at 1

for j = 1:n  % unchanged, applies to all cubic splines
    d(j,1) = (c(j+1) - c(j)) / 3 / h(j);
end

for j = 1:n % unchanged, applies to all cubic splines
    b(j,1) = 1/h(j)*(a(j+1) - a(j)) - h(j)/3*(2*c(j) + c(j+1));
end

a = a(1:end-1);  c = c(1:end-1); % again these are temp values 
% only used to calculate c and d
