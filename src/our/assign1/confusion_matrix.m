function [confusionM] = confusion_matrix(classifications, targets)

  % 6x6 confusion matrix
  size = length(classifications(1, :));
  confusionM = zeros(size, size);  

  for t = 1:length(targets)
    row = targets(t);
    for em = 1:length(classifications(1, :))
      if (classifications(t, em) == 1)
        confusionM(row, em) = confusionM(row, em) + classifications(t, em);
        break;
      end
    end
  end
end
