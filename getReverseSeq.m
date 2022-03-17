function revSeq = getReverseSeq(fowSeq)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @ NAME : Get Reversed Sequence
% @ INPUT : fowSeq  ---- Forward Sequence
% @ OUTPUT : revSeq ---- Reversed Sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

revSeq = zeros(length(fowSeq),1);

for ctr = 1 : length(fowSeq)
    revSeq(ctr) = fowSeq(end-ctr+1);
end