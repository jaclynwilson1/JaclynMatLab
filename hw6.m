f_prime = @(x) -cos(x);
x2 = linspace(0, 3.*pi, 1000);

plot(x2, f_prime(x2))
grid on