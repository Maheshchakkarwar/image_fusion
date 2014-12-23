function hsi = rgbtohsi(x1)
%RGBTOHSI Summary of this function goes here
%   Detailed explanation goes here
% RGBImg=imread(x1);
% [gif cmap]=rgb2ind(RGBImg,128);
% % The modified colormap is brighter if 0 < beta < 1 and darker if -1 < beta < 0. 
% % brighten(beta), followed by brighten(-beta), where beta < 1, restores the original map.
% cmap=brighten(-0.09);
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
S=1-3.*(min(min(r,g),b))./(r+g+b+eps);
I=(r+g+b)/3;
hsi=cat(3,H,S,I);

end

