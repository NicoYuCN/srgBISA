function [  FISH_bb ] = FISH_atlas( imgPath, imgNum, imgType )
tmppath = imgPath; % 图像所在文件夹路径
tmpnum = imgNum;   % 图像张数
tmptype = imgType; % 图像后缀名

% FISH = zeros(1, tmpnum+1); % image number + time
FISH_bb=zeros(1,tmpnum+1);
% t0 = cputime;
% for i=0:tmpnum-1
%     img=imread(strcat(tmppath,num2str(i),tmptype));
%     sh1 = fish(img);
%     FISH(1,i+1)=sh1;
% end
% FISH(1, tmpnum+1) = cputime - t0;

t0 = cputime;
for i=0:tmpnum-1
    img=imread(strcat(tmppath,num2str(i),tmptype));
    [sh2, ~] = fish_bb(img);
    FISH_bb(1,i+1)=sh2;
end
FISH_bb(1, tmpnum+1) = cputime - t0;

end

