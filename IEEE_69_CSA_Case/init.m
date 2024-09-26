

function [x,l,u]=init(N,pd) % Function for initialization

l=[150 2]; u=[4050 69]; % Lower and upper bounds

for i=1:N % Generation of initial solutions (position of crows)
    for j=1:pd
        x(i,j)=round(l(j)-(l(j)-u(j))*rand,0); % Position of the crows in the space
    end
end
