
% file to test the basic finite difference method and Numerov's method

% The interval for the yubu29 version is as follows.
a=0;
b=1;

% add appropriate statements to first set the 1-line functions
% uex, q and r as described in your version of the assignment
% and do the rest of the tasks as described
% to create a table which compares the basic method
% and Numerov's methods.
uex = @(x) cos(12.1 *x)/(1.23 - x);
q = @(x) exp(-0.37*(x - 0.53)^2);
uexdd = @(x) q(x)*u(x) +r(x);
r  =@(x) uexdd(x)-q(x).*uex(x);

a = 0;
b = 1;
ua = uex(a);
ub = uex(b);
 
for k  = 2:8
    n = 2^k;
    yubu29_basic_fdm(a, b, q, r, ua, ub, n);
    disp(u);
end