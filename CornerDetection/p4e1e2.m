filter_img = double(imread('filter.jpg'));
filter = filter_img - mean(filter_img(:));
[m,n] = size(filter);
synthetic_img = double(imread('toy.png'));
synthetic = synthetic_img - mean(synthetic_img(:));
intensity = conv2(double(synthetic), double(filter), 'same');
figure;
imagesc(intensity);
%imshow(uint8(255 * intensity / max(max(intensity))));
predict_center = zeros(3,2);
for iteration = 1:3
    y = max(max(intensity));
    [row, col] = find(intensity == y);
    predict_center(iteration,1) = row(1);
    predict_center(iteration,2) = col(1);
    %bound for the box
    lower_row = row(1) - floor(m/2);
    upper_row = row(1) + floor(m/2);
    lower_col = col(1) - floor(n/2);
    upper_col = col(1) + floor(n/2);
    %draw box around the peak point
    for i = lower_row:upper_row
        synthetic_img(i,lower_col) = 0;
        synthetic_img(i,upper_col) = 0;
    end
    for j = lower_col:upper_col
        synthetic_img(lower_row,j) = 0;
        synthetic_img(upper_row,j) = 0;
    end
    %eliminate the points which can not be peak any more
    for i = (row(1)-m):(row(1)+m)
        for j = (col(1)-n):(col(1)+n)
            if(i > 0) && (j > 0)
                intensity(i,j) = NaN;
            end
        end
    end
end
%figure;
%imshow(synthetic_img);
%calculate quality for bounding box with different filter size
detError = zeros(3,1);
groundtruth_center = [88, 340];
for i = 1:3
    filter_size = m + (i-2) * 20;
    detError(i) = detectionError(predict_center(2,:), groundtruth_center, filter_size, synthetic);
end