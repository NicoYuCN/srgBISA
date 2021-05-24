%% Matlab code, RISE

clc
clear
close all
%%
CISQ_RISE=zeros(1,151);
%% Read  image
t0 = cputime;
for i=0:149
    img=imread(strcat('F:\IQA2017\blur\CSIQ_blur\',num2str(i),'.png'));
%figure,imshow(img)  
scale = 3;
%% compute quality score
score = RISE(img,scale);
CISQ_RISE(1,i+1)=score;
end
RISE_score(1, 151) = cputime - t0;
%%
clear all;
RISE_score=zeros(1,146);
%% Read  image
t0 = cputime;
for i=0:144
    img=imread(strcat('F:\IQA2017\blur\LIVE_gblur\',num2str(i),'.bmp'));

%figure,imshow(img)  
scale = 3;
%% compute quality score
score = RISE(img,scale);
live_RISE(1,i+1)=score;
end
RISE_score(1, 146) = cputime - t0;

%%
clear all;
RISE_score=zeros(1,101);
%% Read  image
t0 = cputime;
for i=0:99
    img=imread(strcat('F:\IQA2017\blur\TID2008_blur\',num2str(i),'.bmp'));

%figure,imshow(img)  
scale = 3;
%% compute quality score
score = RISE(img,scale);
TID2008_RISE(1,i+1)=score;
end
RISE_score(1, 101) = cputime - t0;

%%
clear all;
RISE_score=zeros(1,126);
%% Read  image
t0 = cputime;
for i=0:124
    img=imread(strcat('F:\IQA2017\blur\TID2013_blur\',num2str(i),'.bmp'));

%figure,imshow(img)  
scale = 3;
%% compute quality score
score = RISE(img,scale);
TID2013_RISE(1,i+1)=score;
end
RISE_score(1, 126) = cputime - t0;
save('F:\IQA2017\blur_score\testRISE');