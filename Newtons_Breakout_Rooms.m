
%f = @(x)   4.*exp(-(x-1).^2)+exp(-4.*x.^2)-sin(x); % f(x)   FILL IN
%f_prime 
f = @(x) x.^3 -x.^2 -4; % derivative of f(x)   FILL IN
f_prime= @(x) 3.*x.^2 -2.*x;
x0 = 1; % initial guess, chosen based on a plot....

% first, plot f(x)
figure(1);  
fplot(f); % this is another way to plot simple functions
grid on
% can either zoom and pan using the GUI figure tools, and/or, 
%xlim([-4 4]); % put two numbers in here to set x limits
% ylim([  ]); % put two numbers in here to set y limits


% now, Newton's Method

N = 1E6;  tol = 1E-6;
clear x % prevents confusing issues if you rerun code many times and x already exists from previous run

x(1) = x0;

for i = 2:N % we already have x(1) as the initial guess
    x(i) = x(i-1) -  f(x(i-1))./f_prime(x(i-1)); % FILL IN, plugging x(i-1) into your f and f_prime functions
    if abs( ( x(i) - x(i-1) )  ) < tol
        break
    end

end

x % super lazy way to see results - just plot the list of consecutive approximations of the root



% plot the iterations (no need to modify this)
figure(2); clf
x_vec = linspace(min(-1, 0.9*min(x)),max(4,1.1*max(x)),500); % my attempt at choosing decent x limits for this problem

plot(x_vec,f(x_vec),'b','linewidth',3);
hold on
plot(x_vec,zeros(size(x_vec)),':k','linewidth',2);

for i = 1:length(x)-1
    plot(x(i),0,'bo');    hold on  % circle marker on x axis
    %      pause
    plot(x(i),f(x(i)),'ko','markerfacecolor','k'); % filled circle on curve

    plot(repmat(x(i),1,2),[0, f(x(i))],'--','linewidth',1); % vertical line between two circles
    %      pause
    plot([x(i),x(i+1)],[f(x(i)), 0], '-','linewidth',1); % tangent line intersecting x axis
    % purposely don't hold off, so we just keep adding to the plot in the loop
end
