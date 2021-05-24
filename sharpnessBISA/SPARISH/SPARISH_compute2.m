function SPARISH = SPARISH_compute2(img,Dic,L,lamba,x)

if (~exist('L'))
   L=6;
end

if (~exist('lamba'))
   lamba=0.03;
end

if (~exist('x'))
   x=0.6;
end

 load Dic.mat; %trained dictionary

[img_block,var_gray]=blocks(img);
 
%% 灰度信息稀疏表示系数
A_gray=OMP(Dic,img_block,L);  
A_gray=full(A_gray);
% A_gray=sum(abs(A_gray));
A_gray=sum(A_gray.*A_gray);

  
%% 对|A|进行递减排列，其对应的std_block也随|A|变化
n=size(A_gray,2);
temp_gray=zeros(2,n);
temp_gray(1,:)=A_gray;
temp_gray(2,:)=var_gray;
% temp_gray(2,:)=A_gray;
% temp_gray(1,:)=var_gray;
  
temp_gray=temp_gray';
sort_temp_gray=sortrows(temp_gray,-2);

 m=floor(x*n); %取 |A|最大的x%计算
 
SPARISH=sum(sort_temp_gray(1:m,1))/sum(sort_temp_gray(1:m,2));
% SHARISH=sum(sort_temp_gray(1:m,2))/sum(sort_temp_gray(1:m,1));

end

