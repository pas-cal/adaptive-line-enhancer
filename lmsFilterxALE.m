function [thetahat, xhat] = lmsFilterxALE(obsSeq,tapNum,delay,stepSize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @ NAME: LMS Filter with ALE technique
% @ INPUT:  obsSeq   ----- Observed sequence
%           tapNum   ----- Order of the filter
%           delay    ----- Delay
% @ OUTPUT: thetahat ----- LMS estimator
%           xhat     ----- Estimated sequence
% @ COMMNET: Adaptive Linear Enhancer
%            Cancel correlation of unperiodic voice signal by delaying
%                 -----------------------------------------
%                 |                                       |
% s(n) -- (+) -- y(n) -- delta(d) -- y(n-d) -- Filter -- (-) -- nphat(n)
%          |                                     |        |  
%        np(n)                                   ------- e(n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize

M = length(obsSeq);
thetahat = zeros(tapNum,M);
xhat = zeros(M,1);
Y = getDelaySequence(obsSeq,tapNum, delay);

% Get tap input
x = obsSeq;

% Loop
for n = 1 : M-1

    % Estimate
    xhat(n) = Y(:,n).'*thetahat(:,n);
    % Eigenvalue analysis
    R = Y(:,n)*Y(:,n)';
    lambda = max(eig(R));
    delta = (2/lambda)-stepSize;
    if(delta < 0)
        warning("LMS Unstable");
    end

    % Update thetahat
    thetahat(:,n+1) = thetahat(:,n)+stepSize*Y(:,n).*(x(n+1)-xhat(n));

end


