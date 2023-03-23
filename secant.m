clear 
clc

f = @(x) 120.*x.*2.*32./(5280.*15.^2);
%F = @(x) -2.0.*log10((0.00015./x)./3.7 + (2.51./((15.*x./0.0001)(120.*x.*2.*32./(5280.*15.^2)).^(0.5))))-(120.*x.*2.*32./(5280.*15.^2)).^(-0.5));
F = @(x) -2.0.*log10((0.00015./x)./3.7+2.51./((15.*x./0.0001).*(f(x).^(0.5)))) - f(x).^(-0.5);

%f=@ (x) x*x*x-4*x-9;
%Write your function f(x), where f(x)=0.
% Root lies between in the interval (x0, x1).
x0=1; %here x0=2
x1=8;%here x1=3
tol=1E-10; %error of tolerance you want. 
w(1) = x1;
i = 2;
if F(x0)*F(x1)>0 
    disp('Enter valid interval !!!');
    return
else
err=abs(x1-x0);
fprintf('\n x0 \t\t x1 \t\t f(x0) \t\t f(x1)');
fprintf('\n %11.8f \t %11.8f \t %11.8f \t %11.8f',x0,x1,F(x0),F(x1));
while err > tol
    x2=(x0*F(x1)-x1*F(x0))/(F(x1)-F(x0));
    x0=x1;        
    x1=x2;
    err=abs(x1-x0);
    root=x2; 
    w(i) = x1;
    i = i+1;
    fprintf('\n %11.8f \t %11.8f \t %11.8f \t %11.8f',x0,x1,F(x0),F(x1));
end
    fprintf('\n The root is %11.8f ',root);
end