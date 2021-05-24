function [ RISE_score ] = RISE_atlas( imgPath, imgNum, imgType )
tmppath = imgPath; % ͼ�������ļ���·��
tmpnum = imgNum;   % ͼ������
tmptype = imgType; % ͼ���׺��

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

