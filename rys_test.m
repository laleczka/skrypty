kanaly = [1:16]; 
l_kanalow = length(kanaly);
ha = tight_subplot(l_kanalow/2, 2, 0.06, [0.08 0.07], [0.15 0.15]);
x_ax = -0.2:1/250:1-1/250;
poz = 1;
czyn1 = 0;
czyn2 = 7;
for i=1:16
        if i>8
            poz = i - czyn2;
            czyn2 = czyn2 - 1;
        else
            poz = i + czyn1;
            czyn1 = czyn1 + 1;
        end
        if i>9
            set(gca,'ytick',[])
        end
        axes(ha(poz));
        plot(x_ax, mean(all_dataTrial(i,:,:),3), 'linewidth', 1.1)
        ylabel(['CxC', num2str(i)],  'fontweight','bold', 'FontSize', 9)
        if i == 8
            xlabel('Czas [s]', 'FontSize', 13)
        end
        if i == 16
            set(gca,'ytick',[])
            xlabel('Czas [s]', 'FontSize', 13)
        end
        ylim([-0.75 0.75])
        xlim([-0.2 1])
end
%set(gca, 'FontSize', 12);

print(gcf,'-dpng','-r300', 'usrednione.png') 