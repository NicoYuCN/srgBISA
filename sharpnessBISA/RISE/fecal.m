function fe=fecal(im)
    rf=dct2(im);                         %��ͼ�������ɢ���ұ任
    rf(1,1)=0.00000001;
    nrf=rf.^2/sum(sum(rf.^2));           %�����й�ʽ��9������ɢ����ϵ�����й�һ��
    nrf(nrf==0)=0.00000001;
    fe=-sum(sum(nrf.*log2(nrf)));        %�����й�ʽ��10������ֲ�ͼ����
return;