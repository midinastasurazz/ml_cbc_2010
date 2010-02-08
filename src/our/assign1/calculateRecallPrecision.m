function [ recall, precision, fMeasure] = ...
    calculateRecallPrecision(confusionM, actualM, fMeasureAlpha)

  sizem = length(confusionM(1, :));
  recall = zeros(sizem, 1);
  precision = zeros(sizem, 1);
  fMeasure = zeros(sizem, 1);

  for i = 1:sizem
    positive = confusionM(i, i);
    % sum everything in the row minus diagonal entry
    negativer = actualM(i, i) - positive;
    recall(i) = positive / (positive + negativer);

    % sum everything in the column minus diagonal entry
    negativep = sum(confusionM(:, i)) - positive;
    precision(i) = positive / (positive + negativep);
    fMeasure(i) = (1 + fMeasureAlpha) * (precision(i) * recall(i)) ...
      / (fMeasureAlpha * precision(i) + recall(i)); 
  end
end
