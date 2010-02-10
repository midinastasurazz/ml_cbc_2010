startup;
testing;
classifications = testTrees(trees,examples);
actual = confusion_matrix(classifications, targets);

n = 10;

pred = nFold(examples, targets, n);

meanError = trace(actual - pred);

sprintf('The error is %d%%', meanError)
