function signal = obrob(data, sample_rate)
    % Filtorwanie dolnoprzepustowe "na dwa razy"
    [b,a] = butter(2, 2000/(sample_rate/2), 'low');

    temp = filtfilt(b, a, data);
    temp = temp(1:4:end);

    sample_rate2 = sample_rate/4;

    [d,c] = butter(2, 1250/(sample_rate2/2), 'low');
    temp2 = filtfilt(d, c, temp);
    temp2 = temp2(1:5:end);
    
    Fs = sample_rate2/5;

    % Normalizacja
    signal = (temp2 - mean(temp2))/std(temp2);
    
    %Filtr wycinaj¹cy zanieczyczenia od sieci
    w0 = 50/(Fs/2);
%     [b,a] = iirnotch(w0, w0/35);
%     temp4 = filtfilt(b,a, temp3);

    %filtr górnoprzepustowy usuwaj¹cy efekt 'p³yniêcia'
%     [d,c] = butter(1, 1/(Fs/2), 'high');
%     signal = filtfilt(d,c,temp3);
end