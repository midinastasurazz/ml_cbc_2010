clear;
startup;
testing;

n = 10;

[totalError, percentageError, confusionM] = nFold2(examples, targets, n);

sprintf('Total error estimate: %d', totalError);