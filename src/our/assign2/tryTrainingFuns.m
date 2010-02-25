function [ recall precison fMeasure ] = tryTrainingFuns()
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
  
  for i = 1:length(funs)
    [ confusionM, recall, precision, fMeasure ] = nFold(x, y, 10, 'trainrp', actualM)
    
  end
end
