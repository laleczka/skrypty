function dtfs(NDTF_boot_control, time, nr, band, band2, zakres)
    ha = tight_subplot(13,13,0.0,[.04 .01],[.03 .01]);
    ind = 1;
    x = 1:1:55;
    X=[x,fliplr(x)];
    figure();
    for row=1:13
        for col=1:13
            axes(ha(ind));

            tmp_con_low = squeeze(NDTF_boot_control(row,col,:,1,:));
            tmp_con_high= squeeze(NDTF_boot_control(row,col,:,3,:));
            
            load(['C:\Users\L635-10K\Desktop\lic_fiz\szczury\kontrola15\', 'kontrola15_VEP',num2str(nr),'.mat_mout.mat'])
            names = mv.opisy;

            tmp_a1h_low = squeeze(NDTF_boot(row,col,:,1,:));
            tmp_a1h_high = squeeze(NDTF_boot(row,col,:,3,:));

            con_l = mean(tmp_con_low(band,:),1);
            con_h = mean(tmp_con_high(band,:),1);

            a1h_l = mean(tmp_a1h_low(band,:),1);
            a1h_h = mean(tmp_a1h_high(band,:),1);

            Y1=[con_l,fliplr(con_h)];
            Y2=[a1h_l,fliplr(a1h_h)];

            fill(X,Y1,'b');
            hold on
            fill(X,Y2, 'r');
            xlim([1 55]);
            ylim([0 zakres])
            alpha(0.5)

            set(ha,'xtick',[],'ytick',[]);
            if col == 1
                title1 = strcat(names(row));
                ylabel(title1)
            end
            if row == 13
                xlabel(names(col));
            end      
            ind = ind + 1;
        end
    end
    legend('control', time)
    print( gcf,'-dpng','-r300',['C:\Users\L635-10K\Desktop\lic_fiz\szczury\obrazki\kontrola15\', time, '_', num2str(band2), '.png']) 
    close all
end