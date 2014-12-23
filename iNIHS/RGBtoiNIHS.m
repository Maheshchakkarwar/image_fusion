function hsi = RGBtoiNIHS(x1)
%RGBTOINIHS Summary of this function goes here
%   Detailed explanation goes here

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
end

