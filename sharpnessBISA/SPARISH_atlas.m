function [ SPARISH ] = SPARISH_atlas( imgPath, imgNum, imgType )
tmppath = imgPath; % ͼ�������ļ���·��
tmpnum = imgNum;   % ͼ������
tmptype = imgType; % ͼ���׺��
load Dic_pre.mat;
SPARISH = zeros(1, tmpnum+1); % image number + time
t0 = cputime;
for i=0:tmpnum-1
    img=imread(strcat(tmppath,num2str(i),tmptype));
    [score] = SPARISH_compute2(img,Dic);
    SPARISH(1,i+1)=score;
end
SPARISH(1, tmpnum+1) = cputime - t0;
end

