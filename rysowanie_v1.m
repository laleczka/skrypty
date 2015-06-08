%path_Out = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\obrazki\',rat,'\'];

data = get_data('kontrola15', {'1','5','9','13'});
data2 = get_data('beta4', {'1','8','12','16'});

Fs = 250;
x_axis = -0.2:1/Fs:1-1/Fs;

subplot(2,1,1)
plot(x_axis, squeeze(mean(data(31, :, :, :),3)))
title('Bez stymulacji elektrycznej uœredniony kana³ LGN8', 'FontSize',15)
xlim([-0.2 1])
ylim([-0.75 1.25])
ylabel('Amplituda [uV]', 'FontSize',12)
legend('kontrola', 'po 1h', 'po 2h', 'po 3h')

subplot(2,1,2)
plot(x_axis, squeeze(mean(data2(23, :, :, :),3)))
hold on
title('Po stymulacji elektrycznej uœredniony kana³ LGN8', 'FontSize',15)
xlim([-0.2 1])
ylim([-0.75 1.25])
ylabel('Amplituda [uV]', 'FontSize',12)
xlabel('Czas [s]', 'FontSize',12)