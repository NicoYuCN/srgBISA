
function [sharpnessScore map] =MLVSharpnessMeasure(x)

T=1000;
alpha=-0.01;
x=double(x);
x(:)=x(:)/255; 
x=rgb2gray(x);

[map] = MLVMap(x);

[xs ys]=size(map);
xy_number=xs*ys;
l_number=round(xy_number);
vec = reshape(map,1,xy_number);
vec=sort(vec,'descend');
svec=vec(1:l_number);

a=(1:xy_number);
q=exp(alpha*a);
svec=svec.*q;
if T<l_number
    svec=svec(1:T);
else
    svec=svec(1:l_number);
end
[E gamparam sigma] = estimateggdparam(svec);
sharpnessScore=sigma;   
end %function

