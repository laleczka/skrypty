l_kanalow = 4;
%kanaly = [17,18,20,22];
kanaly = [1, 4, 8, 10];
ha = tight_subplot(l_kanalow,2, 0.045, [0.08 0.07], [0.18 0.18]);
x_ax = -0.2:1/250:1-1/250;
for i=1:8
axes(ha(i));
    if mod(i, 2) == 0
        plot(x_ax, mean(all_dataTrial(kanaly(i/2),:,:),3), 'linewidth', 1.1, 'color', [0 0 0])
        if i == 2
            title('B', 'fontweight','bold', 'FontSize', 13)
        end
        if i == 8
            xlabel('Czas [s]', 'FontSize', 13)
        end
        ylim([-0.75 0.75])
        xlim([-0.2 1])
    else
        plot(x_ax, all_dataTrial(kanaly((i+1)/2),:,8), 'color', [0 0 0.9]) %10 8
        hold on
        plot(x_ax, all_dataTrial(kanaly((i+1)/2),:,149), 'color', [0 0.9 0]) %151 103
        hold on
        plot(x_ax, all_dataTrial(kanaly((i+1)/2),:,240), 'color', [0.9 0 0]) %121
        if i == 1
            title('A', 'fontweight','bold', 'FontSize', 13)
        end
        if i == 7
            xlabel('Czas [s]', 'FontSize', 13)
        end
        ylabel(['CxC', num2str(kanaly((i+1)/2))],  'fontweight','bold', 'FontSize', 11)
        ylim([-2 2])
        xlim([-0.2 1])
    end
    hold off
    set(gca, 'FontSize', 12);
end
print(gcf,'-dpng','-r300', 'usrednione_CxC.png') 