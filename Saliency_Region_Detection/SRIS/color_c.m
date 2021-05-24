function c_cha = color_c(img,img_gray,saliency,mode,c,sa,l,a)
img = double(img);
if strcmp(mode,'hsv')
    img = img.*255;
end
if strcmp(mode,'rgb')
    a = a*0.1;
end
[rows, cols] = size(img_gray);
c_cha = ones(rows,cols);
for i = 1:rows
    for j = 1:cols
        c_cha(i,j) = -l.*((img(i,j,1)-c(1,1)).^2+(img(i,j,2)-c(1,2)).^2+(img(i,j,3)-c(1,3)).^2) + ...
            l.*((img(i,j,1)-c(2,1)).^2+(img(i,j,2)-c(2,2)).^2+(img(i,j,3)-c(2,3)).^2)-...
            a.*(saliency(i,j)-sa(1,1)).^2+a.*(saliency(i,j)-sa(2,1)).^2;
    end
end
