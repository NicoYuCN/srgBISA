%================================================================
% image blocks 8*8
%================================================================

% function [jnd_block,signal_block]=blocks(image)
function [signal_block,var_block]=blocks(image)
% image=imread('1.bmp');
[m n z] = size(image);
if z > 1
    image = rgb2gray(image);
end
image=double(image);
rb = 8;
cb = 8;

% maximum block indices 
r = floor(m/rb);
c = floor(n/cb);

signal_block=zeros(rb*cb,r*c);
var_block=zeros(1,r*c);

k=0;
for i=1:r
    for j=1:c
        k=k+1;
        row = (rb*(i-1)+1):rb*i;
        col = (cb*(j-1)+1):cb*j;
        image_temp = image(row,col);

        [Gx Gy] = gradient(image_temp);
         graI = abs(Gx) + abs(Gy);  % Magnitude
        
         signal_block(:,k)=graI(:);
         var_block(:,k)=var2(image_temp); 
    end
end

% signal_block=gradient(signal_block);
% std_block=std(signal_block);

% signal_block(:,find(sum(abs(signal_block),1)==0))=[];
% std_block(std_block==0)=[];

% %%%=========��ͼ����=================
% function H_img=entropy(img)
% [m,n]=size(img);      %��ͼ��Ĺ��
% img_size=m*n;         %ͼ�����ص���ܸ���
% L=256;                %ͼ��ĻҶȼ�
% H_img=0;
% Nk=zeros(L,1);
% 
% for i=0:255
%     Nk(i+1,1)=sum(sum(img==i));      %ͳ��ÿ���Ҷȼ����صĵ���
% end
% %%%%%%%%%%%%%%%%%%%
% for k=1:L
%     P(k)=Nk(k)/img_size;                  %����ÿһ���Ҷȼ����ص���ռ�ĸ���
%     if P(k)~=0;                           %ȥ������Ϊ0�����ص�
%         H_img=-P(k)*log2(P(k))+H_img;     %����ֵ�Ĺ�ʽ
%     end
% end

% signal_block=zeros(rb*cb,r*c);
% % jnd_block=zeros(1,r*c);
% % widthjnb = [5*ones(1,51) 3*ones(1,205)];
% for i=1:r
%     for j=1:c
%         row = (rb*(i-1)+1):rb*i;
%         col = (cb*(j-1)+1):cb*j;
%         image_temp = image(row,col);
%  
%         decision = get_edgeblocks_mod(image_temp,T);
%         if (decision==1)
% %             contrast = get_contrast_block(image_temp);
% %             temp = widthjnb(contrast+1);
% %             jnd_block(1,i*j)=temp;
%             [Gx Gy] = gradient(image_temp);
%             % Magnitude
%             graI = abs(Gx) + abs(Gy);
%             signal_block(:,i*j)=image_temp(:);
%         end
%     end
% end
% 
% % jnd_block(jnd_block==0)=[];
% signal_block(:,find(sum(abs(signal_block),1)==0))=[];

% function im_out = get_edgeblocks_mod(img,T)
% % im_in = double(img);
% [im_in_edge] = edge(img,'canny');
% 
% [m,n] = size(im_in_edge);
% L = m*n;
% im_edge_pixels = sum(sum(im_in_edge));
% im_out = im_edge_pixels > (L*T) ;


