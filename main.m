        % Integrate all code in one file
clear; close all; clc;
mm={'SaliencyFilter'};%'SRIS','tp17','SORBD','SaliencyFilter'};%,'tp17','SORBD','SRIS','SaliencyFilter','Basnet'};
basePath='F:/IQA2017/';
database={'TID2013_blur','LIVE_gblur','CSIQ_blur'};
data_Num={'125','145','150'};
data_Type={'.bmp','.bmp','.png'};
method={'data_MEW','data_CPBD','data_S3','data_FISH','data_SVC','data_LPC','data_MLV','data_SPARISH','data_BIBLE','data_RISE'};

% method={'data_MEW','data_JNB','data_CPBD','data_S3','data_FISH_bb','data_SVC','data_LPC','data_MLV','data_ARISMC','data_SPARISH','data_BIBLE','data_RISE'};
N=5;
for n=1:N
    for z=1:length(mm)
        m=mm{z};
        mode={'blur','center_crop',[m,'/saliency_rectcrop'],[m,'/saliency_rect']};
        rmode={'blur','center_crop',[m,'_saliency_rectcrop'],[m,'_saliency_rect']};

        for i=1:length(database)
            datax=load([basePath,database{i},'.txt']);
            imgNum=str2num(data_Num{i});
            imgType=data_Type{i}; 

            imgPath=[basePath,mode{1},'/',database{i},'/'];

            crop_imgPath=[basePath,mode{2},'/',database{i},'/'];
            if ~exist(crop_imgPath,'dir')
                mkdir(crop_imgPath);
                fprintf('Cut out the center of the "%s" image.\n',database{i});     
                for c=0:imgNum-1%
                    img=imread(strcat(imgPath,num2str(c),imgType));
                    [w,h,~]=size(img);
                    cropimg=imcrop(img, [int32(w/3), int32(h/3), int32(w/3), int32(h/3)]);

                    imwrite(cropimg,strcat(crop_imgPath,num2str(c),imgType));  

                end
            end

            

            saliency_mask_imgPath=[basePath,m,'/mask',num2str(n),'/',database{i},'/'];
            saliency_rectcrop_imgPath=[basePath,mode{3},num2str(n),'/',database{i},'/'];
            saliency_rect_imgPath=[basePath,mode{4},num2str(n),'/',database{i},'/'];


            if ~exist(saliency_rectcrop_imgPath,'dir')

                mkdir(saliency_rect_imgPath);
                mkdir(saliency_rectcrop_imgPath);
                mkdir(saliency_mask_imgPath);
               
                fprintf('Generate the saliency detection rect image of "%s".\n',database{i});     
               
                switch(m) 
                case 'SRIS'

                    fprintf('SRIS:Generate the saliency detection mask image of "%s".\n',database{i});     
                   
                    for c=0:imgNum-1%
                        imgfile=strcat(imgPath,num2str(c),imgType);
                        Img =imread(imgfile);
                       
                        mask=SRIS_Main(imgfile);
                        imwrite(mask,strcat(saliency_mask_imgPath,num2str(c),imgType));
                        bw=im2bw(mask);
                        img_reg = regionprops(bw,  'area', 'boundingbox');
                        areas = [img_reg.Area];
                        rects = cat(1,  img_reg.BoundingBox);
                        [~, max_id] = max(areas);
                        max_rect = rects(max_id, :);
                        rectcrop_img=imcrop(Img, max_rect);
                        imwrite(rectcrop_img,strcat(saliency_rectcrop_imgPath,num2str(c),imgType));

                      
                        [rol,cow]=find(bw==1);
                        rect=[min(cow),min(rol),max(cow)-min(cow)+1,max(rol)-min(rol)+1];
                        rect_img=imcrop(Img, rect);
                        imwrite(rect_img,strcat(saliency_rect_imgPath,num2str(c),imgType));
                        


                    end
                case 'tp17' 
                    fprintf('The EXE file needs to be executed on Windows' ); 


                    for c=0:imgNum-1%
                        imgfile=strcat(imgPath,num2str(c),imgType);                     
                        Img =imread(imgfile);
                       
                        mask=tp17_gen(saliency_mask_imgPath,imgPath,num2str(c),imgType);
                        [~,~,ch]=size(mask)

                        % get binary image
                        if ch==1
                            bw=im2bw(mask); 
                        else
                            gray_img = rgb2gray(mask);
                            T = graythresh(gray_img);
                            bw = im2bw(gray_img, T);
                        end
                        imwrite(bw,strcat(saliency_mask_imgPath,num2str(c),imgType));


                        img_reg = regionprops(bw,  'area', 'boundingbox');
                        areas = [img_reg.Area];
                        rects = cat(1,  img_reg.BoundingBox);
                        [~, max_id] = max(areas);
                        max_rect = rects(max_id, :);
                        rectcrop_img=imcrop(Img, max_rect);
                        imwrite(rectcrop_img,strcat(saliency_rectcrop_imgPath,num2str(c),imgType));

                        [rol,cow]=find(bw==1);
                        rect=[min(cow),min(rol),max(cow)-min(cow)+1,max(rol)-min(rol)+1];
                        rect_img=imcrop(Img, rect);
                        imwrite(rect_img,strcat(saliency_rect_imgPath,num2str(c),imgType));
                     


                    end


                case 'SORBD' 
                    fprintf('The Saliency Image generated on Python & Mask needs to be Bin' ); 
                    saliency_mask_imgPath=[basePath,m,'/mask/',database{i},'/BinMask/'];
                    for c=0:imgNum-1%
                        imgfile=strcat(imgPath,num2str(c),imgType);
                        mask_imgfile=strcat(saliency_mask_imgPath,num2str(c),imgType);

                        mask=imread(mask_imgfile);
                        Img =imread(imgfile);
                        bw=im2bw(mask);
                        img_reg = regionprops(bw,  'area', 'boundingbox');
                        areas = [img_reg.Area];
                        rects = cat(1,  img_reg.BoundingBox);
                        [~, max_id] = max(areas);
                        max_rect = rects(max_id, :);
                        rectcrop_img=imcrop(Img, max_rect);
                        imwrite(rectcrop_img,strcat(saliency_rectcrop_imgPath,num2str(c),imgType));

                       
                        [rol,cow]=find(bw==1);
                        rect=[min(cow),min(rol),max(cow)-min(cow)+1,max(rol)-min(rol)+1];
                        rect_img=imcrop(Img, rect);
                        imwrite(rect_img,strcat(saliency_rect_imgPath,num2str(c),imgType));
                       

                    end
                case 'SaliencyFilter'
                    fprintf('The Saliency Image generated on Python & Mask needs to be Bin' ); 
                    saliency_mask_imgPath=[basePath,m,'/mask/',database{i},'/BinMask/'];
                    for c=0:imgNum-1%
                        imgfile=strcat(imgPath,num2str(c),imgType);
                        mask_imgfile=strcat(saliency_mask_imgPath,num2str(c),imgType);

                        mask=imread(mask_imgfile);
                        Img =imread(imgfile);
                        bw=im2bw(mask);
                        img_reg = regionprops(bw,  'area', 'boundingbox');
                        areas = [img_reg.Area];
                        rects = cat(1,  img_reg.BoundingBox);
                        [~, max_id] = max(areas);
                        max_rect = rects(max_id, :);
                        rectcrop_img=imcrop(Img, max_rect);
                        imwrite(rectcrop_img,strcat(saliency_rectcrop_imgPath,num2str(c),imgType));

                       
                        [rol,cow]=find(bw==1);
                        rect=[min(cow),min(rol),max(cow)-min(cow)+1,max(rol)-min(rol)+1];
                        rect_img=imcrop(Img, rect);
                        imwrite(rect_img,strcat(saliency_rect_imgPath,num2str(c),imgType));
                    end
                case 'Basnet'
                    fprintf('The Saliency Image generated on Python & Mask needs to be Bin' ); 
                   
                    for c=0:imgNum-1%
                        imgfile=strcat(imgPath,num2str(c),imgType);
                        mask_imgfile=strcat(saliency_mask_imgPath,num2str(c),imgType);

                        mask=imread(mask_imgfile);
                        Img =imread(imgfile);
                        bw=im2bw(mask);
                        img_reg = regionprops(bw,  'area', 'boundingbox');
                        areas = [img_reg.Area];
                        rects = cat(1,  img_reg.BoundingBox);
                        [~, max_id] = max(areas);
                        if  max(areas)<1024%32*32
                                              
                            rectcrop_img=Img;
                            imwrite(rectcrop_img,strcat(saliency_rectcrop_imgPath,num2str(c),imgType));
                            rect_img=Img;
                            imwrite(rect_img,strcat(saliency_rect_imgPath,num2str(c),imgType));
                        else
                            max_rect = rects(max_id, :);
                            rectcrop_img=imcrop(Img, max_rect);
                            imwrite(rectcrop_img,strcat(saliency_rectcrop_imgPath,num2str(c),imgType));


                            [rol,cow]=find(bw==1);
                            rect=[min(cow),min(rol),max(cow)-min(cow)+1,max(rol)-min(rol)+1];
                            rect_img=imcrop(Img, rect);
                            imwrite(rect_img,strcat(saliency_rect_imgPath,num2str(c),imgType));
                        end
                    end
                    
                otherwise 
                                  
                   fprintf('Invalid Saliency mode' ); 
               
                end
            end

            for j=1:length(mode)

                if j<=2
                     imgPath=[basePath,mode{j},'/',database{i},'/'];
                     datamat=[basePath,'result/',rmode{j},'_',database{i},'.mat'];
                else
                     imgPath=[basePath,mode{j},int2str(n),'/',database{i},'/'];
                     datamat=[basePath,'result/',rmode{j},int2str(n),'_',database{i},'.mat'];
                end
               
                if ~exist( datamat,'file')

                    %RISE need to be executed in the subfolder of RISE£¨on windows£© 
