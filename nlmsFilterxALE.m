function [thetahat,xhat,mu] = nlmsFilterxALE(obsSeq,tapNum,delay,mubar,c)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @ NAME: NLMS Filter with ALE technique
% @ INPUT:  obsSeq   ----- Observed sequence
%           tapNum   ----- Order of the filter
%           delay    ----- Delay
%           mubar    ----- mubar
%           c        ----- c
% @ OUTPUT: thetahat ----- NLMS estimator
%           xhat     ----- Estimated sequence
%           mu       ----- Step size
% @ COMMNET:             mubar
%            mu(n) = ---------------
%                     c + ||Y(n)||^2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize

thetahat = zeros(tapNum,length(obsSeq));
xhat = zeros(length(obsSeq),1);
mu = zeros(length(obsSeq)-1,1);

% Get Y(n)

Y = getDelaySequence(obsSeq,tapNum,delay);

% x

x = obsSeq;

% Loop

for n = 1 : length(obsSeq)-1

    % Get Signal power
    PY = Y(:,n)'*Y(:,n)/tapNum;

    % Get normalized stepsize mu
    mu(n) = mubar/(c+PY);

    % Estimate

    xhat(n) = Y(:,n)'*thetahat(:,n);
    
    % Update thetahat
    
    thetahat(:,n+1) = thetahat(:,n)+mu(n)*Y(:,n+1)*(x(n+1)-Y(:,n+1)'*thetahat(:,n));

end

