function corners = CornerDetect(Image, nCorners, smoothSTD, windowSize)
Image = rgb2gray(Image);
del_corner = 20;

dx = [-1 0 1; -1 0 1; -1 0 1];
dy = dx';
g = fspecial('gaussian',max(1,fix(6*smoothSTD)), smoothSTD);
sumWindow = ones(windowSize);

imG = conv2(Image, g, 'same');
Ix = conv2(imG, dx, 'same');
Iy = conv2(imG, dy, 'same');
Ix2 = conv2(Ix.^2, sumWindow, 'same');
Iy2 = conv2(Iy.^2, sumWindow, 'same');
Ixy = conv2(Ix.*Iy, sumWindow,'same');

min_lambda = zeros(size(Ix2));
for i = 1 : size(Ix2,1)
    for j = 1 : size(Ix2, 2)
        min_lambda(i,j) = min(eig([Ix2(i,j) Ixy(i,j); Ixy(i,j) Iy2(i,j)]));
    end
end

non_max = imregionalmax(min_lambda, 8);
min_lambda = non_max.*min_lambda;
min_lambda([1:del_corner, end-del_corner+1:end],[1:del_corner, end-del_corner+1:end]) = 0;

[~,sortIndex] = sort(min_lambda(:),'descend');
maxInd = sortIndex(1:nCorners)-1;
maxIndx = mod(maxInd, size(Ix2,1))+1;
maxIndy = floor(maxInd/size(Ix2,1))+1;
corners = [maxIndx maxIndy];
imshow(Image);
hold all
scatter(maxIndy, maxIndx, 'o')

