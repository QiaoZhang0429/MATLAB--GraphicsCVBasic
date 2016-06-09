function [ warped_img ] = warp( I, new_points, H )

[m,n] = size(rgb2gray(I));
height = max(new_points(:,1));
width = max(new_points(:,2));
warped_img = zeros(height, width, 3);
for i = 1:height
    for j = 1:width
        pixel_ori = inv(H) * [i;j;1];
        pixel_ori = pixel_ori ./ pixel_ori(3);
        pixel_ori = round(pixel_ori);
        if(pixel_ori(1) < 1)
            pixel_ori(1) = 1;
        end
        if(pixel_ori(1) > m)
            pixel_ori(1) = m;
        end
        if(pixel_ori(2) < 1)
            pixel_ori(2) = 1;
        end
        if(pixel_ori(2) > n)
            pixel_ori(2) = n;
        end
        warped_img(i,j,:) = I(pixel_ori(1), pixel_ori(2),:);
    end
end

end

