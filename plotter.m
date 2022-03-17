function plotter(newFig, signal, fs, type)

    frame = 32; %64 is also ok
    frameSize = fix(frame*0.001*fs);
    if ( newFig == 1 )
        figure;
    end
    if ( strcmp(type, 'time'))
        plot(signal); 
        xlabel('Samples');ylabel('Amplitude');
    end

    if (strcmp(type, 'freq') )
        [B,f,T] = specgram(signal,frameSize*2,fs,hanning(frameSize),round(frameSize/2));
        B = 20*log10(abs(B));
        imagesc(T,f,B);axis xy;colorbar
        if ( nargin > 5 )
            title(['Spectrogram' ' - ' name]);
        end
        xlabel('Time (s)');ylabel('Frequency (Hz)'); 
        colormap jet
    end

end