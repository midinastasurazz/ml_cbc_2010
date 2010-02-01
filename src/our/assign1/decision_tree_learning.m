function [ tree ] = decision_tree_learning( examples, attribs, targets )
%DECISION_TREE_LEARNING Generate a decision tree using ID3 algorithm
%   Detailed explanation goes here

    nt = length(targets);
    
    firstVal = targets(1);
    allSame = 1;
    for i = 1:nt
        if (firstVal ~= targets(i))
            allSame = 0;
            break;
        end
    end
    
    % create tree structure    
    if (allSame == 1)
        % return leaf node with label of the classification
        %tree.op = '';
        tree.kids = [];
        tree.class = targets(1);
        %tree.class = emolab2str(targets(1));
    elseif (length(attribs) == 0)
        % no more attributes to check
        % return leaf node with the most frequent element of (targets)
        %tree.op = '';
        tree.kids = [];
        tree.class = majority_value(targets);
    else
        best = choose_attribute(attribs, examples, targets);
        %attribute for this node
        tree.op = best;  
        %as attributes are binary, create cell array 1x2
        tree.kids = cell(1, 2);
        %tree.class = '';
        % binary attributes
        for attributeVal = 1:2
            %tree.kids{i} = 5;         
            % column best
            indexSet = find(examples(:, best) == attributeVal);
            %examplesi = examples(examples(:, best) == 1, :)
            examplesSubtree = examples(indexSet, :);
            targetsSubtree = targets(indexSet);
            if (isempty(examplesSubtree))
                % if no more examples don't recurse, return a leaf
                %tree.op = '';
                tree.kids = [];
                tree.class = majority_value(targets);
            else
                tree.kids{i} = decision_tree_learning( ...
                    examplesSubtree, ...
                    attribs(attribs ~= best), ...
                    targetsSubtree);
            end          
        end
    end
end