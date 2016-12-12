%  file : Assig1_3.m
%  description : This program will magnify the original image
%                256 X 256 by two and give a 512 X 512 image using the
%                cubic spline method

% read the 256 X 256 image into a matrix
iImageSmall = imread('goldhill256.bmp');

iSizeSmall = length(iImageSmall);

iSizeLarge = 2*iSizeSmall;

% create a zero matrix twice the size of the image matrix
dImageLarge = zeros(iSizeLarge);

% populate the new matrix with the values from the image matrix
% this is done to get the image matrix interlaced with zeros
for i = 1:1:iSizeSmall
    for j = 1:1:iSizeSmall
        dImageLarge(2*i-1 , 2*j-1) = iImageSmall(i , j);
    end
end

H = [1 1; 1 1];

H4 = conv2(H,conv2(H,conv2(H,H)));

H4 = H4 ./ 64;

% convolve the new matrix with one matrix of the 2nd order
% convolved with itself four times and normalized to 1 to get 
% the magnified image matrix
dImageLarge = conv2(dImageLarge,H4);

iImageLarge = uint8(dImageLarge);

iImageLarge = iImageLarge(1:iSizeLarge,1:iSizeLarge);

figure(1);
imshow(iImageSmall);
figure(2);
imshow(iImageLarge);

