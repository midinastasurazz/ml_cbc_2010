function [ fMeasure ] = tryTrainingFuns()
%UNTITLED1 Summary of this function goes here
%   Detailed explanation goes here
  funs = {
    'trainbfg',
    'trainbr',
    'trainc',
    'traincgb',
    'traincgf',
    'traincgp',
    'traingd',
    'traingda',
    'traingdm',
    'traingdx',
    'trainlm',
    'trainoss',
    'trainr',
    'trainrp',
    'trainscg'};

  n = length(funs);
  fMeasure = zeros(n, 1);
  [x y] = loaddata('cleandata_students.txt');
  for i = 1:n
    [ ~, ~, ~, ~, ~, ~, fMeasure(i) ] = nFold(x, y, 10, funs{i});
  end
end
