%This programm does pan sharpening with the help of wavelets. It decomposes
%the panchromatic image and the multispectral image and then takes the
%approximation coefficients of the multispectral band and the detail
%coefficients of the panchromatic image to reconstruct a band.
%The function expects the following parameter:
%
%   panimage: high resolution panchromatic image
%
%   lowres: low resolution multispectral image, which has already been
%   upsampled so that it has exactly the same size as 'highres'
%
%   level: level of the wavelet decomposition used for reconstruction.
%   Default: 2
%
%   waveletname is the wavelet that is used. Default: haar


function solution = waveletfusion( lowres, panimage, level, waveletname)



if ~exist('waveletname')
    waveletname = 'haar';
end
%if ~exist('lowres')
   % load('registeredcity.mat')
%end

if ~exist('level')
    level = 2;
end

[n m c] = size(lowres);

%show initial images
%figure, imshow(panimage), title('high resolution panchromatic image');
%bands = lowres(:,:,1);
%for k=2:c
%    bands = [bands, lowres(:,:,k)];
%end
%figure, imshow(bands), title('Low resolution image - the different bands are shown seperately');


%do waveletdecomposition of the panchromatic image
[panvec, s] = wavedec2(panimage,level,waveletname);

%do waveletdecomposition of the multispectral image
for i=1:c
    reconstvec(:,i) = panvec;
    lowresvec(:,i) = wavedec2(lowres(:,:,i),level,waveletname);
end

%use detail coefficients from panchromatic image and approximation image
%from the bands of the multispectral image
for j=1:s(1,1) * s(1,2)
        reconstvec(j,:) = lowresvec(j,:);
end

%reconstruct image doing inverse wavelet transform
for i=1:c
    solution(:,:,i) = waverec2(reconstvec(:,i),s,waveletname);
end

%show result
%bands = solution(:,:,1);
%for k=2:c
  %  bands = [bands, solution(:,:,k)];
%end
%figure, imshow(bands), title('Wavelet restored images - the different bands are shown seperately');
%imwrite(bands, 'ihsrestored', 'jpg');


