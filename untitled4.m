syms x_sym y_sym
for x = 0:0.0001:1
    if (x > 0 && x <= 1)
        y_sym = @(x) x + 5;
        % Other processing as desired. Also result can be back converted from symbol type to
        % double number type as 
        % y = double(subs(y_sym, x_sym, x));
    if x ==0:
        y_sym = @(x) 0;

    end
end



y_sym(0)