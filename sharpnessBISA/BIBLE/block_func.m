%================================================================
% Divide image into blocks and compute block variances
%================================================================
function [signal_block,var_block,r,c]=block_func(img_dst,img_gradient,blkSZ)
% image=imread('1.bmp');
[m n z] = size(img_dst);
if z > 1
    img_dst = rgb2gray(img_dst);
end
img_dst=double(img_dst);
img_gradient=double(img_gradient);
rb = blkSZ;
cb = blkSZ;

% maximum block indices
r = floor(m/rb);
c = floor(n/cb);

signal_block=zeros(rb*cb,r*c);
var_block=zeros(1,r*c);
k=0;
for i=1:r
    for j=1:c
        k=k+1;
        row = (rb*(i-1)+1):rb*i;
        col = (cb*(j-1)+1):cb*j;
        image_temp = img_gradient(row,col);
        var_temp = img_dst(row,col);
        
        signal_block(:,k)=image_temp(:);
        var_block(:,k)=var2(var_temp);
    end
end