function [ confusionM, recall, precision, fMeasure ] = ...
    nFold( inputs, targets, n, trainFun, actualM)

    [inputsNN, targetsNN] = ANNdata(inputs, targets);
    
    foldsize = length(inputsNN) / n;
    
    confusionM = zeros(6, 6);
    PR = [0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1; 0 1;0 1];

    % size of the last layer must be 6 - number of classes
    Si = [10 10 6];
    TransferFs = {'tansig' 'tansig', 'tansig'};
    for foldi = 1:n
        index = ((foldi - 1) * foldsize + 1):(foldi * foldsize);
        testEx = inputsNN(:, index);
        testTargets = targets(index);
        % remove testing examples
        trainEx = inputsNN;
        trainEx(:, index) = [];
        trainTargets = targetsNN;
        trainTargets(:, index) = [];

        % create a new neural network
        % trainrp - fast
        [net] = newff(PR, Si, TransferFs, trainFun, 'learngdm', 'mse');

        net.trainParam.mem_reduc = 10;
        net.trainParam.show = NaN;
        net.trainParam.epochs = 10;
        net.trainParam.goal = 0.005;
        net.trainParam.lr = 'learngdm'; % traingdm

        [net] = train(net, trainEx, trainTargets);

        [classifications] = testANN2(net, testEx);
        [correctClassifications] = testTargets;

        confusionM = confusionM + confusionMatrix(classifications, correctClassifications); 
    end
    [recall precision fMeasure] = calculateRecallPrecision(confusionM, actualM, 1);
end
