% clc; clear all; close all;
f=@(x) cos(2*x);
x=linspace(0,2*pi,4);
n=length(x);
y=f(x);
[a,b,c,d] = periodic_cubic_spline(x,y);
% [a,b,c,d] = clamped_cubic_spline(x,y,[0 0]);
% for j=1:n-1
%     S=@(x) a(j)+b(j).*(x-x(j))+c(j).*(x-x(j)).^2+d(j).*(x-x(j)).^3;
%     X=linspace(x(j),x(j+1),100);
%     fplot(S,[X(1) X(end)])
%     hold on
% end
X=linspace(0,2*pi,1E4);
Y=cubic_spline_interp(a,b,c,d,x,X);
figure(456); clf
plot(X,Y)
hold on
plot(x,f(x),'o')
fplot(f,[x(1) x(end)])
xlabel('x');
ylabel('y');
ylim([-1.1 1.1]);
hold off
legend('spline','points','f(x)','location','best')