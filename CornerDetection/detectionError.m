function [ quality ] = detectionError( predict_center, groundtruth_center, filter_size, synthetic )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

predict_label = zeros(size(synthetic));
groundtruth_label = zeros(size(synthetic));

lower_row = predict_center(1) - floor(filter_size/2);
upper_row = predict_center(1) + floor(filter_size/2);
lower_col = predict_center(2) - floor(filter_size/2);
upper_col = predict_center(2) + floor(filter_size/2);
for i = lower_row:upper_row
    for j = lower_col:upper_col
        predict_label(i,j) = 1;
    end
end

lower_row = groundtruth_center(1) - floor(filter_size/2);
upper_row = groundtruth_center(1) + floor(filter_size/2);
lower_col = groundtruth_center(2) - floor(filter_size/2);
upper_col = groundtruth_center(2) + floor(filter_size/2);
for i = lower_row:upper_row
    for j = lower_col:upper_col
        groundtruth_label(i,j) = 1;
    end
end

union = or(predict_label,groundtruth_label);
intersect = and(predict_label,groundtruth_label);
quality = sum(sum(intersect)) / sum(sum(union));

end

