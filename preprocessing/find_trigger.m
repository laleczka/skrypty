function time_ok = find_trigger(path_data, rat, file, Fs2)
    veps = [1,5,9,13];
    load([path_data, rat, '_VEP', num2str(veps(file)), '_spike.mat'])
    
    time_spike = eval([rat, '_VEP', num2str(veps(file)), '_spike_Ch32.times']);
    time_spike = round(time_spike*Fs2);
    trials_no = size(time_spike, 1);
    
    load([path_data, rat, '_VEP', num2str(veps(file)), '_D1.mat'])
    time_D1 = zeros(trials_no, 1);
    time_interval = 1.8*20000;
    stim_begin = find(D1 == 1, 1);
    time_D1(1) = stim_begin;
    stim_begin = stim_begin + time_interval;
    ind_trial = 2;
    s = stim_begin;
    while s < length(D1)
        if D1(s) == 1
            time_D1(ind_trial) = s;
            ind_trial = ind_trial + 1;
            s = s + time_interval;
        else
            s = s + 1;
        end
    end
    time_D1 = round(time_D1*(Fs2/20000)); 
    delay = time_D1(1) - time_spike(1);
    time_ok = time_spike + delay;
end