function [y_interp] = cubic_spline_interp(a,b,c,d, x_nodes, x_interp)
% input spline coefficients a, b, c, d and original data nodes x,
% and locations to interpolate x_interp
% output interpolated function values y_interp

for i = 1:length(x_interp) % go one by one through each interpolated point requested
    for j = 1:length(x_nodes)-1 % step through each spline piece to figure out which piece x_interp(i) is in
        if x_interp(i) >= x_nodes(j) && x_interp(i) <= x_nodes(j+1) % if x_interp(i) is within spline piece j,
            y_interp(i) =  a(j) + b(j).*(x_interp(i)-x_nodes(j))+c(j).*(x_interp(i)-x_nodes(j)).^2 + d(j).*(x_interp(i)-x_nodes(j)).^3;  % evaluate the cubic polynomial for spline piece j at x_interp(i)
            break % no point checking all the other intervals, we already found the right one
        end
    end
    
    % the current requested x might not be between any of the data nodes
    % not a good idea to extrapolate a spline in the "real world" but we will here for instructive purposes,
    % using the first and last cubic polynomial pieces
    
    if x_interp(i) < x_nodes(1) % extrapolating before first node, use first piece
        y_interp(i) = a(1) + b(1)*(x_interp(i) - x_nodes(1)) + c(1)*(x_interp(i) - x_nodes(1))^2 + d(1)*(x_interp(i) - x_nodes(1))^3; % evaluate the cubic polynomial for
        % the first spline piece
        
    elseif x_interp(i) > x_nodes(end) % extrapolating after last node, use last piece
        y_interp(i) = a(end) + b(end)*(x_interp(i) - x_nodes(end-1)) + c(end)*(x_interp(i) - x_nodes(end-1))^2 + d(end)*(x_interp(i) - x_nodes(end-1))^3; % evaluate the cubic polynomial for
        % the last spline piece
        
    end
    
    
    
end