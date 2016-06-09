function diff = SSD(img1,img2,x1,x2,y1,y2,width,height)
%param:
%x1,y1: the center of first window
%x2,y2: the center of second window
%width, height: dimension of the window

%windows
window1 = img1(x1-height:x1+height,y1-width:y1+width);
window2 = img2(x2-height:x2+height,y2-width:y2+width);

%difference
diff = window1 - window2;
diff = diff(:);
diff = sum(diff.^2);
end