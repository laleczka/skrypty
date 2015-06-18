addpath(genpath('kcsd1d'));
rat = 'kontrola15';
path = ['C:\Users\L635-10K\Desktop\lic_fiz\dane\', rat, '\'];
for vep=1:1
    load([path, rat, '_VEP', num2str(vep),'.mat'])
    %chan = [33,35,36,37,39,40,42,45];
    chan = 33:48;
    l_el = length(chan);
    X = 0:0.01:(l_el+1)*0.1;
    %elPos = [0.1, 0.2, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55];
    elPos = 0.1:0.1:(l_el)*0.1;
    %chan = [1,3,4,6,7,8,9,10]; %chan = [2,4,6,7,8,9,10,11];
    
    %chan = 1:8;
    pots = zeros(length(chan), 300);
    %chan = 33:2:48;
    for i=1:length(chan)
            pots(i, :) = mean(all_dataTrial(chan(i), :, :),3) * -1;
    end
    k = kCSD1d(elPos, pots, 'X', X);
    k.estimate;
    figure;
    imagesc(k.csdEst);
    set(gca,'YTick',[12:10:(l_el+1)*10]);
    set(gca,'YTickLabel',1:1:8);
    set(gca,'XTick', 1:50:300);
    set(gca,'XTickLabel',-0.2:0.2:1);
    %colormap(a)
    grid on
    ylabel('Numer elektrody', 'FontSize', 13)
    xlabel('Czas [s]', 'FontSize', 13)
    title([rat, ' VEP', num2str(vep), ' CxI'], 'FontSize', 15)
    file_name = [path, rat, '_CxI_VEP', num2str(vep),'.png'];
    %print(gcf,'-dpng','-r300', file_name) 
end