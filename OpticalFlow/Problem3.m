I1 = imread('flower/flower/00032.png');I1 = rgb2gray(I1);
I2 = imread('flower/flower/00033.png');I2 = rgb2gray(I2);
I1 = double(I1)/255;
I2 = double(I2)/255;


maxIter=30;
thres=0.002;
windowSize = 30;
pyramidSize = 4;
tau = 0.3;

p1 = cell(pyramidSize,1); p2 = cell(pyramidSize,1);
p1{pyramidSize} = I1; p2{pyramidSize} = I2;
for i = pyramidSize-1:-1:1
    p1{i} = impyramid(p1{i+1},'reduce');
    p2{i} = impyramid(p2{i+1},'reduce');
end
[u,v,hitMap] = opticalFlow(p1{1},p2{1},windowSize,tau);
for level = 2:pyramidSize
    level
    I1 = p1{level};
    I2 = p2{level};
    u = imresize(u,2);
    v = imresize(v,2);
    u = 2.*u;
    v = 2.*v;
    
    [Ix,Iy] = gradient(I1);
    Ixx = Ix.^2;
    Iyy = Iy.^2;
    Ixy= Ix.*Iy;
    A = ones(windowSize);
    Ixx = imfilter(Ixx,A,'same');
    Iyy = imfilter(Iyy,A,'same');
    Ixy = imfilter(Ixy,A,'same');
    [m,n] = size(I1);
    us = zeros(m,n);
    vs = zeros(m,n);
    for i = 1:m
        for j = 1:n
            l = j - floor(windowSize/2); 
            r = j + floor(windowSize/2);
            t = i - floor(windowSize/2); 
            b = i + floor(windowSize/2);
            if(l<=0)
                l=1; 
            end
            if(r>n)
                r=n; 
            end
            if(t<=0)
                t = 1; 
            end
            if(b>m)
                b=m; 
            end
            
            M = [Ixx(i,j) Ixy(i,j); Ixy(i,j) Iyy(i,j)];
            if(min(eig(M)) > tau)
                up = u(i,j); vp = v(i,j);
                for iter = 1:maxIter
                    [x,y] = meshgrid(1:size(I1,2), 1:size(I1,1));
                    xp = x+up;
                    yp = y+vp;
                    I2warped = interp2(x,y,I2,xp(t:b,l:r),yp(t:b,l:r));
                    diff = I2warped - I1(t:b,l:r);
                    Ixt = Ix(t:b,l:r).*diff;
                    Iyt = Iy(t:b,l:r).*diff;
                    b = [sum(Ixt(:)); sum(Iyt(:))];
                    dirs = -M\b;
                    dirs(isnan(dirs)) = 0;
                    up = up + dirs(1);
                    vp = vp + dirs(2);
                    if(abs(dirs(1))<thres && abs(dirs(2))<thres)
                        break;
                    end
                end
                us(i,j)=up; vs(i,j)=vp;
            end
        end
    end
    u = us; v = vs;
end
resu = us;
resv = vs;

[x, y] = meshgrid(1:5:size(I1,2), size(I1,1):-5:1);
qu = resu(1:5:size(I1,1), 1:5:size(I1,2));
qv = resv(1:5:size(I1,1), 1:5:size(I1,2));
figure,title('coarse to fine')
quiver(x,y, qu, -qv,'linewidth', 1);
  

    
    
    
    
    
    

