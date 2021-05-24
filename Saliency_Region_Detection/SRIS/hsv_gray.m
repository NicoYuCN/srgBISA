function img = hsv_gray(img_in)
imgh = img_in(:,:,1);
imgs = img_in(:,:,2);
imgv = img_in(:,:,3);
img = (imgh + imgs +imgv)./(3);
