% anger_target = remap_emotion(targets, 1);
% disgust_target = remap_emotion(targets, 2);
% fear_target = remap_emotion(targets, 3);
% happiness_target = remap_emotion(targets, 4);
% sadness_target = remap_emotion(targets, 5);
% surprise_target = remap_emotion(targets, 6);

emotion_targets = cell(1, 6);
for i = 1:6
    emotion_targets{i} = remap_emotion(targets, i); % return a structure that maps the targets to 0 or 1
							% depending the emotion they repsresent
end

trees = cell(1, 6);
for i = 1:6
    trees{i} = decision_tree_learning(examples, ...
        attribs, emotion_targets{i}); % creates the decision trees
%DrawDecisionTree(trees{i},emolab2str(i));
end
