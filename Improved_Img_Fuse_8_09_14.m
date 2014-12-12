function C=fusion(x1,x2)

% % [gifImage cmap] = imread(x1);
% % RGBImg = ind2rgb(gifImage, cmap);
%  RGBImg=imread(x1);
% [gif cmap]=rgb2ind(RGBImg,128);
% % The modified colormap is brighter if 0 < beta < 1 and darker if -1 < beta < 0. 
% % brighten(beta), followed by brighten(-beta), where beta < 1, restores the original map.
% %  cmap=brighten(-0.09);
% RGBImg = ind2rgb(gif,cmap);
% RGBImg=imresize(RGBImg,[256 256]);
% subplot(2,3, 1);
% imshow(RGBImg),title('Multispectral Image');
F1=im2double(x1);
r=F1(:,:,1);
g=F1(:,:,2);
b=F1(:,:,3);
th=acos((0.5*((r-g)+(r-b)))./((sqrt((r-g).^2+(r-b).*(g-b)))+eps));
H=th;
H(b>g)=2*pi-H(b>g);
H=H/(2*pi);

I=(r+g+b)/3;
x=(H);
y=(120);
% disp(class(x) );
I1=2./3-((mod(x,y)-60)./180);
% HLOWER PART Calculate Saturation
S=1-3.*(min(min(r,g),b))./(r+g+b+eps);
% HUPPER PART Calculate Saturation
id=find(I>I1);
S(id)=1-3.*(1-max(max(r(id),g(id)),b(id)))./(3-(r(id)+g(id)+b(id)+eps));
hsi=cat(3,H,S,I);
% subplot(2,3, 3);
% imshow(hsi),title('iNIHS  Image');
% %start calculation on pan
% 
% % % [gifImage cmap] = imread(x2);
% % % PANImg = ind2rgb(gifImage, cmap);
% PANImg= imread(x2);
% PANImg=imresize(PANImg,[256 256]);
% PANImg=rgb2gray(PANImg);
% subplot(2,3,2);
% imshow(PANImg),title('Panchromatic Image');
% F1=im2double(PANImg);
% % r=F1(:,:,1);
% % g=F1(:,:,2);
% % b=F1(:,:,3);
% % I=(r+g+b)/3;
% F1=im2double(x2);
% I=F1;
%end
hsi=cat(3,H,S,I);
%disp(hsi);
% subplot(2,3, 4);
% imshow(hsi),title('iNIHS After Intensity Substitution');
 C=iNIHS2RGB(hsi);
%  disp(C);
% subplot(2,3, 5);
% imshow(C),title('HSI to RGB');
% C=rgb2gray(C);
%spectrum=log(1+abs(fftshift(fft2(C))));
% subplot(2,3, 6);
% imshow(C),title('Gamut Problem');
% disp(C);
end
function C=iNIHS2RGB(hsi)
HV=hsi(:,:,1)*2*pi;
SV=hsi(:,:,2);
IV=hsi(:,:,3);
R=zeros(size(HV));
G=zeros(size(HV));
B=zeros(size(HV));
x=(HV);
y=2.*pi./3;
I1=2./3-((mod(x,y)-pi./3)./pi);
%RG Sector
% id=find((0<=HV)& (HV<2*pi/3));
id=find((IV<=I1)& (HV>=0)& (HV<(2.*pi./3)) & (IV<=(2./3-(HV-pi./3)./pi)) );
B(id)=IV(id).*(1-SV(id));
R(id)=IV(id).*(1+SV(id).*cos(HV(id))./cos(pi/3-HV(id)));
G(id)=3*IV(id)-(R(id)+B(id));

%BG Sector
% id=find((2*pi/3<=HV)& (HV<4*pi/3));
id=find((IV<=I1)&(HV>=(2.*pi./3))& (HV<4.*pi./3)& (IV<=(2./3-(HV-pi)./pi)));
R(id)=IV(id).*(1-SV(id));
G(id)=IV(id).*(1+SV(id).*cos(HV(id)-2*pi/3)./cos(pi-HV(id)));
B(id)=3*IV(id)-(R(id)+G(id));
%BR Sector
% id=find((4*pi/3<=HV)& (HV<2*pi));
id=find((IV<=I1)&(HV>=4.*pi./3)& (HV<2.*pi)& (IV<=(2./3-(HV-(2.*pi-pi./3))./pi)));
G(id)=IV(id).*(1-SV(id));
B(id)=IV(id).*(1+SV(id).*cos(HV(id)-4*pi/3)./cos(5*pi/3-HV(id)));
R(id)=3*IV(id)-(G(id)+B(id));
% -----------END iNIHS to RGB for HLOWER---------------------------

% --------- iNIHS to RGB transformation for color points in HUPPER-------
%section YC
id=find((IV>I1)& pi./3<(HV)& (HV<=pi)& (IV>(1./3+(HV-(2.*pi./3))./pi)));
HV(id)=HV(id)-4.*pi./3;
G(id)=IV(id).*(1-SV(id))+SV(id);
B(id)=1-(1-IV(id)).*(1+(SV(id).*cos(HV(id)))./cos(pi./3-HV(id)));
R(id)=3.*IV(id)-(G(id)+B(id));

%section CM
id=find((IV>I1)&(pi<HV)& (HV<=(2.*pi-pi./3))& (IV>(1./3+(HV-(4.*pi./3))./pi)));
B(id)=IV(id).*(1-SV(id))+SV(id);
R(id)=1-(1-IV(id)).*(1+(SV(id).*cos(HV(id)))./cos(pi./3-HV(id)));
G(id)=3*IV(id)-(B(id)+R(id));

%section MY
id=find((IV>I1)&((HV>-pi./3)& (HV<=0)& (IV>1./3+(2.*pi-HV)/pi)) | ((HV>0) & (HV<=pi./3) & (IV>(1./3+HV./pi))));
HV(id)=HV(id)-2.*pi./3;
R(id)=IV(id).*(1-SV(id))+SV(id);
G(id)=1-(1-IV(id)).*(1+(SV(id).*cos(HV(id)))./cos(pi./3-HV(id)));
B(id)=3.*IV(id)-(R(id)+G(id));
%-------END iNIHS To RGB for HUPPER-------------------------
 C=cat(3,R,G,B);
C=max(min(C,1),0);
end
