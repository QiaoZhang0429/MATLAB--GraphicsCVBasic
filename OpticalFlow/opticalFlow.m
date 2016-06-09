%opticalFlow.m
function [u,v,hitMap] = opticalFlow(I1,I2,windowSize,tau)

I1 = double(I1)/255;
I2 = double(I2)/255;
Hsize = round(windowSize/10);
std = windowSize/20;
G = fspecial('gaussian', Hsize, std);
I1 = imfilter(I1,G,'same');
I2 = imfilter(I2,G,'same');
[Ix,Iy] = gradient(I1);
diff = I2-I1;
Ixx = Ix.^2;
Iyy = Iy.^2;
Ixy= Ix.*Iy;
Ixt = Ix.*diff;
Iyt = Iy.*diff;
A = ones(windowSize);
Ixx = imfilter(Ixx,A,'same');
Iyy = imfilter(Iyy,A,'same');
Ixy = imfilter(Ixy,A,'same');
Ixt = imfilter(Ixt,A,'same');
Iyt = imfilter(Iyt,A,'same');

[m,n] = size(I1);

u = zeros(m,n);
v = zeros(m,n);
hitMap = zeros(m,n);

for i=1:m
    for j=1:n
        M = [Ixx(i,j),Ixy(i,j);Ixy(i,j),Iyy(i,j)];
        b = [Ixt(i,j);Iyt(i,j)];
        if(min(eig(M)) > tau)
            hitMap(i,j) = 1;
            dirs = -M\b;
            u(i,j) = dirs(1);
            v(i,j) = dirs(2);
        end
    end
end
end