function plot_dtf(con_dtf, vep_dtf, chan_names,limit, vep_name, path_Out, band_name)
    x = 1:1:55;
    X=[x,fliplr(x)];
    
    ha = tight_subplot(13,13,0.0,[.04 .01],[.03 .01]);
    ind = 1;
    figure();
    for row = 1:13
        for col=1:13
            axes(ha(ind));
            fill(X, squeeze(con_dtf(row,col,1,:)), 'b')
            hold on
            fill(X, squeeze(vep_dtf(row,col,1,:)), 'r')
            xlim([1 55]);
            ylim([0 limit]);
            alpha(0.5)
            set(ha,'xtick',[],'ytick',[]);
            if col == 1
                title1 = strcat(chan_names(row));
                ylabel(title1)
            end
            if row == 13
                xlabel(chan_names(col));
            end      
            ind = ind + 1;
        end
    end
    legend('control', vep_name)
    if exist([path_Out, '\',band_name], 'file') == 0
        mkdir([path_Out, '\', band_name])
    end
    print( gcf,'-dpng','-r300', [path_Out, '\', band_name,'\', vep_name, '_', band_name, '.png']) 
    close all
end