function animatedPlot(y, thetahat, fs, type)

step = 2000; % frame length for animation
thetahat = thetahat';

N = floor((length(y)-step)/500); % overlap of 500 samples everytime

for i=1:1:N
    
    [PSD,norm] = pwelch(y((i-1)*250+1:i*250+step), hamming(512), 500, 256, fs);
    filt = thetahat((i-1)*500+2000,:);
    F = abs(fft(filt,129));

    plot(norm, 10*log10(PSD));
    hold on
    plot(norm, 20*log10(F));
    legend('Input Signal', 'Filter Response');
    ylim([-100,20]);
    xlim([0, 4000]);
    xlabel("Frequency (Hz)");
    ylabel("Magnitude (dB)");
    title(type)
    grid on 
    box off
    hold off

    drawnow
end