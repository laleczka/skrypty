addpath(genpath('kcsd1d'));
rat = 'beta3';
path = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\', rat, '\'];
for vep=1:1
    load([path, rat, '_VEP', num2str(vep),'.mat'])
    X = 0:0.01:0.8;
    %elPos = [0.1, 0.2, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55];
    elPos = 0.1:0.1:0.7;
    %chan = [1,3,4,6,7,8,9,10]; %chan = [2,4,6,7,8,9,10,11];
    %chan = [33,35,36,37,39,40,42,45];
    %chan = [17:23];
    chan = 9:15;
    pots = zeros(length(chan), 300);
    %chan = 33:2:48;
    for i=1:length(chan)
            pots(i, :) = mean(all_dataTrial(chan(i), :, :),3) * -1;
    end
    k = kCSD1d(elPos, pots, 'X', X);
    k.estimate;
    figure;
    imagesc(k.csdEst);
    set(gca,'YTick',[12:10:81]);
    set(gca,'YTickLabel',1:1:7);
    set(gca,'XTick', 1:50:300);
    set(gca,'XTickLabel',-0.2:0.2:1);
    %colormap(a)
    grid on
    ylabel('Numer elektrody', 'FontSize', 13)
    xlabel('Czas [s]', 'FontSize', 13)
    title([rat, ' VEP', num2str(vep), ' SC'], 'FontSize', 15)
    file_name = [path, rat, '_SC_VEP', num2str(vep),'.png'];
    %print(gcf,'-dpng','-r300', file_name) 
end