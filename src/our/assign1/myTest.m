function [classification] = myTest(trees, test)

% classify each example to an emotion using the decision trees created
% when the testind sample was not used to create the trees, some examples may be classified to more than one emotion or to none.

  classes = zeros( length(test(:,1)), length(trees) );

	classification = zeros(length(test(:,1)),1);

  for ex = 1:length(test(:,1))
    for tr = 1:length(trees)
      classes(ex, tr) = executeTree(trees{tr}, test(ex,:));
      if(executeTree(trees{tr}, test(ex,:)) == 1)
	%classification(ex) = tr;
        emolab2str(tr);
      end
    end
  end
  classification = classes;
end

function [res] = executeTree(tree, example)
  
  if (~isempty(tree.kids))
    branch = example(tree.op);
    subtree = tree.kids{branch + 1};
    res = executeTree(subtree, example);
  else
    res = tree.class; 
  end
end