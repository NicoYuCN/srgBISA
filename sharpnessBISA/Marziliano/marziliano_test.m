clear all;clc;
%%
tic
marziliano_score=zeros(1,150);
for i=0:149
img=imread(strcat('F:\IQA2017\blur\CSIQ_blur\',num2str(i),'.png'));
% img=imread('img1.bmp');
img=rgb2gray(img);
Q= marziliano(img);
marziliano_score(1,i+1)=Q;
end
 toc
% for x=1:4
%     imageName1=strcat(num2str(x),'.png');
%     imageName2=strcat('E:\研究生学习资料\无参考质量评价\模糊算法融合\Data\',imageName1);
%     
%     I=imread(imageName2);
%     img=rgb2gray(I);
%     Q(x) = marziliano(img);
%     q=Q'
% end
%     save('F:/IQA2017/blur_score/CSIQ/marziliano_score.mat');
   
%%
tic
marziliano_score=zeros(1,145);
for i=0:144
img=imread(strcat('F:\IQA2017\blur\LIVE_gblur\',num2str(i),'.bmp'));
% img=imread('img1.bmp');
img=rgb2gray(img);
Q= marziliano(img);
marziliano_score(1,i+1)=Q;
end
 toc
 
 %%
tic
marziliano_score=zeros(1,100);
for i=0:99
img=imread(strcat('F:\IQA2017\blur\TID2008_blur\',num2str(i),'.bmp'));
% img=imread('img1.bmp');
img=rgb2gray(img);
Q= marziliano(img);
marziliano_score(1,i+1)=Q;
end
 toc
 
 %%
tic
marziliano_score=zeros(1,125);
for i=0:124
img=imread(strcat('F:\IQA2017\blur\TID2013_blur\',num2str(i),'.bmp'));
% img=imread('img1.bmp');
img=rgb2gray(img);
Q= marziliano(img);
marziliano_score(1,i+1)=Q;
end
 toc