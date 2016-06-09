function [corrPts,corsSSD] = correspondanceMatchingLine(I1,I2,corners1,F,R,SSDth)

pic2 = zeros(size(I1));
pic2(1:size(I2,1),1:size(I2,2)) = I2;
I2 = pic2;
I = [I1 I2];
imshow(I);
hold all
scatter(corners1(:,2),corners1(:,1),'LineWidth',1.5);

ncorners = size(corners1,1);

corrPts = 10000*ones(ncorners, 2);

corsSSD = 10000*ones(ncorners,1);
for i = 1:ncorners
    epiline = F*[corners1(i,2) corners1(i,1) 1]';
    pts = linePts(epiline, [1, size(I2,2)], [1, size(I2,1)]);
    
   for x = 1 : size(I2, 2)
        y = fix((pts(2,2) - pts(1,2)) / (pts(2,1) - pts(1,1))*(x - pts(1,1)) + pts(1,2));
        if (x-R > 0) && (y-R > 0) && (x+R <= size(I2,2)) && (y+R <= size(I2,1))
            tmp = SSD(I1,I2,corners1(i,1),y,corners1(i,2),x,R,R);
            if (tmp < SSDth) && (tmp < corsSSD(i))
                corsSSD(i) = tmp;
                corrPts(i,:) = [x, y];
            end
        end
    end
    if corsSSD(i) < 10000
        scatter([corners1(i,2) corrPts(i,1)+size(I1,2)], [corners1(i,1) corrPts(i,2)], 'LineWidth', 2);
        plot([corners1(i,2) corrPts(i,1)+size(I1,2)], [corners1(i,1) corrPts(i,2)]);
    end
end
ind = 1;
for i = 1 : ncorners
    if corsSSD(i) < inf
        pt1(ind,:) = [corners1(i,2), corners1(i,1)];
        pt2(ind,:) = corrPts(i,:);
        ind = ind+1;
    end
end

corrPts = pt1;
corsSSD = pt2;



