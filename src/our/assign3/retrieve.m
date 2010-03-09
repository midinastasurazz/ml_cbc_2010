% [case] = retrieve(cbr, newcase),
% where cbr is a non-empty CBR system, newcase a novel case without a solution
% associated to it, and case is the case that matches best with newcase
% according to the implemented similarity measure.
%
function [ caseoutput ] = retrieve( cbr, newcase )
	
	
	% Doesn't work...
	% bestmatch = paperAlgorithmSelection( cbr, newcase );
	
	% 85% accuracy? based on little but luck... need to try noisy data
	bestmatch = vectorLengthDiff( cbr, newcase );	
	
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
	
	% loop through all the found best cases
	for m=1:best_cases_pos
		% Calculate their 'score' - higher is better...
		newscore = calculateScore( newcase.au, cbr.cases{best_cases(m)}.au );
		% check whether this is higher than what we have found previously
		if ( newscore > bestScore )
			bestScore = newscore;
			bestPosition = m;
		end
	end
	
	% return the index of the best case in the cbr
	index = best_cases(bestPosition);
end

% relies on the fact that the au are in order [2,5,6] and not [2,6,5]
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
