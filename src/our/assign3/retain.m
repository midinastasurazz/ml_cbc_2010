% [cbr] = retain(cbr, solvedcase)
% updates the CBR system by storing the solved case solvedcase.
% (Hint: You may wish to write a function that stores a lot of cases in the CBR
% system in one go. This functionality will enable to use the function during
% initialization as well. Think what will happen if you try to add a case to the
% CBR system that is already known to the system.
%
function [cbr] = retain( cbr, solvedcase )

	alreadyIn = 1;
	
	for i=1:cbr.count
	 	if( length( solvedcase.au ) == length( cbr.cases{i}.au ) )
			if( sum(solvedcase.au == cbr.cases{i}.au ) == length( solvedcase.au ) )
				if( solvedcase.target == cbr.cases{i}.target )
					cbr.cases{i}.typicality = cbr.cases{i}.typicality+1;
					alreadyIn = 0;
					break;
				end
			end
		end
	end
	
	if( alreadyIn == 1 )
		% Increment the available cases
		cbr.count = cbr.count+1;
	
		% Add the case
		cbr.cases{cbr.count} = solvedcase;
		
		addToIndex = 1;
	
		for j=1:length( solvedcase.au )
			if( cbr.index(solvedcase.target, solvedcase.au(j) ) == 1 )
				addToIndex = 0;
				break;
			end
		end
		
		if( addToIndex == 1 )
			for k=1:length( solvedcase.au )
				cbr.index( solvedcase.target, solvedcase.au(k) ) = 1;
			end
		end
	end
end

