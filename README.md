# Salient region guided blind image sharpness assessment
In this study, three `salient region detection (SRD)` methods and ten BISA models are jointly explored, and the output saliency maps from SRD methods are re-organized as the input of BISA models.

At last, experiments are conducted on three Gaussian blurring image databases and the prediction performance is evaluated.
![捕获](https://user-images.githubusercontent.com/37394978/119085145-bb19df00-ba35-11eb-841a-d7d9c7c47ba5.PNG)

# Datasets
We have reported experimental results on different IQA datasets including [TID2013](http://www.ponomarenko.info/tid2013.htm), [LIVE](http://live.ece.utexas.edu/research/quality/subjective.htm), [CSIQ](http://vision.eng.shizuoka.ac.jp/mod/page/view.php?id=23).
Note: You need to download the corresponding datasets.
# Usage


* Saliency_Region_Detection --- The generation of salient region masks.
* sharpnessBISA --- blind image sharpness assessment methods
* main.py --- You need to change the base_Path value according to the location of the files.


# Requirements
* Matlab R2018a to implement main.m 
* Python 3.6 to generate salient region mask of SRD_SORBD
* Windows operating system to execute the EXE files of SRD_SRIS and SRD_DPLSG

# Reference resources
感谢以下的项目,排名不分先后

* A. Joshi, M. S. Khan, S. Soomro, A. Niaz, B. S. Han and K. N. Choi, ["SRIS: Saliency-Based Region Detection and Image Segmentation of COVID-19 Infected Cases,"](https://github.com/Adijo1603/SRIS) IEEE Access, vol. 8, pp. 190487-190503, 2020.
* Zhou L, Yang Z, Zhou Z, et al. [Salient Region Detection using Diffusion Process on a 2-Layer Sparse Graph[J]](https://github.com/lizhounaa/salient-region-detection-tip17). IEEE Transactions on Image Processing, 2017, 26(12): 5882 - 5894.
* Zhu, Wangjiang and Liang, Shuang and Wei, Yichen and Sun, Jian. [Saliency optimization from robust background detection.](https://github.com/avinash-vadlamudi/Saliency-Extraction)Proceedings of the IEEE conference on computer vision and pattern recognition 2014, 2814–2821.
* Dai G ,  Wang Z ,  Li Y , et al. [Evaluation of no-reference models to assess image sharpness[C]](https://www.researchgate.net/publication/320637084_Evaluation_of_no-reference_models_to_assess_image_sharpness)// 2017 IEEE International Conference on Information and Automation (ICIA). IEEE, 2017.
