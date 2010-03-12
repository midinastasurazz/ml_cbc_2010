function [ confusionM, recall, precision, fMeasure, ...
    totalR, totalP, totalF] = ...
    nFold( inputs, targets, n, trainFun)

    [inputsNN, targetsNN] = ANNdata(inputs, targets);
    
    foldsize = length(inputsNN) / n;
    
    PR = [0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1];

    % size of the last layer must be 6 - number of classes
    Si = [10 10 6];
    TransferFs = {'tansig' 'tansig', 'tansig'};

    confusionM = zeros(6, 6);
    recall = cell(6, 1);
    precision = cell(6, 1);
    fMeasure = cell(6, 1);
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
        
        % set up NN parameters
        net.trainParam.mem_reduc = 10;
        % do not show the error graph
        net.trainParam.show = NaN;
        net.trainParam.epochs = 100;
        net.trainParam.goal = 0.005;
        net.trainParam.lr = 0.5; % traingdm

        [net] = train(net, trainEx, trainTargets);

        [classifications] = testANN2(net, testEx);
        [correctClassifications] = testTargets;

        curConfusionM = confusionMatrix(classifications, correctClassifications);
        
        [recall{foldi}, precision{foldi}, fMeasure{foldi}] = ...
            calculateRecallPrecision(curConfusionM, 1);
        
        %recall{foldi} = recall_foldi;
        %precision{foldi} = precision_foldi;
        %fMeasure{foldi} = fMeasure_foldi;
        confusionM = confusionM + curConfusionM;
    end
    [totalR, totalP, totalF] = ...
        calculateRecallPrecision(confusionM, 1);    
end
