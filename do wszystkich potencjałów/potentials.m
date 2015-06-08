rat = 'kontrola15';
path_Out = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\', rat, '\'];
path_In = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\', rat, '\'];
% veps = {'1','7','11', '15'};
veps = {'1', '9', '13', '14'};
data = load([path_In, rat, '_VEP1.mat']);
[chan_no, samp_no, trial_no] = size(data.all_dataTrial);
response = zeros(chan_no, samp_no, 4);
response(:,:,1) = mean(data.all_dataTrial(:,:,:),3);
for vep = 2:4
    %for chan = 1:chan_no
    data = load([path_In, rat, '_VEP',veps{vep},'.mat']);
    response(:,:,vep) = mean(data.all_dataTrial(:,:,:),3);
end
time = {'control', 'after1h', 'after2h', 'after3h'};

%channels = {[1,3,4,6,7,8,9,10], 17:23, 24:31, [33,35,36,37,39,40,42,45]}; %kontrola15
channels = {1:3, 9:15, 16:23, 25:32};
struction = {'CxC', 'SC', 'LGN', 'CxI'};
for s=1:4
    file_name = [path_Out, rat, '_',struction{s}, '.png'];
    draw_potential(response,time, channels{s}, struction{s}, file_name)
end