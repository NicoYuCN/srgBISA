close all
clc
clear all

%%
tic
svcscore=zeros(1,150);
for i=0:149
img=imread(strcat('F:\IQA2017\blur\CSIQ_blur\',num2str(i),'.png'));
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
svcscore(1,i+1)=BlurPred;
end
toc
% save('F:/IQA2017/blur_score/TID2013/svcscore.mat');
%%
clear all;
tic
svcscore=zeros(1,145);
for i=0:144
img=imread(strcat('F:\IQA2017\blur\LIVE_gblur\',num2str(i),'.bmp'));

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
svcscore(1,i+1)=BlurPred;
end
toc

%%
clear all;
tic
svcscore=zeros(1,100);
for i=0:99
img=imread(strcat('F:\IQA2017\blur\TID2008_blur\',num2str(i),'.bmp'));

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
svcscore(1,i+1)=BlurPred;
end
toc

%%
clear all;
tic
svcscore=zeros(1,125);
for i=0:124
img=imread(strcat('F:\IQA2017\blur\TID2013_blur\',num2str(i),'.bmp'));
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
svcscore(1,i+1)=BlurPred;
end
toc