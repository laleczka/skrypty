rat = 'beta3';
path_Out = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\',rat,'\DTFy_nowe\'];
path_In = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\',rat,'\nowy\'];

%load a control file
con_data = load([path_In, rat,'_VEP1.mat_mout.mat']);
chan_names = con_data.mv.opisy;
con_dtf = compute_bands(con_data);
veps = {'7','11','15'};
vep_names = {'after1h', 'after2h', 'after3h'};
band_names = {'1-4', '4-8', '8-13', '13-30'};
max_value = max(max(max(max(squeeze(con_dtf(:,:, 1,:))))));
limits = [1,0.5,0.1,0.01];
for vep=1:3
    vep_data = load([path_In, rat,'_VEP', veps{vep},'.mat_mout.mat']);
    vep_dtf = compute_bands(vep_data);
    for b=1:4
        plot_dtf(con_dtf(:,:,b,:)/max_value, vep_dtf(:,:,b,:)/max_value, chan_names, limits(b), vep_names{vep}, path_Out, band_names{b})
    end
end