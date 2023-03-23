f = @(t,y) t.^(-2).*(10.*sin(10.*t) - 2.*t.*y); % dy/dt

a = 1;  b = 2.5; % initial, final time
y0 = 2; % initial condition

n = 154 % # time steps (not counting initial condition)
h = (1.5)./n; % time step

figure(834);  clf;
t_refined = linspace(a,b,1E4); % to plot exact solution
y = @(t) (t.^(-2)).*(cos(10)-cos(10.*t)+2); % exact solution
plot(t_refined,y(t_refined),'b--','linewidth',2);
hold on

t = a:h:b; % times to calculate approximate solution w at

w = NaN(length(t), 4); % initialize approx sols with NaNs
% columns will be for Midpoint, Heun's, RK 4 

w(1,:) = y0; % start with known initial condition for all methods

for i = 2:length(t) % skip i = 1 since we already have initial condition

    
    % Midpoint:  column 1 of w
    k1 = f(t(i-1),w(i-1,1));
    k2 = f( t(i-1)+h/2 , w(i-1,1) + h/2*k1) ;
    w(i,1) = w(i-1,1) + h*k2; 

    % Heun's = Modified Euler:  column 2 of w
    k1 = f(t(i-1),w(i-1,2));
    k2 = f(t(i-1)+h, w(i-1, 2)+(k1.*h));
    w(i,2) = w(i-1, 2) + (h./2).*(k1+k2);

    % RK 4:  column 3 of w
    k1 = h.*f(t(i-1), w(i-1, 3));
    k2 = h.*f(t(i-1)+(h./2), w(i-1, 3)+(k1./2));
    k3 = h.*f(t(i-1)+(h./2), w(i-1, 3)+(k2./2));
    k4 = h.*f(t(i-1)+h, w(i-1, 3)+k3);

    w(i,3) = w(i-1,3) + (k1+2.*k2+2.*k3+k4)./6;

    %Eulers
    w(i,4) = w(i-1,4) + h.*(f(t(i-1), w(i-1,4))); % Euler's method

 

end

% plot approx. solutions
plot(t,w(:,1),'go','markersize',8,'markerfacecolor','g');  
plot(t,w(:,2),'bo','markersize',8,'markerfacecolor','b');
plot(t,w(:,3),'ro','markersize',8,'markerfacecolor','r');  
plot(t,w(:,4),'ro','markersize',8,'markerfacecolor','r');  

% spline 'em (again could use natural_cubic_spline and cubic_spline_interp instead)
w_interp = ( spline(t,w',t_refined) )'; % transpose ' flips rows to columns
plot(t_refined,w_interp(:,1),'g-');  
plot(t_refined,w_interp(:,2),'b-');
plot(t_refined,w_interp(:,3),'r-');
plot(t_refined,w_interp(:,4),'r-');

legend('exact','Midpoint Method','Heun''s Method','Runge Kutta Order 4','Euler"s Method','Location','best','fontsize',15);
set(gca,'fontsize',20);

digitsOld = digits(10);
error = vpa(abs( w(end,:) - y(b) )) % abs error at final time for each method