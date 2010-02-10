function newClass = clarify(class, trees, test)

len = zeros(1,6);
termNodes = zeros(1,6)
for k=1:length(trees)
    len(k) = getTreeLen(trees{k})-1;
termNodes(k) = getTermNodes(trees{k})
end

newClass = class;
minDepth = 100;
maxDepth = 0;
bestChoise = 1;
for i = 1:length(class)
    if (sum(class(i,:))>1)
        for j = 1:length(class(i,:))
            if(class(i,j) == 1)
                depth = findDepth(trees{j},test(i,:));
%                 if (depth < minDepth)
%                     minDepth = depth;
%                     bestChoise = j;
%                 end
                if (depth > maxDepth)
                    maxDepth = depth;
                    bestChoise = j;
                end
            end
        end
        newClass(i,:) = 0;
        newClass(i,bestChoise) = 1;
    end
    if (sum(class(i,:))==0)
        for j = 1:length(class(i,:))
            depth = findDepth(trees{j},test(i,:));
            if (depth < minDepth)
                minDepth = depth;
                bestChoise = j;
            end
%             if (depth > maxDepth)
%                 maxDepth = depth;
%                 bestChoise = j;
%             end
        end
        newClass(i,bestChoise) = 1;
    end
    
end

end

function depth = findDepth(tree, example)
if (~isempty(tree.kids))
    branch = example(tree.op);
    subtree = tree.kids{branch + 1};
    depth = findDepth(subtree, example) + 1;
else
    depth = 1;
end
end

function len = getTreeLen(tree)
if (~isempty(tree.kids))
    subtree1 = tree.kids{1};
    subtree2 = tree.kids{2};
    len = 1+ max (getTreeLen(subtree1),getTreeLen(subtree2));
else
    len = 1;
    
end

end


function nodes = getTermNodes(tree)
if (~isempty(tree.kids))
    subtree1 = tree.kids{1};
    subtree2 = tree.kids{2};
nodes = getTermNodes(subtree1)+getTermNodes(subtree2);
else
nodes = 1;
end

end
