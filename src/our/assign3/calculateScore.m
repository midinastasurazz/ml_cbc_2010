% function [score] = calculateScore(aus1, aus2)
% Calculates the number of common elements between two lists of aus recursively
% relies on the fact that the au are in order [2,5,6] and not [2,6,5]
%
function [score] = calculateScore(aus1, aus2)
	
	% fed up with typing length...
	l1 = length( aus1 );
	l2 = length( aus2 );
	
	% if either empty, we are done
	if( l1 == 0 || l2 == 0 )
		score = 0;
	% if the au1 has a greater element on front shif the au2
	elseif( aus1(1) > aus2(1) )
		score = calculateScore( aus1, aus2(2:l2 ) );
	% if the au2 has a greater element on front shif the au1
	elseif( aus1(1) < aus2(1) )
		score = calculateScore( aus1(2:l1), aus2 );
	% must have equality on the head, add one to the score, recurse on the tail
	else
		aus1 = aus1(2:l1);
		aus2 = aus2(2:l2 );
		score = 1 + calculateScore( aus1, aus2 );
	end
end