%                     data_JNB = JNB_atlas( imgPath, imgNum, imgType );                            fprintf('dataset:"%s",mode:"%s",IQA:JNB\n',database{i}, mode{j});

                    data_RISE = RISE_atlas( imgPath, imgNum, imgType );                          fprintf('dataset:"%s",mode:"%s",IQA:RISE\n',database{i}, mode{j});

%                     data_ARISMC = ARISMC_atlas( imgPath, imgNum, imgType );                      fprintf('dataset:"%s",mode:"%s",IQA:ARISMC\n',database{i}, mode{j});
                    data_S3 = S3_atlas( imgPath, imgNum, imgType );                              fprintf('dataset:"%s",mode:"%s",IQA:S3\n',database{i}, mode{j});
                    data_LPC = LPC_atlas( imgPath, imgNum, imgType );                            fprintf('dataset:"%s",mode:"%s",IQA:LPC\n',database{i}, mode{j});
                    data_BIBLE = BIBLE_atlas( imgPath, imgNum, imgType );                        fprintf('dataset:"%s",mode:"%s",IQA:BIBLE\n',database{i}, mode{j});
                    data_CPBD = CPBD_atlas( imgPath, imgNum, imgType );                          fprintf('dataset:"%s",mode:"%s",IQA:CPBD\n',database{i}, mode{j});
                    data_MLV = MLV_atlas( imgPath, imgNum, imgType );                            fprintf('dataset:"%s",mode:"%s",IQA:MLV\n',database{i}, mode{j});
                    data_FISH= FISH_atlas( imgPath, imgNum, imgType );           fprintf('dataset:"%s",mode:"%s",IQA:FISH_bb\n',database{i}, mode{j});
                    data_MEW = Marziliano_atlas( imgPath, imgNum, imgType );                     fprintf('dataset:"%s",mode:"%s",IQA:Marziliano\n',database{i}, mode{j});
                    data_SVC = SVC_atlas( imgPath, imgNum, imgType );                            fprintf('dataset:"%s",mode:"%s",IQA:SVC\n',database{i}, mode{j});
                    data_SPARISH = SPARISH_atlas( imgPath, imgNum, imgType );                    fprintf('dataset:"%s",mode:"%s",IQA:SPARISH\n',database{i}, mode{j});

                    save(datamat)
                  


                    fprintf('The evaluation of data:"%s",mode:"%s".\n',database{i}, mode{j}); 
                    metric={'RMSE','PLCC','SRCC'};

%                     score ={' ','MEW','JNB','CPBD','S3','FISH','SVC','LPC','MLV','ARISMC','SPARISH','BIBLE','RISE'};
                    score ={' ','MEW','CPBD','S3','FISH','SVC','LPC','MLV','SPARISH','BIBLE','RISE'};
                    score{2,1}=[database{i},'_',mode{j},'_',metric{1}];
                    score{3,1}=[database{i},'_',mode{j},'_',metric{2}];
                    score{4,1}=[database{i},'_',mode{j},'_',metric{3}];

                    for k=1:length(method)  
                        variable_value=eval(method{k}); 
                        %BIQI(csiq,varia)
                        [RMSE, PLCC, SRCC]=BIQI(datax,variable_value(1,1:end-1)');
                        score{2,k+1}=RMSE;
                        score{3,k+1}=PLCC;
                        score{4,k+1}=SRCC;
                    end
                    save([basePath,'result/',rmode{j},int2str(n),'_',database{i},'_eval.mat'],'score')
                    %save([basePath, mode{j},'/',database{i},'_eval.mat'], 'score')
                else

                    fprintf('The evaluation of data:"%s",mode:"%s" has done.\n',database{i}, mode{j}); 

                end
            end

        end
    end
end
