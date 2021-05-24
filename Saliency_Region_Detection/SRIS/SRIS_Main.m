function[ mask] = SRIS_Main(imgfile)
% Copyright (c) 2020, Aditi Joshi and Kwang Nam Choi, Chung-Ang University
% All rights reserved.
% Freely distributed for educational and research purposes only.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% Cite: A. Joshi, M. S. Khan, S. Soomro, A. Niaz, B. S. Han and K. N. Choi, 
%       "SRIS: Saliency-Based Region Detection and Image Segmentation of COVID-19 
%       Infected Cases," IEEE Access, vol. 8, pp. 190487-190503, 2020.
 
%%
%clear;clc;close
%% input image
Img =imread(imgfile);% imread('/Users/liusiqi/Desktop/code/BISA/blur/IQA_ref_img/CSIQ_ref_img/cactus.png');
color_space = 'rgb';    % Choose hsv for real images or rgb for synthetic images

%% Parameter set
timestep = 1;           % time step
mu = 0.2;               % coefficient of the distance regularization term P(phi)
max_iter = 20;          % the maximum iteration time
lambda = 0.01;          % weight of color intensity energy 
alfa = 0.06;            % weight of saliency energy inside zero level set
beta = 5;               % coefficient of penalization of the length of contour L(phi)
epsilon = 1.5;          % papramater that specifies the width of the DiracDelta function
sigma = 1;              % scale parameter in Gaussian kernel

%%
[rows, cols,~] = size(Img);
T1 = rows.*cols.*0.005;
T2 = rows.*cols.*0.001;
if size(Img,3) ~= 3
    Img = repmat(Img,1,1,3);
end
if strcmp(color_space,'hsv')
    Img_hsv = rgb2hsv(Img);
    Img_gray = hsv_gray(Img_hsv);
    Img_gray = Img_gray.*100;
else
    Img_hsv = Img;
    Img_gray = rgb2gray(Img);
    Img_gray = double(Img_gray);
end

%% edge indicator
G = fspecial('gaussian',3,sigma);       % Gaussian kernel
Img_smooth = conv2(Img_gray,G,'same');  % smooth image by Gaussiin convolution
[Ix,Iy] = gradient(Img_smooth);
f = Ix.^2+Iy.^2;
g = 1./(1+f);                           % edge indicator function.
%% initial level-set
c0=1;
phi = c0*ones(rows,cols);
phi(10:rows-10,10:cols-10) = -c0;
% 
% figure(1);
% subplot(221)
% imagesc(Img); axis off; axis equal; hold on
% contour(phi,[0,0],'r','LineWidth',2)
% title('Input image');
% 
% subplot(223)
% imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;
% contour(phi, [0,0], 'r','LineWidth',2);
% title('Contour evolution');

%% start iteration
flag = 0;
saliency = Saliency(Img);
% figure(1);subplot(222);
% imshow(saliency); title('Saliency map');

tic
for n=1:max_iter
    sa = ave_saliency(saliency,phi);
    c = ave(Img,Img_hsv,color_space,rows,cols,phi);
    if (flag == 1 || n>10)
        cha_c = 0;
    else
        cha_c = color_c(Img_hsv,Img_gray,saliency,color_space,c,sa,lambda,alfa);
    end
    phia = im2bw(phi,0);
    last_phia = phia;
    phi = sris(phi,g,beta,epsilon,mu,timestep,cha_c,Img_gray,c);    % Energy function
    phi = conv2(phi, G, 'same');
    
    phia = im2bw(phi,0);
    E = sum(sum(abs(phia - last_phia)));
    if E < T1
        flag = 1;
    end
    
%     figure(1);subplot(223)
%     imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray);   contour(phi, [0,0], 'r','LineWidth',2);
%     title(['Contour evolution, iteration = ' num2str(n)])
%     
    if (E < T2 && flag == 1)
        break;
    end
end
toc
% 
% phi = -phi;
% sum_in = 0;
% sum_out = 0;
% count_in = 0;
% count_out = 0;
% for i=1:rows
%     for j=1:cols
%         if(phi(i,j)>0)
%             count_in = count_in+1;
%             sum_in = sum_in + saliency(i,j);
%         else
%             count_out = count_out+1;
%             sum_out = sum_out + saliency(i,j);
%         end
%     end
% end
% if(sum_in/count_in < sum_out/count_out)
%     phi = -phi;
% end
% %im2bw使用阈值（threshold）变换法把灰度图像（grayscale image）转换成二值图像
% % figure(1); subplot(224)
% % imshow(phia);
% % title('Final Segmentation')

% thresh=graythresh(phi);
% phia = im2bw(phi,thresh);
% newphia=phi*255/max(max(phi))-min(min(phi));
% thresh=graythresh(newphia)
% phia = im2bw(newphia,thresh);
%phia = im2bw(phi,0);
mask =~phia;
%imwrite(mask,'mask.png');
%mask=roipoly(Img); 



