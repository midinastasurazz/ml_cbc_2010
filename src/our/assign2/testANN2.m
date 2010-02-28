function [ classification ] = testANN2( network, inputs )

    t = sim(network, inputs);
    [classification] = NNout2labels(t);

end
