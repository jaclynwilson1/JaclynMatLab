function [x,c] = GQ_nodes_weights(n)
%
% This script is for computing definite integrals using Legendre-Gauss
% Quadrature. Computes the Legendre-Gauss nodes x and weights c on the 
% standard interval [-1, 1] with n function evaluation points

% The approximate integral of f from -1 to 1 is then sum( f(x) .* c )
% assuming f is vectorized e.g. using .*, ./, .^ operators.

% Adapted from code by Greg von Winckel - 02/25/2004

n=n-1;
N1=n+1; N2=n+2;
xu=linspace(-1,1,N1)';
% Initial guess
x=cos((2*(0:n)'+1)*pi/(2*n+2))+(0.27/N1)*sin(pi*xu*n/N2);
% Legendre-Gauss Vandermonde Matrix
L=zeros(N1,N2);
% Derivative of LGVM
Lp=zeros(N1,N2);
% Compute the zeros of the N+1 Legendre Polynomial
% using the recursion relation and the Newton-Raphson method
x0=2;
% Iterate until new points are uniformly within epsilon of old points
while max(abs(x-x0))>eps
    
    
    L(:,1)=1;
    Lp(:,1)=0;
    
    L(:,2)=x;
    Lp(:,2)=1;
    
    for k=2:N1
        L(:,k+1)=( (2*k-1)*x.*L(:,k)-(k-1)*L(:,k-1) )/k;
    end
    
    Lp=(N2)*( L(:,N1)-x.*L(:,N2) )./(1-x.^2);
    
    x0=x;
    x=x0-L(:,N2)./Lp;
    
end

% Compute the weights
c = 2./((1 - x.^2).*Lp.^2)*(N2/N1)^2;
