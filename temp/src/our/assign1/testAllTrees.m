function [emotionClasses] = testAllTrees(trees, examplesIn)
    
  % 100x6 matrix, one column for each tree/emotion
  emotionClasses = zeros(length(examplesIn), length(trees));
  for ex = 1:length(examplesIn(:, 1))
    for tr = 1:length(trees)
      emotionClasses(ex, tr) = executeTree(trees{tr}, examplesIn(ex,:));
    end
  end
  %classification = emotionClasses;
end