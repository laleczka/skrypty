%load('kon_imp_v2.mat')
rat = 'beta3';
vep = '15';
path_In = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\', rat, '\'];
load([path_In, rat, '_VEP',vep,'.mat_mout.mat']);
path_Out = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\obrazki\',rat,'\'];
names = mv.opisy;
nums = mv.chnss;

ha = tight_subplot(13,13,0.0,[.04 .01],[.03 .01]);
ind = 1;
for row=1:13
    for col=1:13
        axes(ha(ind));
        pcolor(squeeze(NDTF_boot(row,col,:,2,:))); shading flat; caxis([0 20]);
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

print(gcf,'-dpng','-r300',[path_Out, rat, '_VEP',vep,'.png']) 