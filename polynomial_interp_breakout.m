
% try to fit this function by an interpolating polynomial by varying n_nodes
f = @(x) 1./(x.^2 +1);
x_vec = linspace(-5,5,1000);  
n_nodes = 5; % number of equally spaced nodes to base polynomial on

x_nodes = linspace(min(x_vec),max(x_vec), n_nodes); % n_nodes equally spaced nodes spanning x_vec bounds
y_nodes = f(x_nodes); % y values of original function at nodes
p = polyfit(x_nodes,y_nodes,n_nodes-1)  % outputs coefficients of interpolating polynomial of degree n_nodes-1
y_interp1 = polyval(p,x_vec); % evaluates polynomial over densely sampled x_vec for plotting
n_nodes = 7; % number of equally spaced nodes to base polynomial on

x_nodes = linspace(min(x_vec),max(x_vec), n_nodes); % n_nodes equally spaced nodes spanning x_vec bounds
y_nodes = f(x_nodes); % y values of original function at nodes
p = polyfit(x_nodes,y_nodes,n_nodes-1)  % outputs coefficients of interpolating polynomial of degree n_nodes-1
y_interp2 = polyval(p,x_vec); % evaluates polynomial over densely sampled x_vec for plotting
n_nodes = 13; % number of equally spaced nodes to base polynomial on

x_nodes = linspace(min(x_vec),max(x_vec), n_nodes); % n_nodes equally spaced nodes spanning x_vec bounds
y_nodes = f(x_nodes); % y values of original function at nodes
p = polyfit(x_nodes,y_nodes,n_nodes-1)  % outputs coefficients of interpolating polynomial of degree n_nodes-1
y_interp3 = polyval(p,x_vec); % evaluates polynomial over densely sampled x_vec for plotting

figure(38); clf
%plot(x_vec,f(x_vec),'linewidth',2); grid on % plot original function
hold on % add to plot
plot(x_vec,y_interp1,'g--','LineWidth',2); % plot nodes that polynomial goes through

plot(x_vec,y_interp2,'r--','LineWidth',2); % plot nodes that polynomial goes through

plot(x_vec,y_interp3,'b--','LineWidth',2); %  plot interpolating polynomial
hold off % stop adding
legend('n=5','n=7','n=13','Location','best','fontsize',16) % input labels in order that they were plotted