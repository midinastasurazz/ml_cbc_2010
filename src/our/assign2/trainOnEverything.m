function [confM net] = trainOnEverything()
    [x, y] = loaddata('cleandata_students.txt');
    [x2, y2] = ANNdata(x,y);

    PR = [0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
          0 1;0 1;0 1; 0 1;0 1];

    % size of the last layer must be 6 - number of classes
    Si = [10 10 6];
    TransferFs = {'tansig' 'tansig' 'tansig'};

    % creata a new neural network
    [net] = newff(PR, Si, TransferFs, 'trainrp');

    net.trainParam.mem_reduc = 10;
    net.trainParam.show = NaN;
    net.trainParam.epochs = 100;
    net.trainParam.goal = 0.005;
    net.trainParam.lr = 0.05; % traingdm

    [net] = train(net, x2, y2);

    [classifications] = testANN2(net, x2);
    [correctClassifications] = y;

    confM = confusionMatrix(classifications, correctClassifications);
end
