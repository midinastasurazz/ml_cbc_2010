% [cbr] = retain(cbr, solvedcase)
% updates the CBR system by storing the solved case solvedcase.
% (Hint: You may wish to write a function that stores a lot of cases in the CBR
% system in one go. This functionality will enable to use the function during
% initialization as well. Think what will happen if you try to add a case to the
% CBR system that is already known to the system.
%
function [cbr] = retain( cbr, solvedcase )

	% TODO: Check whether the case already exists in the system	
	
	% Increment the available cases
	cbr.count = cbr.count+1;
	
	% Add the case
	cbr.cases{cbr.count} = solvedcase;
	
	if( length( solvedcase.au ) == 1 )
		cbr.index( solvedcase.target, solvedcase.au(1) ) = 1;
	end
end

