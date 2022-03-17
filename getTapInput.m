function tapInput = getTapInput(obsSeq, tapNum)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @ NAME: Get Input Matrix for taps
% @ INPUT:  obsSeq   ----- Observed sequence
%           tapNum   ----- Order of the filter
% @ OUTPUT: tapInput ----- Tap Input Sequence
% @ COMMENT: Y(n) = [y(n) y(n-1) ... y(n-N)]
%            Y(1) = [y(1) 0 ... 0]
%            Y(N) = [y(N) y(N-1) ... 0]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tapInput = zeros(tapNum,length(obsSeq));
tapInput(1,1) = obsSeq(1);

for Ptr = 2 : length(obsSeq)-1
    tapInput(2:tapNum,Ptr) = tapInput(1:tapNum-1,Ptr-1);
    tapInput(1,Ptr) = obsSeq(Ptr);
end

