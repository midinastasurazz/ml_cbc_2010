function [error] = calculateError(matrix)

  error = zeros(6, 1);

  for i = 1:length(matrix)
    for j = 1:length(matrix)
      if (i ~= j)
        error(i) = error(i) + matrix(i, j);
      end
    end
  end
end
