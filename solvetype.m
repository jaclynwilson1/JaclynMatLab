function [ans] = solvetype(method, f, a, b, n)
h = (1.5)./n;

t = a:h:b; % times to calculate approximate solution w at
w = NaN(size(t)); % initialize approx sol with NaNs
w(1) = 2; % start with known initial condition

%Eulers Method
if method == 'Eulers'

    for i = 2:length(t) % skip i = 1 since we already have initial condition
    
        w(i) = w(i-1) + h.*(f(t(i-1), w(i-1))); % Euler's method
    % note, I've shifted indices vs lecture / BF 
    % so (i+1) --> (i) and (i) --> (i-1) here
    
    end
end

%Midpoint Method
if method == 'Midpoint'
    if mod(n,2) ~= 0
        error('n must be even for Midpoint Rule');
    end

end
if method == 'Heun'

end
if method == 'Runge'

end


