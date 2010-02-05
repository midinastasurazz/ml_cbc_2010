function confMatrix = nFold(examples, tergets, n)

N = length(examples);
foldsize = N/n

emotion_targets = cell(1, 6);
for i = 1:6
    emotion_targets{i} = remap_emotion(targets, i);
end

trees = cell(1, 6);

for count = 0:foldsize-1

testing = examples(count*n+1:(count+1)*n,:);
training = [examples(1:count*n,:) ; examples((count+1)*n+1:N,:)];

	for i = 1:6
	    trees{i} = decision_tree_learning(examples, ...
		attribs, emotion_targets{i});
	end

end

int init = 0;

while init <= N

init = init + 10

