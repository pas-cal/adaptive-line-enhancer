function delaySeq = getDelaySequence(obsSeq, tapNum, delay)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @ NAME: Get delayed sequence
% @ INPUT:  obsSeq   ----- Observed sequence
%           tapNum   ----- Order of the filter
%           delay    ----- Delay
% @ OUTPUT: delaySeq ----- Delayed sequence
% @ COMMENT: Y(n)  = [y(n) y(n-1) ... y(n-N)]
%            Yd(n) = [y(n-d) y(n-d-1) ... y(n-d-N)]
%            -> n = d
%            Yd(n) = [0 0 ... 0]
%            -> n = d+1
%            Yd(n) = [y(1) 0 ... 0]
%            -> n = d+N
%            Yd(n) = [y(N) y(N-1) ... 0]
%            -> n = d+N+1
%            Yd(n) = [ y(N+1) ... y(1)]
%            size(delaySeq) = [tapNum, obsLength] 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize parameter
obsLength = length(obsSeq);
delaySeq = zeros(tapNum, obsLength);

% Delay loop
for Ptr = 1 : length(obsSeq)

    if(Ptr > delay)
        delaySeq(2:tapNum,Ptr) = delaySeq(1:tapNum-1,Ptr-1);
        delaySeq(1,Ptr) = obsSeq(Ptr-delay);
    end

end