clc
N = 10000
s = 0.9
Ss = 0.6
fT = 2/7
Ro = 2.5
fR = 1/14
fQ = 0.01
TR = 14
E = 0.5
P = 0.2
tp=20


G = @(x) N.*E.*P./((Ro./TR).*(1-1./(Ro./(s.*fT.*TR+1+Ss)))).*(exp((Ro./TR).*(1-1./(Ro./(s.*fT.*TR+1+Ss))).*x)-1);
F = @(x) N.*G(x).*exp((Ro./TR).*(1-1./(Ro./(s.*fT.*TR+1+Ss))).*(x-tp));
figure(1)
x1 = 0:0.01:100;
x2 = 0:0.01:100;
plot(x1, G(x1))
hold on
plot(x2, F(x2))
grid on