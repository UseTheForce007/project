% script to test yubu29_cube_root() and yubu29_cardano()

% angles t and radius values rm in the yubu29 version of
% the tests to do and output to show which uses 
% the function yubu29_cube_root()
m=101;
t=linspace(-pi, pi, m);
rm=[1e-59, 1, 1e+59];
% Add appropriate statements
for i = 1:3
	points=complex(cos(t).*rm(i),sin(t).*rm(i));
	
	ww=yubu29_cube_root(points,1);
	w = points.^(1/3) ;
	dif =abs(abs(ww) -abs(w));
	printf('radius r=  %4e, %d points, the relative dif=  %4e\n',rm(i),m,dif(1));
end
% Randomly created values to use to compare yubu29_cardano()
% with the matlab function roots()
n=10;
rand('seed', 1839829);
ra=randi([-19, 19], n, 2);

for k=1:n
	c=ra(k, 1);
	d=ra(k, 2);
	r=yubu29_cardano(c,d);
	vg=norm(r.^3+c*r+d, inf);
	rr = roots([1 0 c d]);
	diff_r =abs(r - rr) ;
	printf('k=  %d, c=  %d, d=%d, vg=  %4e, diff_r=  %4e\n',k,c,d,vg,diff_r);
end
