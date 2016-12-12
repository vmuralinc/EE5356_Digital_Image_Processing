%  file : Assig1_2.m
%  description : This program will magnify the original image
%                256 X 256 by two and give a 512 X 512 image using the
%                linear interpolation method

% read the 256 X 256 image into a matrix
iImageSmall = imread('goldhill256.bmp');

iSizeSmall = length(iImageSmall);

iSizeLarge = 2*iSizeSmall;

% create a zero matrix twice the size of the image matrix to be
% used as image matrix for linear interpolation
dImageLinear = zeros(iSizeLarge);

% populate the FOH matrix with the values from the image matrix
% this is done to get the image matrix interlaced with zeros
for i = 1:1:iSizeSmall
    for j = 1:1:iSizeSmall
        dImageLinear(2*i-1,2*j-1) = iImageSmall(i,j);
    end
end

H2 = [0.25 0.5 0.25;0.5 1 0.5;0.25 0.5 0.25];

% convolve the FOH matrix with one matrix of the 2nd order
% convolved with itself (H2 = H conv H ) normalized to one
% to get the magnified image matrix
iImageLinear = uint8(conv2(dImageLinear,H2));

iImageLinear = iImageLinear(1:iSizeLarge,1:iSizeLarge);

imshow(iImageSmall);

figure(2)
imshow(iImageLinear);