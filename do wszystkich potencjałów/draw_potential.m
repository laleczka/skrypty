function draw_potential(response,time, channels, struction, file_name)
figure()
ha = tight_subplot(length(channels),1, 0.05, [0.1 0.02], [0.2 0.2]);
%ha = tight_subplot(length(channels),1, 0.05, [0.3 0.3], [0.05 0.05]);
x_ax = -0.2:1/250:1-1/250;
C = {[0.0 0.0 0.0],[0 0 0.9],[0 0.9 0],[0.9 0 0]};
for i=1:length(channels)
    axes(ha(i));
    for j=1:length(response(1,1,:))
        plot(x_ax, response(channels(i), :, j), 'color', C{j}, 'linewidth', 1.1)
        set(gca, 'FontSize', 12);
        hold on
    end
    hold off
    if strcmp(struction, 'CxC')
        ylabel([struction,num2str(channels(i))], 'fontweight','bold', 'FontSize', 12)
        ylim([-2.75 2.75])
    end
    if strcmp(struction, 'SC')
        ylabel([struction,num2str(channels(i)-8)])
        %ylabel([struction,num2str(channels(i)-16)])
        ylim([-2.75 2.75])
    end
    if strcmp(struction, 'LGN')
        ylabel([struction,num2str(channels(i)-15)])
        %ylabel([struction,num2str(channels(i)-23)])
        ylim([-1 1])
    end
    if strcmp(struction, 'CxI')
        %ylabel([struction,num2str(channels(i)-24)])
        ylabel([struction,num2str(channels(i)-32)])
        ylim([-2 2])
    end
    xlim([-0.2, 1])
    %ylim([-1.5 1.5])
end
xlabel('Czas [s]', 'FontSize', 12)
legend(time)
print( gcf,'-dpng','-r300', file_name) 
%close all
end