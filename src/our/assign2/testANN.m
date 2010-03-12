function [ classification ] = testANN( network, inputs )
%UNTITLED1 Summary of this function goes here
%   Detailed explanation goes here
    dummyOut = ones(length(inputs));
    [inputsNN, ~] = ANNdata(inputs, dummyOut);
    t = sim(network, inputsNN);
    [classification] = NNout2labels(t);

end