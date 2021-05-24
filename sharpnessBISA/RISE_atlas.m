function [ RISE_score ] = RISE_atlas( imgPath, imgNum, imgType )
tmppath = imgPath; % 图像所在文件夹路径
tmpnum = imgNum;   % 图像张数
tmptype = imgType; % 图像后缀名

RISE_score = zeros(1, tmpnum+1); % image number + time
t0 = cputime;
for i=0:tmpnum-1
    img=imread(strcat(tmppath,num2str(i),tmptype));
    scale = 3;
%% compute quality score
score = RISE(img,scale);
    RISE_score(1,i+1)=score;
end
RISE_score(1, tmpnum+1) = cputime - t0;

end

