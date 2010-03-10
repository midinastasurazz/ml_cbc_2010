function cbr = addCase(cbr, newCase)

    if cbr.count == 0
        cbr.cases = [newCase];
        return
    end
    i = 1;
    while i <= cbr.count
        if (length(cbr.cases(i).au) == length(newCase.au)) % if same number of AUs
            if cbr.cases(i).au == newCase.au
                cbr.cases(i).typicality =cbr.cases(i).typicality +1;
                break
            end

        end
        i = i+1;
    end
    if i > cbr.count
        cbr.cases = [cbr.cases newCase];
        %do something with the index
    end
    
end
