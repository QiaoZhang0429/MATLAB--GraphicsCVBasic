function [U,V,W] = surfaceNorm(facedata)
load(facedata);

%number of given points that are not on the edges or corner
numX = size(heightmap,1)-2;
numY = size(heightmap,2)-2;

%Given points starting from x = 2 y = 2 to x = 187 y = 125
%the edge points will be handeled seperately 
Xs = 2:1:size(heightmap,1)-1;
Ys = 2:1:size(heightmap,2)-1;

%approximate the gradient
%assume the edge points have gradient 0

gradientX = zeros(size(heightmap,1),size(heightmap,2));
gradientY = gradientX;

gradientX(2:end-1,2:end-1) = (heightmap(Xs+1,Ys) - heightmap(Xs-1,Ys))/2;
gradientY(2:end-1,2:end-1) = (heightmap(Xs,Ys+1) - heightmap(Xs,Ys-1))/2;


UVW(1,:) = reshape(gradientX,1,size(gradientX,1)*size(gradientX,2));
UVW(2,:) = reshape(gradientY,1,size(gradientY,1)*size(gradientY,2));
UVW(3,:) = ones(1,size(gradientX,1)*size(gradientX,2));

%normalization 
for i = 1:(numX+2)*(numY+2)
    UVW(:,i) = UVW(:,i)/norm(UVW(:,i));
end

%plotting
U = reshape(UVW(1,:),size(gradientX,1),size(gradientX,2));
V = reshape(UVW(2,:),size(gradientX,1),size(gradientX,2));
W = reshape(UVW(3,:),size(gradientX,1),size(gradientX,2));
a = quiver3(heightmap,U,V,W);
saveas(a,'surface norm.jpg');


