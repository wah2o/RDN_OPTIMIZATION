%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA125
% Project Title: Implementation of Cultural Algorithm in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Cultural Algorithm (CA) in MATLAB (URL: https://yarpiz.com/425/ypea125-cultural-algorithm), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function Culture = AdjustCulture(Culture, spop)

    n = numel(spop);
    nVar = numel(spop(1).Position);
    
    for i = 1:n
        if spop(i).Cost<Culture.Situational.Cost
            Culture.Situational = spop(i);
        end
        
        for j = 1:nVar
            if spop(i).Position(j)<Culture.Normative.Min(j) ...
                    || spop(i).Cost<Culture.Normative.L(j)
                Culture.Normative.Min(j) = spop(i).Position(j);
                Culture.Normative.L(j) = spop(i).Cost;
            end
            if spop(i).Position(j)>Culture.Normative.Max(j) ...
                    || spop(i).Cost<Culture.Normative.U(j)
                Culture.Normative.Max(j) = spop(i).Position(j);
                Culture.Normative.U(j) = spop(i).Cost;
            end
        end
    end

    Culture.Normative.Size = Culture.Normative.Max-Culture.Normative.Min;
    
end