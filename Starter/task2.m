%Homework 0
%Qiao Zhang
%20151002

figure;
for i = 1:2
    Border = imread(['border', num2str(i), '.png']);
    Center = imread(['center', num2str(i), '.png']);
    Complete = reconstruct(Border, Center);
    subplot(2,2,i);
    imshow(Complete);
    title(['picture ', num2str(i)]);
end
for i = 3:4
    Border = imread(['border', num2str(i), '.jpg']);
    Center = imread(['center', num2str(i), '.jpg']);
    Complete = reconstruct(Border, Center);
    subplot(2,2,i);
    imshow(Complete);
    title(['picture ', num2str(i)]);
end