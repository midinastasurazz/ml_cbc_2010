function [fmDT, fmANN, fmCBR] = totalTest(x,y)

[a,fmDT] = nFold(x,y,10); %desicion trees

[ a, s, d, fmANN, aa, ss, dd] = nFoldANN( x, y, 10, 'trainrp'); % ANN

[ e, ee, eee, eeee, eeeee, fmCBR] = CBRnfold( 10, x, y ); % CBR