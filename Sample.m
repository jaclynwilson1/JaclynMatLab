%Function Sample(a,b) is declared with a and b as parameters and it returns
%the value of p
%this function is a bisection to find a root of f(x) in the interval [a,b]
function [p_history] = Sample(a,b)

%assigns value to tol as tolerace, which is used as a parameter that we
%must have found the root if the distance between a and b is less than this
%value
tol = 1E-10;
%assigns 25 to the variable 25 which is the number of iterations the
%function will perform at maximum
N0 = 25;

%assigns x^3+4x^2 - 9 to F as a function of x
%F = @(x)(x.^3 + 4*x.^2 -9);
%F = @(x)(1/2.*x.^3 + 12.*x + 2);
%F = @(x)(cos(x)-(1./4)+sin(x));
%     2.178527832031250e+00 is the smallest positive root
%F = @(x)(sin(x)-exp(-x));
%5.885620117187500e-01 is the smallest amount
f = @(x) 120.*x.*2.*32./(5280.*15.^2);
%F = @(x) -2.0.*log10((0.00015./x)./3.7 + (2.51./((15.*x./0.0001)(120.*x.*2.*32./(5280.*15.^2)).^(0.5))))-(120.*x.*2.*32./(5280.*15.^2)).^(-0.5));
F = @(x) -2.0.*log10((0.00015./x)./3.7+2.51./((15.*x./0.0001).*(f(x).^(0.5)))) - f(x).^(-0.5);


%calculates and assings F(a) to FA
FA = F(a);
%calculates and assigns F(b) to FB
FB = F(b);

%if the sign (+/-) of FA and FB are the same we make the user choose a
%different interval
if sign(FA)*sign(FB) > 0
    disp(' ')
    %displays a message that the interval choosen has the same signs and in
    %order to proceed the user needs to select a new interval
    disp(['f(',num2str(a),') and f(',num2str(b),') have the same sign.'])
    disp('Try a different interval.')
    disp(' ')
    return;
end

%initiate three arrays to store the history of the values of a, b, and p
a_history = []; b_history = []; p_history = [];

%initialize i = 1 so we can iterate over the method
i = 1;

%iterate through the while loop until i is 25, else we stop
while i <= N0
    %assign p to the calculated midpoint in interval (a,b)
    p = a + (b-a)/2;
    %assign FP to F(p) which is the value of the function with x = p
    FP = F(p);
    
    %add the current values of a, b, and p to the existing arrays at index
    %i 
    a_history(i) = a;  b_history(i) = b;  p_history(i) = p;

    %if the value of FP is equivalent to 0 OR (b-a)/2 (which is half the
    %distance between a and b) is less than tol, meaning the interval is
    %very very small and close to 0, we beak the loop and declare p a root
    if FP == 0 || (b-a)/2 < tol%check if FP (f(p)) is equivalent to 0
        break;
    end
    
    %iterate by adding 1 to i
    i = i + 1;
    
    %if the sign (+/-) of FA and FP are the same sign
    if sign(FA)*sign(FP) > 0
       %assign p to a, so the new interval is (p,b)
        a = p; 
        %assign FP to FA for the new interval
        FA = FP;
    else%if the sign are different
        %assign p to b, so the new interval is (a,p)
        b = p;
        %assign FP to FB for the new interval
        FB=FP;
    end%end this set of conditionals
    
end%end the while loop

%we print that the root is the p value we found and the error is calculated
%as the halfway distance between the current values of a and b
disp(' ')
disp(['The root is ',num2str(p,11),' with a possible error of ',num2str((b-a)/2)])
disp(' ')

if i > N0%if we run through the whole iteration to i=26 without fiding a root
    %then we display that the method did not find the root
    disp(['The method did not meet the'])
    disp(['tolerance ',num2str(tol),' after ',num2str(N0),' iterations']),
    disp(' ')
end
%below prints a table showing the history of the values we tested for
%bisection
format long e,
disp(' n       a_n           p_n            b_n         F(p_n)         ')
disp('----------------------------------------------------------------------')
for kk = 1:length(p_history)
    fprintf(' %u   %11.8f   %11.8f   %11.8f   %11.8f   \n', kk, a_history(kk), p_history(kk), b_history(kk), F(p_history(kk)) )
end
disp(' ')

%sets the interval of the x values we are plotting
x_1=0:0.01:10;
%plots the function F(x) over x_1 interval that shows the approximate
%location of the root which is -0.16647434235
plot(x_1, F(x_1));
grid on
hold on
%plot(p,F(p),'r*')  % marking the approximate location of the root


