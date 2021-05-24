function [ S3 ] = S3_atlas( imgPath, imgNum, imgType )
tmppath = imgPath; % 图像所在文件夹路径
tmpnum = imgNum;   % 图像张数
tmptype = imgType; % 图像后缀名

LPC = zeros(1, tmpnum+1); % image number + time
t0 = cputime;
for i=0:tmpnum-1
    img=imread(strcat(tmppath,num2str(i),tmptype));
    img=double(rgb2gray(img));
    [s_map1 s_map2 s3] = s3_map(img);
[m,n]=size(s3);
sort_s3=sort(s3(:),'descend');
N=floor(m*n/100);
b=sum(sort_s3(1:N,:));
Q=b/N;
    S3(1,i+1)=Q;
end
S3(1, tmpnum+1) = cputime - t0;
end

