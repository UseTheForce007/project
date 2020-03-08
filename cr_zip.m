function cr_zip(a, zipname, quiet)

%% cr_zip(a, zipname, quiet) creates a zip file called zipname 
%  of the cell array a
%  if nargin<3 or quiet==0 then some intermediate messages are displayed
%  a backup of the .m files in a{} is also done

  % check the input that we have a cell array of strings
  b=a(:);
  n=length(b);
  ic=iscellstr(b);
  if ic==0
    fprintf('input to %s has length %d\n', mfilename, n);
    fprintf('but it is not a cell array of strings, cannot contiue\n');
    return;
  end

  % if a 3rd argument is not given then show the messages
  if nargin<3
    quiet=0;
  end

  % check that the zip file name ends in .zip and adjust if not
  % and change any unacceptable chars in the name to _
  lzip=length(zipname);
  if lzip<5
    zipname=[zipname, '.zip'];
    lzip=length(zipname);
  end
  if zipname(lzip-3:lzip) ~= '.zip'
    zipname=[zipname, '.zip'];
    lzip=length(zipname);
    for i=1:lzip
      if char_check(zipname(i))==0
        zipname(i)='_';
      end
    end
  end
  
  % create a backup folder
  % xdone is set to 1 if this is successful
  xdone=0;
  iedir=exist('backup_assignment', 'dir');
  if iedir~=7
    x=mkdir('backup_assignment');
    if x==1
      xdone=1;
    end
  else
    xdone=1;
  end

  if xdone==1
    if quiet==0
      fprintf('Folder backup_assignment exists.\n');
    end
  else
    fprintf('Warning: failed to create folder backup_assignment\n');
  end
  
  % check which files exist using y() and warn about those which do not
  % and also get the last modified times in lm() of the .m files which
  % is used to name the backup file
  % 2 is the code for a file
  % y2 just collects the m-files as only these are backed up
  y=zeros(n, 1);
  y2=zeros(n, 1);
  lm=zeros(n, 1);
  me=0;
  mne=0;
  m_too_large=0;
  for i=1:n
    f=a{i};
    lf=length(f);

    fdet=dir(f);
    if length(fdet)>0
      y(i)=1;
      y2(i)=1;
      lm(i)=get_from_date(fdet.date);
      if f(lf-1:lf)~='.m'
        lm(i)=-1;
      end
      if f(lf-3:lf)=='.txt'
        y2(i)=0;
      end
      me=me+1;
    else
      fprintf('Warning: file %s does not exist\n', f);
      mne=mne+1;
      continue;
    end

  end

  if me==n
    if quiet==0
      fprintf('All %d files exist.\n', n);
    end
  else
    fprintf('%d file(s) exist, %d file(s) do not exist\n', me, mne);
  end

  if me==0
    fprintf('no files exist, hence no zip file created\n');
    return
  end
  
  % show the name of the most recently changed file
  % and create part of the backup file name as fpart
  [flm, ii]=max(lm);
  f=a{ii};
  fdet=dir(f);
  if quiet==0
    fprintf('Most recently changed .m file is %s with the change at %s\n',...
            f, fdet.date);
  end
  fpart=fdet.date;
  l=length(fpart);
  for k=1:l
    if fpart(k)==' ' || fpart(k)==',' || fpart(k)==';' ...
       || fpart(k)=='.' || fpart(k)==':'
      fpart(k)='_';
    end
  end
  
  % create a cell array c of the files that exist
  v=find(y);
  c=b(v);

  % create a cell array c2 for the ones to be backed-up
  v2=find(y2);
  c2=b(v2);
 
  % create the zip file 
  zip(zipname, c);
  
  % also create a backup of the zip file
  bver=['b_ver_', zipname];
  lbver=length(bver); 
  if xdone==1
    dsep='/';
    dpwd=pwd;
    kdir=find(dpwd=='\', 1);
    if length(kdir)==1, dsep='\'; end
    nam=['backup_assignment', dsep, bver(1:lbver-4), '_', fpart, '.zip'];
    lnam=length(nam);
    for i=1:lnam
      if char_check(nam(i))==0
        nam(i)='_';
      end
    end

    zip(nam, c2);
    fzipb=dir(nam);
    if quiet==0
      fprintf('%s created and has %d bytes\n', nam, fzipb.bytes);
    end
  end

end

function x=char_check(c)
% return 1 if c is a valid char for the file name
  x=1;
  if c=='/' || c=='\' || c=='.' || c=='_' 
    return
  end
  if 'a'<= c && c<='z', return, end
  if 'A'<= c && c<='Z', return, end
  if '0'<= c && c<='9', return, end
  
  x=0;
end

function n=get_from_date(a)
  % Get the number of seconds since 2000 using a date string.
  % This is needed when the datenum field is missing as in freemat.
  % It is a bit cumbersome as the different versions have different
  % formats for the date.
  
  l=length(a);
  y=0;
  mo=0;
  d=0;
  h=0;
  m=0;
  s=0;
  n=-1;
  
  % get the year
  for i=1:l-3
    u='0'<=a(i:i+3);
    v=a(i:i+3)<='9';
    if sum(u)<4 || sum(v)<4, continue, end;
    y=str2num(a(i:i+3))-2000;
    a(i:i+3)='    ';
    break;
  end
  
  % get the month number
  mons=['Jan'; 'Feb'; 'Mar'; 'Apr'; 'May'; 'Jun'; ...
        'Jul'; 'Aug'; 'Sep'; 'Oct'; 'Nov'; 'Dec'];
  for i=1:l-2
    if a(i)==' ', continue, end
    if '0'<=a(i) && a(i)<='9', continue, end
    for j=1:12
      if mons(j, :)==a(i:i+2)
        mo=j;
        a(i:i+2)='   ';
        break;
      end
    end
  end
  
  % get the hour, min and sec
  k=find(a==':', 1);
  if length(k)==0
    return;
  end
  if k<2
    return;
  end
  
  h=str2num(a(k-2:k-1));
  m=str2num(a(k+1:k+2));
  s=str2num(a(k+4:k+5));
  a(k-2:k+5)='        ';
  
  % remove anything which is not a digit that remains
  for i=1:l
    if a(i)<'0' || a(i)>'9'
      a(i)=' ';
    end
  end
  
  % any integers left should be the day of the month
  d=str2num(a);
  
  % now get the number of seconds since the start of the century
  day_sec=24*3600;
  n=s+60*m+3600*h;
  n=n+(d-1)*day_sec;
  md=[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  md4=md;
  md4(2)=md(2)+1;
  if rem(y, 4)==0
    mdu=md4;
  else
    mdu=md;
  end
  n=n+sum(mdu(1:mo-1))*day_sec;
  y4=floor(y/4);
  n=n+(365*y+y4)*day_sec;
end
