% Test FISH and FISH_bb with image 'lena.png'

clc;
clear;
close all;
%%
tic
fishscore=zeros(1,150);
for i=0:149
img=imread(strcat('F:\IQA2017\blur\CSIQ_blur\',num2str(i),'.bmp'));
sh1 = fish(img);
fishscore1(i+1)=sh1;
[sh2, ~] = fish_bb(img);
fishscore(i+1)=sh2;
end
% figure, imshow(map,[]);
toc
save('F:/IQA2017/blur_score/TID2013/FISH_score.mat');