
load ciliate_path.mat
% you will now have X, Y, Z available as variables
% these are vectors containing the 3D coordinates of the ciliate over time

figure(358);  clf;
plot3(X,Y,Z,'o'); % plot data nodes
axis equal; grid on;  hold on;
view([-51 19]); % sets 3D view

% here you need to define a parameter t corresponding with each coordinate
% typically t linearly increases from 0 at the first coordinate
% to 1 at the last coordinate (hint: use linspace)
t =

% then fit 3 separate natural cubic splines to X(t), Y(t), and Z(t)
[a_x,b_x,c_x,d_x] =
[a_y,b_y,c_y,d_y] =
[a_z,b_z,c_z,d_z] =


% finally, evaluate each spline at many values of t between 0 and 1,
% generating X_interp, Y_interp, Z_interp
t_vec = linspace(0,1,1000);

X_interp =
Y_interp =
Z_interp =


% and plot the interpolated coordinates with a line
plot3(X_interp,Y_interp,Z_interp,'r-','LineWidth',2);

hold off