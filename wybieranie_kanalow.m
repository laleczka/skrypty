channels = 1:16;
figure()
ha = tight_subplot(length(channels)/2,2, 0.07, [0.1 0.02], [0.15 0.15]);
x_ax = -0.2:1/250:1-1/250;
ind_a = 7;
ind_b = 0;
for i=1:length(channels)
    if mod(i,2) == 0
        axes(ha(i));
        plot(x_ax, mean(all_dataTrial(channels(i+ind_a), :, :),3))
        ylabel(['CxC',num2str(i+ind_a)])
        if i == 16
            xlabel('Czas [s]', 'FontSize', 12)
        end
        ind_a = ind_a - 1;
    else
        axes(ha(i));
        plot(x_ax, mean(all_dataTrial(channels(i-ind_b), :, :),3))
        ylabel(['CxC',num2str(i-ind_b)])
        if i == 15
            xlabel('Czas [s]', 'FontSize', 12)
        end
        ind_b = ind_b + 1;
    end
    xlim([-0.2 1])
    ylim([-1 1])
end
print( gcf,'-dpng','-r300', '16_kanalow.png') 