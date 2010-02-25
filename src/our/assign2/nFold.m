function [ confusionM ] = nFold( inputs, targets, n )

    [inputsNN, targetsNN] = ANNdata(inputs, targets);
    
    foldsize = length(inputsNN) / n;
    
    confusionM = zeros(6, 6);
    PR = [0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1; 0 1;0 1];

    % size of the last layer must be 6 - number of classes
    Si = [34 6];
    TransferFs = {'logsig' 'purelin'};
    for foldi = 1:n
        index = ((foldi - 1) * foldsize + 1):(foldi * foldsize);
        testEx = inputsNN(:, index);
        testTargets = targets(index);
        % remove testing examples
        trainEx = inputsNN;
        trainEx(:, index) = [];
        trainTargets = targetsNN;
        trainTargets(:, index) = [];

        % creata a new neural network
        % trainrp - fast but inaccurate
        [net] = newff(PR, Si, TransferFs, 'trainrp');

        net.trainParam.mem_reduc = 10;
        net.trainParam.show = 1000;
        net.trainParam.epochs = 100;
        net.trainParam.goal = 0.001;
        net.trainParam.lr = 'learngdm'; % traingdm

        [net] = train(net, trainEx, trainTargets);

        [classifications] = testANN(net, testEx);
        [correctClassifications] = testTargets;

        confusionM = confusionMatrix(classifications, correctClassifications, confusionM); 
    end
end
