rat = 'kontrola14';
path_Out = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\obrazki\',rat,'\'];
path_In = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\', rat, '\'];
data = load([path_In, rat, '_VEP1.mat']);
power_spec = zeros(300, 257);
NFFT = 2^nextpow2(300);
for trial = 1:300
    [PSD, Freq] = pwelch(data.all_dataTrial(17,:,trial), 250, 5, NFFT, 250, 'onesided');
    power_spec(trial, :) = PSD;
end
[PSD, Freq] = pwelch(mean(data.all_dataTrial(17,:,:),3),  250, 5,NFFT, 250, 'onesided');
plot(Freq, mean(power_spec(:,:),1), 'b')
hold on
plot(Freq, PSD, 'r')
xlim([0 100])