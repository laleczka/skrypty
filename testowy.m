fs = 250;
for i = 1:8
    subplot(8, 1, i)
    %[pa, fa] = pwelch(all_dataTrial(i, :, i+32), [], [], [], 250);
%     [pf, ff] = pwelch(mean(all_dataTrial(i, :, :), 3), [], [], [], fs);
    plot(-0.2:1/250:1-1/250, mean(all_dataTrial(i, :, :),3), 'b')
    %xlim([-0.2 0.6])
    ylim([-1 1])
    title(['kana³ ', num2str(i)])
    hold off
end
% 
% [pa, fa] = pwelch(mean(alldataTrialVEP(4, :, :), 3), [], [], [], 1250);
% [pf, ff] = pwelch(mean(all_dataTrial(4, :, :), 3), [], [], [], fs);
% subplot(2,1,1)
% plot(fa,pa)
% xlim([0 60])
% %ylim([0 1e-3])
% subplot(2,1,2)
% plot(ff, pf)
% xlim([0 60])
% %ylim([0 1e-3])