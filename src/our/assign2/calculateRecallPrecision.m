function [recall, precision, fMeasure] = ...
    calculateRecallPrecision(confusionM, fMeasureAlpha)

  % returns the recall and precision rates and the F measure calculated
  % from the confusion matrix

  sizem = length(confusionM(1, :));
  
  recall = zeros(6, 1);
  precision = zeros(6, 1);
  fMeasure = zeros(6, 1);
  
  for i = 1:sizem
    % diagonal entries are correctly identified
    truePositive = confusionM(i, i);
    
    % sum everything in the row minus diagonal entry
    % actualM(i, i)
    falseNegative = sum(confusionM(i, :)) - truePositive;

    % sum everything in the column minus diagonal entry
    falsePositive = sum(confusionM(:, i)) - truePositive;
    
    if (truePositive + falseNegative ~= 0)
      recall(i) = truePositive / (truePositive + falseNegative);
    else
      recall(i) = 1;  
    end  
    
    if (truePositive + falsePositive ~= 0)
        precision(i) = truePositive / (truePositive + falsePositive);
    else
        precision(i) = 1;
    end
    
    fMeasure(i) = (1 + fMeasureAlpha) * (precision(i) * recall(i)) ...
      / (fMeasureAlpha * precision(i) + recall(i));
  end

end
