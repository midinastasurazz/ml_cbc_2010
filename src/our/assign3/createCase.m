% [case] = createCase( target, aus )
% 
% Create a case based on the target and aus given
%
% ---Structure of a Case---
%
% target : the target of a case = which emotion it represents 1-6
%			- if the target is 0, it is a new case!
% au 	 : a vector of au's that make up the case - e.g. [9,12,35]
%			- always in ascending order due to the createCase method
%
function [newcase] = createCase( target, aus )

	newcase.target = target;
	newcase.au = [];
	
	pos = 1;
	
	for i=1:length( aus )
		if( aus( i ) > 0 )
			newcase.au( pos ) = i;
			pos = pos + 1;
		end
	end
end

