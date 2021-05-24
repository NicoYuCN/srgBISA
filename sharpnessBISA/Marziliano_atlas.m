function [ Marziliano ] = Marziliano_atlas( imgPath, imgNum, imgType  )

tmppath = imgPath; % ͼ�������ļ���·��
tmpnum = imgNum;   % ͼ������
tmptype = imgType; % ͼ���׺��

Marziliano = zeros(1, tmpnum+1); % image number + time
t0 = cputime;
for i=0:tmpnum-1
    img=imread(strcat(tmppath,num2str(i),tmptype));
    img=rgb2gray(img);
   Q= marziliano(img);
Marziliano(1,i+1)=Q;
end
Marziliano(1, tmpnum+1) = cputime - t0;
end

