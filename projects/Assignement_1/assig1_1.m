%  file : Assig1_1.m
%  description : This program will magnify the original image
%                256 X 256 by two and give a 512 X 512 image using the
%                replication method

% read the 256 X 256 image into a matrix
iImgSmall = imread('goldhill256.bmp');

iSizeSmall = length(iImgSmall);

iSizeLarge = 2 * iSizeSmall

% create a zero matrix twice the size of the image matrix
dImgLarge = zeros(iSizeLarge);

% populate the new matrix with the values from the image matrix
% this is done to get the image matrix interlaced with zeros
for i = 1:1:iSizeSmall
    for j = 1:1:iSizeSmall
        dImgLarge(2*i-1,2*j-1) = iImgSmall(i,j);
    end
end

H = ones(2);

% convolve the new matrix with one matrix of the 2nd order
% to get the magnified image matrix
iImgLarge = uint8(conv2(dImgLarge,H));

iImgLarge = iImgLarge(1:iSizeLarge,1:iSizeLarge);

figure(1);
imshow(iImgSmall);

figure(2);
imshow(iImgLarge);