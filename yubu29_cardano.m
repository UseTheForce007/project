function r=yubu29_cardano(c, d)
%%function r=yubu29_cardano(c, d)
% This solves x^3+c*x+d=0 using Cardano's method to get one of the roots.
% Inputs:  c and d
% Outputs: r is a vector of length 3 containing the 3 roots 
% Replace the next line and add appropriate statements
r=[0 0 0];
p = -c/3;
dt = d^2 - 4 * p^3;
if dt >= 0
    y = max(abs(-d-sqrt(dt))/2,abs(-d+sqrt(dt))/2);
    if y >= 0 
        u = nthroot(y,3);
    else 
        u = -nthroot(-y,3);
    end
    r1 = u +p/u;
else 
    t = atan2(sqrt(abs(dt)),-d);
    r1 = 2*sqrt(p)*cos(t/3);
end
r(1) = r1;
a = 1;
b = r1;
c = c + r1^2;
d = sqrt(b^2 - 4*a*c);
r(2) = ( -b + d ) / (2*a);
r(3) = ( -b - d ) / (2*a);

