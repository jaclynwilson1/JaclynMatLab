clc; clear all; close all;

x = [2 5 8 9 7 6 8 10 7 2];
y = [4 0.5 3 6 7 5 4 6 8 4];

clf;
plot(x,y,'o'); % plot data nodes
axis equal; grid on;  hold on;

t = linspace(0,1,length(x));

[a_x,b_x,c_x,d_x] = periodic_cubic_spline(t,x);
[a_y,b_y,c_y,d_y] = periodic_cubic_spline(t,y);

t_interp = linspace(0,1,1000);

X_interp = cubic_spline_interp(a_x,b_x,c_x,d_x,t,t_interp);
Y_interp = cubic_spline_interp(a_y,b_y,c_y,d_y,t,t_interp);

plot(X_interp,Y_interp,'r-','LineWidth',2);

hold off
legend('points','spline','location','best')