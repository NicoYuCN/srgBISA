
clear all;
clc

% ps='img3.bmp';
% img = imread(ps); 
% 
% figure(1);imagesc(img);title('i');colormap gray; drawnow;
%         
% [sharpnessScore map]= MLVSharpnessMeasure(img);
% sharpnessScore
% % figure, imshow(map)
% figure(2);imagesc(map);title('s2'); colormap gray; drawnow;

% tic
% 
% clear all;
% clc;
% 
% for x=1:590
%     imageName1=strcat(num2str(x),'.JPG');
%     imageName2=strcat('F:\Image databases\ImageDatabase\ImageDatabase1\',imageName1);
%     
%     I=imread(imageName2);
%     [sharpnessScore map]= MLVSharpnessMeasure(I);
%     Q(x)=sharpnessScore;
%     q=Q'
% end
% 
% toc
% tic
% %img=imread('img1.bmp');
% MLV_score = zeros(1,145);
% for i=0:144
% % i=1;
% img=imread(strcat('F:\IQA2017\blur\LIVE_gblur\',num2str(i),'.bmp'));
% [sharpnessScore, ~]= MLVSharpnessMeasure(img);
% MLV_score(1,i+1)=sharpnessScore;
% end
% toc

tic
%img=imread('img1.bmp');
MLV_score = zeros(1,150);
for i=0:9
% i=1;
img=imread(strcat('F:\IQA2017\blur\CSIQ_blur\',num2str(i),'.png'));
[sharpnessScore, ~]= MLVSharpnessMeasure(img);
MLV_score(1,i+1)=sharpnessScore;
end
toc
% imwrite(map,'Dragon.bmp')
% figure, imshow(map)
% figure,  imshow(mat2gray(map)*1)
%  save('F:/IQA2017/blur_score/LIVE/LPC_score.mat');

