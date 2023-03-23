
f = @(t,y) 2.*cos(t)-y; % dy/dt

a = 0;  b = 10; % initial, final time

h = 1; % time step

figure(123);  clf; 
t_refined = linspace(a,b,1E4); % to plot exact solution
y = @(t)  2^(1/2)*cos(t - pi/4); % exact solution
plot(t_refined,y(t_refined),'b-','linewidth',2); 
hold on

t = a:h:b; % times to calculate approximate solution w at
w = NaN(size(t)); % initialize approx sol with NaNs
w(1) = 1; % start with known initial condition

for i = 2:length(t) % skip i = 1 since we already have initial condition
    
    w(i) = w(i-1) + h.*(f(t(i-1), w(i-1))); % Euler's method
    % note, I've shifted indices vs lecture / BF 
    % so (i+1) --> (i) and (i) --> (i-1) here
    
end

% plot approx. solution
plot(t,w,'ro-','markerfacecolor','r','markersize',6);  grid on
legend('exact','Euler''s','Location','best','fontsize',14);

error = abs( w(end) - y(b) ) % abs error at final time