function RGB = darkening_ms(img_mat,beta)
%Darkening MS Summary of this function goes here
%   Detailed explanation goes here
% X=imread('sat1.jpg');
[gif cmap]=rgb2ind(img_mat,128);
ncmap=brighten(cmap,beta);
RGB=ind2rgb(gif,ncmap);
% imagesc(double(RGB)); figure(gcf)

end

