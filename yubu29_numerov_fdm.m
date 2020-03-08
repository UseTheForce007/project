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
