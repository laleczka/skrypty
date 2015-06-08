rat = 'kontrola15';
path_Out = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\obrazki\',rat,'\'];
path_In = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\', rat, '\'];
load([path_In, 'kontrola15_VEP1.mat_mout.mat'])
NDTF_boot_control = NDTF_boot;

times = {'after1h', 'after2h', 'after3h'};
veps = [5, 9, 13];
bands = {[1:4], [4:8], [8:13], [13:30]};
bands2 = {'1-4', '4-8', '8-13', '13-30'};
zakresy = [1e5, 1e5, 1e5];

for band = 1:4
    for vep = 1:3
        dtfs(NDTF_boot_control, times{vep}, veps(vep), bands{band}, bands2{band}, zakresy(vep))
    end
end