function score = bible_func(img_dst,img_gradient,order,blkSZ,img_orgdst)

if (~exist('order'))
   order = blkSZ-1;
end

if (~exist('blkSZ'))
   blkSZ = 8;
end

[img_block,var_gray,Rnum,Cnum]=block_func(img_dst,img_gradient,blkSZ);
%% 2. SDSP saliency
saliencyMap = SDSP(img_orgdst);
saliencyMap = mat2gray( imresize(saliencyMap, [Rnum Cnum], 'bilinear') );

for k=1:size(img_block,2)
    block = reshape(img_block(:,k),blkSZ,blkSZ);
    mmt = TM_function(block,order);       % Tchebichef moment
        
    mmt(1,1)=0; % remove DC component
    Energy(1,k)= sum(sum(mmt.^2));
end


%% pooling using visual saliency 
saliencyweight = reshape(saliencyMap,1,Rnum*Cnum);

score = sum(Energy.*saliencyweight)/sum(var_gray.*saliencyweight);

end

