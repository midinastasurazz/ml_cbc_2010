% function [] = noisyTest( x, y, xn, xy )
% Test decision trees, ANN and CBR, created with the clean data, with the noisy
% data.
% Return an array of F-measure 
function [ fmesDT, fmesANN, fmesCBR ] = noisyTest( x, y, xn, yn )
	
	%%%%%%%%%%%%
	%  Step 1  %
	%%%%%%%%%%%%
	
	% Decision Tree Initialization
	attribs = 1:45;
	
	for i = 1:6
    	emotion_targets{i} = remap_emotion(y, i);
	end
	
	for i = 1:6
        trees{i} = decision_tree_learning(x, attribs, emotion_targets{i});
    end
	
	% Artificial Neural Network Initialisation
	[nn ann] = trainOnEverything();
	[xn2, yn2] = ANNdata(xn,yn);
	
	% Case Based Reasoning Initialization
	cbr = CBRinit(x, y);
	
	
	%%%%%%%%%%%%
	%  Step 2  %
	%%%%%%%%%%%%
	
	% Decision Tree Testing
	classtmp 		= myTest( trees, xn );
	classtmp2		= clarify( classtmp, trees, xn );
	classifications = decisionClHelper( classtmp2 );
	treeConfM 		= confusionMatrix( classifications, yn );
	
	% Artificial Neural Network Testing
	classifications = testANN2( ann, xn2 );
    annConfM 		= confusionMatrix( classifications, yn );
	
	% Case Based Reasoning Testing
	classifications = testCBR( cbr, xn );
	cbrConfM		= confusionMatrix( classifications, yn );
	
	
	%%%%%%%%%%%%
	%  Step 3  %
	%%%%%%%%%%%%
	
	[re, pr, fmesDT] = calculateRecallPrecisionCBR(treeConfM, 1);
	[re, pr, fmesANN] = calculateRecallPrecisionCBR(annConfM, 1);
	[re, pr, fmesCBR] = calculateRecallPrecisionCBR(cbrConfM, 1);
end

% A helper function to reduce the 100x6 matrix produced by the decision tree
% algorithms to a 100x1 vector to be given to confusionMatrix()
function [classifications] = decisionClHelper( oldClass )
	classifications = zeros( length(oldClass(:,1)),1 );
	for i=1:length(oldClass(:,1))
		for j=1:length(oldClass(1,:))
			if( oldClass(i,j) == 1 )
				classifications( i ) = j;
				break;
			end
		end
	end 
end
