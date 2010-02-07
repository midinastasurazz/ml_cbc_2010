function [classification] = testTrees(trees, examples)
    
  % 100x6 matrix, one column for each tree/emotion
  %emotionClasses = zeros(length(examples), length(trees));

  classification = zeros(length(examples), 1);

  for ex = 1:length(examples)
    for tr = 1:length(trees)
      tempRes = executeTree(trees{tr}, examples(ex,:));
      %emotionClasses(ex, tr) = tempRes;
      if(tempRes == 1)
        classification(ex) = tr;
        % we classified current example, no need to execute other trees
        continue;
      end
    end
  end
  %classification = emotionClasses;
end
