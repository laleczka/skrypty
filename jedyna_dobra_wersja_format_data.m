%% Jedyna s³uszna wersja!!!
rat = 'kontrola15';
% path_data = ['Z:\Home\Porowska\', rat, '\'];
% path_spike = ['Z:\Dane doœwiadczalne\eyestim\Multichannel System Data\',rat,'\'];
path_data = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\', rat, '\'];
for file=5:5%14 - number of VEPs
    %load data with frequency 1000 Hz.
          load([path_data, rat, '_VEP', num2str(file),  '_1000Hz.mat']) %contains variable all_data & D1
        %     %D1 contains analog event data
        %     load([path_data, '\',rat, '_VEP', num2str(file), '_spike.mat']) 
        %     load([path_data, '\',rat, '_VEP', num2str(file), '_D1.mat']) 
        %     trials_no = eval([rat, '_VEP', num2str(file), '_spike_Ch32.length']);
        %     min_zeros = 3e4; %minimum space between trials
        %     i = find(D1>0,1); %first trial
        %     indices = zeros(trials_no,1);
        %     indices(1) = i;
        %     i = i + min_zeros;
        %     ind = 2;
        %     %this loop finds beginnings of trials (in 20kHz freq)
        %     while ind<=trials_no
        %         if D1(i) == 0
        %             i = i + 1;
        %         else
        %             indices(ind) = i;
        %             i = i + min_zeros;
        %             ind = ind + 1;
        %         end
        %     end
        %     indices = round(indices/20); %indices of beginnings (in 1kHz freq)
    Fs = 1000;
    chan_no = length(all_data(:,1));
    %Fs2 must be a divisor of Fs
    Fs2 = 250;
    all_data2 = zeros(chan_no, length(all_data(1,:))*Fs2/Fs);
    [b,a] = butter(1, 100/(Fs/2),'low'); %Fs2*0.35 cutoff freq must be at least 0.5 of Fs2
    %w0 = 50/(Fs/2);
    %[d,c] = iirnotch(w0, w0/35);
    [d, c] = butter(1, [49.5/(Fs2/2) 50.5/(Fs2/2)], 'stop');
    [f,e] = butter(1, 1/(Fs2/2), 'high');
    for chan = 1:chan_no
        all_data(chan,:) = filtfilt(b,a,all_data(chan,:));
        all_data2(chan,:) = all_data(chan, 1:(Fs/Fs2):end);
        all_data2(chan,:) = filtfilt(d,c, all_data2(chan,:));
        all_data2(chan,:) = filtfilt(f,e, all_data2(chan,:)); 
    end
    time_D1 = round(indices*Fs2/Fs); %now indices of samples are in Fs2 freq
    
    
    time_spike = eval([rat, '_VEP', num2str(file), '_spike_Ch32.times']); %indices of sec
    time_spike = round(time_spike*Fs2); %indices of samples
    
    dif = time_D1(1) - time_spike(1); %latency
    time_ok = time_spike + dif; %spike time corrected by beginning of D1
    
    tim_on = 0.2; %time before event in sec
    tim_off = 1; %time after event in sec
    
    korekta = 0;
    all_dataTrial = zeros(chan_no, (tim_on+tim_off)*Fs2, trials_no);
    for trial=1:trials_no
        for chan=1:40
            all_dataTrial(chan, :, trial) = all_data2(chan, round(time_ok(trial)-tim_on*Fs2+korekta):round(time_ok(trial)+Fs2*tim_off-1+korekta));
        end
        korekta = korekta + 21/trials_no;     
    end
    A = all_dataTrial(1,:,1);
    B = all_dataTrial(1,:,trials_no);
    [acor,lag] = xcorr(A,B);
    [~,I] = max(abs(acor));
    lagDiff = lag(I);
    %save([path_data, rat, '_VEP', num2str(file), '.mat'],'all_dataTrial');
end
