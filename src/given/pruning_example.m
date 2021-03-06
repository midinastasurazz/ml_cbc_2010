function prune_example(x,y)
    
% x: noSamples x 45 (as returned by loaddata)
% y: noSamples x 1 (as returned by loaddata)

tree = treefit(x,y,'method','classification','catidx',1:100,'splitmin',1); % Fit a tree-based model for classification
% Compute error rate for tree
% also returns the vector
% s containing the standard error of each cost value, the vector
% nodes containing number of terminal nodes for each subtree, and the
% scalar bestlevel containing the estimated best level of pruning.
[cost,s,nodes,bestLevel] = treetest(tree,'cross',x,y); %uses 10-fold cross-validation to compute the cost vector
[cost2,s2,nodes2,bestLevel2] = treetest(tree,'resubstitution'); %computes the cost of the tree T using a resubstitution method

prunedTree = treeprune(tree,'level',bestLevel);
prunedTree2 = treeprune(tree,'level',bestLevel2);

[mincost,minloc] = min(cost);
[mincost2,minloc2] = min(cost2);


plot(nodes,cost,'b-o',nodes(bestLevel+1),cost(bestLevel+1),'rs');% crossvalidation
xlabel('Tree size (number of terminal nodes)')
ylabel('Cost')
axis([0 12 0 1])
grid on
%hold all;
figure(2)
plot(nodes2,cost2,'b-o',nodes2(bestLevel2+1),cost2(bestLevel2+1),'rs');% resubstitution
%plot(nodes2,cost2,'g-o',nodes2(bestLevel2+1),cost2(bestLevel2+1),'rs');
xlabel('Tree size (number of terminal nodes)')
ylabel('Cost')
grid on
axis([0 12 0 1])

treedisp(tree)
