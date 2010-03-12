function [ averages ] = averageResultsPerFold( results )
    
    n = length(results);
    averages = zeros(n, 1);
    for i = 1:n
        averages(i) = sum(results{i}) / n;
    end
end

