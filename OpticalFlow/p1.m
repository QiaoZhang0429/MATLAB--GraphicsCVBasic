I1 = imread('stadium.jpg');
figure(10);
imshow(I1);
points = ginput(4);
figure(1);
imshow(I1);
points = [points(1,2),points(1,1),1; points(2,2),points(2,1),1; points(3,2),points(3,1),1; points(4,2),points(4,1),1];
points = round(points);
hold on
plot(points(1,2),points(1,1),'r+');
plot(points(2,2),points(2,1),'r+');
plot(points(3,2),points(3,1),'r+');
plot(points(4,2),points(4,1),'r+');
hold off
new_points = [50,1,1;1,200,1;1,1,1;50,200,1];
H = computeH(points, new_points);
warped_img = warp(I1, new_points, H);
figure(2);
imshow(uint8(warped_img));