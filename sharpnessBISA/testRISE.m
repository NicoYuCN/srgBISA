 clear; close all; clc;
addpath('RISE\');
imgPath = 'F:\IQA2017\BISA\blur\LIVE_gblur\';    imgNum = 145;   imgType = '.bmp';
live_RISE = RISE_atlas( imgPath, imgNum, imgType );

imgPath = 'F:\IQA2017\BISA\blur\CSIQ_blur\';    imgNum = 150;   imgType = '.png';
CSIQ_RISE = RISE_atlas( imgPath, imgNum, imgType );

imgPath = 'F:\IQA2017\BISA\blur\TID2008_blur\';    imgNum = 100;   imgType = '.bmp'; 
TID2008_RISE = RISE_atlas( imgPath, imgNum, imgType ); 

imgPath = 'F:\IQA2017\BISA\blur\TID2013_blur\';    imgNum = 125;   imgType = '.bmp';
TID2013_RISE = RISE_atlas( imgPath, imgNum, imgType ); 

save('testRISE');
