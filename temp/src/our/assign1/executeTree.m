function [res] = executeTree(tree, example)
  
  if (~isempty(tree.kids))
    branch = example(tree.op);
    % +1 as cell array is indexed from 1
    subtree = tree.kids{branch + 1};
    res = executeTree(subtree, example);
  else
    res = tree.class; 
  end
end