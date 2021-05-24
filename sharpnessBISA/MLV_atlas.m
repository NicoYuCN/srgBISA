function [ MLV ] = MLV_atlas( imgPath, imgNum, imgType )

tmppath = imgPath; % 图像所在文件夹路径
tmpnum = imgNum;   % 图像张数
tmptype = imgType; % 图像后缀名

MLV = zeros(1, tmpnum+1); % image number + time
t0 = cputime;
for i=0:tmpnum-1
    
    img=imread(strcat(tmppath,num2str(i),tmptype));
    [sharpnessScore, ~]= MLVSharpnessMeasure(img);
    MLV(1,i+1)=sharpnessScore;
end
MLV(1, tmpnum+1) = cputime - t0;
end

