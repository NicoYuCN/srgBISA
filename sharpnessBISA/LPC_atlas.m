function [ LPC ] = LPC_atlas( imgPath, imgNum, imgType )

tmppath = imgPath; % 图像所在文件夹路径
tmpnum = imgNum;   % 图像张数
tmptype = imgType; % 图像后缀名

LPC = zeros(1, tmpnum+1); % image number + time
t0 = cputime;
for i=0:tmpnum-1
    img=imread(strcat(tmppath,num2str(i),tmptype));
    img=rgb2gray(img);
    Q = lpc_si(img);
    LPC(1,i+1)=Q;
end
LPC(1, tmpnum+1) = cputime - t0;

end

