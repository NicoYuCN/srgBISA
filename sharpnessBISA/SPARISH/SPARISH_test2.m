
%%
clear all;clc;
t0=cputime;
load Dic_pre.mat; %trained dictionary
 CSIQ_SPARISH=zeros(1,151);
% img=imread('1.bmp');
% L=6;
% [img_block,var_gray]=blocks(img);
% img_block=img_block(:,1:100);
% A_gray=OMP(Dic,img_block,L);  
for i=0:149
   img=imread(strcat('F:\IQA2017\BISA\blur\CSIQ_blur\',num2str(i),'.png'));
    [SPARISH] = SPARISH_compute2(img,Dic);
    CSIQ_SPARISH(1,i+1)=SPARISH;
end
 CSIQ_SPARISH(1,151)=cputime-t0;
%     save('F:/IQA2017/blur_score/TID2013/SPARISH_score.mat');


%%
t0=cputime;
load Dic_pre.mat; %trained dictionary
 LIVE_SPARISH=zeros(1,146);
% img=imread('1.bmp');
% L=6;
% [img_block,var_gray]=blocks(img);
% img_block=img_block(:,1:100);
% A_gray=OMP(Dic,img_block,L);  
for i=144
   img=imread(strcat('F:\IQA2017\BISA\blur\LIVE_gblur\',num2str(i),'.bmp'));
    [SPARISH] = SPARISH_compute2(img,Dic);
    LIVE_SPARISH(1,i+1)=SPARISH;
end
%  LIVE_SPARISH(1,146)=cputime-t0;
%     save('F:/IQA2017/blur_score/TID2013/SPARISH_score.mat');


%%
t0=cputime;
load Dic_pre.mat; %trained dictionary
 TID2008_SPARISH=zeros(1,101);
% img=imread('1.bmp');
% L=6;
% [img_block,var_gray]=blocks(img);
% img_block=img_block(:,1:100);
% A_gray=OMP(Dic,img_block,L);  
for i=0:99
   img=imread(strcat('F:\IQA2017\BISA\blur\TID2008_blur\',num2str(i),'.bmp'));
    [SPARISH] = SPARISH_compute2(img,Dic);
    TID2008_SPARISH(1,i+1)=SPARISH;
end
TID2008_SPARISH(1,101)=cputime-t0;

%%
t0=cputime;
load Dic_pre.mat; %trained dictionary
 TID2013_SPARISH=zeros(1,126);
% img=imread('1.bmp');
% L=6;
% [img_block,var_gray]=blocks(img);
% img_block=img_block(:,1:100);
% A_gray=OMP(Dic,img_block,L);  
for i=0:124
   img=imread(strcat('F:\IQA2017\BISA\blur\TID2013_blur\',num2str(i),'.bmp'));
    [SPARISH] = SPARISH_compute2(img,Dic);
    TID2013_SPARISH(1,i+1)=SPARISH;
end
TID2013_SPARISH(1,126)=cputime-t0;