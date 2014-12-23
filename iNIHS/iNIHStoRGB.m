function C=iNIHStoRGB(hsi)
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


