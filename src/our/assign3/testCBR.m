% y = testCBR(CBR, x),
% which takes your train CBR system and the features x as returned by loaddata
% and produces a vector of label predictions y in the format of loaddata..

function [y] = testCBR( cbr, x )

	% loop over the inputted cases
	for i=1:length( x(:,1) )
		% create a case based on the input
		thiscase = createCase( 0, x(i,:) );
		
		% search for a bestmatch in the cbr
		bestmatch = retrieve( cbr, thiscase );
		
		% Set the target of thiscase to be that of the bestmatch
		thiscase = reuse( bestmatch, thiscase );
		
		% set the return vector to have the computed target value
		y(i) = thiscase.target; % = bestmatch.target... 
	end
end
