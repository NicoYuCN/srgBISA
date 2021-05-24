clear all;clc;
%%
tic
s3score=zeros(1,150);
for i=0:149
img=imread(strcat('F:\IQA2017\blur\CSIQ_blur\',num2str(i),'.png'));
img=double(rgb2gray(img));

[s_map1 s_map2 s3] = s3_map(img);

[m,n]=size(s3);
sort_s3=sort(s3(:),'descend');
N=floor(m*n/100);
b=sum(sort_s3(1:N,:));
Q=b/N;
s3score(1,i+1)=Q;
end
toc
% for x=241:590
%     imageName1=strcat(num2str(x),'.JPG');
%     imageName2=strcat('F:\Image databases\ImageDatabase\ImageDatabase1\',imageName1)
%     I=imread(imageName2);
%     img=double(rgb2gray(I));
% 
%     [s_map1 s_map2 s3] = s3_map(img);
%     
%     [m,n]=size(s3);
%     sort_s3=sort(s3(:),'descend');
%     N=floor(m*n/100);
%     b=sum(sort_s3(1:N,:));
%     Q(x)=b/N;
%     q=Q'
%     
% end

% save('F:/IQA2017/blur_score/LIVE/s3_score.mat');
%%
clear all;
s3score=zeros(1,145);
for i=0:144
img=imread(strcat('F:\IQA2017\blur\LIVE_gblur\',num2str(i),'.bmp'));
img=double(rgb2gray(img));

[s_map1 s_map2 s3] = s3_map(img);

[m,n]=size(s3);
sort_s3=sort(s3(:),'descend');
N=floor(m*n/100);
b=sum(sort_s3(1:N,:));
Q=b/N;
s3score(1,i+1)=Q;
end
toc


%%
clear all;
tic
s3score=zeros(1,100);
for i=0:99
img=imread(strcat('F:\IQA2017\blur\TID2008_blur\',num2str(i),'.bmp'));
img=double(rgb2gray(img));

[s_map1 s_map2 s3] = s3_map(img);

[m,n]=size(s3);
sort_s3=sort(s3(:),'descend');
N=floor(m*n/100);
b=sum(sort_s3(1:N,:));
Q=b/N;
s3score(1,i+1)=Q;
end
toc

%%
clear all;
tic
s3score=zeros(1,125);
for i=0:124
img=imread(strcat('F:\IQA2017\blur\TID2013_blur\',num2str(i),'.bmp'));
img=double(rgb2gray(img));

[s_map1 s_map2 s3] = s3_map(img);

[m,n]=size(s3);
sort_s3=sort(s3(:),'descend');
N=floor(m*n/100);
b=sum(sort_s3(1:N,:));
Q=b/N;
s3score(1,i+1)=Q;
end
toc