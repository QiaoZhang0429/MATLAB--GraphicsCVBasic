    attempt_count = 0;
    overlap_max = 0;
    %synthetic image blur
    h = fspecial('gaussian', [70 70], 4);
    synthetic = imfilter(synthetic, h, 'replicate');
    %filter image blur
    h = fspecial('gaussian', [70 70], 3);
    filter_ori = imfilter(filter_ori, h, 'replicate');
    %rotate the template
    for degree = -10:5:10
        filter = filter_ori;
        filter = imrotate(filter, degree);
        %rescale the template
        for proportion = 4:6
            attempt_count = attempt_count + 1;
            scale = sqrt(double((synthetic_m * synthetic_n) / (filter_m * filter_n) / proportion));
            filter = imresize(filter, scale);
            overlap = BoundingBox( filter, synthetic, synthetic_img, groundtruth);
            if(overlap > overlap_max)
                overlap_max = overlap;
                attempt = attempt_count;
            end
        end
        %flip the template
        filter = filter_ori;
        filter = filter(:,end:-1:1);
        for proportion = 4:6
            attempt_count = attempt_count + 1;
            scale = sqrt(double((synthetic_m * synthetic_n) / (filter_m * filter_n) / proportion));
            filter = imresize(filter, scale);
            overlap = BoundingBox( filter, synthetic, synthetic_img, groundtruth);
            if(overlap > overlap_max)
                overlap_max = overlap;
                attempt = attempt_count;
            end
        end
    end
    fprintf('%i %f\n', iteration, overlap_max);