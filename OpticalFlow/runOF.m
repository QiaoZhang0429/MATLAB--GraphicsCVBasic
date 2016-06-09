clear all;
clc;

I1 = imread('sphere/sphere.0.png');I1 = rgb2gray(I1);
I2 = imread('sphere/sphere.1.png');I2 = rgb2gray(I2);
[m,n] = size(I1);

[u1,v1,hitMap1] = opticalFlow(I1,I2,15,0.02);
[u2,v2,hitMap2] = opticalFlow(I1,I2,30,0.08);
[u3,v3,hitMap3] = opticalFlow(I1,I2,100,0.89);

intv = floor(n/20);
[x,y] = meshgrid(1:intv:n,1:intv:m);

subplot(2,3,1);
quiver(x,y,u1(1:intv:m, 1:intv:n),v1(1:intv:m, 1:intv:n));
title('windowSize = 15')
set(gca,'YDir','reverse');
axis image;
subplot(2,3,2);
quiver(x,y,u2(1:intv:m, 1:intv:n),v2(1:intv:m, 1:intv:n));
title('windowSize = 30')
set(gca,'YDir','reverse');
axis image;
subplot(2,3,3);
quiver(x,y,u3(1:intv:m, 1:intv:n),v3(1:intv:m, 1:intv:n));
title('windowSize = 100')
set(gca,'YDir','reverse');
axis image;
subplot(2,3,4);
imshow(hitMap1);
title('windowSize = 15')
subplot(2,3,5);
imshow(hitMap2);
title('windowSize = 30')
subplot(2,3,6);
imshow(hitMap3);
title('windowSize = 100')
axis image;