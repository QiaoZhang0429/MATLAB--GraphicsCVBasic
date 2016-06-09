function findOutliers(points3D,P2,outlierTH,corsSSD)
load('dino2.mat');
indIn = 1; indOut = 1; outlier = []; inlier = [];
for i = 1 : size(corsSSD, 1)
    norm(corsSSD(i,:)-points3D(i,1:2))
    if norm(corsSSD(i,:)-points3D(i,1:2)) > outlierTH
        outlier(indOut, :) = points3D(i,1:2);
        indOut = indOut+1;
    else
        inlier(indIn, :) = points3D(i,1:2);
        indIn = indIn + 1;
    end
end

I1 = rgb2gray(dino01);
imshow(I1);
hold  on;
scatter(corsSSD(:,1), corsSSD(:,2), 'k', 'lineWidth', 2);
if (sum(size(inlier)) > 0) scatter(inlier(:,1), inlier(:,2), 'b+', 'lineWidth', 2); end
if (sum(size(outlier)) > 0) scatter(outlier(:,1), outlier(:,2), 'r+', 'lineWidth', 2); end

end