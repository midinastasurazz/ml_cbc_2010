function [fmDT, fmANN, fmCBR] = totalTest(x,y)

[a,fmDT] = nFold(x,y,10); %desicion trees

[ a, s, d, fmANN, aa, ss, dd] = nFoldANN( x, y, 10, 'trainrp'); % ANN

[ e, ee, eee, eeee, eeeee, fmCBR] = CBRnfold( 10, x, y ); % CBR


fmDT_con = convert(fmDT);
fmANN_con = convert(fmANN);
fmCBR_con = convert(fmCBR);

h = zeros(0,18);

alpha = 0.05;

%ttest
for k = 1:length(fmDT_con)
    h(k) = ttest2(fmDT_con{k},fmANN_con{k},alpha);
    h(length(fmDT_con)+k) = ttest2(fmDT_con{k},fmCBR_con{k},alpha);
    h(2*length(fmDT_con)+k) = ttest2(fmANN_con{k},fmCBR_con{k},alpha);
end

h

p = zeros(0,6);

%anova
for l = 1:length(fmDT_con)
    temp = [fmDT_con{l} ; fmANN_con{l} ; fmCBR_con{l}];
    p(l) = anova1(temp','','off');
    
end

p

end

function con = convert(init)
%con = cell(6, 1);
for i=1:length(init)
    for j = 1:length(init{i})
        con{j}(i) = init{i}(j);
    end
end
end