%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA117
% Project Title: Implementation of Harmony Search in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Harmony Search in MATLAB (URL: https://yarpiz.com/92/ypea117-harmony-search), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function [g_best,BestCost]=hs
format long;
%% Problem Definition

%Load_Flow = @(x) Sphere(x);        % Cost Function

nVar = 2;             % Number of Deciison Variables

VarSize = [1 nVar];   % Decision Variables Matrix Size

VarMin=[150 2];         % Lower Bound of Variables
VarMax=[4050 69];         % Upper Bound of Variables
%% Harmony Search Parameters

MaxIt = 100;     % Maximum Number of Iterations

HMS = 50;         % Harmony Memory Size

nNew = 20;        % Number of New Harmonies

HMCR = 0.9;       % Harmony Memory Consideration Rate

PAR = 0.1;        % Pitch Adjustment Rate

FW = 0.02*(VarMax-VarMin);    % Fret Width (Bandwidth)

FW_damp = 0.995;              % Fret Width Damp Ratio

%% Initialization

% Empty Harmony Structure
empty_harmony.Position = [];
empty_harmony.Cost = [];

% Initialize Harmony Memory
HM = repmat(empty_harmony, HMS, 1);

% Create Initial Harmonies
for i = 1:HMS
    HM(i).Position = unifrnd(VarMin, VarMax, VarSize);
    HM(i).Cost = Load_Flow(HM(i).Position);
end

% Sort Harmony Memory
[~, SortOrder] = sort([HM.Cost]);
HM = HM(SortOrder);

% Update Best Solution Ever Found
BestSol = HM(1);

% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);

%% Harmony Search Main Loop

for it = 1:MaxIt
    
    % Initialize Array for New Harmonies
    NEW = repmat(empty_harmony, nNew, 1);
    
    % Create New Harmonies
    for k = 1:nNew
        
        % Create New Harmony Position
        NEW(k).Position = unifrnd(VarMin, VarMax, VarSize);
        for j = 1:nVar
            if rand <= HMCR
                % Use Harmony Memory
                i = randi([1 HMS]);
                NEW(k).Position(j) = HM(i).Position(j);
            end
            
            % Pitch Adjustment
%             if rand <= PAR
%                 %DELTA = FW*unifrnd(-1, +1);    % Uniform
%                 DELTA = FW*randn();            % Gaussian (Normal) 
%                 NEW(k).Position(j) = NEW(k).Position(j)+DELTA;
%             end
        for j = 1:numel(NEW(k).Position)
    % Ensure DELTA is scalar
    DELTA = FW*randn();
    if numel(DELTA) > 1
        DELTA = DELTA(j);  % Pick the appropriate scalar value if DELTA is a vector
    end
    
    % Correct scalar assignment
    NEW(k).Position(j) = NEW(k).Position(j) + DELTA;
end

        end
        
        % Apply Variable Limits
        NEW(k).Position = max(NEW(k).Position, VarMin);
        NEW(k).Position = min(NEW(k).Position, VarMax);

        % Evaluation
        NEW(k).Cost = Load_Flow(NEW(k).Position);
        
    end
    
    % Merge Harmony Memory and New Harmonies
    HM = [HM
        NEW]; %#ok
    
    % Sort Harmony Memory
    [~, SortOrder] = sort([HM.Cost]);
    HM = HM(SortOrder);
    
    % Truncate Extra Harmonies
    HM = HM(1:HMS);
    
    % Update Best Solution Ever Found
    BestSol = HM(1);
    
    % Store Best Cost Ever Found
    BestCost(it) = BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Damp Fret Width
    FW = FW*FW_damp;
    
end
g_best=BestSol.Position;
%% Results

figure;
% plot(BestCost, 'LineWidth', 2);
semilogy(BestCost, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
