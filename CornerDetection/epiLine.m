function epiLine(cor1,cor2)
load('warrior2.mat');
sze = 14;
img1 = rgb2gray(warrior01);
img2 = rgb2gray(warrior02);
%line1 = F*[cor1 ones(sze,1)]';
%line2 = F*[cor2 ones(sze,1)]';
flag = 2;

if flag == 2
    imshow(img2);
    hold on;
    scatter(cor2(:,1),cor2(:,2),200);
    hold on;
    F = fund(cor1,cor2);
    line = F*[cor1 ones(sze,1)]';
    for i = 1:sze
        pts = linePts(line(:,i),[1,size(img2,2)],[1,size(img2,1)]);
        plot(pts(:,1),pts(:,2));
    end
else
    imshow(img1);
    hold on;
    scatter(cor1(:,1),cor1(:,2),200);
    hold on;
    F = fund(cor2,cor1);
    line = F*[cor2 ones(sze,1)]';
    for i = 1:sze
        pts = linePts(line(:,i),[1,size(img2,2)],[1,size(img2,1)]);
        plot(pts(:,1),pts(:,2));
    end
end
end
% imshow(img2);
% hold on;
% scatter(cor2(:,1),cor2(:,2),150);

