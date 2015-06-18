function [data, names] = get_data2(rat, veps)
    path_In = ['C:\Users\L635-10K\Desktop\lic_fiz\dane\', rat, '\'];
    load([path_In, rat, '_VEP1.mat_mout.mat']);
    a = size(NDTF_boot);
    data = zeros(a(1), a(2), a(3), a(4), a(5), 4);
    data(:,:,:,:,:,1) = NDTF_boot;
    names = mv.opisy;

    for vep=2:4
        load([path_In, rat, '_VEP',veps{vep},'.mat_mout.mat']);
        data(:,:,:,:,:, vep) = NDTF_boot;
    end
end

