startup;% sets up the directory
testing;% loads the data and created the trees
classifications = myTest(trees,examples); % classify each example to an emotion using the decision trees created
actual = confusion_matrix(classifications, targets); % creates the confurion matrix 

n = 10;

pred = nFold(examples, targets, n);% using n-Fold validation we test our trees and return the confusion matrix

[recall precision fMeasure] = ...
    calculateRecallPrecision(pred, actual, 1); % calculates the recall and precision rates and the F measures

meanError = trace(actual - pred); % calculates the error using the confusion matrices

sprintf('The error is %d%%', meanError)
