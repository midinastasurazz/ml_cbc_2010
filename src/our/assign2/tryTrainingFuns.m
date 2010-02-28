function [ recall precision fMeasure ] = tryTrainingFuns()
%UNTITLED1 Summary of this function goes here
%   Detailed explanation goes here
  funs = {
%    'trainbfg',
    'trainbr',
%    'trainc',
    'traincgb',
%    'traincgf',
%    'traincgp',
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
  recall = zeros(n, 1);
  precision = zeros(n, 1);
  fMeasure = zeros(n, 1);
  actualM = trainOnEverything();
  [x y] = loaddata('cleandata_students.txt');
  for i = 1:n
    i
    [ confusionMi, recalli, precisioni, fMeasurei ] = nFold(x, y, 10, funs{i}, actualM);
    recall(i, 1) = recalli;
    precision(i, 1) = precisioni;
    fMeasure(i, 1) = fMeasurei;
  end
end
