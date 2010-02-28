addpath(genpath(pwd));
% start up the code. Adds everything to the directory 
% to restore default path uncomment below
% restoredefaultpath;

% assign1
%attribs = 1:45;
%[examples, targets] = loaddata('cleandata_students.txt'); % loads the data

%assign2
[x, y] = loaddata('cleandata_students.txt'); % loads the data
[x2, y2] = ANNdata(x,y);

