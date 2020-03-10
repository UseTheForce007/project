function [u, x]=yubu29_numerov_fdm(a, b, q, r, ua, ub, n)
%%function [u, x]=yubu29_numerov_fdm(a, b, q, r, ua, ub, n)
%   Numerov's finite difference method for u''=q(x)*u+r(x) on [a, b]
%   with boundary conditions of ua at a and ub at b using
%   (n+1) equally spaced points x in [a, b] with x(1)=a, x(n+1)=b.
%   The inputs q and r are function handles.
%   The outputs are a column vector u of length (n+1) containing
%   the approximate solution and a column vector x of the same length
%   with the equally spaced points used.
%   
%..modify the following and add appropriate lines
x(n+1)=b;
u(n+1)=ub;
u(1)=ua;
u(n+1)=ub;
h = (b-a)/n+1;
x = [a:b:h];
c(1) = (-h^2*(r(x(i))+10*r(x(2)+r(3))/12) + ua*(1-(h^2*q(x(1))/12);
c(n) = (-h^2*(r(x(n-1)+10*r(x(n)+r(x(n+1))/12) + ub*(1-(h^2*q(x(n+1))/12);
for i = 2 : n-1
    c(i)= (-h^2*(r(x(i)+10*r(x(i+1)+r(x(i+2))/12);
    cent_diag(i) = 2 + (10*h^2 * q(x(i+1))/12;
    low_diag(i-1) = -1 + (h^2*q(x(i))/12;
    upper_diag(i-1) = -1 + (h^2* q(x(i+2))/12;
end

A = spdiags([low_diag cent_diag upper_diag],-1:1,n,n);
U = linsolve(A,c);
U = [0;U;0];
u = u';
u = U + u;
