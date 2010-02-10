function [ attribs ] = remap_emotion( attribs, emotion )
%REMAP_EMOTION Remap vector of emotion results
%   <emotion> => 1
%   <other> => 0

    % order of the commands matters(!)
    attribs(attribs ~= emotion) = 0;
    attribs(attribs == emotion) = 1;
end

