function [ totalError, percentageError, confusionM ] = ...
    nFold2( examples, targets, n )
%NFOLD2 Summary of this function goes here
%   Detailed explanation goes here

    foldsize = length(examples) / n;
    emotion_targets = cell(1, 6);
    for i = 1:6
        emotion_targets{i} = remap_emotion(targets, i);
    end
    
    confusionM = zeros(6, 6);
    attribs = 1:45;
    errorCount = 1:n;
    for foldi = 1:n
        index = ((foldi - 1) * foldsize + 1):(foldi * foldsize);
        testEx = examples(index, :);
        testTargets = targets(index);
        % remove testing examples
        trainEx = examples;
        trainEx(index, :) = [];

        trees = cell(1, 6);
        for i = 1:6
            trainTargets = emotion_targets{i};
            trainTargets(index) = [];
            trees{i} = decision_tree_learning(trainEx, ...
                attribs, trainTargets);
        end
        classification = testAllTrees(trees, testEx);
        currentConfM = confusion_matrix(classification, testTargets);
        
        currentError = foldsize - correctlyIdentified(currentConfM);
        errorCount(foldi) = currentError;
        
        confusionM = confusionM + currentConfM;
        %classes = testTrees(trees, testEx);
    end
    percentageError = 1 - correctlyIdentified(confusionM) / length(examples);
    totalError = sum(errorCount) / n;
end

function [ correctlyIdentified ] = correctlyIdentified( confusionM )
    correctlyIdentified = trace(confusionM);
end