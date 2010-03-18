% [ totalError, percentageError, confusionM ] = CBRnfold( n, examples, targets )
% Most of this code was lifted from project1. Performs nfold on CBR with examples
% and targets. Calculates the error, percentage error and confusion matrix as
% before.

function [ totalError, percentageError, confusionM, recall, precision, fMeasure ] = CBRnfold( n, examplesin, targetsin )

	foldsize = round( length(examplesin) / n );
	
	%indexIn = 1+round( (length(examplesin)-1).*rand(foldsize*n,1) );
	indexIn = 1:foldsize*n;
	
	examples = examplesin(indexIn,:);
	targets = targetsin(indexIn,:);
	confusionM = zeros(6, 6);
    
    recall = cell(6, 1);
    precision = cell(6, 1);
    fMeasure = cell(6, 1);
	
	for fold=1:n
		index = ((fold - 1) * foldsize + 1):(fold * foldsize);
		% create testing examples
        testExamples = examples(index, :);
        testTargets = targets(index);
        % create training examples/targets by removing testing values
        trainExamples = examples;
        trainExamples(index, :) = [];
        trainTargets = targets;
        trainTargets(index) = [];
        
        cbr = CBRinit( trainExamples, trainTargets );
        
        classification = testCBR( cbr, testExamples );
        
        currentConfM = CBRconfusion_matrix(classification, testTargets);
        
        currentError = foldsize - trace(currentConfM);
        errorCount(fold) = currentError;
        
         [recall{fold}, precision{fold}, fMeasure{fold}] = ...
             calculateRecallPrecisionCBR(currentConfM, 1);
        
        confusionM = confusionM + currentConfM;
	end
	
	
	percentageError = 1 - trace(confusionM) / length(examplesin);
    totalError = sum(errorCount);
    
    [Arecall, Aprecision, AfMeasure] = ...
             calculateRecallPrecisionCBR(confusionM, 1);
    Arecall ;
    Aprecision; 
    AfMeasure;
    % The perfect output should be ...
    % CBRconfusion_matrix( targets, targets )
end


function [confusionM] = CBRconfusion_matrix(classifications, targets)

  % 6x6 confusion matrix
  confusionM = zeros(6, 6);  

  for t = 1:length(targets)
    row = targets(t);
    col = classifications(t);
    confusionM(row, col) = confusionM(row, col) + 1;
  end
end
