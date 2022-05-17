function [A, B] = clean(sim,exp)
    j=1;    
    while j<=size(exp)
        if exp(j) < 313.15
            sim(j) = [];
            exp(j) = [];
        else
            j = j+1;
        end
    end
    A = sim;
    B = exp;
end