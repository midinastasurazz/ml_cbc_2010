function [confM] = trainOnEverything()
    [x, y] = loaddata('cleandata_students.txt');
    [x2, y2] = ANNdata(x,y);

    PR = [0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1; 0 1;0 1];

    % size of the last layer must be 6 - number of classes
    Si = [10 6];
    TransferFs = {'tansig' 'purelin'};

    % creata a new neural network
    [net] = newff(PR, Si, TransferFs, 'trainrp');

    net.trainParam.show = 5;
    net.trainParam.epochs = 100;
    net.trainParam.goal = 0.005;
    net.trainParam.lr = 'learngdm'; % traingdm

    [net] = train(net, x2, y2);

    [classifications] = testANN(net, x2);
    [correctClassifications] = y;

    confM = zeros(6);
    confM = confusionMatrix(classifications, correctClassifications, confM);
end