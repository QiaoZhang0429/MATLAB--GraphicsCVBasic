function [points3D,pt1] = triangulate(P1,P2,corrPts,corsSSD)

load('dino2.mat');
I1 = rgb2gray(dino01);
I2 = rgb2gray(dino02);
pt1 = corrPts;
pt2 = corsSSD;
%ind = 1;
% for i = 1 : ncorners
%     if corsSSD(i) < inf
%         pt1(ind,:) = [corners1(i,2), corners1(i,1)];
%         pt2(ind,:) = corrPts(i,:);
%         ind = ind+1;
%     end
% end
P = zeros(size(pt1, 1), 3);

for i = 1 : size(pt1, 1)
    A = [pt1(i, 1)*P1(3,:) - P1(1,:); pt1(i, 2)*P1(3,:) - P1(2,:); pt2(i, 1)*P2(3,:) - P2(1,:); pt2(i, 2)*P2(3,:) - P2(2,:)];
    P(i, :) = A(:,1:3)\(-A(:,4));
end

pt1p = (P1*[P'; ones(1, size(pt1,1))])'; pt2p = (P2*[P'; ones(1, size(pt1,1))])';

pt1p(:, 1) = fix(pt1p(:,1)./pt1p(:,3)); pt1p(:, 2) = fix(pt1p(:,2)./pt1p(:,3));
pt2p(:, 1) = fix(pt2p(:,1)./pt2p(:,3)); pt2p(:, 2) = fix(pt2p(:,2)./pt2p(:,3));

points3D = pt1p;


% indIn = 1; indOut = 1; outlier = []; inlier = [];
% for i = 1 : size(pt1, 1)
%     norm(pt1(i,:)-pt1p(i,1:2))
%     if norm(pt1(i,:)-pt1p(i,1:2)) > 20
%         outlier(indOut, :) = pt1p(i,1:2);
%         indOut = indOut+1;
%     else
%         inlier(indIn, :) = pt1p(i,1:2);
%         indIn = indIn + 1;
%     end
% end
% 
% imshow(I1);
% hold  on;
% scatter(pt1(:,1), pt1(:,2), 'k', 'lineWidth', 2);
% if (sum(size(inlier)) > 0) scatter(inlier(:,1), inlier(:,2), 'b+', 'lineWidth', 2); end
% if (sum(size(outlier)) > 0) scatter(outlier(:,1), outlier(:,2), 'r+', 'lineWidth', 2); end
end


