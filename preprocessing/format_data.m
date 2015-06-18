rat = 'beta4';
%path_data = ['Z:\Dane doœwiadczalne\eyestim\Multichannel System Data\',rat,'\'];
path_data = ['C:\Users\L635-10K\Desktop\lic_fiz\dane\', rat, '\'];
veps = [1,8,12,16];
for file=1:length(veps)%number of VEPs
    %load data with frequency 1000 Hz.
    Fs = 1000;
    load([path_data, rat, '_VEP', num2str(veps(file)),  '_1000Hz.mat']) %contains variable all_data
    %_spike_mat contains information about number of trials
    %here the sampling frequency is changed
    chan_no = length(all_data(:,1));
    %Fs2 must be a divisor of Fs
    Fs2 = 250;
    all_data2 = zeros(chan_no, length(all_data(1,:))*Fs2/Fs);
    [b,a] = butter(1, 100/(Fs/2),'low'); %Fs2*0.4 cutoff freq must be at least 0.5 of Fs2
    [d,c] = butter(1, [49.5/(Fs2/2) 50.5/(Fs2/2)], 'stop');    
    [f,e] = butter(1, 1/(Fs2/2), 'high');
    for chan = 1:chan_no
        all_data(chan,:) = filtfilt(b,a,all_data(chan,:));
        all_data2(chan,:) = all_data(chan, 1:(Fs/Fs2):end);
        all_data2(chan,:) = filtfilt(d,c, all_data2(chan,:));
        all_data2(chan,:) = filtfilt(f,e, all_data2(chan,:)); 
    end
    
%     time_ok = find_trigger(path_data, rat, file, Fs2);
    
    fileID = fopen([path_data, rat, '_VEP', num2str(veps(file)),'.dat']);
    A = textscan(fileID,'%f','Headerlines',1);
    fclose(fileID);
    A = A{1};
    time_ok = A(find(A==1)-1); %time in sec
    time_ok = round(time_ok*Fs2);
    
    trials_no = length(time_ok);
   
    tim_on = 0.2; %time before event in sec
    tim_off = 1; %time after event in sec
    corr = 0;
    all_dataTrial = zeros(chan_no, (tim_on+tim_off)*Fs2, trials_no);
    all_dataTrialF = zeros(chan_no, (tim_on+tim_off)*Fs2, trials_no);
    for trial=1:trials_no
        for chan=1:chan_no
            all_dataTrial(chan, :, trial) = all_data2(chan, round(time_ok(trial)-tim_on*Fs2+corr):round(time_ok(trial)+Fs2*tim_off-1+corr));
        end
        corr = corr + 0/trials_no;
    end
    save([path_data, rat, '_VEP', num2str(veps(file)), '.mat'],'all_dataTrial');
end
