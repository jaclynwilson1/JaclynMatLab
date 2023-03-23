%% 
% $$\begin{array}{l}\frac{\mathrm{dS}}{\mathrm{dt}}=-\beta \mathrm{SA}-\beta 
% \mathrm{SI}-\mathrm{ES}\\\frac{\mathrm{dA}}{\mathrm{dt}}=\beta \mathrm{SA}+\beta 
% \mathrm{SI}-f_S A-f_R A-{\mathrm{sf}}_T A+\mathrm{ES}\\\frac{\mathrm{dI}}{\mathrm{dt}}=f_S 
% A-f_R I-f_Q I\\\frac{\mathrm{dQ}}{\mathrm{dt}}=f_Q I+{\mathrm{sf}}_T A-f_R Q\\\frac{\mathrm{dR}}{\mathrm{dt}}=f_R 
% \left(Q+I+A\right)\end{array}$$

close all;
fR = 1/14;
fS = (0.6).*fR;
s = 0.9;
fQ = 0.2;
fT = 2/7;
beta = 0.2;
E = 10;
clc;
format long;
%step 1: define the equations
f = @(t, y) [-beta.*y(1).*y(2)-beta.*y(1).*y(3)-y(1).*E; beta.*y(1).*y(2)+beta.*y(1).*y(3)-y(2).*fR-y(2).*fS-y(2).*s.*fT+y(1).*E; y(2).*fS-y(3).*fQ-fR.*y(3); fQ.*y(3)+y(2).*s.*fS-y(4).*fR; fR.*(y(4)+y(3)+y(2))];
[x,y] = explicit_euler(f,[0,100],[1000;0;0;0;0],0.1) % Calling Euler function
plot(x,y);
title('When Time Step is 10');
legend('s(t)', 'a(t)', 'i(t)', 'q(t)', 'r(t)')
xlabel('t')
ylabel('Solutions')

[x, y]
%%
function [x, y] = explicit_euler( f, xRange, y_initial, h )
% This function uses Euler’s explicit method to solve the ODE
% dv/dt=f(t,v); x refers to independent and y refers to dependent variables
% f defines the differential equation of the problem
% xRange = [x1, x2] where the solution is sought on
% y_initial = column vector of initial values for y at x1
% numSteps = number of equally-sized steps to take from x1 to x2
% x = row vector of values of x
% y = matrix whose k-th column is the approximate solution at x(k)
    x(1) = xRange(1);
    numSteps = ( xRange(2) - xRange(1) ) /h ;
    y(:,1) = y_initial(:);
    for k = 1 : numSteps
        x(k + 1) = x(k) + h; 
        y(:,k+1) = y(:,k) + h * f( x(k), y(:,k) );
    end
end