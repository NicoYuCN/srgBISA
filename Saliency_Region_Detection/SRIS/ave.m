function c = ave(img,img_hsv,mode,rows,cols,phi_a)
if strcmp(mode,'hsv')
    img = img_hsv.*255;
end
img1 = img(:,:,1);
img2 = img(:,:,2);
img3 = img(:,:,3);
sum1_in = 0;sum2_in = 0;sum3_in = 0;
sum1_out = 0;sum2_out = 0;sum3_out = 0;
count_in = 0;count_out = 0;
for i = 1:rows
    for j = 1:cols
        if phi_a(i,j) >= 0
            count_in = count_in + 1;
            sum1_in = sum1_in + double(img1(i,j));
            sum2_in = sum2_in + double(img2(i,j));
            sum3_in = sum3_in + double(img3(i,j));
        else
            count_out = count_out + 1;
            sum1_out = sum1_out + double(img1(i,j));
            sum2_out = sum2_out + double(img2(i,j));
            sum3_out = sum3_out + double(img3(i,j));
        end
    end
end
c = [sum1_in/count_in sum2_in/count_in sum3_in/count_in;
    sum1_out/count_out sum2_out/count_out sum3_out/count_out];