% [case] = retrieve(cbr, newcase),
% where cbr is a non-empty CBR system, newcase a novel case without a solution
% associated to it, and case is the case that matches best with newcase
% according to the implemented similarity measure.
%
function [ caseoutput ] = retrieve( cbr, newcase )
	
	
	% works!
	bestmatch = paperAlgorithmSelection( cbr, newcase );
	
	% 85% error
	% bestmatch = vectorLengthDiff( cbr, newcase );	

	caseoutput = cbr.cases{ bestmatch };
end


% Gained 85% Accuracy on from CBRnfold method ( n=10 )
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

% Attempt to reproduce the algorithm on page 3 of
% http://www.doc.ic.ac.uk/~maja/ICME04-CBR.pdf
% read the paper first!
function [index] = paperAlgorithmSelection( cbr, newcase )
	
	%%%%%%%%%%
	% Step 1 %
	%%%%%%%%%%
	
	% Contains whether we are going to inspect emotion i or not
	clusters = zeros( 6, 1 );
	
	% vector of indices from cbr.cases that match
	best_cases = [];
	best_cases_pos = 0;
	
	% recreate the input 45 1's and 0's indicating presence or absence of an au
	newcaseAU = zeros( 45, 1 );
	
	%%%%%%%%%%
	% Step 2 %
	%%%%%%%%%%
	
	% Check to see if any of the aus in this new case are on their own in the
	% case base. If they are, mark that we are interested in them in clusters
	% we do not add the relevant cases to cases_list, we restrict the search
	% later
	for k=1:length(newcase.au)
		for em=1:6
			if( cbr.index( em, newcase.au(k) ) == 1 )
				clusters(em) = 1;
			end
		end
		% Useful for the next bit
		newcaseAU( newcase.au( k ) ) = 1;
	end
	
	%%%%%%%%%%
	% Step 3 %
	%%%%%%%%%%
		
	% Loop through all the cases in the case base
	for i=1:cbr.count
		% Check to see if we are interested in this instance
		if( clusters( cbr.cases{i}.target ) == 1 )
			for j=1:length( cbr.cases{i}.au )
				% Does the new case contain an au that is also in this case
				if( newcaseAU(cbr.cases{i}.au(j)) == 1 )
					% increment the counter ( need a ++ operator )
					best_cases_pos = best_cases_pos + 1;
					% Add it to the best cases
					best_cases(best_cases_pos) = i;
				end
			end
		end
	end
	
	%%%%%%%%%%
	% Step 4 %
	%%%%%%%%%%
	bestScore = 0;
	bestPosition = 1;
	bestTypic = 0;
	
	% loop through all the found best cases
	for m=1:best_cases_pos
		% Calculate their 'score' - higher is better...
		newscore = calculateScore( newcase.au, cbr.cases{best_cases(m)}.au );
		% get the new typicality
		newtypic = cbr.cases{best_cases(m)}.typicality;
		% check whether this is higher than what we have found previously
		% Or, is this the same and we have a higher typicality
		if ( (newscore > bestScore) || ...
				(newscore == bestScore && newtypic > bestTypic) )
			% Update the best found so far
			bestScore = newscore;
			bestPosition = m;
			bestTypic = newtypic;
		end
	end
	
	if( best_cases_pos > 0 )
		% return the index of the best case in the cbr
		index = best_cases(bestPosition);
	else
		% what to do if we don't have any best cases?
		index = 1
	end
	
	
end
