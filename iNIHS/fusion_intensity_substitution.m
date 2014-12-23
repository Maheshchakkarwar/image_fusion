function fused_img = fusion_intensity_substitution(x1,x2)
%FUSION_IHS_SUBSTITUTION Summary of this function goes here
%   Detailed explanation goes here
hsi=RGBtoiNIHS(x1);
HV=hsi(:,:,1);
SV=hsi(:,:,2);
IV=hsi(:,:,3);
PANimg=im2double(x2);
IV=PANimg;
hsi=cat(3,HV,SV,IV);
fused_img=iNIHStoRGB(hsi);
end

