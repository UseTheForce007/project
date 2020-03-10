% script to test yubu29_cube_root() and yubu29_cardano()

% angles t and radius values rm in the yubu29 version of
% the tests to do and output to show which uses 
% the function yubu29_cube_root()
m=101;
t=linspace(-pi, pi, m);
rm=[1e-59, 1, 1e+59];
% Add appropriate statements

% Randomly created values to use to compare yubu29_cardano()
% with the matlab function roots()
n=10;
rand('seed', 1839829);
ra=randi([-19, 19], n, 2);

for k=1:n
  c=ra(k, 1);
  d=ra(k, 2);
  % Add statements to get the approximate roots
  % from both methods, compare them and show the magnitude
  % of the difference between the two.
  r = yubu29_cardano(c,d);
  vg=norm(r.^3+c*r+d, inf);
  r_e = ([1 0 c d]);
  
end
