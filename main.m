%% Initial
clc;   
[orgAudio,sampFreq] = audioread("EQ2401Project2data2022.wav");

%% Parameters define

tapNum = 50;
misadjustment = 0.1;

%% RLS Set up

tapNr = 128;
delay = 100;
lambda = 0.9999;

%% Pre-analysis

stepSize = getStepSize(orgAudio,tapNum,delay,misadjustment);

%% Filter

% LMS filter
delayLMS = 100;
[lmsThetaHat,lmsNoise] = lmsFilterxALE(orgAudio,tapNum,delayLMS,stepSize);
lmsAudio = orgAudio-lmsNoise;

% customized LMS filter
[lmsThetaHatxCtm,lmsNoisexCtm] = lmsFilterxALExCtm(orgAudio,tapNum,delayLMS,stepSize);
lmsAudioxCtm = orgAudio-lmsNoisexCtm;

% NLMS filter
mubar = stepSize;
c = 0.001;
[nlmsThetaHat,nlmsNoise,mu] = nlmsFilterxALE(orgAudio,tapNum,delayLMS,mubar,c);
nlmsAudio = orgAudio-nlmsNoise;

%RLS Filter
[rlsThetaHat, rlsAudio, pbar] = rlsFilterxALE(orgAudio,tapNr,delay,lambda);
rlsNoise = orgAudio - rlsAudio;



% Spectrum analysis

[orgSpec, orgFreqUnit] = getSpectrum(orgAudio,sampFreq);
[lmsSpec, lmsFreqUnit] = getSpectrum(lmsAudio,sampFreq);
[lmsxCtmSpec, lmsxCtmFreqUnit] = getSpectrum(lmsAudioxCtm,sampFreq);
[nlmsSpec, nlmsFreqUnit] = getSpectrum(nlmsAudio,sampFreq);
[rlsSpec, rlsFreqUnit] = getSpectrum(rlsAudio,sampFreq);

%% Play the Audio

soundsc(orgAudio);
pause(5);
soundsc(lmsAudio);
filename = 'lmsAudio.wav';
audiowrite(filename,lmsAudio,sampFreq)
pause(5);
soundsc(lmsAudioxCtm);
filename = 'backwardLmsAudio.wav';
audiowrite(filename,lmsAudioxCtm,sampFreq)
pause(5);
soundsc(nlmsAudio);
filename = 'nlmsAudio.wav';
audiowrite(filename,nlmsAudio,sampFreq)
pause(5);
soundsc(rlsAudio);
filename = 'rlsAudio.wav';
audiowrite(filename,rlsAudio,sampFreq)



%% Plot

figure(1)
subplot(3,1,1)
plot(orgAudio);
title("Original Audio")
subplot(3,1,2);
plot(lmsNoise);
title("Estimated noise")
subplot(3,1,3);
plot(lmsAudio);
title("LMS Filtered Audio")

figure(2)
subplot(3,1,1)
plot(orgAudio);
title("Original Audio")
subplot(3,1,2);
plot(lmsNoisexCtm);
title("Estimated noise")
subplot(3,1,3);
plot(lmsAudioxCtm);
title("Customized LMS Filtered Audio")

figure(3)
subplot(3,1,1)
plot(orgAudio);
title("Original Audio")
subplot(3,1,2);
plot(nlmsNoise);
title("Estimate noise")
subplot(3,1,3);
plot(nlmsAudio);
title("Normalised LMS Filtered Audio")

figure(4)
subplot(3,1,1)
plot(orgAudio);
title("Original Audio")
subplot(3,1,2);
plot(nlmsNoise);
title("Estimate noise")
subplot(3,1,3);
plot(rlsAudio);
title("RLS Filtered Audio")

figure(5)
plot(orgFreqUnit,orgSpec);
hold on;
plot(lmsFreqUnit,lmsSpec);
plot(lmsxCtmFreqUnit,lmsxCtmSpec);
plot(nlmsFreqUnit,nlmsSpec);
plot(rlsFreqUnit, rlsSpec);
legend("Original", "LMS", "Customized LMS", "NLMS", "RLS");
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Signal Power spectrum to Frequency")

figure(6)
animatedPlot(orgAudio,lmsThetaHat,sampFreq,"LMS");

figure(7)
animatedPlot(orgAudio,nlmsThetaHat,sampFreq,"Normalised LMS");

figure(8)
animatedPlot(orgAudio,rlsThetaHat,sampFreq,"RLS");


figure(9) %All 5 figures on one plot
hold on
subplot(5,2,1)
plotter(0,orgAudio,sampFreq,'freq')
subplot(5,2,2)
plotter(0,orgAudio,sampFreq,'time')
annotation('textbox', [0 0.87 1 0.1],'String', 'Noisy Input Audio', 'EdgeColor', 'none','HorizontalAlignment', 'center')

subplot(5,2,3)
plotter(0,lmsAudio,sampFreq,'freq')
subplot(5,2,4)
plotter(0,lmsAudio,sampFreq,'time')
annotation('textbox', [0 0.7 1 0.1],'String', 'ALE with LMS Audio', 'EdgeColor', 'none','HorizontalAlignment', 'center')

subplot(5,2,5)
plotter(0,lmsAudioxCtm,sampFreq,'freq')
subplot(5,2,6)
plotter(0,lmsAudioxCtm,sampFreq,'time')
annotation('textbox', [0 0.52 1 0.1],'String', 'ALE with Custom LMS Audio', 'EdgeColor', 'none','HorizontalAlignment', 'center')

subplot(5,2,7)
plotter(0,nlmsAudio,sampFreq,'freq')
subplot(5,2,8)
plotter(0,nlmsAudio,sampFreq,'time')
annotation('textbox', [0 0.35 1 0.1],'String', 'ALE with Normalised LMS Audio', 'EdgeColor', 'none','HorizontalAlignment', 'center')

subplot(5,2,9)
plotter(0,rlsAudio,sampFreq,'freq')
subplot(5,2,10)
plotter(0,rlsAudio,sampFreq,'time')
annotation('textbox', [0 0.17 1 0.1],'String', 'ALE with RLS Audio', 'EdgeColor', 'none','HorizontalAlignment', 'center')
hold on;