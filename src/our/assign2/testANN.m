function [ classification ] = testANN( network, inputs )
%UNTITLED1 Summary of this function goes here
%   Detailed explanation goes here
    [inputsNN, outputsNN] = ANNdata(x, y);
    t = sim(network, inputsNN);
    [classification] = NNout2labels(t);

end