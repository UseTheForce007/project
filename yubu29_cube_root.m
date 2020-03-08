function ww=yubu29_cube_root(zz, out)
%%function ww=yubu29_cube_root(zz, out)
% This computes the principal cube root of zz.
% If out~=0 then intermediate output of the iteration can be shown
% but otherwise no intermediate output is displayed.
% The output ww is such that ww(k) is the principal cube root of zz(k).

% get z with 0.5<=abs(z)<=4 such that zz=(8^e)*z;
[~, ez]=log2( abs(zz) );
e=floor(ez/3);
z=zz./(2.^(3*e));

if nargin==1
  out=0;
end

% Modify the next non-comment statements 
% and add appropriate statements to attempt to obtain w
% approximately satisfying w^3-z=0
% and finally set ww from w
ww=ones( size(zz) );
w=ones( size(zz) );
