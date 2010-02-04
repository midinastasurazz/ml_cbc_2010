function [classification] = testTrees(trees, examples)

  classes = zeros( length(examples), length(trees) );

  for ex = 1:length(examples)
    for tr = 1:length(trees)
      classes(ex, tr) = executeTree(trees{tr}, examples(ex,:));
      if(executeTree(trees{tr}, examples(ex,:)) == 1)
        emolab2str(tr);
      end
    end
  end
  classification = classes;
end

function [res] = executeTree(tree, example)
  
  if (length(tree.kids) > 0)
    branch = example(tree.op);
    subtree = tree.kids{branch + 1};
    res = executeTree(subtree, example);
  else
    res = tree.class; 
  end
end
