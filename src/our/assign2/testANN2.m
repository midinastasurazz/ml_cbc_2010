function [ classification ] = testANN2( network, inputs )
%UNTITLED1 Summary of this function goes here
%   Detailed explanation goes here;
    t = sim(network, inputs);
    [classification] = NNout2labels(t);

end
