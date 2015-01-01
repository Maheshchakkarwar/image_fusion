function fusion_ihs_gamut(x1,x2)

[gifImage cmap] = imread(x1);
RGBImg = ind2rgb(gifImage, cmap);
RGBImg=imresize(RGBImg,[256 256]);
subplot(2,3, 1);
imshow(RGBImg),title('Multispectral Image');
F1=im2double(RGBImg);
r=F1(:,:,1);
g=F1(:,:,2);
b=F1(:,:,3);
th=acos((0.5*((r-g)+(r-b)))./((sqrt((r-g).^2+(r-b).*(g-b)))+eps));
H=th;
H(b>g)=2*pi-H(b>g);
H=H/(2*pi);
S=1-3.*(min(min(r,g),b))./(r+g+b+eps);
I=(r+g+b)/3;
hsi=cat(3,H,S,I);
subplot(2,3, 3);
imshow(RGBImg),title('IHS  Image');
%start calculation on pan

% [gifImage cmap] = imread(x2);
% PANImg = ind2rgb(gifImage, cmap);
PANImg= imread(x2);
PANImg=imresize(PANImg,[256 256]);
subplot(2,3,2);
imshow(PANImg),title('Panchromatic Image');
F1=im2double(PANImg);
% r=F1(:,:,1);
% g=F1(:,:,2);
% b=F1(:,:,3);
% I=(r+g+b)/3;
I=F1;
%end
hsi=cat(3,H,S,I);
%disp(hsi);
subplot(2,3, 4);
imshow(hsi),title('HSI After Intensity Substitution');
 C=hsitorgb(hsi);
%  disp(C);
subplot(2,3, 5);
imshow(C),title('HSI to RGB');
C=rgb2gray(C);
%spectrum=log(1+abs(fftshift(fft2(C))));
subplot(2,3, 6);
gamut=zeros(size(hsi));
gamut(hsi>1 | hsi <0)=1;
colormap(gray);
imshow(gamut),title('Gamut Problem');
disp(C);
end
function C=hsitorgb(hsi)
HV=hsi(:,:,1)*2*pi;
SV=hsi(:,:,2);
IV=hsi(:,:,3);
R=zeros(size(HV));
G=zeros(size(HV));
B=zeros(size(HV));
%RG Sector
id=find((0<=HV)& (HV<2*pi/3));
B(id)=IV(id).*(1-SV(id));
R(id)=IV(id).*(1+SV(id).*cos(HV(id))./cos(pi/3-HV(id)));
G(id)=3*IV(id)-(R(id)+B(id));

%BG Sector
id=find((2*pi/3<=HV)& (HV<4*pi/3));
R(id)=IV(id).*(1-SV(id));
G(id)=IV(id).*(1+SV(id).*cos(HV(id)-2*pi/3)./cos(pi-HV(id)));
B(id)=3*IV(id)-(R(id)+G(id));
%BR Sector
id=find((4*pi/3<=HV)& (HV<2*pi));
G(id)=IV(id).*(1-SV(id));
B(id)=IV(id).*(1+SV(id).*cos(HV(id)-4*pi/3)./cos(5*pi/3-HV(id)));
R(id)=3*IV(id)-(G(id)+B(id));
C=cat(3,R,G,B);
C=max(min(C,1),0);
end
