rat = 'kontrola8';
path_data = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\', rat, '\'];
files = ['1', '5', '9', '13'];

load([path_data, rat,'_VEP', files(1), '.mat'])
control = all_dataTrial;
clear all_dataTrial

load([path_data, rat,'_VEP',files(2),'.mat'])
after1h = all_dataTrial;
clear all_dataTrial

load([path_data, rat,'_VEP',files(3),'.mat'])
after2h = all_dataTrial;
clear all_dataTrial

load([path_data, rat,'_VEP13.mat'])
after3h = all_dataTrial;
clear all_dataTrial

struct = 'CxC';
Fs = 250;
os_x = -0.2:1/Fs:1-1/Fs;
channels = [2,4,6,7,8,9,10,11]; %14 i 15
%channels = 17:1:23;
%channels = 24:1:31;
%channels = 1:2:15;
figure()
ha = tight_subplot(length(channels),1, 0.03, [0.04 0.02], [0.2 0.2]);
for i=1:length(channels)
    axes(ha(i));
    plot(os_x, mean(control(channels(i), :,:),3),...
     os_x, mean(after1h(channels(i), :,:),3),...
     os_x, mean(after2h(channels(i), :,:),3),...
    os_x, mean(after3h(channels(i), :,:),3))
     
    ylim([-1 1])
    xlim([-0.2 1])
    ylabel([struct, num2str(channels(i))])
end
legend('control', 'after1h', 'after2h', 'after3h')
print( gcf,'-dpng','-r300',[rat, '_', struct, '.png']) 

% names = mv.opisy;
% tims = {'after1h', 'after2h', 'after3h'};
% nrs = [2,3,4];
% band = 13:30;
% band2 = '13-30';
% 
% for i=1:3
%     dtfs(tims{i}, nrs(i), band, band2)
% end
