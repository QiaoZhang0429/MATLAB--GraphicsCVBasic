%load the intensity and light source direction
load synthetic_data;

%variables declaration
[m,n] = size(im1);
B = double(zeros(m,n,3));
surface_normal = double(zeros(m,n,3));
albedo_map = double(zeros(m,n));
s = double([l1; l2; l3; l4]);%all 4 images
%s = double([l1; l2; l4]);%subset of 3 images

%pseudo inverse of matrix s
%calculate albedo and surface normal at each point
pseudo_inv = (s' * s) \ s';
for i = 1:m
    for j = 1:n
        e = double([im1(i,j); im2(i,j); im3(i,j); im4(i,j)]);%all 4 images
        %e = double([im1(i,j); im2(i,j); im4(i,j)]);%subset of 3 images
        B(i,j,:) = pseudo_inv * e;
        albedo_map(i,j) = sqrt(B(i,j,1)^2 + B(i,j,2)^2 + B(i,j,3)^2);
        surface_normal(i,j,:) = B(i,j,:) ./ albedo_map(i,j);
    end
end

%normalise albedo to [0,1]
maximum = max(max(albedo_map));
minimum = min(min(albedo_map));
albedo_map = (albedo_map - minimum) ./ (maximum - minimum);

%show albedo map
figure;
imagesc(albedo_map);
%imshow(uint8(albedo_map));

%show surface normal map
figure;
[x,y] = meshgrid(1:5:m, 1:5:n);
z = zeros(size(x));
quiver3(y,x,z,surface_normal(1:5:m,1:5:n,1),surface_normal(1:5:m,1:5:n,2),surface_normal(1:5:m,1:5:n,3));

%calculate height map by integration
height_map = zeros(size(albedo_map));
p = -1 .* surface_normal(:,:,1) ./ surface_normal(:,:,3);
q = -1 .* surface_normal(:,:,2) ./ surface_normal(:,:,3);
for j = 1:n
    if(j == 1)
        height_map(1,j) = height_map(1,j) + q(1,j);
    else
        height_map(1,j) = height_map(1,j-1) + q(1,j);
    end
    for i = 2:m
        height_map(i,j) = height_map(i-1,j) + p(i,j);
    end
end

%show height map
figure;
[x,y] = meshgrid(1:1:m, 1:1:n);
surf(y,x,height_map);

%show the final reconstruction map
figure;
quiver3(y(1:5:m,1:5:n),x(1:5:m,1:5:n),height_map(1:5:m,1:5:n,1),surface_normal(1:5:m,1:5:n,1),surface_normal(1:5:m,1:5:n,2),surface_normal(1:5:m,1:5:n,3));