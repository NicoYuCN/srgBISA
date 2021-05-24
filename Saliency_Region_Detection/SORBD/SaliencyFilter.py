from sys import argv
import cv2
import math
import numpy as np
import matplotlib.pyplot as plt
from skimage import img_as_float;
from skimage import img_as_bool;
from skimage.color import rgb2lab
from skimage.segmentation import slic
from scipy import ndimage as nd
from scipy.spatial.distance import cdist
from scipy.stats import norm
import time


def Uniqueness(img,number=0.25):
	M,N=img.shape[:2];

	lab_image = cv2.cvtColor(np.float32(img/255.0),cv2.COLOR_BGR2LAB)/1.0;

	blur_image2=np.einsum('ijk,ijk->ij',lab_image,lab_image)

	blur_image = cv2.GaussianBlur(lab_image, (N-1+(N%2),M-1+(M%2)), number*math.sqrt(M*N), borderType=cv2.BORDER_REPLICATE)
	blur_image2 = cv2.GaussianBlur(blur_image2, (N-1+(N%2),M-1+(M%2)), number*math.sqrt(M*N), borderType=cv2.BORDER_REPLICATE)


	UniquenessMap=np.einsum('ijk,ijk->ij',lab_image,lab_image)+blur_image2-2*np.einsum('ijk,ijk->ij',lab_image,blur_image);
	minR=UniquenessMap.min();
	maxR=UniquenessMap.max();

	bigMap = 255*(UniquenessMap-minR)/(maxR-minR)
	return bigMap

def Distribution(img,std = 20, scale = 1, kernel_size = 253):
	A,B=img.shape[:2];
	a,b =int(A/scale),int(B/scale);

	small_image = cv2.cvtColor(np.float32(img/255.0),cv2.COLOR_BGR2LAB)
	midMapi = np.zeros((256,256,256), np.double)
	midMapj = np.zeros((256,256,256), np.double)
	m2_ = np.zeros((256,256,256), np.double)
	w = np.zeros((256,256,256), np.double)
	bigMap = np.zeros((a,b), np.double)

	for i in range(a):
		for j in range(b):
			L = int(small_image[i][j][0])
			A = int(small_image[i][j][1])
			B = int(small_image[i][j][2])
			v = np.zeros(2, np.double)
			v[0] = i
			v[1] = j
			midMapi[L][A][B] += i
			midMapj[L][A][B] += j
			m2_[L][A][B] += np.dot(v,v)
			w[L][A][B] += 1

	m1 = np.zeros((256,256,256,2), np.double)

	m1[:,:,:,0] = nd.filters.gaussian_filter(midMapi, std, mode='constant', cval=0.0, truncate=len(midMapi)/std)
	m1[:,:,:,1] = nd.filters.gaussian_filter(midMapj, std, mode='constant', cval=0.0, truncate=len(midMapi)/std)
	m1_ = nd.filters.gaussian_filter(m2_, std, mode='constant', cval=0.0, truncate=len(midMapi)/std)
	w = nd.filters.gaussian_filter(w, std, mode='constant', cval=0.0, truncate=len(midMapi)/std)

	maxMap = 0
	minMap = 255


	for i in range(a):
		for j in range(b):
			L = int(small_image[i][j][0])
			A = int(small_image[i][j][1])
			B = int(small_image[i][j][2])
			mean = np.dot(m1[L,A,B],m1[L,A,B])
			meanSquare = m1_[L,A,B]
			bigMap[i][j] = (meanSquare-mean/w[L,A,B])/w[L,A,B]
			minMap = min(minMap, bigMap[i][j])
			maxMap = max(maxMap,bigMap[i][j])

	return ((bigMap-minMap), np.uint8(255*(bigMap-minMap)/(maxMap-minMap)))

