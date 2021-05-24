clear all;clc;
tic
for i=0:124
I=imread(strcat('F:\IQA2017\blur\TID2013_blur\',num2str(i),'.bmp'));
img=rgb2gray(I);
Q = CPBD_compute(img);
CPBD_score(i+1)=Q;
end
% for x=1:4
%     imageName1=strcat(num2str(x),'.png');
%     imageName2=strcat('E:\研究生学习资料\无参考质量评价\模糊算法融合\Data\',imageName1);
%     
%     I=imread(imageName2);
%     img=rgb2gray(I);
%     Q(x) = CPBD_compute(img);
%     q=Q'
% end
toc

save('F:/IQA2017/blur_score/TID2013/CPBD_score.mat');