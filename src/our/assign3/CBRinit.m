% [cbr] = CBRinit(x, y)
% where x is an [n x 45] matrix of AU examples which has the same format as the
% matrix of AUs returned by the function loaddata, and y is a vector of length
% n of labels using the same format as the labels returned by loaddata. Convert
% the input vector x to the appropriate format as described above inside this
% function.
%
% Structure of a CBR
%
% count : the number of cases in the system ( count+1 is the next free position)
% cases : a cell of cases that are in the cbr system
%
% index : if cases appear as single au's
function [cbr] = CBRinit( x, y )
	cbr.count = 0;
	cbr.cases = [];
	
	cbr.index = zeros(6, 45);	
	
	newcase = [];
	lengths = [];
	
	% loop round the examples and targets
	for i=1:length(y)
		% Create a case, and retain it in the CBR
		newcase{i} = createCase( y(i), x(i,:) );
		lengths(i) = length( newcase{i}.au );
	end
	
	[sorted, perms] = sort( lengths );
		
	for j=1:length(newcase)
		cbr = retain( cbr, newcase{perms(j)} );
	end
	
	
end 