def anotherMap(img0,img1):
	a,b = img0.shape[:2]

	r = np.zeros((a,b), np.double)
	print(a,b)
	maxR = 0.0
	minR = 255
	small_image = cv2.cvtColor(np.float32(img0/255.0),cv2.COLOR_BGR2LAB)
	S_ = np.zeros((256,256,256), np.double)
	W = np.zeros((256,256,256), np.double)
	std = 6

	S = cv2.GaussianBlur(img1, (b-1+b%2,a-1+a%2), std, borderType=cv2.BORDER_REPLICATE)
	for i in range(a):
		for j in range(b):
			L = int(small_image[i][j][0])
			A = int(small_image[i][j][1])
			B = int(small_image[i][j][2])
			S_[L][A][B] += S[i][j]
			W[L][A][B] += 1

	S_ = nd.filters.gaussian_filter(S_, std, mode='constant', cval=0.0)
	W = nd.filters.gaussian_filter(W, std, mode='constant', cval=0.0)
	for i in range(a):
		for j in range(b):
			L = int(small_image[i][j][0])
			A = int(small_image[i][j][1])
			B = int(small_image[i][j][2])
			r_ = S_[L][A][B]/W[L][A][B]
			r[i,j] = r_

	minR=r.min()
	maxR=r.max()

	return np.uint8(255*((r-minR)/(maxR-minR)))

def remap(r1,r2,k=0.02):

	r=(r1/1.0)*np.exp(-k*r2/1.0);
	maxR = r.max()
	minR = r.min()
	return ((r-minR),np.uint8(255*((r-minR)/(maxR-minR))))
import os
from skimage.filters import threshold_otsu
if __name__ == '__main__':
	# if(len(argv)!=2):
	# 	print ("python Scratch.py #ImageName")
	Base_path = 'F:/IQA2017/'
	Img_path = ['CSIQ_blur', 'LIVE_gblur', 'TID2013_blur']  # ['IQA_ref_img/CSIQ_ref_img']
	N=5
	for n in range(1,N+1):
		for i in range(len(Img_path)):
			imgpath = os.path.join(Base_path, 'blur', Img_path[i])
			outpath = os.path.join(Base_path, 'SaliencyFilter/mask'+str(n), Img_path[i])
			if (os.path.exists(outpath) == False):
				os.makedirs(outpath)

				os.makedirs((outpath + '/BinMask'))
				os.makedirs((outpath + '/Saliency'))
			else:
				pass
			# print(imgpath)
			imgfile = os.listdir(imgpath)
			for imgname in imgfile:
				if imgname.endswith('jpg') or imgname.endswith('png')or imgname.endswith('bmp'):
					filename = os.path.join(imgpath,imgname)#str(argv[1])
					print(filename)
					rgb_image = cv2.imread(filename)
					U = Uniqueness(rgb_image,0.25)
					#cv2.imwrite(outpath+"/Uniqueness_"+imgname, U);


					D = Distribution(rgb_image, 17, 1)
					#cv2.imwrite(outpath+"/Distribution_"+imgname, ~D[1]);


					result = remap(U,D[0]/(len(D[0])*len(D[0][0])), 6)
					Final_Saliency = anotherMap(rgb_image,result[0])
					out=Final_Saliency
					cv2.imwrite(outpath + '/Saliency/' + imgname, out)

					#print(out.shape)
					global_thresh = threshold_otsu(out)
					binary_global = out > global_thresh
					cv2.imwrite(outpath + '/BinMask/' + imgname, 255 * binary_global.astype('uint8'))

					bgdModel = np.zeros((1, 65), np.float64)
					fgdModel = np.zeros((1, 65), np.float64)

					mask = np.zeros(rgb_image.shape[:2], np.uint8)
					mask[binary_global == False] = 0
					mask[binary_global == True] = 1

					mask, bgdModel, fgdModel = cv2.grabCut(rgb_image, mask, None, bgdModel, fgdModel, 5,
														   cv2.GC_INIT_WITH_MASK)
					mask = np.where((mask == 2) | (mask == 0), 0, 1).astype('uint8')
					fin_img = rgb_image * mask[:, :, np.newaxis]
					# fig = plt.figure("gray_image")
					# ax = fig.add_subplot(1,1,1)
					# ax.imshow(Final_Saliency)
					# plt.axis("off")
					# plt.show()
					outfile=outpath +'/'+ imgname
					print(outfile)
					cv2.imwrite(outfile, fin_img)

