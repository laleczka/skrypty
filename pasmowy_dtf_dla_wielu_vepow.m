path_Out = 'C:\Users\L635-10K\Desktop\lic_fiz\dane\obrazki\';
bands = {'name', 'value'};
% bands.name = {'1-4','4-8','8-13', '13-30'};
% bands.value = {1:4, 4:8, 8:13, 13:30};
bands.name = {'1-10','10-30','20-40'};
bands.value = {1:10, 10:30, 20:40};
% rat = 'beta3';
% veps = {'1','7','11','15'};

% rat = 'beta4';
% veps = {'1', '8', '12', '16'};

rat = 'kontrola15';
veps = {'1', '5', '9', '13'};

[data, names] = get_data2(rat, veps);

%get 6-D matrix chan x chan x freq x boot x sample x vep <3

band_dtf = zeros(13,13,length(bands.name),110,length(veps));
for i=1:length(veps)
    band_dtf(:,:,:,:,i) = compute_bands(data(:,:,:,:,:, i));
end

kan_z = 9;
kan_d = 4;
for b=1:3
    band = b;
    pasmowy(band_dtf, names, rat, path_Out, bands, band, kan_z, kan_d, data)
end

% row = 2;
% col = 6;
% dzielnik = 18000;
% cc={[0 0 1], [0 0.5 0], [1 0 0], [0 0.75 0.75]};
% %x = 1:1:55;
% x = -0.2:0.0218:1-0.0218;
% X=[x,fliplr(x)];

%% wersja 1
% for v = 1:4
%     fill(X, squeeze(band_dtf(row,col,1,:,v)/dzielnik), cc{v})
%     hold on
% end
% hold off
% xlim([-0.2 x(55)]);
% title(['œredni nDTF w paœmie 1-4 Hz z kana³u ', names{col}, ' do kana³u ', names{row}], 'FontSize',15)
% legend('kontrola', 'po 1h', 'po 2h', 'po 3h')
% ylabel('Amplituda', 'FontSize',12)
% xlabel('Czas [s]', 'FontSize',12)
% alpha(0.5)

% %% wersja 2
% for s = 1:3
%     subplot(3,1,s)
%     fill(X, squeeze(band_dtf(row,col,bands.value(1),:,1)/dzielnik), 'b')
%     hold on
%     fill(X, squeeze(band_dtf(row,col,bands.value(1),:,s+1)/dzielnik), 'r')
%     if s == 1
%         title(['œredni nDTF bez stymulacji w paœmie ', bands.name{1},' Hz z kana³u ', names{col}, ' do kana³u ', names{row}], 'FontSize',15)
%     end
%     legend('kontrola', ['po ', num2str(s), 'h'])
%     xlim([-0.2 x(55)]);
%     ylim([0 15]);
%     ylabel('Amplituda', 'FontSize',12)
%     alpha(0.5)
% end
% xlabel('Czas [s]', 'FontSize',12)
% hold off
% file_name = [path_Out,rat, '_', bands.name{1}, '_z_', names{col}, '_do_', names{row}, '.png'];
% print( gcf,'-dpng','-r300', file_name) 