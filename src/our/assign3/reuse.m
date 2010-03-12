% [solvedcase] = reuse(case, newcase)
% where case is the best-matching case previously returned by RETRIEVE and
% newcase is the novel case presented to the CBR system. REUSE attaches the
% solution of case to newcase, resulting in solvedcase.
%
function [solvedcase] = reuse( bestcase, newcase )

	% Am I missing something here??
	solvedcase.au = newcase.au;
	solvedcase.target = bestcase.target;
end
