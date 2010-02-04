function [confusionM] = confusion_matrix(classifications, targets)

  confusionM = zeros( 6, 6 );  

  for t = 1:length(targets)
    row = targets(t);
    for em = 1:length(classifications(1, :))
      confusionM(row, em) = confusionM(row, em) + classifications(t, em);
    end
  end
end
