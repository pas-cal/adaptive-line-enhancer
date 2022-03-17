function [thetahat, xhat] = lmsFilterxALExCtm(obsSeq,tapNum,delay,stepSize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @ NAME: LMS Filter with ALE technique
% @ INPUT:  obsSeq   ----- Observed sequence
%           tapNum   ----- Order of the filter
%           delay    ----- Delay
% @ OUTPUT: thetahat ----- LMS estimator
%           xhat     ----- Estimated sequence
% @ COMMNET: Backward LMS + Forward LMS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Do Forward LMS
[fxThetahat, fxAudio] = lmsFilterxALE(obsSeq,tapNum,delay,stepSize);
% Get reversed sequence
obsRevSeq = getReverseSeq(obsSeq);
% Do Backward LMS
[bxThetahat, bxRevAudio] = lmsFilterxALE(obsRevSeq,tapNum,delay,stepSize);
% Revers back
bxAudio = getReverseSeq(bxRevAudio);
% Get maximum
xhat = (fxAudio+bxAudio)/2;
% ThetaHat
thetahat = [fxThetahat;bxThetahat];

