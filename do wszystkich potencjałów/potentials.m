rat = 'beta3';
path_Out = ['C:\Users\L635-10K\Desktop\lic_fiz\dane\', rat, '\'];
path_In = ['C:\Users\L635-10K\Desktop\lic_fiz\dane\', rat, '\'];
veps = {'1','7','11', '15'};
%veps = {'1', '5', '9', '13'};
%veps = {'1', '8', '12', '16'};
%channels = {[1, 3,5,6]};
%channels = {[17,18,20,22]};
channels = {[16:16+7]};
%channels = {[1,4,8,10]};
struction = {'LGN'};
time = {'kontrola', 'po 1h', 'po 2h', 'po 3h'};
data = load([path_In, rat, '_VEP1.mat']);
[chan_no, samp_no, trial_no] = size(data.all_dataTrial);
response = zeros(chan_no, samp_no, 4);
response(:,:,1) = mean(data.all_dataTrial(:,:,:),3);
for vep = 2:length(veps)
    data = load([path_In, rat, '_VEP',veps{vep},'.mat']);
    response(:,:,vep) = mean(data.all_dataTrial(:,:,:),3);
end
% for v = 1:length(veps)
%     tmp_res = squeeze(response(channels{1},:,v));
%     save([path_Out, rat, '_sredni_VEP',num2str(veps{v}),'.mat'], 'tmp_res')
% end
for s=1:length(struction)
    file_name = [path_Out, rat, '_',struction{s}, '.png'];
    draw_potential(response,time, channels{s}, struction{s}, file_name)
end
