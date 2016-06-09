clear;
clc;

%set(0,'DefaultLineMarkerSize',16);
%set(0, 'DefaultLineLineWidth', 2);
%set(gcf, 'Color', [1 1 1]);

nCorners = 50;
smoothSTD = 1;
windowSize = [7,7];

I1 = imread('sphere/sphere.0.png'); I1 = rgb2gray(I1);
I2 = imread('sphere/sphere.1.png'); I2 = rgb2gray(I2);
Image = double(I1)/255;

idx = CornerDetect(Image, nCorners, smoothSTD, windowSize);
imshow(Image);
hold on;
scatter(idx(:,2),idx(:,1),'o','lineWidth',2);
hold on;

[m,n] = size(I1);

[u,v,hitMap] = opticalFlow(I1,I2,100,0.01);

intv = floor(n/20);
[x,y] = meshgrid(1:intv:n,1:intv:m);
for i=1:50
    xi = idx(i,2);
    yi = idx(i,1);
    quiver(xi,yi,25*u(yi,xi),25*v(yi,xi),1,'color',[0 0 1],'lineWidth',2);
end
set(gca,'YDir','reverse');
axis image;