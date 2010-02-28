
[x, y] = loaddata('cleandata_students.txt');
[x2, y2] = ANNdata(x,y);

PR = [0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
      0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
      0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
      0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;
      0 1;0 1;0 1;0 1;0 1];

% number of neurons per layer
% size of the last layer must be 6 - number of different classes
Si = [10 10 6];

[net] = newff(PR, Si);

% display error each 5 epochs
net.trainParam.show = 5;
net.trainParam.epochs = 100;
% target error
net.trainParam.goal = 0.001;
net.trainParam.lr = 'learngdm';

[net] = train(net, x2, y2);

[predictedClassifications] = testANN(net, x2);
confM = zeros(6);
[confM] = confusionMatrix(predictedClassifications, y2, confM);