clear all;clc;
LPC_score1=zeros(4,175);
t0=cputime;
for i=0:149
img=imread(strcat('F:\IQA2017\BISA\blur\CSIQ_blur\',num2str(i),'.png'));
 %img=imread('monkey.bmp');
img=rgb2gray(img);
[si lpc_map] = lpc_si(img);
 LPC_score1(1,i+1)=si;
 end
LPC_score1(1,151)=cputime-t0;
% scales   = [1 3/2 2];
% w = [1 -3 2];
% norient  = 8;
% C = 2;
% Beta_k = 1e-4;
% 
% [row col]= size(img);
% B = round(min(row, col)/16);
% 
% [lpc_si lpc_map] = lpc_si(img, scales, w, C, Beta_k, norient, B);
% lpc_si
% figure, imshow(lpc_map)
% figure,  imshow(mat2gray(lpc_map)*1)
% imwrite(lpc_map,'squirrel.bmp')

% for x=1:4
%     imageName1=strcat(num2str(x),'.png');
%     imageName2=strcat('E:\研究生学习资料\模糊评价\模糊算法融合\Data\',imageName1);
%     
%     I=imread(imageName2);
%     I=rgb2gray(I);
%     [si lpc_map] = lpc_si(I);
%     Q(x)=si;
%     q=Q'
% end

 
% save('F:/IQA2017/blur_score/LIVE/LPC_score.mat');


%%

t0=cputime;
% LPC_score=zeros(1,145);
for i=0:144
img=imread(strcat('F:\IQA2017\BISA\blur\LIVE_gblur\',num2str(i),'.bmp'));
 %img=imread('monkey.bmp');
img=rgb2gray(img);
[si lpc_map] = lpc_si(img);
 LPC_score1(2,i)=si;
 end
LPC_score1(2,145)=cputime-t0;

%%

t0=cputime;
% LPC_score=zeros(1,100);
for i=0:99
img=imread(strcat('F:\IQA2017\BISA\blur\TID2008_blur\',num2str(i),'.bmp'));
 %img=imread('monkey.bmp');
img=rgb2gray(img);
[si lpc_map] = lpc_si(img);
 LPC_score1(3,i+1)=si;
 end
LPC_score1(3,151)=cputime-t0;


%%

t0=cputime;
% LPC_score=zeros(1,125);
for i=0:124
img=imread(strcat('F:\IQA2017\BISA\blur\TID2013_blur\',num2str(i),'.bmp'));
 %img=imread('monkey.bmp');
img=rgb2gray(img);
[si lpc_map] = lpc_si(img);
 LPC_score1(4,i+1)=si;
 end
LPC_score1(4,151)=cputime-t0;