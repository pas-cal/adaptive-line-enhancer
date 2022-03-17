function mu = getStepSize(obsSeq, tapNum, delay, misadjustment)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @ NAME: Get Boundary step size for Stable system
% @ INPUT:  obsSeq           ----- Observed sequence
%           misadjustment    ----- Misadjustment
%           tapNum           ----- Tap number
%           delay            ----- Delay
% @ OUTPUT: mu               ----- Step size
% @ COMMENT :  
%                   mu*N*varY   
%              M = -------------
%                       2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize

mun = zeros(length(obsSeq),1);

% Get Y

Y = getDelaySequence(obsSeq, tapNum, delay);

for n = 1 : length(obsSeq)

    % Get observe signal power

    varY = var(Y(:,n));

    % Get mu

    mun(n) = misadjustment*2/tapNum/varY;

end

mu = min(mun);

