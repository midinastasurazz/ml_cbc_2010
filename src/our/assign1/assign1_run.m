startup;
testing;
classifications = testTrees(trees,examples);
actual = confusion_matrix(classifications, targets);

n = 10;

pred = nFold(examples, targets, n);

[recall precision fMeasure] = ...
    calculateRecallPrecision(pred, actual, 1);

meanError = trace(actual - pred);

sprintf('The error is %d%%', meanError)
