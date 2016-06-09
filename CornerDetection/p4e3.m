for iteration = 4:4
    %load image and coordinates
    filter_img = double(imread('cartemplate.jpg'));
    filter_img = filter_img(280:900, 90:1720);%cut template
    filter_ori = filter_img - mean(filter_img(:));
    filter = filter_ori;
    [filter_m,filter_n] = size(filter);
    filename = ['car', num2str(iteration), '.jpg'];
    synthetic_img = double(imread(filename));
    synthetic = synthetic_img - mean(synthetic_img(:));
    [synthetic_m,synthetic_n] = size(synthetic);
    filename = ['car', num2str(iteration), '.txt'];
    fp = fopen(filename, 'r');
    line = fgetl(fp);
    tmp = regexp(line, '\s+', 'split');
    x1 = char(tmp{1});
    y1 = char(tmp{2});
    line = fgetl(fp);
    tmp = regexp(line, '\s+', 'split');
    x2 = char(tmp{1});
    y2 = char(tmp{2});
    fclose(fp);
    groundtruth = [str2num(y1), str2num(x1); str2num(y2), str2num(x2)];  
    %pre-processing
    if(iteration == 1)
        scale = sqrt(double((synthetic_m * synthetic_n) / (filter_m * filter_n) / 6));
        filter = imresize(filter, scale);
    end
    if(iteration == 2)
        scale = sqrt(double((synthetic_m * synthetic_n) / (filter_m * filter_n) / 4.5));
        filter = imresize(filter, scale);
        filter = filter(:,end:-1:1);
    end
    if(iteration == 3)
        filter = imresize(filter, [filter_m, floor(0.45 * filter_n)]);
        [filter_m,filter_n] = size(filter);
        h = fspecial('gaussian', [50 50], 3);
        synthetic = imfilter(synthetic, h, 'replicate');
        filter = imfilter(filter, h, 'replicate');
        scale = sqrt(double((synthetic_m * synthetic_n) / (filter_m * filter_n) / 11.5));
        filter = imresize(filter, scale);
        %filter = imrotate(filter, -5);
        filter = gradient(double(filter));
        synthetic = gradient(double(synthetic));
        %filter = double(edge(filter, 'canny'));
        %synthetic = double(edge(synthetic, 'canny'));
    end
    if(iteration == 4)
        filter = filter(:,end:-1:1);
        h = fspecial('gaussian', [50 50], 11);
        synthetic = imfilter(synthetic, h, 'replicate');
        filter = imfilter(filter, h, 'replicate');
        scale = sqrt(double((synthetic_m * synthetic_n) / (filter_m * filter_n) / 6));
        filter = imresize(filter, scale);
        filter = gradient(double(filter));
        synthetic = gradient(double(synthetic));
        %filter = double(edge(filter, 'canny'));
        %synthetic = double(edge(synthetic, 'canny'));
    end
    if(iteration == 5)
        filter = imresize(filter, [filter_m, floor(0.85 * filter_n)]);
        [filter_m,filter_n] = size(filter);
        h = fspecial('gaussian', [50 50], 11);
        synthetic = imfilter(synthetic, h, 'replicate');
        filter = imfilter(filter, h, 'replicate');
        scale = sqrt(double((synthetic_m * synthetic_n) / (filter_m * filter_n) / 6));
        filter = imresize(filter, scale);
        %filter = imrotate(filter, -5);
        %filter = gradient(double(filter));
        %synthetic = gradient(double(synthetic));
        filter = double(edge(filter, 'canny'));
        synthetic = double(edge(synthetic, 'canny'));
        figure;
        imshow(filter);
        figure;
        imshow(synthetic);
    end
    %run algorithm
    overlap = BoundingBox( iteration, filter, synthetic, synthetic_img, groundtruth);
end