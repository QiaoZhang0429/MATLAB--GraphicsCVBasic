function [ quality ] = overlapPercent( predict_center, groundtruth, filter, synthetic )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

predict_label = zeros(size(synthetic));
groundtruth_label = zeros(size(synthetic));
[filter_m,filter_n] = size(filter);

lower_row = predict_center(1) - floor(filter_m/2);
upper_row = predict_center(1) + floor(filter_m/2);
lower_col = predict_center(2) - floor(filter_n/2);
upper_col = predict_center(2) + floor(filter_n/2);
for i = lower_row:upper_row
    for j = lower_col:upper_col
        predict_label(i,j) = 1;
    end
end

lower_row = groundtruth(1,1);
upper_row = groundtruth(2,1);
lower_col = groundtruth(1,2);
upper_col = groundtruth(2,2);
for i = lower_row:upper_row
    for j = lower_col:upper_col
        groundtruth_label(i,j) = 1;
    end
end

union = or(predict_label,groundtruth_label);
intersect = and(predict_label,groundtruth_label);
quality = sum(sum(intersect)) / sum(sum(union));

end

