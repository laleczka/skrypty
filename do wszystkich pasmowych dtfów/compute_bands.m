function band_dtf = compute_bands(data)
    band = {1:4, 4:8, 8:13, 13:30};
    band_dtf = zeros(13,13,4,110);
    for i=1:4
        %band_dtf(:,:,i,:) = count_dtf(data.NDTF_boot, band{i}); %do draw_dtf
        band_dtf(:,:,i,:) = count_dtf(data, band{i}); %wielu vepow
    end
end

function band_dtf = count_dtf(data, band)
    band_dtf = zeros(13, 13, 110);
    for row=1:13
        for col=1:13
            tmp_low = squeeze(data.NDTF_boot(row,col,:,1,:));
            tmp_high= squeeze(data.NDTF_boot(row,col,:,3,:));
%             tmp_low = squeeze(data(row,col,:,1,:));
%             tmp_high= squeeze(data(row,col,:,3,:));
            
            [low, high] = find_extrema(tmp_low(band, :), tmp_high(band, :));
            
            band_dtf(row, col, :) = [low,fliplr(high)];
        end
    end
end

function [low, high] = find_extrema(tmp_low, tmp_high)
    low = zeros(1,55);
    high = zeros(1,55);
    for i = 1:55
        low(i) = min(tmp_low(:, i));
        high(i) = max(tmp_high(:,i));
    end
end
            
