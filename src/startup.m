addpath(genpath(fullfile(pwd)));

attribs = 1:45;
[examples, targets] = loaddata('cleandata_students.txt');
% to restore default path uncomment below
% restoredefaultpath;