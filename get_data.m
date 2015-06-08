function data = get_data(rat, veps)
    path_In = ['C:\Users\L635-10K\Desktop\lic_fiz\szczury\', rat, '\'];
    load([path_In, rat, '_VEP1.mat']);
    a = size(all_dataTrial);
    data = zeros(a(1), a(2), a(3),4);
    data(:,:,:,1) = all_dataTrial;

    for vep=2:4
        load([path_In, rat, '_VEP',veps{vep},'.mat']);
        data(:,:,:, vep) = all_dataTrial;
    end
end