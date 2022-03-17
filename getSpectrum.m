function [specSeq_ssb,freqUnit] = getSpectrum(timeSeq,sampFreq)

% @ NAME: Get Spectrum
%
% @ INPUT: timeSeq --- Time sequence
%
% @ OUTPUT: specSeq_ssb --- Single side band of spectrum

% Fast Fourier Transfer
specSeq_fft = fft(timeSeq);
specSeq_dsb = abs(specSeq_fft/length(timeSeq));
specSeq_ssb = specSeq_dsb(1:floor(length(timeSeq)/2)+1);
specSeq_ssb(2:end-1) = 2*specSeq_ssb(2:end-1);

% Get unit of frequency domain for ploting purpose
freqUnit = sampFreq*(0:(length(timeSeq)/2))/length(timeSeq);