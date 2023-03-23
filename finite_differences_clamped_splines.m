f = @(x) cos(x);

x_left = 0;   x_right = 3*pi;    n_nodes = 10;

x = linspace(x_left, x_right, n_nodes); % nodes for spline
x_interp = linspace(x_left, x_right, 500); % interpolation points for smooth plots

figure(34); clf
plot(x_interp,f(x_interp),'k--','linewidth',2); % orig function
hold on
plot(x,f(x),'ko','markerfacecolor','k','markersize',8); % sampled nodes

% we'll now fit a clamped spline, getting the left and right endpoint derivatives using approximate derivative formulas

h = x(2) - x(1); % this can be the distance between any two consecutive nodes since they're equally spaced

% try 2-point formula   f' = ( f(x0+h) - f(x0) ) / h
% approx derivative at left endpoint, using point to right: h is positive
y_prime_approx(1) = ( f(x(2)) - f(x(1))  ) / h;
% approx derivative at right endpoint, using point to left: h is negative
y_prime_approx(2) = ( f(x(end-1)) - f(x(end))  ) / (-h); % end means the last value in indexing operations

% clamped spline using 2-pt endpoint formula
[a,b,c,d] = clamped_cubic_spline(x,f(x),y_prime_approx);
y_interp = cubic_spline_interp(a,b,c,d,x,x_interp);
plot(x_interp,y_interp,'linewidth',2); 


% try 5-point formula    f' = 1/(12h)( -25f(x0) + 48f(x0+h) -36f(x0+2h) +16f(x0+3h) -3f(x0+4h) )
% approx derivative at left endpoint, using points to right: h is positive
y_prime_approx(1) = 1./(12.*h).*( -25.*f(x_left) + 48.*f(x_left+h) -36.*f(x_left+2.*h) +16.*f(x_left+3.*h) -3.*f(x_left+4.*h) );

% approx derivative at right endpoint, using points to left:  h is negative
y_prime_approx(2) = 1./(12.*h).*( -25.*f(x_right) + 48.*f(x_right-h) -36.*f(x_right-2.*h) +16.*f(x_right-3.*h) -3.*f(x_right-4.*h) );
% clamped spline using 5-pt endpoint formula
[a,b,c,d] = clamped_cubic_spline(x,f(x),y_prime_approx);
y_interp = cubic_spline_interp(a,b,c,d,x,x_interp);
plot(x_interp,y_interp,'linewidth',2); 

legend('cos(x)','nodes','clamped spline 2-pt endpoint','clamped spline 5-pt endpoint','Location','NorthEast','fontsize',18);