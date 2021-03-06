function [ bestAttribute ] = choose_attribute( attribs, examples, targets )
%CHOOSE_ATTRIBUTE Summary of this function goes here
%   Detailed explanation goes here
% choosing the best attribute using the ID3 algorithm

    positive = length(targets(targets == 1));
    negative = length(targets) - positive;
    originalGain = entropy(positive, negative);
    
    maxGain = 0;
    maxIndex = 1;

    totalAttribs = length(attribs);
    for i = 1:totalAttribs
        rem = remainder(positive, negative, attribs, examples, targets, i);
        gain = originalGain - rem;
        if (gain > maxGain)
            maxGain = gain;
            maxIndex = i;
        end
    end
    bestAttribute = attribs(maxIndex);
end

function [ e ] = entropy(p, n)
    a = p / (p + n + eps);
    b = n / (p + n + eps);
    e = abs(- a * log2(a + eps) - b * log2(b + eps));
end

function [ suma ] = remainder(positive, negative, attribs, examples, targets, index)
    % binary attributes 0..1
    attribValues = 1;
    suma = 0;
    for attributeVal = 0:attribValues
        % attribs(index) - column number
        indexSet = find(examples(:, attribs(index)) == attributeVal);
        targetsAttrib = targets(indexSet);
        %examplesi = examples(examples(:, best) == 1, :)
        %examplesAttrib = examples(indexSet, :);
        pos = length(targetsAttrib(targetsAttrib == 1));
        neg = length(targetsAttrib) - pos;
        
        suma = suma + (pos + neg) * entropy(pos, neg);
    end
    suma = suma / (positive + negative);
end
