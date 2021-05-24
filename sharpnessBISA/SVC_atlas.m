function [ SVC ] = SVC_atlas( imgPath, imgNum, imgType )
tmppath = imgPath; % 图像所在文件夹路径
tmpnum = imgNum;   % 图像张数
tmptype = imgType; % 图像后缀名

SVC = zeros(1, tmpnum+1); % image number + time
t0 = cputime;
for i=0:tmpnum-1
    img=imread(strcat(tmppath,num2str(i),tmptype));
    img = double( rgb2gray(img) );
% figure,imshow(uint8(img))
C=50;
[U,S,V] = svd(img);
X = diag(S) ;
idx = find(X>C);
X2 = X(idx);

num = 1:length(X2);
X3 = log(1./X2);
A = log(num); 

Numerator = sum(A.*X3');
Denominator = sum(A.*A);

BlurPred = Numerator/Denominator;
SVC(1,i+1)=BlurPred;
end
SVC(1, tmpnum+1) = cputime - t0;

end

