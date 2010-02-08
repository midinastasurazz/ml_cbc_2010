clear;
startup;
testing;

n = 10;

[totalError, percentageError, confusionM] = nFold2(examples, targets, n);

classifications = testAllTrees(trees,examples);
actualM = confusion_matrix(classifications, targets);

[recall precision fMeasure] = calculateRecallPrecision(confusionM, actualM, 1);

sprintf('Total error estimate: %d', totalError);
