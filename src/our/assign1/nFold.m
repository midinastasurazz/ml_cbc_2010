function [confMatrix,fMeasure] = nFold(examples, targets, n)

% n-Fold validation

N = length(examples);
foldsize = N/n;

emotion_targets = cell(1, 6);
newemotion_targets = cell(1,6);
attribs = 1:45;

confMatrix = zeros(6);

    recall = cell(6, 1);
    precision = cell(6, 1);
    fMeasure = cell(6, 1);

for i = 1:6
    emotion_targets{i} = remap_emotion(targets, i);
end

trees = cell(1, 6);

for count = 0:foldsize-1
    
    test = examples(count*n+1:(count+1)*n,:);% the testing set
    training = [examples(1:count*n,:) ; examples((count+1)*n+1:N,:)];% the training set
    newTargets = targets(count*n+1:(count+1)*n);% the targets set
    
    for i = 1:6
        newemotion_targets{i} = [emotion_targets{i}(1:count*n) ; emotion_targets{i}((count+1)*n+1:N)];
        trees{i} = decision_tree_learning(training, ...
            attribs, newemotion_targets{i}); % the new decision trees
        %DrawDecisionTree(trees{i},emolab2str(i))
    end

    class = myTest(trees,test); % the classification
    
    newClass = clarify(class,trees,test); % the improved classification
    
    curConfusionM = confusion_matrix(newClass,newTargets);
    [recall{count+1}, precision{count+1}, fMeasure{count+1}] = ...
            calculateRecallPrecisionCBR(curConfusionM, 1);
    
    confMatrix = confMatrix + curConfusionM;
end

end
