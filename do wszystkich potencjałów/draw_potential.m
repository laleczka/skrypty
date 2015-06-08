function draw_potential(response,time, channels, struction, file_name)
figure()
ha = tight_subplot(length(channels),1, 0.03, [0.04 0.02], [0.2 0.2]);
x_ax = -0.2:1/250:1-1/250;
C = {[0.0 0.0 0.0],'b','r','g'};
for i=1:length(channels)
    axes(ha(i));
    for j=1:length(response(1,1,:))
        plot(x_ax, response(channels(i), :, j), 'color', C{j})
        hold on
    end
    hold off
    if strcmp(struction, 'CxC')
        ylabel([struction,num2str(channels(i))])
        ylim([-2 2])
    end
    if strcmp(struction, 'SC')
        ylabel([struction,num2str(channels(i)-8)])
        ylim([-2 2])
    end
    if strcmp(struction, 'LGN')
        ylabel([struction,num2str(channels(i)-15)])
        ylim([-1 1])
    end
    if strcmp(struction, 'CxI')
        ylabel([struction,num2str(channels(i)-24)])
        ylim([-1.5 1.5])
    end
    xlim([-0.2, 1])
    %ylim([-1.5 1.5])
end
legend(time)
print( gcf,'-dpng','-r300', file_name) 
%close all
end