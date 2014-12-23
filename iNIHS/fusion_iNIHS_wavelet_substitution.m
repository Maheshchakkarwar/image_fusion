function fused_img = fusion_iNIHS_wavelet_substitution(x1,x2)
%FUSION_IHS_WAVELET_SUBSTITUTION Summary of this function goes here
%   Detailed explanation goes here

hsi=RGBtoiNIHS(x1);
HV=hsi(:,:,1);
SV=hsi(:,:,2);
IV=hsi(:,:,3);
sY=size(IV);
[LL1,LH1,HL1,HH1]=dwt2(IV,'db1');
PANimg=im2double(x2);
sX=size(PANimg);
[LL2,LH2,HL2,HH2]=dwt2(PANimg,'db1');
X = idwt2(LL1,LH2,HL2,HH2,'db1',sY);
IV=im2double(X);
hsi=cat(3,HV,SV,IV);
fused_img=iNIHStoRGB(hsi);
end

