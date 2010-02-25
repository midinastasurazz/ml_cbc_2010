function [ confM ] = confusionMatrix( predictions, correctClassifications, confM )

    n = length(predictions);   
    for i = 1:n
        row = correctClassifications(i);
        col = predictions(i);
        confM(row, col) = confM(row, col) + 1;
    end
    
end