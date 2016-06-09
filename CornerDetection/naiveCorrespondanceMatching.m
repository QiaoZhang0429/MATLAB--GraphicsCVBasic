function [I, corsSSD] = naiveCorrespondanceMatching(I1, I2, corners1, corners2, R, SSDth)
numCorners = size(corners1,1);
pic2 = zeros(size(I1));
pic2(1:size(I2,1),1:size(I2,2)) = I2;
I2 = pic2;
I = [I1 I2];
imshow(I);
hold all
scatter(corners2(:,2)+size(I1,2),corners2(:,1),'LineWidth',1.5);
hold all
scatter(corners1(:,2),corners1(:,1),'LineWidth',1.5);
corsSSD = zeros(numCorners,2);

for i = 1:numCorners
    minSSD = 10000;
    minj = 1;
    for j = 1:numCorners
        SSDscore = SSD(I1,I2,corners1(i,1),corners2(j,1),corners1(i,2),corners2(j,2),R,R);
        if SSDscore < minSSD
            minSSD = SSDscore;
            minj = j;
        end
    end
    
    if minSSD>SSDth
        fprintf('no match for point at (%d, %d)',corners1(i,1),corners2(i,2));
    else
        corsSSD(i,:) = [corners2(minj,1),corners2(minj,2)];
        line([corners1(i,2),corners2(minj,2)+size(I1,2)],[corners1(i,1),corners2(minj,1)]);
    end
end
end