function [ predict_center ] = drawBoundBox( intensity, synthetic_img, filter, groundtruth )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    [filter_m,filter_n] = size(filter);
    [synthetic_m,synthetic_n] = size(synthetic_img);
    %find peak center
    while(1)
        y = max(max(intensity));
        [row, col] = find(intensity == y);
        if(row(1) > floor(filter_m/2)) && (col(1) > floor(filter_n/2)) && (row(1) < (synthetic_m - floor(filter_m/2)) && (col(1) < (synthetic_n - floor(filter_n/2))))
            predict_center = [row(1), col(1)];
            break;
        end
        intensity(row(1), col(1)) = NaN;
    end
    %bound for the box
    lower_row = predict_center(1) - floor(filter_m/2);
    upper_row = predict_center(1) + floor(filter_m/2);
    lower_col = predict_center(2) - floor(filter_n/2);
    upper_col = predict_center(2) + floor(filter_n/2);
    %draw box around the peak point
    for i = lower_row:upper_row
        synthetic_img(i,lower_col) = 0;
        synthetic_img(i,upper_col) = 0;
    end
    for j = lower_col:upper_col
        synthetic_img(lower_row,j) = 0;
        synthetic_img(upper_row,j) = 0;
    end
    %draw groundtruth box
    disp(groundtruth);
    for i = groundtruth(1,1):groundtruth(2,1)
        synthetic_img(i,groundtruth(1,2)) = 30;
        synthetic_img(i,groundtruth(2,2)) = 30;
    end
    for j = groundtruth(1,2):groundtruth(2,2)
        synthetic_img(groundtruth(1,1),j) = 30;
        synthetic_img(groundtruth(2,1),j) = 30;
    end
    figure;
    imshow(uint8(synthetic_img));
end

