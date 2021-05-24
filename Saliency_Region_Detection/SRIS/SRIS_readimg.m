function [ ] = SRIS_readimg()
clear;clc;close
mode='test_single';
%'ref2blur';%'salient_detect';
if strcmp(mode,'test_single')==1
    imgfile='D:\ProgramData\CASEUNet\docu_bin\BCDUnet_DIBCO-master\DIBCO\2016\DIPCO2016_dataset\1.bmp';
    outfile='D:\ProgramData\CASEUNet\docu_bin\BCDUnet_DIBCO-master\DIBCO\2016\DIPCO2016_dataset\1_sris.bmp';
    mask=SRIS_Main(imgfile);
    imwrite(mask,strcat(outfile));
end
if strcmp(mode,'ref2blur')==1

    refPath='/Users/liusiqi/Desktop/code/BISA/blur/IQA_ref_img/CSIQ_ref_img/';
    maskPath='/Users/liusiqi/Desktop/code/BISA/result_SRIS/ref_mask_img/';
    resultPath='/Users/liusiqi/Desktop/code/BISA/result_SRIS/CSIQ_salientmap_ref_to_blur/';
    imgPath='/Users/liusiqi/Desktop/code/BISA/blur/CSIQ_blur/';
    reffile=dir([refPath,'*.png']);
    
    tmpnum=30;
    for j=1:tmpnum%??????

        
        mask=SRIS_Main(strcat(refPath,reffile(j).name));
        imwrite(mask,strcat(maskPath,reffile(j).name));  
        for i=1:5
        
            img=imread(strcat(imgPath,num2str(j*5-i),'.png'));
        
        
            %mask=roipoly(Img); 
            red=immultiply(mask,img(:,:,1)); 
            blue=immultiply(mask,img(:,:,3)); 
            green=immultiply(mask,img(:,:,2)); 
            result=cat(3,red,green,blue);

            result_path=strcat(resultPath,num2str(j*5-i),'.png')
            imwrite(result,result_path);  
        end
    end
   
end

if strcmp(mode,'salient_detect')==1

    imgPath='/Users/liusiqi/Desktop/code/BISA/blur/';
    %refimgPath='/Users/liusiqi/Desktop/code/BISA/blur/IQA_ref_img/CSIQ_ref_img/family.png'
    imgfile=scanDir(imgPath);%datatype is cell,{} refers to content,() refers to position
    result_imgfile=strrep(imgfile,'/blur/','/result_SRIS/');
    %refimgfile=scanDir(refimgPath);
    mask_imgfile=strrep(imgfile,'/blur/','/mask_SRIS/');
    %refimgfile=scanDir(refimgPath);

    for j=1:length(imgfile)%??????
        result_imgfile{j}
        mask=SRIS_Main(imgfile{j});
        Img =imread(imgfile{j});
        imwrite(mask,mask_imgfile{j});
        red=immultiply(mask,Img(:,:,1)); 
        blue=immultiply(mask,Img(:,:,3)); 
        green=immultiply(mask,Img(:,:,2)); 
        result=cat(3,red,green,blue);
        imwrite(result,result_imgfile{j});



    end
end