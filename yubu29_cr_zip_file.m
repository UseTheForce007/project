function yubu29_cr_zip_file(q)
%%function ma18zyz9_cr_zip_file(q)
% This creates the zip file that you need to submit.

if nargin==0
  q=0;
end

fil={ 'yubu29_cube_root.m', 'yubu29_cardano.m', ...
      'yubu29_test_cubic_iter.m', 'yubu29_cubic_plot.m', ... 
      'yubu29_basic_fdm.m', 'yubu29_numerov_fdm.m', ...
      'yubu29_test_fdm.m', ...
      'yubu29_cr_zip_file.m', 'yubu29_check_code_output.txt' };
n=length(fil);
a=fil(1:n-1);
out_ch=fil{n};

zipname='yubu29_ma2895_1920.zip';

% set a_e as the files that exist so that zip does not fail if
% any are missing
ex_a=zeros(1, n-1);
m=0;
for k=1:n-1
  j=exist(a{k}, 'file');
  if j==2
    m=m+1;
    ex_a(m)=k;
  else
    fprintf('...warning, %s does not exist\n', a{k});
  end
end
a_ex=a(ex_a(1:m));

% create the backup as well using cr_zip if this is available
ie=exist('cr_zip.m', 'file');
if ie==2
  cr_zip(a, zipname, q);
else
  zip(zipname, a_ex);
end


% create the checkcode output if possible
fprintf('\n');
la=length(a);
ch=which('checkcode');
fp=fopen(out_ch, 'w');

if isempty(ch)
  fprintf(fp, 'No version of checkcode with your version of Matlab\n');
  fprintf('No version of checkcode with your version of Matlab\n');
else
  for i=1:la
    ia=exist(a{i}, 'file');
    if ia~=2
      fprintf('warning: no file %s to run checkcode with\n', a{i});
      continue;
    end
    w=checkcode(a{i});
    lw=length(w);
    fprintf(fp, '\n%d checkcode messages for file=%s follows:\n\n', ...
            lw, a{i});
    fprintf('%d checkcode messages for file=%s\n', ...
            lw, a{i});
    for j=1:lw
      fprintf(fp, 'L=%d, C=%d %d, %s\n', ...
              w(j).line, w(j).column, w(j).message);
    end    
  end
end

fclose(fp);

% add the checkcode output to the zip file
% set fil_ex as the files that exist so that zip does not fail
ex_fil=zeros(1, n);
m=0;
for k=1:n
  j=exist(fil{k}, 'file');
  if j==2
    m=m+1;
    ex_fil(m)=k;
  else
    fprintf('...warning, %s does not exist\n', fil{k});
  end
end
fil_ex=fil(ex_fil(1:m));

zip(zipname, fil_ex);

fprintf('\n%s contains all the output from checkcode\n', out_ch);
fprintf('\n%s is the file to submit\n', zipname);
