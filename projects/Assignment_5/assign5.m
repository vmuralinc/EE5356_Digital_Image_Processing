clear all;
close all;
clc;

%project 5
image = imread('goldhill256.bmp');

%taking DFT of the image matrix
dftImage = fft2(double(image));


%performing the roots filtering
[row col] = size(dftImage);

% getting alpha from user
alpha = input('enter the value of alpha : ');

rootImage = zeros(row,col);

for k = 1:1:row
    for l = 1:1:col
        rootImage(k,l) = (abs(dftImage(k,l))^alpha)*sign(dftImage(k,l));
    end
end

%energy of filtered image before zonal filtering
energyDftImage = energyCalc(dftImage);
energyRootImage = energyCalc(rootImage);

% geometric zonal filtering
H = ones(row,col);
% threshold value taken as 91
Th = 91;
H(Th+1:1:row-Th,1:1:col) = 0;
H(1:1:row,Th+1:1:col-Th) = 0;

filteredDftImage = H .* dftImage;
filteredRootImage = H .* rootImage;

%energy of filtered image after zonal filtering
egyfilteredDftImage = energyCalc(filteredDftImage);
egyfilteredRootImage = energyCalc(filteredRootImage);

ratio = energyDftImage/egyfilteredDftImage;
ratio1 = energyRootImage/egyfilteredRootImage;


%taking inverse DFT
reconImage = ifft2(filteredDftImage);
reconImage1 = ifft2(filteredRootImage);


% display image
figure(1),imshow(image),title('Original image');
figure(2),imshow(real(dftImage)),title('DFT of image');
figure(3),imshow(real(reconImage),[]),title('reconstructed image of DFT without root filtering');
figure(4),imshow(real(rootImage)),title(sprintf('image after root filtering (alpha = %0.2f)',alpha));
figure(5),imshow(real(reconImage1),[]),title(sprintf('reconstructed Image (alpha = %0.2f)',alpha));
figure(6),imshow(H,[]),title('geometric zonal filter');

%display ratios
disp(ratio);
disp(ratio1);
