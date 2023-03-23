function [G_out] = G(x_vec)
for i = 1:length(x_vec)
    x = x_vec(i);
    if x == 0
        G_out(i) = 0;
    else % can be lazy and not include requirement that a < x <= b
        P_4 = 1 - ((x.^2)./2) + ((x.^4)./24) ;
        G_out(i) = ( cos(x) - P_4 ) / (x).^(1/2);
    end
end
end