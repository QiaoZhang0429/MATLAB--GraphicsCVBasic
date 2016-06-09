function [ Complete ] = reconstruct( Border, Center )
%RECONSTRUCT reconstructs the original image from border and center
%   Border: The image on the outside
%   Center: The central part of image

[M,N,three] = size(Border);
[m,n,three] = size(Center);
if(mod((M - m), 2) == 0)
    y1 = (M - m) / 2 + 1;
    y2 = (M - m) / 2 + m;
else
    y1 = (M - m - 1) / 2 + 1;
    y2 = (M - m - 1) / 2 + m;
end
if(mod((N - n), 2) == 0)
    x1 = (N - n) / 2 + 1;
    x2 = (N - n) / 2 + n;
else
    x1 = (N - n - 1) / 2 + 1;
    x2 = (N - n - 1) / 2 + n;
end
Complete = Border;
Complete(y1:y2,x1:x2,:) = Center;

end

