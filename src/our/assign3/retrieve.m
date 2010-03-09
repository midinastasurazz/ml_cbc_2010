% [case] = retrieve(cbr, newcase),
% where cbr is a non-empty CBR system, newcase a novel case without a solution
% associated to it, and case is the case that matches best with newcase
% according to the implemented similarity measure.

function [ caseoutput ] = retrieve( cbr, newcase )
	
	bestmatch = vectorLengthDiff( cbr, newcase );
	
	
	caseoutput = cbr.cases{ bestmatch };
end



function [index] = vectorLengthDiff( cbr, newcase )
	
	% holds the index of the best match
	index = 0;
	% holds the lowest difference between the cbr.cases and the newcase
	bestdiff  = bitmax;	
	
	newlength = length( newcase.au );
	
	for i=1:cbr.count

		caselength = length( cbr.cases{i}.au );
		
		if ( abs(caselength - newlength) < bestdiff )
			
			bestdiff = abs( caselength - newlength );
			index = i;
		end
	end
end
