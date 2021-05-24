function BlurPred = svdBlur_func(img)

% img = imread('1600.png');
% img = double( rgb2gray(img) );
% figure,imshow(uint8(img))


C=50;
[U,S,V] = svd(img);
X = diag(S) ;
idx = find(X>C);
X2 = X(idx);

num = 1:length(X2);
X3 = log(1./X2);
A = log(num); 

Numerator = sum(A.*X3');
Denominator = sum(A.*A);

BlurPred = Numerator/Denominator;


