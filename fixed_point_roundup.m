%%  CTRL Enter to run a cell
function [x_n] = fixed_point_roundup(w)
%g_1 = @(x) (-3./10).*(10.*x.^3 - 15.*x.^4+6.*x.^5)+(13./20); % fails
%g_2 = @(x) (-4./10).*(10.*x.^3 - 15.*x.^4+6.*x.^5)+(14./20);  % converges
%g_3 = @(x) (-5./10).*(10.*x.^3 - 15.*x.^4+6.*x.^5)+(15./20); % converges faster
%g_4 = @(x) (-6./10).*(10.*x.^3 - 15.*x.^4+6.*x.^5)+(16./20); % Newton's Method
%g_1 = @(x) cos(x);
%g_1 = @(x) x - (cos(x)-x)./(-sin(x)-1);
%[-1 0 0.5 0.592516367005939 0.6 0.7 1]
%g_1 = @(x) -2.*log10((0.00015./x)./3.7 + (2.51./((15.*x./0.0001).*(120.*x.*2.*32./(5280.*15.^2)).^(0.5))))-(120.*x.*32./(5280.*15.^2)).^(-0.5);
g_1 = @(x) (1./2).*((120.*x.*2.*32./(5280.*15.^2)).^(-0.5)+2.*log10((0.00015./x)./3.7 + (2.51./((15.*x./0.0001).*(120.*x.*2.*32./(5280.*15.^2)).^(0.5)))))+x;
x0 = 3.9;
x_exact = 3.937;

N = 25;  tol = 1E-10;
clear x error

x(1) = x0; % initialize x_old as initial guess

for i = 2:N
    
    x(i) = g_1( x(i-1) ); % the new estimate
    % can manually change between g_1, g_2, g_3, g_4
    
    error(i) = abs( (x(i) - x_exact)/x_exact );
    
    if abs( x(i) - x(i-1) ) < tol
        break
    end
    
end

disp(' n       x_n         rel. error   ')
disp('----------------------------------')
for kk = 1:length(x)
    fprintf(' %u   %4.4e       %4.4e  \n', kk - 1, x(kk), error(kk) )
end
disp(' ')

%%
x_vec = linspace(0, 1, 500);
figure(83)
plot(x_vec,g_1(x_vec),'linewidth',2);  hold on
plot(x_vec,g_2(x_vec),'linewidth',2);
plot(x_vec,g_3(x_vec),'linewidth',2);
plot(x_vec,g_4(x_vec),'linewidth',2);
plot(x_vec,x_vec,'k--','linewidth',2);
plot(x_vec,-x_vec,'k--','linewidth',2);     hold off
legend('g_1','g_2','g_3','g_4','y = x','location','best');
ylim([0 1]);
set(gca,'FontSize',13);
grid on
