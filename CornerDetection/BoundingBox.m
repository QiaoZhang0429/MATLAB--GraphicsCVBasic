function [ overlapping ] = BoundingBox( iteration, filter, synthetic, synthetic_img, groundtruth )

    %heat map image
    intensity = imfilter(synthetic, filter, 'same');
    %intensity = conv2(synthetic, filter, 'same');
    %intensity map average filtering
    if(iteration == 1)
        h = fspecial('average',  [90 180]);
    end
    if(iteration == 2)
        h = fspecial('average',  size(filter));
    end
    if(iteration == 3)
        h = fspecial('average',  size(filter));
    end
    if(iteration == 4)
        h = fspecial('average',  size(filter));
    end
    if(iteration == 5)
        h = fspecial('average',  size(filter));
    end
    intensity = imfilter(intensity, h, 'replicate');
    figure;
    imagesc(intensity);
    %bounding box drawn on the original image
    predict_center = drawBoundBox(intensity, synthetic_img, filter, groundtruth);
    %bounding box overlapping percent
    overlapping = overlapPercent(predict_center, groundtruth, filter, synthetic);

end

