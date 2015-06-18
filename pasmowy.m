function pasmowy(band_dtf, names, rat, path_Out, bands, band, kan_z, kan_d, data)
    if  strcmp(rat,'beta3') || strcmp(rat,'beta4')
        war = 'po stymulacji';
    end
    if strcmp(rat,'kontrola14') || strcmp(rat,'kontrola15')
        war = 'bez stymulacji';
    end
    row = kan_d;
    col = kan_z;
    
    max_value = max(max(max(max(squeeze(band_dtf(row,col,band,:,:, 1,:))))));
%     limit = max_value * 1.2;
    
    if band == 3
        limit = 100;
    elseif  band == 2
        limit = 1000;
    else
        limit = 6e3;
    end

    x = -0.2:0.0218:1-0.0218;
    X=[x,fliplr(x)];
    ha = tight_subplot(3,1,0.07,[.15 .055],[.07 .035]);
 
    for s = 1:3
        %subplot(3,1,s)
        axes(ha(s))
        fill(X, squeeze(band_dtf(row,col,band,:,1)), 'b')
        hold on
        fill(X, squeeze(band_dtf(row,col,band,:,s+1)), 'r')
        hold on
        plot(x, squeeze(mean(data(row,col,bands.value{band},2,:,1),3)), 'LineWidth',2, 'color', [0 0 0.75])
        hold on
        plot(x, squeeze(mean(data(row,col,bands.value{band},2,:,s+1),3)), 'LineWidth',2, 'color', [0.75 0 0])
        hold off
%         if s == 1
%             title({['œredni nDTF ',war,' w paœmie ', bands.name{band},' Hz z kana³u ', names{col}, ' do kana³u ', names{row}];' '}, 'FontSize',15)
%         end
        legend('kontrola', ['po ', num2str(s), 'h'])
        xlim([-0.2 x(55)]);
        ylim([0 limit]);
        %ylabel('Amplituda', 'FontSize',12)
        alpha(0.4)
        set(gca, 'FontSize', 17);
        if band == 1
            set(gca,'YTick',[2500, 5000])
            set(gca,'YTickLabel',{'2500', '5000'})
        elseif band == 3
            set(gca,'YTick',[50 100])
            set(gca,'YTickLabel',{'50', '100'})
        end
    end
    if exist([path_Out, names{col}(1:end-1),'_', names{row}(1:end-1),'\'], 'file') == 0
        mkdir([path_Out, names{col}(1:end-1),'_', names{row}(1:end-1),'\'])
    end
    xlabel('Czas [s]', 'FontSize',20) 
    file_name = [path_Out,names{col}(1:end-1),'_', names{row}(1:end-1),'\', rat, '_', bands.name{band}, '_z_', names{col}, '_do_', names{row}, '.png'];
    print( gcf,'-dpng','-r300', file_name) 
    close
end
