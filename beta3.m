% %files = cell(16,1);
% for f=1:6
%     file_name =  ['kontrola24_VEP',num2str(f)];
%     wczytaj_mcrack(file_name)
% end
% % 
% wczytaj_mcrack('kontrola9_VEP1')

% trials = 200;
% min_zeros = 3e4;
% i = find(D1>0,1);
% indices = zeros(trials,1);
% indices(1) = i;
% i = i + min_zeros;
% ind = 2;
% while ind<=trials
%     if D1(i) == 0
%         i = i + 1;
%     else
%         indices(ind) = i;
%         i = i + min_zeros;
%         ind = ind + 1;
%     end
% end
% Fs = 1000;
% korekta = 0;
% all_dataTrial = zeros(40, 1.2*Fs, trials);
% for trial=1:trials
%     for chan=1:40
%         all_dataTrial(chan, :, trial) = all_data(chan, round(time_ok(trial)-0.2*Fs+korekta):round(time_ok(trial)+Fs*1-1+korekta));
%     end
%     korekta = korekta + 225/Fs;
% end
% il = zeros(30,1);
% Fs2 = 250;
% korekta = 0;
% all_dataTrial = zeros(chan_no, (tim_on+tim_off)*Fs2, trials_no);
% for trial=1:trials_no
%     for chan=1:40
%         all_dataTrial(chan, :, trial) = all_data2(chan, round(time_ok(trial)-tim_on*Fs2+korekta):round(time_ok(trial)+Fs2*tim_off-1+korekta));
%     end
%     korekta = korekta + 21/trials_no;%21
% end
% 
% A = mean(all_dataTrial(4,:,:),3);
% B = mean(alldataTrialVEP(4,1:5:end,:),3);
% 
% [acor,lag] = xcorr(A,B);
% [~,I] = max(abs(acor));
% lagDiff = lag(I)
% 
% c=32;
% figure();
% plot(alldataTrialVEP(c,:,1),'b')
% hold on
% plot(alldataTrialVEP(c,:,100),'g')
% hold on
% plot(alldataTrialVEP(c,:,200),'y')
% hold on
% plot(alldataTrialVEP(c,:,300),'r')
% legend('1', '100', '200', '300')
%dobre_CxC = [2,4,6,7,8,9,10,11];
dobre = [2,4,6,7,8,9,10,11];
figure();
ha = tight_subplot(8,1,0.055,[0.05 0.05],[0.2 0.2]);
for i=1:8
    %subplot(8,1,i)
    axes(ha(i));
    plot(mean(all_dataTrial(dobre(i),:,:),3))
    title(['CxC',num2str(dobre(i))])
    %hold on
    %plot(mean(alldataTrialVEP(i,:,:),3), 'r')
    ylim([-1 1])
end
