

function [ totalError, percentageError, confusionM ] = CBRnfold( n, examples, targets )

	foldsize = length(examples) / n;
	confusionM = zeros(6, 6);
	
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
        
        confusionM = confusionM + currentConfM;
	end
	
	
	percentageError = 1 - trace(confusionM) / length(examples);
    totalError = sum(errorCount) / n;
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
