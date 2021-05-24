function fe=fecal(im)
    rf=dct2(im);                         %对图像进行离散余弦变换
    rf(1,1)=0.00000001;
    nrf=rf.^2/sum(sum(rf.^2));           %论文中公式（9）对离散余弦系数进行归一化
    nrf(nrf==0)=0.00000001;
    fe=-sum(sum(nrf.*log2(nrf)));        %论文中公式（10）计算局部图像熵
return;